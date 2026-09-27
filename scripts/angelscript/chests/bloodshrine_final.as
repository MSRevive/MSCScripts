#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class BloodshrineFinal : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("polearms_a", 8);
	}

	void chest_additems()
	{
		add_gold((1000 * "game.playersnb"));
		AddStoreItem(STORENAME, "proj_arrow_holy", 30, 0, 0, 30);
		AddStoreItem(STORENAME, "proj_arrow_gholy", 30, 0, 0, 30);
		AddStoreItem(STORENAME, "proj_bolt_silver", 30, 0, 0, 30);
		string GAME_PLAYERS = "game.playersnb";
		add_epic_item();
		if (RandomInt(1, 3) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 5) == 1)
		{
			add_epic_item();
		}
		add_epic_pot();
		if (RandomInt(1, 6) == 1)
		{
			AddStoreItem(STORENAME, "mana_sb", 1, 0);
		}
	}

}

}
