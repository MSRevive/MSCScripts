#pragma context server

#include "monsters/boar2.as"

namespace MS
{

class Boar2 : CGameScript
{
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BOAR_HEIGHT2;
	string BOAR_MODEL;
	int BOAR_SIZE;
	int BOAR_SKIN;
	int BOAR_WIDTH2;
	int DMG_CHARGE;
	int DMG_GORE1;
	float DMG_GORE2;
	float DMG_GORE3;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLEE_CHANCE;
	int NPC_GIVE_EXP;

	Boar2()
	{
		BOAR_WIDTH2 = 32;
		BOAR_HEIGHT2 = 75;
		BOAR_SIZE = 2;
		BOAR_SKIN = 0;
		BOAR_MODEL = "monsters/boar2.mdl";
		NPC_GIVE_EXP = 125;
		DMG_GORE1 = 60;
		DMG_GORE2 = Random(10.0, 15.0);
		DMG_GORE3 = Random(10.0, 15.0);
		DMG_CHARGE = RandomInt(50, 100);
		ATTACK_HITCHANCE = 0.7;
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
