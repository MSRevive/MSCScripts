#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class OrcwarriorHard : CGameScript
{
	string ANIM_ATTACK;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	float FLINCH_CHANCE;
	int NPC_GIVE_EXP;

	OrcwarriorHard()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(5, 25);
		NPC_GIVE_EXP = 80;
		ANIM_ATTACK = "battleaxe_swing1_L";
		FLINCH_CHANCE = 0.45;
		const float ATTACK_ACCURACY = 0.7;
		const int ATTACK_DMG_LOW = 16;
		const int ATTACK_DMG_HIGH = 32;
	}

	void orc_spawn()
	{
		SetHealth(350);
		SetWidth(32);
		SetHeight(60);
		SetName("Orc Champion");
		SetHearingSensitivity(3);
		SetStat("parry", 15);
		SetStat("swordsmanship", 10);
		SetDamageResistance("all", ".8");
		SetModelBody(0, 0);
		SetModelBody(1, 2);
		SetModelBody(2, 1);
	}

}

}
