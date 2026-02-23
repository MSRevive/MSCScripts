#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class PhlamesFinal : CGameScript
{
	PhlamesFinal()
	{
		const string SOME_POTS = "mana_paura;mana_faura;mana_fbrand;mana_font;mana_immune_cold;mana_resist_cold;mana_immune_lightning";
	}

	void OnSpawn() override
	{
		SetName("Treasure Chest");
		tc_add_artifact("blunt_staff_f", 7);
	}

	void chest_additems()
	{
		add_gold(500);
		AddStoreItem(STORENAME, "mana_immune_cold", 1, 0);
		AddStoreItem(STORENAME, "item_gwond", 1, 0);
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "item_charm_w3", 1, 0);
		}
		AddStoreItem(STORENAME, "item_eh", 1, 0);
		offer_felewyn_symbol(100);
		add_epic_item();
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "blunt_gauntlets_demon", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			powshuns_i_got_powshuns();
		}
		add_epic_item();
		add_epic_item();
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "polearms_nag", 1, 0);
		}
		if (RandomInt(1, 15) == 1)
		{
			AddStoreItem(STORENAME, "armor_fireliz", 1, 0);
		}
		if (RandomInt(1, 15) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 25) == 1)
		{
			AddStoreItem(STORENAME, "bows_firebird", 1, 0);
		}
		if (RandomInt(1, 15) == 1)
		{
			powshuns_i_got_powshuns();
		}
		if (RandomInt(1, 30) == 1)
		{
			AddStoreItem(STORENAME, "axes_dragon", 1, 0);
		}
		if (RandomInt(1, 15) == 1)
		{
			add_epic_item();
		}
		add_epic_arrows(60);
		if (RandomInt(1, 8) == 1)
		{
			powshuns_i_got_powshuns();
		}
	}

	void powshuns_i_got_powshuns()
	{
		string N_POTS = GetTokenCount(SOME_POTS, ";");
		N_POTS -= 1;
		string RND_POT_IDX = RandomInt(SOME_POTS, N_POTS);
		string RND_POT = GetToken(SOME_POTS, RND_POT_IDX, ";");
		AddStoreItem(STORENAME, RND_POT, 1, 0);
	}

}

}
