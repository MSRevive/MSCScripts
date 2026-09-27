#pragma context server

#include "monsters/boar_base_remake.as"
#include "monsters/base_ice_race.as"

namespace MS
{

class Snowboar3 : CGameScript
{
	float ATTACK_HITCHANCE;
	string BOAR_MODEL;
	int BOAR_SIZE;
	int BOAR_SKIN;
	int DMG_CHARGE;
	int DMG_GORE_FORWARD;
	float DMG_GORE_LEFT;
	float DMG_GORE_RIGHT;
	float FLEE_CHANCE;
	int NPC_GIVE_EXP;

	Snowboar3()
	{
		BOAR_SIZE = 3;
		BOAR_SKIN = 3;
		BOAR_MODEL = "monsters/boar3.mdl";
		NPC_GIVE_EXP = 400;
		DMG_GORE_FORWARD = 60;
		DMG_GORE_LEFT = Random(40.0, 60.0);
		DMG_GORE_RIGHT = Random(40.0, 60.0);
		DMG_CHARGE = RandomInt(200, 300);
		ATTACK_HITCHANCE = 0.7;
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
