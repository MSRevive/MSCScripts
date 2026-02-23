#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class OrcWarriorBlackhand : CGameScript
{
	string ANIM_ATTACK;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLINCH_CHANCE;
	int NPC_GIVE_EXP;

	OrcWarriorBlackhand()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(8, 16);
		NPC_GIVE_EXP = 60;
		DROP_ITEM1 = "axes_battleaxe";
		DROP_ITEM1_CHANCE = 0.3;
		ANIM_ATTACK = "battleaxe_swing1_L";
		FLINCH_CHANCE = 0.45;
		const float ATTACK_ACCURACY = 0.7;
		const int ATTACK_DMG_LOW = 10;
		const int ATTACK_DMG_HIGH = 20;
		const string ORC_SHIELD = RandomInt(0, 1);
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
		SetStat("parry", 30);
		SetDamageResistance("all", ".8");
		SetModelBody(0, 2);
		SetModelBody(1, 2);
		SetModelBody(2, 1);
	}

}

}
