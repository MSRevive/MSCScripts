#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class UndercliffsSekrat : CGameScript
{
	int BC_SPRITE_IN;

	UndercliffsSekrat()
	{
		BC_SPRITE_IN = 1;
	}

	void OnSpawn() override
	{
		SetMonsterClip(0);
		tc_add_artifact("armor_helm_gaz2", 6);
		tc_add_artifact("armor_helm_gray", 6);
		tc_add_artifact("axes_tp", 6);
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
			add_great_item();
			add_good_pot();
		}
		if (L_RAND == 2)
		{
			add_epic_item();
			add_good_pot();
			add_great_pot();
		}
		if (L_RAND == 3)
		{
			add_epic_item();
			add_great_pot();
			add_epic_pot();
		}
		if (L_RAND == 4)
		{
			add_epic_item();
			add_epic_arrows(15);
			add_epic_pot();
		}
		if (L_RAND == 5)
		{
			add_epic_item();
			add_epic_arrows(30);
			add_great_pot();
			add_epic_pot();
		}
	}

}

}
