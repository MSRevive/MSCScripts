#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Lodagond3 : CGameScript
{
	void OnSpawn() override
	{
		SetName("Lodagond Bonus Chest 1");
	}

	void chest_additems()
	{
		add_gold(RandomInt(100, 200));
		chest_add_hpot_mpot();
		add_epic_item();
		add_great_item();
		if (!("game.playersnb" > 1)) return;
		add_epic_item();
		if (!("game.playersnb" > 2)) return;
		add_epic_item();
		if (!("game.playersnb" > 3)) return;
		add_great_item();
		add_great_item();
		add_epic_item();
		AddStoreItem(STORENAME, "mana_speed", 1, 0);
	}

}

}
