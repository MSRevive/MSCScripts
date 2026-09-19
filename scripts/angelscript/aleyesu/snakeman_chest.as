#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class SnakemanChest : CGameScript
{
	string SCROLL_LIST;

	SnakemanChest()
	{
		SCROLL_LIST = "scroll2_fire_ball;scroll2_blizzard;scroll2_poison;scroll2_frost_xolt;scroll2_fire_wall;scroll2_lightning_storm;scroll_summon_undead";
	}

	void chest_additems()
	{
		add_gold(RandomInt(25, 300));
		AddStoreItem(STORENAME, "key_blue", 1, 0);
		add_a_spell();
		if ((RandomInt(0, 1)))
		{
			add_a_spell();
		}
		if (RandomInt(1, 4) == 1)
		{
			add_a_spell();
		}
	}

	void add_a_spell()
	{
		string N_SCROLLS = GetTokenCount(SCROLL_LIST, ";");
		N_SCROLLS -= 1;
		int RND_PICK = RandomInt(0, SCROLL_LIST);
		string SCROLL_NAME = GetToken(SCROLL_LIST, RND_PICK, ";");
		AddStoreItem(STORENAME, SCROLL_NAME, 1, 0);
	}

}

}
