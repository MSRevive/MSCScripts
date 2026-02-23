#pragma context server

#include "monsters/boar_base_remake.as"

namespace MS
{

class Boar3 : CGameScript
{
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLEE_CHANCE;
	int NPC_GIVE_EXP;

	Boar3()
	{
		const int BOAR_SIZE = 3;
		const int BOAR_SKIN = 0;
		const string BOAR_MODEL = "monsters/boar3.mdl";
		NPC_GIVE_EXP = 350;
		const int DMG_GORE_FORWARD = 60;
		const string DMG_GORE_LEFT = Random(40.0, 60.0);
		const string DMG_GORE_RIGHT = Random(40.0, 60.0);
		const string DMG_CHARGE = RandomInt(200, 300);
		const float ATTACK_HITCHANCE = 0.7;
		FLEE_CHANCE = 0.1;
	}

	void boar_spawn()
	{
		SetName("Gigantic Boar");
		SetHealth(1000);
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
