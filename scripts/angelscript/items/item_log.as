#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemLog : CGameScript
{
	string SCRIPT_ID;

	ItemLog()
	{
		const string MODEL_WORLD = "misc/item_log.mdl";
		const string MODEL_HANDS = "misc/item_log.mdl";
		const string TORCH_LIGHT_SCRIPT = "items/item_torch_light";
	}

	void miscitem_spawn()
	{
		SetName("Firewood");
		SetDescription("Some high quality firewood");
		SetWeight(7);
		SetSize(7);
		SetValue(5);
		SetHUDSprite("trade", "log");
	}

	void OnDrop() override
	{
		ClientEvent("persist", "all", TORCH_LIGHT_SCRIPT, GetEntityIndex(GetOwner()), 1);
		SCRIPT_ID = "game.script.last_sent_id";
	}

	void OnPickup(CBaseEntity@ player) override
	{
		ClientEvent("remove", "all", SCRIPT_ID);
	}

}

}
