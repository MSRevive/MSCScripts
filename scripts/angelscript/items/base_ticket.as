#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class BaseTicket : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;

	BaseTicket()
	{
		MODEL_WORLD = "garbagegibs.mdl";
		MODEL_HANDS = "misc/p_misc.mdl";
	}

	void OnSpawn() override
	{
		ticket_spawn();
		SetDescription("The ticket reads: redeem at any Galat Storage Outlet for the associated item");
		SetHUDSprite("trade", "letter");
	}

}

}
