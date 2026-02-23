#pragma context server

#include "monsters/boar.as"

namespace MS
{

class BoarHard : CGameScript
{
	int CAN_HEAR;
	int HUNT_AGRO;

	BoarHard()
	{
		const int GORE_FORWARD_DAMAGE = 2;
		const float GORE_SIDE_DAMAGE = 1.2;
		const int BOAR_CAN_CHARGE = 1;
		const int BOAR_CHARGE_DMG = 4;
		HUNT_AGRO = 1;
		CAN_HEAR = 1;
		const float FLEE_CHANCE = 0.1;
		const int IS_HARD = 1;
		const int NPC_BASE_EXP = 9;
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
