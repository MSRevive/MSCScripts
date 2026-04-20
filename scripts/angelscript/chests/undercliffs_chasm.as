#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class UndercliffsChasm : CGameScript
{
	int BC_SPRITE_IN;

	UndercliffsChasm()
	{
		BC_SPRITE_IN = 1;
	}

	void OnSpawn() override
	{
		SetMonsterClip(0);
	}

	void chest_additems()
	{
		string L_GOLD_TO_ADD = GetEntityProperty(CHEST_USER, "scriptvar");
		L_GOLD_TO_ADD *= 2;
		L_GOLD_TO_ADD *= "game.playersnb";
		if (L_GOLD_TO_ADD > 25000)
		{
			int L_GOLD_TO_ADD = 25000;
		}
		add_gold(int(L_GOLD_TO_ADD));
		for (int i = 0; i < RandomInt(1, 2); i++)
		{
			add_items_self_adj();
		}
	}

	void add_items_self_adj()
	{
		int L_RAND = RandomInt(1, 5);
		if (L_RAND == 1)
		{
			add_noob_item();
		}
		if (L_RAND == 2)
		{
			add_great_item();
		}
		if (L_RAND == 3)
		{
			add_epic_item();
		}
		if (L_RAND == 4)
		{
			add_epic_item();
			add_epic_arrows(15);
		}
		if (L_RAND == 5)
		{
			add_epic_item();
			add_epic_arrows(30);
		}
	}

}

}
