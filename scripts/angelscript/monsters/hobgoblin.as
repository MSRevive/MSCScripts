#pragma context server

#include "monsters/bgoblin.as"

namespace MS
{

class Hobgoblin : CGameScript
{
	string ANIM_ATTACK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CAN_STUN;
	int DMG_AXE;
	int DMG_CHARGE;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int MOVE_RANGE;
	int NPC_BASE_EXP;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_BREATH;
	string SOUND_DEATH;
	int STEP_SIZE_NORM;

	Hobgoblin()
	{
		NPC_BASE_EXP = 150;
		SOUND_ATTACK1 = "monsters/goblin/c_gargoyle_atk1.wav";
		SOUND_ATTACK2 = "monsters/goblin/c_gargoyle_atk2.wav";
		SOUND_ATTACK3 = "monsters/goblin/c_gargoyle_atk3.wav";
		SOUND_BREATH = "monsters/goblin/sps_fogfire.wav";
		STEP_SIZE_NORM = 36;
		CAN_STUN = 1;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(20, 40);
		ANIM_ATTACK = "swordswing1_L";
		DMG_AXE = RandomInt(40, 75);
		DMG_CHARGE = 50;
		ATTACK_HITCHANCE = 0.8;
		SOUND_DEATH = "monsters/goblin/c_goblin_dead.wav";
		Precache(SOUND_DEATH);
	}

	void goblin_spawn()
	{
		SetName("Hobgoblin");
		SetRace("goblin");
		SetBloodType("red");
		SetHealth(500);
		SetRoam(true);
		SetAnimFrameRate(1.5);
		SetHearingSensitivity(4);
		SetModel("monsters/goblin_new_boss.mdl");
		SetWidth(32);
		SetHeight(72);
		SetModelBody(0, 0);
		SetModelBody(1, 1);
		SetModelBody(2, 6);
		SetModelBody(3, 0);
		SetProp(GetOwner(), "skin", 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("all", 0.7);
		SetStat("parry", 120);
	}

	void gob_jump_check()
	{
		if (!(GOB_JUMPER)) return;
		if (!(GOB_JUMP_SCANNING)) return;
		float GOB_HOP_DELAY = Random(2, 4);
		GOB_HOP_DELAY("gob_jump_check");
		if (!(m_hAttackTarget != "unset")) return;
		if ((IS_FLEEING)) return;
		if ((SUSPEND_AI)) return;
		if (!(GetEntityRange(m_hAttackTarget) < GOBLIN_JUMPRANGE)) return;
		string ME_Z = GetMonsterProperty("origin.z");
		string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
		if ((IsValidPlayer(m_hAttackTarget)))
		{
			TARG_Z -= 38;
		}
		if (ME_Z > TARG_Z)
		{
			string Z_DIFF = ME_Z;
			ME_Z -= TARG_Z;
		}
		else
		{
			string Z_DIFF = TARG_Z;
			Z_DIFF -= ME_Z;
		}
		if (Z_DIFF > ATTACK_RANGE)
		{
			PlayAnim("critical", ANIM_SMASH);
			ScheduleDelayedEvent(0.1, "do_jump");
		}
	}

	void do_jump()
	{
		SetStepSize(1000);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -200, 800));
		ScheduleDelayedEvent(0.5, "push_forward");
		ScheduleDelayedEvent(1.0, "jump_done");
	}

	void push_forward()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 400, 100));
	}

	void jump_done()
	{
		SetStepSize(STEP_SIZE_NORM);
		SetMoveAnim(ANIM_RUN);
	}

	void my_target_died()
	{
		ScheduleDelayedEvent(1.0, "npcatk_go_home");
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		PlayAnim("critical", ANIM_PARRY);
		// PlayRandomSound from: SOUND_PARRY1, SOUND_PARRY2, SOUND_PARRY3
		array<string> sounds = {SOUND_PARRY1, SOUND_PARRY2, SOUND_PARRY3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		ScheduleDelayedEvent(0.75, "swing_sword");
	}

	void swing_axe()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE, ATTACK_HITCHANCE, "slash");
		ANIM_ATTACK = ANIM_SWIPE;
	}

	void swing_sword()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWORD, ATTACK_HITCHANCE, "slash");
		if (RandomInt(1, 3) == 1)
		{
			ANIM_ATTACK = ANIM_SMASH;
		}
	}

	void goblin_pre_spawn()
	{
		ATTACK_RANGE = 96;
		ATTACK_HITRANGE = 128;
		ATTACK_MOVERANGE = 58;
		MOVE_RANGE = 58;
	}

}

}
