#pragma context server

#include "NPCs/base_banker.as"

namespace MS
{

class Deraliateller : CGameScript
{
	int NO_CHAT;
	int STORAGE_ACCOUNT_COST;
	string STORAGE_DISPLAYNAME;
	float STORAGE_FEERATIO;
	string STORAGE_NAME;

	Deraliateller()
	{
		STORAGE_DISPLAYNAME = "Deralia Bank";
		STORAGE_NAME = "deraliastorage";
		STORAGE_FEERATIO = 0.10;
		STORAGE_ACCOUNT_COST = 20;
		NO_CHAT = 1;
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
