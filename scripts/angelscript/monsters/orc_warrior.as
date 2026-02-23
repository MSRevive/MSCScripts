#pragma context server

#include "monsters/orc_base.as"
#include "monsters/orc_base_melee.as"

namespace MS
{

class OrcWarrior : CGameScript
{
	string ANIM_ATTACK;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int NPC_GIVE_EXP;

	OrcWarrior()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(3, 8);
		NPC_GIVE_EXP = 30;
		DROP_ITEM1 = "axes_battleaxe";
		DROP_ITEM1_CHANCE = 0.1;
		ANIM_ATTACK = "battleaxe_swing1_L";
		const float ATTACK_ACCURACY = 0.6;
		const int ATTACK_DMG_LOW = 5;
		const int ATTACK_DMG_HIGH = 10;
	}

	void orc_spawn()
	{
		SetHealth(60);
		SetName("Orc Warrior");
		SetHearingSensitivity(1.5);
		SetStat("parry", 50);
		SetDamageResistance("all", ".9");
		SetModelBody(0, 2);
		SetModelBody(1, 0);
		SetModelBody(2, 1);
	}

}

}
