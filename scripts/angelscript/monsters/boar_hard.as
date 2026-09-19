#pragma context server

#include "monsters/boar.as"

namespace MS
{

class BoarHard : CGameScript
{
	int BOAR_CAN_CHARGE;
	int BOAR_CHARGE_DMG;
	int CAN_HEAR;
	float FLEE_CHANCE;
	int GORE_FORWARD_DAMAGE;
	float GORE_SIDE_DAMAGE;
	int HUNT_AGRO;
	int IS_HARD;
	int NPC_BASE_EXP;

	BoarHard()
	{
		GORE_FORWARD_DAMAGE = 2;
		GORE_SIDE_DAMAGE = 1.2;
		BOAR_CAN_CHARGE = 1;
		BOAR_CHARGE_DMG = 4;
		HUNT_AGRO = 1;
		CAN_HEAR = 1;
		FLEE_CHANCE = 0.1;
		IS_HARD = 1;
		NPC_BASE_EXP = 9;
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetName("Ferocious Wild Boar");
		SetHearingSensitivity(2);
		SetModel("monsters/boar1.mdl");
		if (StringToLower(GetMapName()) == "nightmare_thornlands")
		{
			SetMonsterClip(0);
		}
	}

}

}
