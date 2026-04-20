#pragma context server

#include "monsters/boar_base_remake.as"

namespace MS
{

class Boar2 : CGameScript
{
	float ATTACK_HITCHANCE;
	string BOAR_MODEL;
	int BOAR_SIZE;
	int BOAR_SKIN;
	int DMG_CHARGE;
	float DMG_GORE_FORWARD;
	float DMG_GORE_LEFT;
	float DMG_GORE_RIGHT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLEE_CHANCE;
	int NPC_GIVE_EXP;

	Boar2()
	{
		BOAR_SIZE = 2;
		BOAR_SKIN = 0;
		BOAR_MODEL = "monsters/boar2.mdl";
		NPC_GIVE_EXP = 125;
		DMG_GORE_FORWARD = Random(15.0, 20.0);
		DMG_GORE_LEFT = Random(10.0, 15.0);
		DMG_GORE_RIGHT = Random(10.0, 15.0);
		DMG_CHARGE = RandomInt(50, 100);
		ATTACK_HITCHANCE = 0.7;
		FLEE_CHANCE = 0.1;
	}

	void boar_spawn()
	{
		SetName("Great Boar");
		SetHealth(400);
		SetHearingSensitivity(2);
		SetRoam(true);
	}

	void OnPostSpawn() override
	{
		DROP_ITEM1 = "skin_boar_heavy";
		DROP_ITEM1_CHANCE = 0.5;
	}

}

}
