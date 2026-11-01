#pragma context server

#include "monsters/bgoblin.as"

namespace MS
{

class BgoblinGuard : CGameScript
{
	string ANIM_ATTACK;
	int ATTACK_HITCHANCE;
	int AXE_SWING;
	int CAN_FIREBALL;
	int CAN_STUN;
	int CHARGE_SPEED;
	int DMG_AXE;
	int DMG_SWORD;
	int DOT_FIRE;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	string FLINCH_ANIM;
	int FLINCH_HEALTH;
	float FREQ_CHARGE;
	string F_GOB_TYPE;
	int GOB_CHARGE_MAX_DIST;
	int GOB_CHARGE_MIN_DIST;
	int GOB_JUMPER;
	int GOB_TYPE;
	int NEW_MODEL;
	int NPC_BASE_EXP;

	BgoblinGuard()
	{
		NEW_MODEL = 1;
		NPC_BASE_EXP = 500;
		DOT_FIRE = 40;
		CAN_FIREBALL = 0;
		CAN_FIREBALL = 0;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(25, 50);
		ATTACK_HITCHANCE = 80;
		CAN_STUN = 1;
		GOB_TYPE = RandomInt(1, 2);
		DMG_AXE = RandomInt(60, 150);
		DMG_SWORD = RandomInt(50, 80);
		GOB_JUMPER = 0;
		CHARGE_SPEED = 300;
		FREQ_CHARGE = 10.0;
		GOB_CHARGE_MIN_DIST = 96;
		GOB_CHARGE_MAX_DIST = 128;
		FLINCH_HEALTH = 300;
	}

	void goblin_spawn()
	{
		SetName("Blood Goblin Guard");
		SetRace("goblin");
		SetBloodType("red");
		SetHealth(1500);
		SetRoam(true);
		SetHearingSensitivity(2);
		if (!(NEW_MODEL))
		{
			SetModel("monsters/goblin2.mdl");
			SetWidth(32);
			SetHeight(60);
			SetModelBody(0, 2);
			SetModelBody(1, 2);
			SetModelBody(2, 0);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 2);
		}
		else
		{
			SetModel("monsters/goblin_new.mdl");
			SetWidth(24);
			SetHeight(50);
			SetModelBody(0, 0);
			SetModelBody(1, RandomInt(1, 2));
			SetModelBody(2, 0);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 1);
		}
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("all", 0.75);
		SetDamageResistance("fire", 0.25);
		SetDamageResistance("cold", 1.25);
		ScheduleDelayedEvent(0.01, "gob_guard_set_weapon");
	}

	void gob_guard_set_weapon()
	{
		F_GOB_TYPE = GOB_TYPE;
		if (F_GOB_TYPE == 1)
		{
			SetModelBody(2, 5);
			ANIM_ATTACK = ANIM_SMASH;
			ATTACK_HITCHANCE = 0.8;
			CAN_STUN = 1;
		}
		if (F_GOB_TYPE == 2)
		{
			SetModelBody(2, 6);
			ANIM_ATTACK = ANIM_SWIPE;
			ATTACK_HITCHANCE = 0.9;
			SetStat("parry", 120);
			FLINCH_ANIM = "shielddeflect1";
			CAN_STUN = 1;
		}
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
		AXE_SWING = 1;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE, ATTACK_HITCHANCE, "slash");
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if ((AXE_SWING))
			{
			}
			if (F_GOB_TYPE == 1)
			{
			}
			if (RandomInt(1, 3) == 1)
			{
			}
			ApplyEffect(m_hAttackTarget, "effects/dot_fire", 10.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		}
		AXE_SWING = 0;
	}

}

}
