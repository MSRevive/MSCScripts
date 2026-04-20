#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemLog : CGameScript
{
	string MODEL_HANDS;
	string MODEL_WORLD;
	string SCRIPT_ID;
	string TORCH_LIGHT_SCRIPT;

	ItemLog()
	{
		MODEL_WORLD = "misc/item_log.mdl";
		MODEL_HANDS = "misc/item_log.mdl";
		TORCH_LIGHT_SCRIPT = "items/item_torch_light";
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
