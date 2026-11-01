#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class FminesSpider : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("smallarms_cre", 5);
		tc_add_artifact("armor_faura", 5);
		tc_add_artifact("armor_helm_gaz2", 5);
		tc_add_artifact("armor_helm_gray", 5);
		tc_add_artifact("armor_helm_undead", 5);
		tc_add_artifact("armor_paura", 5);
	}

	void chest_additems()
	{
		string L_GOLD_TO_ADD = GetEntityProperty(CHEST_USER, "scriptvar");
		L_GOLD_TO_ADD *= "game.playersnb";
		L_GOLD_TO_ADD *= 10;
		add_gold(L_GOLD_TO_ADD);
		add_epic_arrows();
		add_epic_arrows();
		if (RandomInt(1, 3) == 1)
		{
			add_epic_arrows();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_epic_item();
			add_epic_arrows();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_epic_item();
			add_epic_item();
			add_epic_arrows();
			add_epic_arrows();
		}
		if (RandomInt(1, 6) == 1)
		{
			add_epic_item();
			add_epic_arrows();
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "mana_paura", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "mana_faura", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "mana_fbrand", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "mana_font", 1, 0);
		}
		offer_felewyn_symbol(10);
	}

}

}
