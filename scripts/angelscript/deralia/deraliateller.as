#pragma context server

#include "NPCs/base_banker.as"

namespace MS
{

class Deraliateller : CGameScript
{
	Deraliateller()
	{
		const string STORAGE_DISPLAYNAME = "Deralia Bank";
		const string STORAGE_NAME = "deraliastorage";
		const float STORAGE_FEERATIO = 0.10;
		const int STORAGE_ACCOUNT_COST = 20;
		const int NO_CHAT = 1;
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetGold(30);
		SetName("Teller");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
	}

}

}
