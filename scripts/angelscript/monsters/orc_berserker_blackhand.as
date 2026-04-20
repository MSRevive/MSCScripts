#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class OrcBerserkerBlackhand : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK1;
	string ANIM_ATTACK2;
	float ATTACK_ACCURACY;
	int ATTACK_DMG_HIGH;
	int ATTACK_DMG_LOW;
	string ATTACK_PUSH;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLINCH_CHANCE;
	int NPC_GIVE_EXP;
	int ORC_SHIELD;

	OrcBerserkerBlackhand()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(8, 16);
		NPC_GIVE_EXP = 60;
		DROP_ITEM1 = "swords_shortsword";
		DROP_ITEM1_CHANCE = 0.25;
		ANIM_ATTACK1 = "battleaxe_swing1_L";
		ANIM_ATTACK2 = "swordswing1_L";
		FLINCH_CHANCE = 0.45;
		ATTACK_ACCURACY = 0.7;
		ATTACK_DMG_LOW = 10;
		ATTACK_DMG_HIGH = 20;
		ORC_SHIELD = RandomInt(0, 1);
	}

	void swing_sword()
	{
		ATTACK_PUSH = /* TODO: $relvel */ $relvel(-100, 130, 120);
	}

	void orc_spawn()
	{
		SetHealth(120);
		SetName("Blackhand Warrior");
		if (GetMapName() == "ms_wicardoven")
		{
			SetName("Voldar Recruit");
			SetProp(GetOwner(), "skin", 3);
		}
		SetHearingSensitivity(2);
		SetStat("parry", 50);
		SetDamageResistance("all", ".7");
		SetModelBody(0, 2);
		SetModelBody(1, 2);
		SetModelBody(2, 4);
		if (ORC_SHIELD == 1)
		{
			if (!(BO_ZOMBIE_MODE))
			{
			}
			SetStat("parry", 90);
			SetModelBody(2, 6);
		}
	}

	void npc_selectattack()
	{
		ANIM_ATTACK = ANIM_ATTACK1;
		ATTACK_PUSH = "none";
		if (RandomInt(0, 99) < 30)
		{
			ANIM_ATTACK = ANIM_ATTACK2;
		}
	}

}

}
