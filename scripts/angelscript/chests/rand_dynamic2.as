#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class RandDynamic2 : CGameScript
{
	string CHEST_TIER;

	void chest_additems()
	{
		CHEST_TIER = GetEntityMaxHealth(CHEST_USER);
		CHEST_TIER /= 500;
		if (("game.central"))
		{
			string L_NPLAYERS = "game.playersnb";
			if (L_NPLAYERS > 1)
			{
			}
			L_NPLAYERS *= 0.5;
			CHEST_TIER += L_NPLAYERS;
		}
		LogDebug("chest_additems chest_tier CHEST_TIER");
		if ((BC_USE_TRACKER))
		{
			if (!(CHEST_FOUND))
			{
				CHEST_FOUND = 1;
				G_CHEST_TRACKER += 1;
			}
			string L_GMULTI = /* TODO: $math(multiply) */ G_CHEST_TRACKER;
		}
		else
		{
			string L_GMULTI = CHEST_TIER;
		}
		string L_GOLD_TO_ADD = GetEntityProperty(CHEST_USER, "scriptvar");
		L_GOLD_TO_ADD *= L_GMULTI;
		if (("game.central"))
		{
			L_GOLD_TO_ADD *= "game.playersnb";
		}
		LogDebug("rand_self_adj gold: int(L_GOLD_TO_ADD)");
		add_gold(int(L_GOLD_TO_ADD));
		if ((BC_USE_TRACKER))
		{
			for (int i = 0; i < G_CHEST_TRACKER; i++)
			{
				add_items_self_adj();
			}
		}
		else
		{
			for (int i = 0; i < int(CHEST_TIER); i++)
			{
				add_items_self_adj();
			}
		}
	}

	void add_items_self_adj()
	{
		LogDebug("add_items_self_adj CHEST_TIER");
		if (CHEST_TIER < 2)
		{
			string L_TYPE = /* TODO: $func */ $func("get_type", 30, 30, 30);
			if (L_TYPE == 1)
			{
				add_great_item(1.0);
			}
			else
			{
				if (L_TYPE == 2)
				{
					add_good_pot(1.0);
				}
				else
				{
					if (L_TYPE == 3)
					{
						add_good_arrows(1.0);
					}
				}
			}
		}
		if (CHEST_TIER >= 2)
		{
			if (CHEST_TIER < 3)
			{
			}
			string L_TYPE = /* TODO: $func */ $func("get_type", 10, 25, 65);
			if (L_TYPE == 1)
			{
				add_good_pot(1.0);
			}
			else
			{
				if (L_TYPE == 2)
				{
					add_epic_item(1.0);
				}
				else
				{
					if (L_TYPE == 3)
					{
						add_great_arrows(1.0);
					}
				}
			}
		}
		if (CHEST_TIER >= 3)
		{
			if (CHEST_TIER < 4)
			{
			}
			string L_TYPE = /* TODO: $func */ $func("get_type", 10, 35, 55);
			if (L_TYPE == 1)
			{
				add_great_pot(1.0);
			}
			else
			{
				if (L_TYPE == 2)
				{
					add_epic_item(1.0);
				}
				else
				{
					if (L_TYPE == 3)
					{
						add_epic_arrows(1.0);
					}
				}
			}
		}
		if (CHEST_TIER >= 4)
		{
			if (CHEST_TIER < 5)
			{
			}
			string L_TYPE = /* TODO: $func */ $func("get_type", 5, 40, 55);
			if (L_TYPE == 1)
			{
				add_epic_pot(1.0);
			}
			else
			{
				if (L_TYPE == 2)
				{
					add_epic_item(1.0);
				}
				else
				{
					if (L_TYPE == 3)
					{
						add_epic_arrows(1.0);
					}
				}
			}
		}
		if (CHEST_TIER >= 5)
		{
			string L_TYPE = /* TODO: $func */ $func("get_type", 10, 40, 50);
			if (L_TYPE == 1)
			{
				add_epic_pot(1.0);
			}
			else
			{
				if (L_TYPE == 2)
				{
					add_epic_item(1.0);
				}
				else
				{
					if (L_TYPE == 3)
					{
						add_epic_arrows(1.0);
					}
				}
			}
		}
	}

	void get_type()
	{
		string L_ROLL = RandomInt(1, 100);
		if (L_ROLL <= param1)
		{
			return;
			LogDebug("get_type [ PARAM1 PARAM2 PARAM3 ] L_ROLL = 1");
			return;
		}
		if (L_ROLL > param1)
		{
			if (L_ROLL <= param2)
			{
			}
			LogDebug("get_type [ PARAM1 PARAM2 PARAM3 ] L_ROLL = 2");
			return;
			return;
		}
		LogDebug("get_type [ PARAM1 PARAM2 PARAM3 ] L_ROLL = 3");
		return;
	}

}

}
