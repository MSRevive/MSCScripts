#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class FinalChest : CGameScript
{
	string SCROLL_LIST;
	string TOME_LIST;

	FinalChest()
	{
		TOME_LIST = "scroll_fire_wall;scroll_lightning_storm;scroll_acid_xolt;scroll_ice_blast;scroll_volcano;scroll_healing_wave";
		SCROLL_LIST = "scroll2_fire_wall;scroll2_lightning_storm;scroll2_acid_xolt;scroll2_ice_blast;scroll2_volcano;scroll2_healing_wave";
	}

	void chest_additems()
	{
		add_gold(800);
		offer_felewyn_symbol(100);
		AddStoreItem(STORENAME, "item_charm_w2", 1, 0);
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "armor_paura", 1, 0);
		}
		add_epic_item();
		add_random_spell();
		if (RandomInt(1, 8) == 1)
		{
			add_random_spell();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_random_spell();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
	}

	void add_random_spell()
	{
		int L_LIST = RandomInt(0, 1);
		if (L_LIST == 0)
		{
			string L_LIST = TOME_LIST;
		}
		else
		{
			string L_LIST = SCROLL_LIST;
		}
		string N_SCROLLS = GetTokenCount(L_LIST, ";");
		N_SCROLLS -= 1;
		int RND_PICK = RandomInt(0, N_SCROLLS);
		string SCROLL_NAME = GetToken(L_LIST, RND_PICK, ";");
		AddStoreItem(STORENAME, SCROLL_NAME, 1, 0);
	}

}

}
