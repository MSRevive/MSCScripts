#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "helena/helena_npc.as"

namespace MS
{

class Genstore : CGameScript
{
	string ANIM_DEATH;
	int CANCHAT;
	int NO_CHAT;
	float OVERCHARGE;
	int SELL_WEAPON_LEVEL;
	string SOUND_DEATH;
	string STORE_NAME;
	string STORE_TRIGGERTEXT;
	int VEND_CONTAINERS;
	int VEND_NEWBIE;
	int VEND_WEAPONS;

	Genstore()
	{
		SOUND_DEATH = "none";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_NAME = "helena_arthur_store";
		CANCHAT = 1;
		OVERCHARGE = 1.5;
		ANIM_DEATH = "dieforward";
		NO_CHAT = 1;
		SELL_WEAPON_LEVEL = 6;
		VEND_NEWBIE = 1;
		VEND_WEAPONS = 1;
		VEND_CONTAINERS = 1;
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetName("Arthur");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
	}

	void trade_success()
	{
		if (!(CANCHAT == 1)) return;
		Say("goods[.56] [.4] [.58] [.66]");
		CANCHAT = 0;
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "item_torch", RandomInt(1, 3), OVERCHARGE);
		AddStoreItem(STORE_NAME, "pack_heavybackpack", 1, OVERCHARGE);
		AddStoreItem(STORE_NAME, "smallarms_dagger", 1, OVERCHARGE);
		AddStoreItem(STORE_NAME, "health_mpotion", RandomInt(10, 20), 115, 0.2);
		AddStoreItem(STORE_NAME, "pack_heavybackpack", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "pack_bigsack", 2, OVERCHARGE, SELL_RATIO);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORE_NAME, "blunt_maul", RandomInt(1, 3), OVERCHARGE);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORE_NAME, "armor_leather_studded", 1, OVERCHARGE);
		}
	}

}

}
