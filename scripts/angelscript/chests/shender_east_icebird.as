#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ShenderEastIcebird : CGameScript
{
	string BC_FARTIFACTS;

	ShenderEastIcebird()
	{
		BC_FARTIFACTS = "mana_faura;mana_fbrand;scroll_ice_blast";
	}

	void OnSpawn() override
	{
		SetName("Icewing Chest");
		tc_add_artifact("mana_faura", 50);
		tc_add_artifact("mana_fbrand", 50);
		tc_add_artifact("scroll_ice_blast", 15);
	}

	void chest_additems()
	{
		if ("game.players.totalhp" >= 2000)
		{
			for (int i = 0; i < 2; i++)
			{
				add_epics();
			}
		}
		add_epic_item();
		for (int i = 0; i < "game.playersnb"; i++)
		{
			add_greats();
		}
		add_gold(500);
	}

	void add_greats()
	{
		add_great_item();
	}

	void add_epics()
	{
		add_epic_item();
	}

}

}
