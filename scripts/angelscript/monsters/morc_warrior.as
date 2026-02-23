#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class MorcWarrior : CGameScript
{
	string ANIM_ATTACK;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int NPC_GIVE_EXP;

	MorcWarrior()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(5, 10);
		NPC_GIVE_EXP = 60;
		DROP_ITEM1 = "axes_battleaxe";
		DROP_ITEM1_CHANCE = 0.01;
		ANIM_ATTACK = "battleaxe_swing1_L";
		const float ATTACK_ACCURACY = 0.6;
		const int ATTACK_DMG_LOW = 10;
		const int ATTACK_DMG_HIGH = 35;
		Precache("monsters/morc.mdl");
	}

	void orc_spawn()
	{
		SetHealth(240);
		SetName("Marogar Orc Warrior");
		SetHearingSensitivity(1.5);
		SetStat("parry", 30);
		SetDamageResistance("all", ".9");
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("cold", 0.1);
		Precache("monsters/morc.mdl");
		SetModel("monsters/morc.mdl");
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 1);
	}

}

}
