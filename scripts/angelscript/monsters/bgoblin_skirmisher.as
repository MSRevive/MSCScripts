#pragma context server

#include "monsters/bgoblin.as"

namespace MS
{

class BgoblinSkirmisher : CGameScript
{
	string ANIM_ATTACK;
	int ATTACK_HITCHANCE;
	float BASE_FRAMERATE;
	int CAN_FIREBALL;
	int CAN_STUN;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	int FLINCH_HEALTH;
	string TOSS_FIREBALL;

	BgoblinSkirmisher()
	{
		const int NEW_MODEL = 1;
		const int NPC_BASE_EXP = 350;
		CAN_FIREBALL = 1;
		const int DMG_FIREBALL = 100;
		const int DMG_FIREBALL_DOT = 25;
		const float FREQ_FIREBALL = 20.0;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(25, 50);
		const string DMG_KNIFE = RandomInt(40, 60);
		BASE_FRAMERATE = 2.0;
		ATTACK_HITCHANCE = 80;
		CAN_STUN = 0;
		FLINCH_HEALTH = 200;
	}

	void goblin_spawn()
	{
		SetName("Blood Goblin Skirmisher");
		SetRace("goblin");
		SetBloodType("red");
		SetHealth(1000);
		SetRoam(true);
		SetHearingSensitivity(4);
		SetAnimFrameRate(2.0);
		if (!(NEW_MODEL))
		{
			SetModel("monsters/goblin2.mdl");
			SetWidth(32);
			SetHeight(60);
			SetModelBody(0, 1);
			SetModelBody(1, 4);
			SetModelBody(2, 8);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 2);
		}
		else
		{
			SetModel("monsters/goblin_new.mdl");
			SetWidth(24);
			SetHeight(50);
			SetModelBody(0, 1);
			SetModelBody(1, 4);
			SetModelBody(2, 8);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 1);
		}
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("fire", 0.25);
		SetDamageResistance("cold", 1.25);
		ANIM_ATTACK = "swordswing1_L";
	}

	void swing_axe()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KNIFE, ATTACK_HITCHANCE, "slash");
	}

	void swing_sword()
	{
		if ((TOSS_FIREBALL))
		{
			TOSS_FIREBALL = 0;
			TossProjectile("proj_fire_ball", /* TODO: $relpos */ $relpos(0, 48, 0), m_hAttackTarget, 400, DMG_FIREBALL, 0.5, "none");
			CallExternal("ent_lastprojectile", "lighten", DMG_FIREBALL_DOT, 0.01);
			EmitSound(GetOwner(), 0, SOUND_FIREBALL, 10);
		}
		if ((TOSS_FIREBALL)) return;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KNIFE, ATTACK_HITCHANCE, "pierce");
	}

	void gob_jump_check()
	{
		if (!(GOB_JUMP_SCANNING)) return;
		string GOB_HOP_DELAY = Random(2, 4);
		GOB_HOP_DELAY("gob_jump_check");
		if (!(GetEntityRange(m_hAttackTarget) > ATTACK_HITRANGE)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if ((I_R_FROZEN)) return;
		if ((IS_FLEEING)) return;
		if (!(GetEntityRange(m_hAttackTarget) < GOBLIN_JUMPRANGE)) return;
		string ME_POS = GetMonsterProperty("origin");
		string MY_Z = (ME_POS).z;
		string TARGET_POS = GetEntityOrigin(m_hAttackTarget);
		string TARGET_Z = (TARGET_POS).z;
		string TARGET_Z_DIFFERENCE = TARGET_Z;
		TARGET_Z_DIFFERENCE -= MY_Z;
		if (TARGET_Z_DIFFERENCE > GOB_JUMP_THRESH)
		{
			if (TARGET_Z_DIFFERENCE < 500)
			{
			}
			PlayAnim("critical", ANIM_SMASH);
			ScheduleDelayedEvent(0.1, "gob_hop");
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (!(param1 > 50)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		jump_away();
	}

	void jump_away()
	{
		npcatk_flee(GetEntityIndex(m_hLastStruck), 100, 1.0);
		ScheduleDelayedEvent(0.1, "gob_hop");
	}

}

}
