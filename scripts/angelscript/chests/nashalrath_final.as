#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class NashalrathFinal : CGameScript
{
	string DID_FIRST_OPEN;

	void OnSpawn() override
	{
		tc_add_artifact("shields_f", 8);
		tc_add_artifact("swords_vb", 8);
		tc_add_artifact("swords_gb", 8);
		SetName("Jaminporlant's Generosity (multi)");
		SetProp(GetOwner(), "scale", 2.0);
	}

	void tc_open()
	{
		if (!(DID_FIRST_OPEN))
		{
			DID_FIRST_OPEN = 1;
			CallExternal(FindEntityByName("gdragon_img"), "ext_exit_sequence");
		}
	}

	void chest_additems()
	{
		add_gold(5000);
		add_epic_item();
		add_epic_item();
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		AddStoreItem(STORENAME, "mana_resist_fire", 1, 0);
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_fire", 1, 0);
		}
		if (RandomInt(1, 24) == 1)
		{
			AddStoreItem(STORENAME, "armor_faura", 1, 0);
		}
		if (RandomInt(1, 24) == 1)
		{
			AddStoreItem(STORENAME, "item_charm_w2", 1, 0);
		}
		if (RandomInt(1, 24) == 1)
		{
			AddStoreItem(STORENAME, GetRandomToken("smallarms_cre;smallarms_cre;smallarms_crel;smallarms_cref", ";"), 1, 0);
		}
		if ("game.players.totalhp" > 4000)
		{
			add_epic_item();
			add_epic_item();
		}
		add_great_item();
		add_great_item();
		add_great_item();
	}

}

}
