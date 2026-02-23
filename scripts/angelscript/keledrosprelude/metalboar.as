#pragma context server

#include "monsters/boar_hard.as"

namespace MS
{

class Metalboar : CGameScript
{
	int CAN_FLEE;
	int CAN_STTACK;
	float DROP_ITEM1_CHANCE;
	int HIT_COUNT;
	int IMMUNE_VAMPIRE;
	int IS_FLEEING;
	string NPCATK_FLEE_RESTORETARGET;
	int NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string PUSH_VEL;

	Metalboar()
	{
		if ((StringToLower(GetMapName())).findFirst("keledros") == 0)
		{
			NPC_IS_BOSS = 1;
		}
		const int NPC_BOSS_REGEN_RATE = 0;
		const int NPC_BOSS_RESTORATION = 0;
		const int GORE_FORWARD_DAMAGE = 15;
		const float GORE_SIDE_DAMAGE = 8.5;
		const float ATTACK_HITPERCENT = 0.85;
		const int BOAR_CAN_CHARGE = 1;
		const int BOAR_CHARGE_DMG = 25;
		NPC_GIVE_EXP = 500;
		const int NPC_BASE_EXP = 200;
		const string SOUND_STRUCK1 = "weapons/axemetal1.wav";
		const string SOUND_STRUCK2 = "weapons/axemetal2.wav";
		const string SOUND_STRUCK3 = "doors/doorstop5.wav";
		Precache(SOUND_STRUCK1);
		Precache(SOUND_STRUCK2);
		Precache(SOUND_STRUCK3);
		IMMUNE_VAMPIRE = 1;
		DROP_ITEM1_CHANCE = 0.0;
		Precache("monsters/stoneboar.mdl");
	}

	void OnSpawn() override
	{
		SetHealth(650);
		SetDamageResistance("all", ".35");
		SetDamageResistance("pierce", ".15");
		SetDamageResistance("fire", ".05");
		SetDamageResistance("lightning", 2.0);
		SetDamageResistance("poison", 0.0);
		SetName("Boar made of metal");
		SetHearingSensitivity(9);
		SetModel("monsters/stoneboar.mdl");
		HIT_COUNT = 0;
		CAN_FLEE = 0;
	}

	void OnPostSpawn() override
	{
		SetDamageResistance("holy", 2.0);
	}

	void boar_charge_hit()
	{
		ApplyEffect(m_hLastStruckByMe, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 600, 600), 0);
		ApplyEffect(m_hLastStruckByMe, "effects/debuff_stun", 6, GetEntityIndex(GetOwner()));
	}

	void gore_forward()
	{
		ApplyEffect(GetOwner(), "effects/specialattack_haste", 2);
		PUSH_VEL = Vector3(0, 0, 0);
		if (RandomInt(1, 10) == 1)
		{
			ApplyEffect(m_hLastStruckByMe, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 400, 400), 0);
		}
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, GORE_FORWARD_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void gore_left()
	{
		ApplyEffect(GetOwner(), "effects/specialattack_haste", 2);
		PUSH_VEL = /* TODO: $relvel */ $relvel(200, 100, 20);
		if (RandomInt(1, 10) == 1)
		{
			ApplyEffect(m_hLastStruckByMe, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(200, 400, 400), 0);
		}
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, GORE_SIDE_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void gore_right()
	{
		ApplyEffect(GetOwner(), "effects/specialattack_haste", 2);
		PUSH_VEL = /* TODO: $relvel */ $relvel(-200, 100, 20);
		if (RandomInt(1, 10) == 1)
		{
			ApplyEffect(m_hLastStruckByMe, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(-200, 400, 400), 0);
		}
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, GORE_SIDE_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		HIT_COUNT += 1;
		if (HIT_COUNT >= 10)
		{
			SetHearingSensitivity(100);
			string MY_ATTACKER = GetEntityIndex(m_hLastStruck);
			npcatk_flee(MY_ATTACKER, 640, 2);
			HIT_COUNT = 0;
		}
	}

	void OnFlee()
	{
		PlayAnim("once", "break");
		SetMoveDest(param1);
		SetMoveAnim(ANIM_CHARGE);
		IS_FLEEING = 1;
		NPCATK_FLEE_RESTORETARGET = IS_HUNTING;
		PARAM3("npcatk_stopflee");
	}

	void npcatk_stopflee()
	{
		CAN_STTACK = 1;
		IS_FLEEING = 0;
		CAN_FLEE = 0;
		SetMoveAnim(ANIM_RUN);
		if ((NPCATK_FLEE_RESTORETARGET))
		{
			npcatk_faceattacker(HUNT_LASTTARGET);
		}
		npc_stopflee();
		ScheduleDelayedEvent(1, "boar_charge");
	}

}

}
