#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class BaseTicket : CGameScript
{
	BaseTicket()
	{
		const string MODEL_WORLD = "garbagegibs.mdl";
		const string MODEL_HANDS = "misc/p_misc.mdl";
	}

	void OnSpawn() override
	{
		ticket_spawn();
		SetDescription("The ticket reads: redeem at any Galat Storage Outlet for the associated item");
		SetHUDSprite("trade", "letter");
	}

}

}
