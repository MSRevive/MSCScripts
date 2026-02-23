#pragma context server

#include "monsters/boar2.as"

namespace MS
{

class Boar2 : CGameScript
{
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLEE_CHANCE;
	int NPC_GIVE_EXP;

	Boar2()
	{
		const int BOAR_WIDTH2 = 32;
		const int BOAR_HEIGHT2 = 75;
		const int BOAR_SIZE = 2;
		const int BOAR_SKIN = 0;
		const string BOAR_MODEL = "monsters/boar2.mdl";
		NPC_GIVE_EXP = 125;
		const int DMG_GORE1 = 60;
		const string DMG_GORE2 = Random(10.0, 15.0);
		const string DMG_GORE3 = Random(10.0, 15.0);
		const string DMG_CHARGE = RandomInt(50, 100);
		const float ATTACK_HITCHANCE = 0.7;
		FLEE_CHANCE = 0.1;
	}

	void OnPostSpawn() override
	{
		DROP_ITEM1 = "skin_boar_heavy";
		DROP_ITEM1_CHANCE = 0.5;
		ATTACK_RANGE = 90;
		ATTACK_HITRANGE = 100;
	}

}

}
