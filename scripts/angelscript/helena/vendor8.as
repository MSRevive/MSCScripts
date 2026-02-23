#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "helena/helena_npc.as"

namespace MS
{

class Vendor8 : CGameScript
{
	string ANIM_DEATH;
	string ARROW_AMT;
	int CANCHAT;
	float OVERCHARGE;
	float SELL_RATIO;
	string STORE_NAME;
	string STORE_TRIGGERTEXT;
	int VEND_ARMORER;
	int VEND_CONTAINERS;
	int VEND_NEWBIE;
	int VEND_WEAPONS;

	Vendor8()
	{
		const string SOUND_DEATH = "none";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_NAME = "helena_general_store";
		CANCHAT = 1;
		OVERCHARGE = 1.5;
		SELL_RATIO = 0.8;
		ANIM_DEATH = "diesimple";
		const int NO_CHAT = 1;
		VEND_NEWBIE = 1;
		VEND_WEAPONS = 1;
		VEND_CONTAINERS = 1;
		VEND_ARMORER = 0;
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetName("Fletcher");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		VEND_NEWBIE = 1;
		VEND_WEAPONS = 1;
		VEND_CONTAINERS = 1;
		VEND_ARMORER = 0;
	}

	void trade_success()
	{
		if (!(CANCHAT == 1)) return;
		Say("goods[.56] [.4] [.58] [.66]");
		CANCHAT = 0;
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "proj_arrow_fire", 600, OVERCHARGE, 0, 60);
		AddStoreItem(STORE_NAME, "proj_arrow_wooden", 600, OVERCHARGE, 0, 60);
		AddStoreItem(STORE_NAME, "proj_arrow_broadhead", 300, OVERCHARGE, 0, 60);
		AddStoreItem(STORE_NAME, "proj_arrow_silvertipped", 300, OVERCHARGE, 0, 60);
		AddStoreItem(STORE_NAME, "proj_arrow_poison", 300, OVERCHARGE, 0, 120);
		AddStoreItem(STORE_NAME, "proj_bolt_wooden", 100, OVERCHARGE, 0, 25);
		AddStoreItem(STORE_NAME, "proj_bolt_iron", 100, OVERCHARGE, 0, 25);
		AddStoreItem(STORE_NAME, "pack_quiver", 3, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "bows_orcbow", 1, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "bows_treebow", 2, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "bows_shortbow", 1, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "item_feather", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "pack_quiver", 1, OVERCHARGE, SELL_RATIO);
		if (RandomInt(1, 12) == 1)
		{
			ARROW_AMT = RandomInt(1, 5);
			ARROW_AMT *= 30;
			AddStoreItem(STORE_NAME, "proj_arrow_jagged", ARROW_AMT, OVERCHARGE, SELL_RATIO, 30);
		}
		if (RandomInt(1, 10) == 1)
		{
		}
	}

}

}
