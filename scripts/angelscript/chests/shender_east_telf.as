#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ShenderEastTelf : CGameScript
{
	int CHEST_LOCKED;

	ShenderEastTelf()
	{
		CHEST_LOCKED = 1;
	}

	void OnSpawn() override
	{
		SetName("Fedrosh's Lockbox");
		SetName("telf_chest");
		tc_add_artifact("smallarms_crec", 17);
	}

	void ext_unlock()
	{
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 255, 255), 64, 90.0);
	}

	void chest_additems()
	{
		if (RandomInt(1, 16) <= "game.playersnb")
		{
			AddStoreItem(STORENAME, "swords_katana4", 1, 0);
		}
		add_epic_item();
		for (int i = 0; i < "game.playersnb"; i++)
		{
			add_epics();
		}
		if ("game.players.totalhp" >= 2000)
		{
			for (int i = 0; i < 2; i++)
			{
				add_epics();
			}
		}
		if ("game.players.totalhp" >= 4000)
		{
			for (int i = 0; i < 4; i++)
			{
				add_epics();
			}
		}
		add_great_item();
		add_great_item();
		add_great_item();
		add_great_pot();
		add_epic_pot();
	}

	void add_epics()
	{
		add_epic_item();
	}

}

}
