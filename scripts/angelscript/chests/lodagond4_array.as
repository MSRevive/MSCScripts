#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Lodagond4Array : CGameScript
{
	void OnSpawn() override
	{
		tc_add_artifact("smallarms_frozentongueonflagpole", 100);
		tc_add_artifact("bows_thornbow", 100);
		tc_add_artifact("scroll2_lightning_chain", 100);
		tc_add_artifact("blunt_mithral", 100);
		tc_add_artifact("mana_leadfoot", 100);
		tc_add_artifact("armor_belmont", 100);
		tc_add_artifact("armor_helm_gaz2", 100);
		tc_add_artifact("swords_frostblade55", 100);
	}

	void chest_additems()
	{
		add_gold(RandomInt(800, 1400));
		AddStoreItem(STORENAME, "item_crystal_reloc", 1, 0);
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "mana_resist_cold", 1, 0);
		}
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "mana_resist_fire", 1, 0);
		}
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "mana_protection", 1, 0);
		}
		if (RandomInt(1, 12) == 1)
		{
			AddStoreItem(STORENAME, "mana_gprotection", 1, 0);
		}
		if (RandomInt(1, 12) == 1)
		{
			AddStoreItem(STORENAME, "mana_speed", 1, 0);
		}
		if (RandomInt(1, 12) == 1)
		{
			AddStoreItem(STORENAME, "mana_demon_blood", 1, 0);
		}
		if (RandomInt(1, 12) == 1)
		{
			AddStoreItem(STORENAME, "mana_gprotection", 1, 0);
		}
		if (RandomInt(1, 12) == 1)
		{
			AddStoreItem(STORENAME, "mana_speed", 1, 0);
		}
		if (RandomInt(1, 12) == 1)
		{
			AddStoreItem(STORENAME, "mana_demon_blood", 1, 0);
		}
	}

}

}
