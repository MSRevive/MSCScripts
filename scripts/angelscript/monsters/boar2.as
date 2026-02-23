#pragma context server

#include "monsters/boar_base_remake.as"

namespace MS
{

class Boar2 : CGameScript
{
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLEE_CHANCE;
	int NPC_GIVE_EXP;

	Boar2()
	{
		const int BOAR_SIZE = 2;
		const int BOAR_SKIN = 0;
		const string BOAR_MODEL = "monsters/boar2.mdl";
		NPC_GIVE_EXP = 125;
		const string DMG_GORE_FORWARD = Random(15.0, 20.0);
		const string DMG_GORE_LEFT = Random(10.0, 15.0);
		const string DMG_GORE_RIGHT = Random(10.0, 15.0);
		const string DMG_CHARGE = RandomInt(50, 100);
		const float ATTACK_HITCHANCE = 0.7;
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
