#pragma context server

#include "monsters/bgoblin.as"

namespace MS
{

class VgoblinWeak : CGameScript
{
	string ANIM_ATTACK;
	string ATTACK_HITCHANCE;
	string CAN_FIREBALL;
	string CAN_POISON;
	string CAN_STUN;
	int DMG_AXE;
	int DMG_CLUB;
	int DMG_FIREBALL;
	int DMG_SWORD;
	int DOT_POISON;
	string DROP_ITEM1;
	string DROP_ITEM1_CHANCE;
	string F_GOB_TYPE;
	int GOB_TYPE_SET;
	int NEW_MODEL;
	int NPC_BASE_EXP;
	string SOUND_FIREBALL;
	int TOSS_FIREBALL;

	VgoblinWeak()
	{
		NEW_MODEL = 1;
		NPC_BASE_EXP = 150;
		DMG_CLUB = RandomInt(10, 20);
		DMG_AXE = RandomInt(10, 25);
		DMG_SWORD = RandomInt(5, 25);
		DMG_FIREBALL = 20;
		DOT_POISON = RandomInt(1, 5);
		SOUND_FIREBALL = "bullchicken/bc_attack2.wav";
	}

	void goblin_spawn()
	{
		SetName("Vile Goblin");
		SetHealth(300);
		if (!(NEW_MODEL))
		{
			SetModel("monsters/goblin2.mdl");
			SetWidth(32);
			SetHeight(60);
		}
		else
		{
			SetModel("monsters/goblin_new.mdl");
			SetWidth(24);
			SetHeight(50);
		}
		SetRace("goblin");
		SetBloodType("green");
		SetRoam(true);
		SetHearingSensitivity(2);
		if (!(NEW_MODEL))
		{
			SetModelBody(0, 2);
			SetModelBody(1, 4);
			SetModelBody(2, 0);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 3);
		}
		else
		{
			SetModelBody(0, 0);
			SetModelBody(1, 0);
			SetModelBody(2, 0);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 2);
		}
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("poison", 0.5);
		SetDamageResistance("lightning", 1.5);
		ScheduleDelayedEvent(0.01, "goblin_set_weapon");
	}

	void goblin_set_weapon()
	{
		if ((GOB_TYPE_SET)) return;
		GOB_TYPE_SET = 1;
		F_GOB_TYPE = GOB_TYPE;
		if ((param1).findFirst(PARAM) == 0)
		{
			int DO_NADDA = 1;
		}
		else
		{
			F_GOB_TYPE = param1;
		}
		if (F_GOB_TYPE == 1)
		{
			SetDamageResistance("all", 0.75);
			SetModelBody(2, 7);
			ANIM_ATTACK = ANIM_SMASH;
			ATTACK_HITCHANCE = 0.75;
			string MY_HP = GetEntityHealth(GetOwner());
			MY_HP *= 1.5;
			SetHealth(MY_HP);
			CAN_STUN = 0;
		}
		if (F_GOB_TYPE == 2)
		{
			SetDamageResistance("all", 0.75);
			SetModelBody(2, 1);
			ANIM_ATTACK = ANIM_SMASH;
			ATTACK_HITCHANCE = 0.8;
			string MY_HP = GetEntityHealth(GetOwner());
			MY_HP *= 1.25;
			SetHealth(MY_HP);
			CAN_STUN = 0;
			CAN_POISON = 1;
			DROP_ITEM1 = "axes_poison1";
			DROP_ITEM1_CHANCE = 0.05;
		}
		if (F_GOB_TYPE == 3)
		{
			CAN_FIREBALL = 1;
			SetModelBody(0, 1);
			SetModelBody(2, 4);
			ANIM_ATTACK = ANIM_SWIPE;
			ATTACK_HITCHANCE = 0.9;
			CAN_STUN = 0;
			CAN_POISON = 1;
			DROP_ITEM1 = "swords_poison1";
			DROP_ITEM1_CHANCE = 0.05;
		}
	}

	void toss_fireball()
	{
		TOSS_FIREBALL = 0;
		TossProjectile("proj_poison_spit2", /* TODO: $relpos */ $relpos(0, 48, 0), m_hAttackTarget, 400, DMG_FIREBALL, 0.5, "none");
		EmitSound(GetOwner(), 0, SOUND_FIREBALL, 10);
	}

	void swing_dodamage()
	{
		if (!(param1)) return;
		if (!(CAN_POISON)) return;
		if (!(RandomInt(1, 3) == 1)) return;
		ApplyEffect(param2, "effects/dot_poison", 5, GetEntityIndex(GetOwner()), DOT_POISON);
	}

}

}
