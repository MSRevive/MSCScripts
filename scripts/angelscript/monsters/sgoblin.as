#pragma context server

#include "monsters/bgoblin.as"

namespace MS
{

class Sgoblin : CGameScript
{
	int AM_INVISIBLE;
	string ANIM_ATTACK;
	int ATTACK_HITCHANCE;
	float BASE_FRAMERATE;
	int CAN_FIREBALL;
	int CAN_STUN;
	string CL_IDX;
	string CL_SCRIPT;
	int DMG_KNIFE;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int FIRST_ALERT;
	int FLINCH_HEALTH;
	int NPC_BASE_EXP;
	int ORG_BODY;
	int OVERHEAD_SMASH;
	string SOUND_APPEAR;
	string SOUND_FADE;
	int SWING_COUNT;

	Sgoblin()
	{
		NPC_BASE_EXP = 375;
		CAN_FIREBALL = 0;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(40, 50);
		DMG_KNIFE = RandomInt(40, 60);
		BASE_FRAMERATE = 2.0;
		ATTACK_HITCHANCE = 90;
		CAN_STUN = 0;
		FLINCH_HEALTH = 200;
		CL_SCRIPT = "monsters/sgoblin_cl";
		ORG_BODY = 0;
		SOUND_FADE = "monsters/gonome/gonome_melee2.wav";
		SOUND_APPEAR = "ambience/alien_humongo.wav";
	}

	void game_precache()
	{
		Precache(CL_SCRIPT);
	}

	void goblin_spawn()
	{
		SetName("Shadow Goblin");
		SetRace("demon");
		SetBloodType("red");
		SetHealth(1000);
		SetRoam(true);
		SetHearingSensitivity(4);
		SetAnimFrameRate(2.0);
		SetModel("monsters/goblin_new.mdl");
		SetWidth(24);
		SetHeight(50);
		SetModelBody(0, 0);
		SetModelBody(1, 0);
		SetModelBody(2, 8);
		SetModelBody(3, 0);
		SetProp(GetOwner(), "skin", 3);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		ANIM_ATTACK = "swordswing1_L";
		ClientEvent("new", "all", CL_SCRIPT);
		CL_IDX = "game.script.last_sent_id";
		SWING_COUNT = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", CL_IDX);
		if (!(AM_INVISIBLE)) return;
		go_visible();
	}

	void swing_axe()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KNIFE, ATTACK_HITCHANCE, "slash");
		OVERHEAD_SMASH = 1;
	}

	void swing_sword()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KNIFE, ATTACK_HITCHANCE, "pierce");
		SWING_COUNT += 1;
		if (!(SWING_COUNT > 5)) return;
		SWING_COUNT = 0;
		fade_and_flee();
	}

	void npc_selectattack()
	{
		if ((AM_INVISIBLE))
		{
			fade_in();
		}
	}

	void gob_jump_check()
	{
		if (!(GOB_JUMP_SCANNING)) return;
		float GOB_HOP_DELAY = Random(2, 4);
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
		if ((AM_INVISIBLE))
		{
			jump_away();
		}
		if (!(param1 > 200)) return;
		if (!(RandomInt(1, 2) == 1)) return;
		jump_away();
	}

	void jump_away()
	{
		if (!(IS_FLEEING))
		{
			npcatk_flee(GetEntityIndex(m_hLastStruck), 100, 3.0);
		}
		ScheduleDelayedEvent(0.1, "gob_hop");
	}

	void fade_and_flee()
	{
		ClientEvent("update", "all", CL_IDX, "poof_fx", GetEntityOrigin(GetOwner()));
		jump_away();
		ScheduleDelayedEvent(0.25, "go_invisible");
	}

	void go_invisible()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		LogDebug("*** GOING INVISIBLE ***");
		AM_INVISIBLE = 1;
		EmitSound(GetOwner(), 0, SOUND_FADE, 10);
		SetProp(GetOwner(), "rendermode", 2);
		SetProp(GetOwner(), "renderamt", 0);
		SetModelBody(0, 2);
		SetModelBody(1, 0);
		SetModelBody(2, 0);
		SetModelBody(3, 0);
		etherial_immunes();
	}

	void go_visible()
	{
		LogDebug("*** GOING VISIBLE ***");
		AM_INVISIBLE = 0;
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
		normal_immunes();
		SetModelBody(0, 0);
		SetModelBody(1, 0);
		SetModelBody(2, 8);
		SetModelBody(3, 0);
	}

	void fade_in()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		EmitSound(GetOwner(), 0, SOUND_APPEAR, 10);
		ClientEvent("update", "all", CL_IDX, "unpoof_fx", GetEntityOrigin(GetOwner()));
		go_visible();
	}

	void npc_targetsighted()
	{
		if ((FIRST_ALERT)) return;
		if ((AM_INVISIBLE)) return;
		FIRST_ALERT = 1;
		if (!(GetEntityRange(m_hAttackTarget) > ATTACK_HITRANGE)) return;
		fade_and_flee();
	}

	void my_target_died()
	{
		FIRST_ALERT = 0;
		if (!(AM_INVISIBLE)) return;
		fade_in();
	}

	void etherial_immunes()
	{
		ClearFX();
		SetInvincible(true);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 1.0);
	}

	void normal_immunes()
	{
		SetInvincible(false);
		SetDamageResistance("fire", 1.0);
		SetDamageResistance("cold", 1.0);
		SetDamageResistance("poison", 1.0);
		SetDamageResistance("holy", 0.0);
	}

	void game_dodamage()
	{
		if ((OVERHEAD_SMASH))
		{
			if ((AM_INVISIBLE))
			{
			}
			fade_in();
		}
		OVERHEAD_SMASH = 0;
	}

}

}
