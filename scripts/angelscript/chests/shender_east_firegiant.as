#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ShenderEastFiregiant : CGameScript
{
	void OnSpawn() override
	{
		SetName("Fire Giant Chest");
		G_GAVE_TOME7 += 1;
		tc_add_artifact("blunt_bf", 8);
		tc_add_artifact("blunt_bt", 8);
	}

	void chest_additems()
	{
		if (RandomInt(1, 16) <= 1)
		{
			AddStoreItem(STORENAME, "shields_f", 1, 0);
		}
		add_epic_item();
		for (int i = 0; i < "game.playersnb"; i++)
		{
			add_epics();
		}
		add_great_item();
		add_great_item();
		add_great_item();
		add_gold(500);
		if ("game.players.totalhp" > 2000)
		{
			add_epic_item();
		}
	}

	void add_epics()
	{
		add_epic_item();
	}

}

}
