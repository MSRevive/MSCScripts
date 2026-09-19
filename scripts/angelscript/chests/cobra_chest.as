#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class CobraChest : CGameScript
{
	void OnSpawn() override
	{
		int L_DAXE_CHANCE = 5;
		if ((GetEntityProperty(GAME_MASTER, "scriptvar")))
		{
			L_DAXE_CHANCE_MULT += 4;
		}
		if ((GetEntityProperty(GAME_MASTER, "scriptvar")))
		{
			L_DAXE_CHANCE_MULT += 4;
		}
		tc_add_artifact("axes_dragon", L_DAXE_CHANCE);
	}

	void chest_additems()
	{
		add_gold(RandomInt(500, 1000));
		add_epic_item();
		if (RandomInt(1, 8) <= "game.playersnb")
		{
			add_epic_item();
		}
		add_great_item();
		add_great_item();
		add_great_item();
	}

}

}
