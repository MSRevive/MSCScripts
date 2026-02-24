#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class UndercliffsBoss1a : CGameScript
{
	int BC_GLOWSHELL;
	string BC_GLOWSHELL_COLOR;
	int BC_SPRITE_IN;

	UndercliffsBoss1a()
	{
		BC_SPRITE_IN = 1;
		BC_GLOWSHELL = 1;
		BC_GLOWSHELL_COLOR = Vector3(128, 0, 128);
	}

	void OnSpawn() override
	{
		SetName("Widow Chest");
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
		if (RandomInt(1, 5) == 1)
		{
			add_epic_item();
		}
		AddStoreItem(STORENAME, "mana_prot_spiders", 1, 0);
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
			add_great_pot();
		}
		if (L_RAND == 2)
		{
			add_great_pot();
			add_great_pot();
		}
		if (L_RAND == 3)
		{
			add_epic_pot();
		}
		if (L_RAND == 4)
		{
			add_great_pot();
			add_epic_pot();
		}
		if (L_RAND == 5)
		{
			add_epic_pot();
			add_epic_pot();
		}
	}

}

}
