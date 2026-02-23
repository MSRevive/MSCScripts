#pragma context server

#include "monsters/boar_base_remake.as"
#include "monsters/base_ice_race.as"

namespace MS
{

class Snowboar3 : CGameScript
{
	float FLEE_CHANCE;
	int NPC_GIVE_EXP;

	Snowboar3()
	{
		const int BOAR_SIZE = 3;
		const int BOAR_SKIN = 3;
		const string BOAR_MODEL = "monsters/boar3.mdl";
		NPC_GIVE_EXP = 400;
		const int DMG_GORE_FORWARD = 60;
		const string DMG_GORE_LEFT = Random(40.0, 60.0);
		const string DMG_GORE_RIGHT = Random(40.0, 60.0);
		const string DMG_CHARGE = RandomInt(200, 300);
		const float ATTACK_HITCHANCE = 0.7;
		FLEE_CHANCE = 0.1;
	}

	void boar_spawn()
	{
		SetName("Gigantic Snow Boar");
		SetHealth(1200);
		SetHearingSensitivity(2);
		SetRoam(true);
	}

}

}
