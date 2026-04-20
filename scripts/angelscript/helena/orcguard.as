#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class Orcguard : CGameScript
{
	string ANIM_ATTACK;
	float ATTACK_ACCURACY;
	int ATTACK_DMG_HIGH;
	int ATTACK_DMG_LOW;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLINCH_CHANCE;
	int NPC_GIVE_EXP;

	Orcguard()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(15, 35);
		NPC_GIVE_EXP = 100;
		DROP_ITEM1 = "axes_battleaxe";
		DROP_ITEM1_CHANCE = 0.4;
		ANIM_ATTACK = "battleaxe_swing1_L";
		FLINCH_CHANCE = 0.45;
		ATTACK_ACCURACY = 0.8;
		ATTACK_DMG_LOW = 18;
		ATTACK_DMG_HIGH = 45;
	}

	void orc_spawn()
	{
		SetHealth(600);
		SetWidth(32);
		SetHeight(60);
		SetName("Orc Guard");
		SetHearingSensitivity(3);
		SetStat("parry", 15);
		SetStat("swordsmanship", 10);
		SetDamageResistance("all", ".8");
		SetRoam(false);
		SetModelBody(0, 2);
		SetModelBody(1, 2);
		SetModelBody(2, 1);
	}

}

}
