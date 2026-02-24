#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_npc_vendor.as"
#include "old_helena/base_old_helena_npc.as"

namespace MS
{

class Genstore : CGameScript
{
	string ANIM_DEATH;
	int CANCHAT;
	int HELENA_SAVED;
	int NO_CHAT;
	float OVERCHARGE;
	int SELL_WEAPON_LEVEL;
	string SOUND_DEATH;
	string STORE_NAME;
	string STORE_TRIGGERTEXT;

	Genstore()
	{
		SOUND_DEATH = "none";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_NAME = "helena_general_store";
		CANCHAT = 1;
		OVERCHARGE = 1.5;
		ANIM_DEATH = "dieforward";
		NO_CHAT = 1;
		SELL_WEAPON_LEVEL = 6;
	}

	void OnSpawn() override
	{
		SetHealth(800);
		SetName("Arthur");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		ScheduleDelayedEvent(120.0, "add_moar_stuff");
	}

	void trade_success()
	{
		if (!(CANCHAT == 1)) return;
		Say("goods[.56] [.4] [.58] [.66]");
		CANCHAT = 0;
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "item_torch", RandomInt(1, 3), 110);
		AddStoreItem(STORE_NAME, "pack_heavybackpack", 1, 115);
		AddStoreItem(STORE_NAME, "smallarms_dagger", 1, 105);
		AddStoreItem(STORE_NAME, "health_mpotion", RandomInt(10, 20), 115, 0.2);
		AddStoreItem(STORE_NAME, "pack_heavybackpack", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "pack_bigsack", 2, OVERCHARGE, SELL_RATIO);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORE_NAME, "sheath_back", 1, 95);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "sheath_belt_holster", 1, 95);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORE_NAME, "blunt_maul", RandomInt(1, 3), 95);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORE_NAME, "armor_leather_studded", 1, 95);
		}
	}

	void add_moar_stuff()
	{
		MOAR_SUFF += 1;
		if (MOAR_STUFF == 1)
		{
			AddStoreItem(STORE_NAME, "proj_arrow_broadhead", 120, 100, 0, 60);
		}
		if (MOAR_STUFF == 2)
		{
			AddStoreItem(STORE_NAME, "proj_arrow_silvertipped", 120, 100, 0, 60);
		}
		if (MOAR_STUFF == 3)
		{
			AddStoreItem(STORE_NAME, "proj_arrow_jagged", 120, 100, 0, 60);
		}
		if (MOAR_STUFF == 4)
		{
			AddStoreItem(STORE_NAME, "proj_arrow_fire", 120, 100, 0, 60);
		}
		if (MOAR_STUFF == 5)
		{
			AddStoreItem(STORE_NAME, "proj_arrow_frost", 120, 800, 0, 30);
		}
		if (MOAR_STUFF == 6)
		{
			AddStoreItem(STORE_NAME, "proj_arrow_holy", 120, 800, 0, 30);
		}
		if (MOAR_STUFF == 7)
		{
			AddStoreItem(STORE_NAME, "proj_poison", 120, 100, 0, 60);
		}
		if (MOAR_STUFF == 8)
		{
			AddStoreItem(STORE_NAME, "proj_arrow_gpoison", 120, 800, 0, 30);
		}
		if (MOAR_STUFF == 9)
		{
			AddStoreItem(STORE_NAME, "proj_arrow_lightning", 120, 800, 0, 30);
		}
		if (!(MOAR_STUFF < 9)) return;
		ScheduleDelayedEvent(120.0, "add_moar_stuff");
	}

	void old_helena_warboss_died()
	{
		AddStoreItem(STORE_NAME, "item_gwond", 1, 0);
		HELENA_SAVED = 1;
		SpawnNPC("chests/bank1", /* TODO: $relpos */ $relpos(80, 30, 50), ScriptMode::Legacy);
	}

	void basevendor_offerstore()
	{
		if (!(HELENA_SAVED)) return;
		SayText("Just for you , " + I + " ve these old galat storage notes you can use to trade gold with your friends.");
		bchat_mouth_move();
	}

}

}
