#pragma context server

#include "monsters/k_alcolyte.as"

namespace MS
{

class KAlcolyteAmbush : CGameScript
{
	KAlcolyteAmbush()
	{
		const int NPC_PROX_ACTIVATE = 1;
		const int NPC_PROXACT_RANGE = 512;
		const string NPC_PROXACT_EVENT = "ambush";
		const int NPC_PROXACT_IFSEEN = 1;
		const int NPC_PROXACT_FOV = 1;
		const int NPC_PROXACT_CONE = 90;
		const int I_POUNCE = 1;
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
