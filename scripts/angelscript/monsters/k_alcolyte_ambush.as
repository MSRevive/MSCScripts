#pragma context server

#include "monsters/k_alcolyte.as"

namespace MS
{

class KAlcolyteAmbush : CGameScript
{
	int I_POUNCE;
	int NPC_PROXACT_CONE;
	string NPC_PROXACT_EVENT;
	int NPC_PROXACT_FOV;
	int NPC_PROXACT_IFSEEN;
	int NPC_PROXACT_RANGE;
	int NPC_PROX_ACTIVATE;

	KAlcolyteAmbush()
	{
		NPC_PROX_ACTIVATE = 1;
		NPC_PROXACT_RANGE = 512;
		NPC_PROXACT_EVENT = "ambush";
		NPC_PROXACT_IFSEEN = 1;
		NPC_PROXACT_FOV = 1;
		NPC_PROXACT_CONE = 90;
		I_POUNCE = 1;
	}

	void OnSpawn() override
	{
		SetRoam(false);
	}

	void run_mode()
	{
		SetRoam(true);
	}

}

}
