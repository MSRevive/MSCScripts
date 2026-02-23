#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class OrcFlayer : CGameScript
{
	string ANIM_ATTACK;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLINCH_CHANCE;
	int NPC_GIVE_EXP;

	OrcFlayer()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(15, 25);
		NPC_GIVE_EXP = 100;
		DROP_ITEM1 = "swords_shortsword";
		DROP_ITEM1_CHANCE = 0.2;
		ANIM_ATTACK = "swordswing1_L";
		FLINCH_CHANCE = 0.45;
		const float ATTACK_ACCURACY = 0.8;
		const int ATTACK_DMG_LOW = 18;
		const int ATTACK_DMG_HIGH = 25;
	}

	void orc_spawn()
	{
		SetHealth(400);
		SetName("Orcish Flayer");
		SetHearingSensitivity(5);
		SetStat("parry", 15);
		SetStat("swordsmanship", 10);
		SetDamageResistance("all", ".8");
		SetModelBody(0, 2);
		SetModelBody(1, 2);
		SetModelBody(2, 4);
	}

}

}
