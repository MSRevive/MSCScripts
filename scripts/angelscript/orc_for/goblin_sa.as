#pragma context server

#include "orc_for/tiers1.as"
#include "orc_for/goblin_base.as"

namespace MS
{

class GoblinSa : CGameScript
{
	string ANIM_ATTACK;
	string ATTACK_HITCHANCE;
	string F_GOB_TYPE;
	int GOB_TYPE_SET;
	string STUN_ATTACK;
	string STUN_CHANCE;

	GoblinSa()
	{
		const int NPC_BASE_EXP = 75;
		const int NPC_CAP_EXP = 750;
		const int DMG_CLUB = 20;
		const int DMG_AXE = 30;
		const int DMG_SWORD = 15;
	}

	void goblin_spawn()
	{
		SetName("Goblin Warrior");
		SetModel("monsters/goblin_new.mdl");
		SetHealth(100);
		SetWidth(24);
		SetHeight(50);
		SetRace("goblin");
		SetBloodType("red");
		SetRoam(true);
		SetHearingSensitivity(2);
		SetModelBody(0, 0);
		SetModelBody(1, 0);
		SetModelBody(2, 0);
		SetModelBody(3, 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
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
			SetModelBody(2, 7);
			ANIM_ATTACK = ANIM_SMASH;
			ATTACK_HITCHANCE = 0.7;
			STUN_CHANCE = 0.25;
			string MY_HP = GetEntityMaxHealth(GetOwner());
			MY_HP *= 1.5;
			SetHealth(MY_HP);
		}
		if (F_GOB_TYPE == 2)
		{
			SetModelBody(2, 1);
			ANIM_ATTACK = ANIM_SMASH;
			ATTACK_HITCHANCE = 0.75;
			string MY_HP = GetEntityMaxHealth(GetOwner());
			MY_HP *= 1.25;
			SetHealth(MY_HP);
		}
		if (F_GOB_TYPE == 3)
		{
			SetModelBody(0, 0);
			SetModelBody(2, 4);
			ANIM_ATTACK = ANIM_SWIPE;
			ATTACK_HITCHANCE = 0.8;
		}
	}

	void swing_axe()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (F_GOB_TYPE == 1)
		{
			STUN_ATTACK = 1;
			DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CLUB, ATTACK_HITCHANCE, "blunt");
		}
		if (F_GOB_TYPE == 2)
		{
			DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE, ATTACK_HITCHANCE, "slash");
		}
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if ((STUN_ATTACK))
			{
			}
			if (RandomInt(1, 100) < STUN_CHANCE)
			{
			}
			if ((CAN_STUN))
			{
				ApplyEffect(param2, "effects/debuff_stun", 3.0, GetEntityIndex(GetOwner()));
			}
		}
		STUN_ATTACK = 0;
	}

}

}
