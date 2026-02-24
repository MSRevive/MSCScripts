#pragma context server

#include "monsters/base_npc.as"
#include "help/first_vendor.as"
#include "helena/helena_npc.as"
#include "shops/base_magic.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor_confirm.as"

namespace MS
{

class Vendor : CGameScript
{
	string ANIM_DEATH;
	string L_SERVICE;
	int MAGIC_SHOP;
	int NO_CHAT;
	int OVERCHARGE;
	float SELL_RATIO;
	int SELL_WEAPON_LEVEL;
	string SOUND_DEATH;
	int STORE_BUYMENU;
	string STORE_NAME;
	int STORE_RESTOCK;
	int STORE_SELLMENU;
	string STORE_TRADEEXT;
	string STORE_TRIGGERTEXT;
	int STORE_TYPE;
	string TEMP;
	int VEND_ARMORER;
	int VEND_CONTAINERS;
	int VEND_NEWBIE;
	string VEND_NO_GOODBYE;
	int VEND_WEAPONS;

	Vendor()
	{
		SOUND_DEATH = "none";
		ANIM_DEATH = "diesimple";
		STORE_TRADEEXT = "trade";
		STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		STORE_SELLMENU = 1;
		STORE_BUYMENU = 1;
		STORE_RESTOCK = 0;
		NO_CHAT = 1;
		MAGIC_SHOP = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(STORE_RESTOCK_TIME_LO, STORE_RESTOCK_TIME_HI));
		if (!(RAID_ON))
		{
		}
		if ((STORE_RESTOCK))
		{
		}
		NpcStoreRemove(STORE_NAME, "allitems");
		vendor_addstoreitems();
	}

	void OnSpawn() override
	{
		SetHealth(35);
		SetName("Traveling Merchant");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(0, RandomInt(0, 2));
		SetModelBody(1, RandomInt(0, 5));
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_store", "buy");
		CatchSpeech("say_job", "job");
		TEMP = "helena";
		TEMP += RandomInt(0, 400);
		STORE_NAME = TEMP;
		STORE_TYPE = RandomInt(1, 6);
		OVERCHARGE = RandomInt(100, 150);
		SELL_RATIO = Random(".5", ".9");
	}

	void vendor_addstoreitems()
	{
		store_food();
		store_equip();
		store_armor();
		store_weapon();
		store_magic();
		store_none();
	}

	void store_food()
	{
		if (!(STORE_TYPE == 1)) return;
		AddStoreItem(STORE_NAME, "health_apple", RandomInt(5, 15), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "health_lpotion", 0, OVERCHARGE, 0.1);
		AddStoreItem(STORE_NAME, "item_log", RandomInt(1, 4), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "health_mpotion", 0, OVERCHARGE, 0.1);
		AddStoreItem(STORE_NAME, "health_spotion", 0, OVERCHARGE, 0.1);
		AddStoreItem(STORE_NAME, "pack_bigsack", 1, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "mana_mpotion", 0, OVERCHARGE, 0.1);
	}

	void store_equip()
	{
		if (!(STORE_TYPE == 2)) return;
		AddStoreItem(STORE_NAME, "item_torch", RandomInt(3, 8), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "item_log", RandomInt(1, 4), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "health_mpotion", RandomInt(1, 3), OVERCHARGE, 0.1);
		AddStoreItem(STORE_NAME, "pack_bigsack", RandomInt(1, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "pack_heavybackpack", RandomInt(1, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_back_holster", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "pack_quiver", 0, OVERCHARGE, SELL_RATIO);
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORE_NAME, "health_mpotion", RandomInt(1, 5), OVERCHARGE, 0.1);
		}
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORE_NAME, "health_lpotion", RandomInt(1, 2), OVERCHARGE, 0.1);
		}
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORE_NAME, "health_spotion", RandomInt(1, 2), OVERCHARGE, 0.1);
		}
		VEND_NEWBIE = 1;
		VEND_WEAPONS = 0;
		VEND_CONTAINERS = 1;
		VEND_ARMORER = 0;
	}

	void store_armor()
	{
		if (!(STORE_TYPE == 3)) return;
		AddStoreItem(STORE_NAME, "shields_buckler", RandomInt(1, 5), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_helm_knight", RandomInt(0, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_helm_mongol", RandomInt(0, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_helm_plate", RandomInt(1, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_knight", RandomInt(0, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_leather_studded", RandomInt(1, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_mongol", RandomInt(0, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_plate", RandomInt(1, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "shields_ironshield", RandomInt(1, 3), OVERCHARGE, 0.25);
		AddStoreItem(STORE_NAME, "shields_lironshield", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "skin_bear", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "skin_boar", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "skin_boar_heavy", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "skin_ratpelt", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_dark", 0, 200, 1);
		AddStoreItem(STORE_NAME, "armor_golden", 0, 200, 1);
		AddStoreItem(STORE_NAME, "armor_helm_dark", 0, 200, 1);
		AddStoreItem(STORE_NAME, "armor_helm_golden", 0, 200, 1);
		AddStoreItem(STORE_NAME, "armor_leather", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_leather_torn", 0, OVERCHARGE, SELL_RATIO);
		VEND_NEWBIE = 0;
		VEND_WEAPONS = 0;
		VEND_CONTAINERS = 0;
		VEND_ARMORER = 1;
	}

	void store_weapon()
	{
		if (!(STORE_TYPE == 4)) return;
		SELL_WEAPON_LEVEL = 3;
		AddStoreItem(STORE_NAME, "smallarms_knife", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_dagger", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_shortsword", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_scimitar", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_smallaxe", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_axe", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "axes_2haxe", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_hammer2", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_mace", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_maul", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_gauntlets_leather", RandomInt(0, 1), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "polearms_qs", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "polearms_sp", RandomInt(0, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "blunt_greatmaul", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_katana", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_katana2", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_katana3", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_katana4", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_skullblade", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_skullblade2", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_skullblade3", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "swords_skullblade4", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_fangstooth", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_huggerdagger", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_huggerdagger2", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_huggerdagger3", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_huggerdagger4", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_craftedknife", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_craftedknife2", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_craftedknife3", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "smallarms_craftedknife4", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "sheath_back_holster", 1, OVERCHARGE, SELL_RATIO);
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORE_NAME, "blunt_hammer3", RandomInt(1, 2), OVERCHARGE, SELL_RATIO);
		}
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORE_NAME, "axes_battleaxe", RandomInt(1, 2), OVERCHARGE, SELL_RATIO);
		}
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORE_NAME, "axes_scythe", RandomInt(1, 2), OVERCHARGE, SELL_RATIO);
		}
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORE_NAME, "swords_longsword", RandomInt(1, 2), OVERCHARGE, SELL_RATIO);
		}
		if (!(RandomInt(1, 5) == 1)) return;
		AddStoreItem(STORE_NAME, "sheath_back_holster", 5, 100, SELL_RATIO);
		VEND_NEWBIE = 1;
		VEND_WEAPONS = 1;
		VEND_CONTAINERS = 1;
		VEND_ARMORER = 0;
	}

	void store_magic()
	{
		if (!(STORE_TYPE == 5)) return;
		MAGIC_SHOP = 1;
		AddStoreItem(STORE_NAME, "scroll_fire_dart", RandomInt(1, 4), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_lightning_weak", RandomInt(1, 4), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_glow", RandomInt(1, 5), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_fire_dart", RandomInt(1, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_lightning_weak", RandomInt(0, 1), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_glow", RandomInt(1, 2), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "item_log", RandomInt(1, 4), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_ice_shield", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_summon_rat", RandomInt(0, 3), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_summon_rat", RandomInt(0, 1), OVERCHARGE, 0.1);
		AddStoreItem(STORE_NAME, "mana_mpotion", RandomInt(3, 6), OVERCHARGE, 0.1);
		AddStoreItem(STORE_NAME, "sheath_spellbook", RandomInt(3, 6), OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_blizzard", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_fire_wall", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_ice_wall", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_lightning_storm", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_summon_undead", 0, OVERCHARGE, SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_volcano", 0, OVERCHARGE, SELL_RATIO);
		string EXTRA_OVER = OVERCHARGE;
		EXTRA_OVER *= 1.5;
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORE_NAME, "scroll_summon_undead", RandomInt(1, 2), EXTRA_OVER, 0.5);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORE_NAME, "scroll_rejuvenate", RandomInt(1, 2), EXTRA_OVER, 0.5);
		}
		VEND_NEWBIE = 1;
		VEND_WEAPONS = 1;
		VEND_CONTAINERS = 0;
		VEND_ARMORER = 0;
	}

	void store_none()
	{
		if (!(STORE_TYPE == 6)) return;
		DeleteEntity(GetOwner());
	}

	void trade_done()
	{
		if (!(RandomInt(1, 3) == 1)) return;
		if ((VEND_NO_GOODBYE))
		{
			VEND_NO_GOODBYE = 0;
		}
		else
		{
			SayText("Come again soon!");
		}
	}

	void OnSpawn() override
	{
		CatchSpeech("npc_say_store", STORE_TRIGGERTEXT);
		NpcStoreCreate(STORE_NAME);
		vendor_addstoreitems();
	}

	void game_menu_getoptions()
	{
		if ((RAID_ON)) return;
		vendor_addstoremenu(param1);
	}

	void vendor_addstoremenu()
	{
		string reg.mitem.id = "genericstore";
		int reg.mitem.priority = -100;
		string reg.mitem.access = "all";
		if (!(STORE_CLOSED))
		{
			string reg.mitem.title = "Shop";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "vendor_offerstore";
		}
		else
		{
			string reg.mitem.title = "Closed";
			string reg.mitem.type = "disabled";
		}
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		if ((RAID_ON)) return;
		vendor_used();
		vendor_offerstore(GetEntityIndex(m_hLastUsed));
	}

	void npc_say_store()
	{
		if ((RAID_ON)) return;
		vendor_offerstore("ent_lastspoke");
	}

	void vendor_offerstore()
	{
		if ((RAID_ON)) return;
		basevendor_offerstore(param1);
	}

	void basevendor_offerstore()
	{
		if ((RAID_ON)) return;
		int L_SERVICE = 0;
		if ((STORE_BUYMENU))
		{
			L_SERVICE = "buy";
		}
		if ((STORE_SELLMENU))
		{
			L_SERVICE += ";sell";
		}
		NpcStoreOffer(STORE_NAME, param1, L_SERVICE, "trade");
	}

}

}
