#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Hunderswamp1Final : CGameScript
{
	void OnSpawn() override
	{
		SetProp(GetOwner(), "scale", 2.0);
		SetWidth(40);
		SetHeight(60);
		tc_add_artifact("blunt_staff_a", 8);
	}

	void chest_additems()
	{
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_great_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_great_item();
		}
		add_gold(RandomInt(3000, 5000));
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "mana_sb", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "armor_helm_gray", 1, 0);
		}
		if (RandomInt(1, 20) == 1)
		{
			AddStoreItem(STORENAME, "swords_rune_green", 1, 0);
		}
		if (RandomInt(1, 10) == 1)
		{
			AddStoreItem(STORENAME, "scroll2_acid_xolt", 1, 0);
		}
	}

}

}
