#pragma context server

#include "items/base_miscitem.as"

namespace MS
{

class ItemLogMagic : CGameScript
{
	int IN_WORLD;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PARTY_STARTED;
	string SCRIPT_ID;
	string TORCH_LIGHT_SCRIPT;

	ItemLogMagic()
	{
		MODEL_WORLD = "misc/item_log.mdl";
		MODEL_HANDS = "misc/item_log.mdl";
		TORCH_LIGHT_SCRIPT = "player/player_conartist";
	}

	void miscitem_spawn()
	{
		SetName("Magical Firewood");
		SetDescription("Some strange artifact assembled by a somewhat flamboyant wizard");
		SetWeight(7);
		SetSize(7);
		SetValue(5);
		SetHUDSprite("trade", "log");
	}

	void OnDrop() override
	{
		ClientEvent("persist", "all", TORCH_LIGHT_SCRIPT, "disco", GetEntityIndex(GetOwner()));
		SCRIPT_ID = "game.script.last_sent_id";
		IN_WORLD = 1;
		if (!(PARTY_STARTED))
		{
			PARTY_STARTED = 1;
			ScheduleDelayedEvent(0.2, "music_loop");
		}
		ScheduleDelayedEvent(0.1, "world_boogie");
	}

	void OnPickup(CBaseEntity@ player) override
	{
		ClientEvent("remove", "all", SCRIPT_ID);
		IN_WORLD = 0;
	}

	void game_remove()
	{
		ClientEvent("remove", "all", SCRIPT_ID);
		IN_WORLD = 0;
	}

	void world_boogie()
	{
		SetRepeatDelay(0.2);
		if (!(IN_WORLD)) return;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", RandomInt(80, 255));
	}

	void music_loop()
	{
		SetRepeatDelay(13.2);
		if (!(IN_WORLD)) return;
		EmitSound(GetOwner(), 0, "magic/disco_loop.wav", 10);
	}

}

}
