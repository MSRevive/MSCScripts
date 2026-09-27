#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class BossChest : CGameScript
{
	void OnSpawn() override
	{
		if (G_BANDIT_BOSS_TYPE == 1)
		{
			tc_add_artifact("smallarms_flamelick", 20);
			tc_add_artifact("smallarms_bone_blade", 20);
		}
		else
		{
			if (G_BANDIT_BOSS_TYPE == 2)
			{
				tc_add_artifact("blunt_darkmaul", 20);
				tc_add_artifact("blunt_ms1", 100);
			}
			else
			{
				if (G_BANDIT_BOSS_TYPE == 3)
				{
					tc_add_artifact("axes_runeaxe", 20);
					tc_add_artifact("axes_greataxe", 30);
				}
				else
				{
					if (G_BANDIT_BOSS_TYPE == 4)
					{
						tc_add_artifact("swords_liceblade", 100);
						tc_add_artifact("swords_iceblade", 30);
						tc_add_artifact("swords_giceblade", 20);
					}
					else
					{
						if (G_BANDIT_BOSS_TYPE == 5)
						{
							tc_add_artifact("bows_crossbow_light", 30);
							tc_add_artifact("bows_swiftbow", 100);
							tc_add_artifact("bows_orion1", 20);
						}
						else
						{
							if (G_BANDIT_BOSS_TYPE == 6)
							{
								tc_add_artifact("swords_novablade12", 20);
								tc_add_artifact("swords_skullblade4", 40);
							}
						}
					}
				}
			}
		}
	}

	void chest_additems()
	{
		add_gold(RandomInt(250, 400));
		if (G_BANDIT_BOSS_TYPE == 1)
		{
			AddStoreItem(STORENAME, "smallarms_dagger", 1, 0);
			AddStoreItem(STORENAME, "smallarms_huggerdagger4", 1, 0);
			if ((RandomInt(0, 1)))
			{
				AddStoreItem(STORENAME, "smallarms_craftedknife4", 1, 0);
			}
		}
		else
		{
			if (G_BANDIT_BOSS_TYPE == 2)
			{
				AddStoreItem(STORENAME, "blunt_mace", 1, 0);
				AddStoreItem(STORENAME, "blunt_granitemaul", 1, 0);
			}
			else
			{
				if (G_BANDIT_BOSS_TYPE == 3)
				{
					AddStoreItem(STORENAME, "axes_rsmallaxe", 1, 0);
					AddStoreItem(STORENAME, "axes_doubleaxe", 1, 0);
				}
				else
				{
					if (G_BANDIT_BOSS_TYPE == 4)
					{
						AddStoreItem(STORENAME, "swords_katana3", 1, 0);
						AddStoreItem(STORENAME, "swords_poison1", 1, 0);
					}
					else
					{
						if (G_BANDIT_BOSS_TYPE == 5)
						{
							AddStoreItem(STORENAME, "bows_treebow", 1, 0);
						}
						else
						{
							if (G_BANDIT_BOSS_TYPE == 6)
							{
								AddStoreItem(STORENAME, "swords_bastardsword", 1, 0);
								AddStoreItem(STORENAME, "mana_resist_fire", TC_NPLAYERS_QUART, 0);
								if ((RandomInt(0, 1)))
								{
									AddStoreItem(STORENAME, "mana_immune_fire", 1, 0);
								}
							}
						}
					}
				}
			}
		}
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		if (RandomInt(1, 3) == 1)
		{
			add_good_item();
		}
		if (RandomInt(1, 3) == 1)
		{
			add_great_item();
		}
	}

}

}
