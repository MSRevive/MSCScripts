#pragma context server

namespace MS
{

class BaseMagic : CGameScript
{
	int B_OVERCHARGE;
	float B_SELL_RATIO;
	string MAGIC_SHOP;
	float MICRO_RATIO;

	BaseMagic()
	{
		MICRO_RATIO = 0.01;
		B_SELL_RATIO = 0.25;
		B_OVERCHARGE = 200;
	}

	void vendor_addstoreitems()
	{
		ScheduleDelayedEvent(0.1, "bs_supplement");
	}

	void bs_supplement()
	{
		if (MAGIC_SHOP == "MAGIC_SHOP")
		{
			MAGIC_SHOP = 1;
		}
		if (!(MAGIC_SHOP)) return;
		if (!(ItemExists(GetOwner(), "sheath_spellbook")))
		{
			AddStoreItem(STORE_NAME, "sheath_spellbook", RandomInt(3, 6), B_OVERCHARGE, B_SELL_RATIO);
		}
		bs_epic_item();
		if (!(OVERCHARGE != "OVERCHARGE")) return;
		AddStoreItem(STORE_NAME, "scroll_fire_ball", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_fire_dart", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_fire_wall", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_glow", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_ice_shield", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_ice_wall", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_lightning_chain", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_lightning_storm", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_lightning_weak", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_poison", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_rejuvenate", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_summon_rat", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_summon_undead", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll_volcano", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_acid_xolt", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_blizzard", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_fire_ball", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_fire_dart", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_fire_wall", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_frost_bolt", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_frost_xolt", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_glow", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_ice_blast", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_ice_shield", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_ice_wall", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_lightning_chain", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_lightning_storm", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_lightning_weak", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_poison", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_poison_cloud", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_rejuvenate", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_summon_rat", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_summon_undead", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_turn_undead", 0, B_OVERCHARGE, B_SELL_RATIO);
		AddStoreItem(STORE_NAME, "scroll2_volcano", 0, B_OVERCHARGE, B_SELL_RATIO);
	}

	void bs_epic_item()
	{
	}

}

}
