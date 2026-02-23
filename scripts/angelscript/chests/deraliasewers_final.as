#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class DeraliasewersFinal : CGameScript
{
	DeraliasewersFinal()
	{
		const string POT_LIST = "mana_speed;mana_immune_poison;mana_immune_cold;mana_immune_fire;mana_demon_blood;mana_gprotection;mana_bravery;mana_fbrand;mana_faura;mana_paura";
	}

	void OnSpawn() override
	{
		tc_add_artifact("armor_helm_elyg", 10);
		tc_add_artifact("armor_venom", 15);
		tc_add_artifact("blunt_eb", 10);
	}

	void chest_additems()
	{
		add_gold(RandomInt(500, 2000));
		add_epic_arrows();
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "mana_immune_poison", 1, 0);
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "armor_salamander", 1, 0);
		}
		if (RandomInt(1, 8) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 8) == 1)
		{
			add_good_item();
			add_great_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
			add_great_item();
			add_epic_arrows();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
			add_epic_arrows();
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
		}
		if (RandomInt(1, 10) == 1)
		{
			add_epic_item();
			add_epic_arrows();
		}
		l_add_epic_potion();
	}

	void l_add_epic_potion()
	{
		string N_POTS = GetTokenCount(POT_LIST, ";");
		N_POTS -= 1;
		string RND_PICK = RandomInt(0, N_POTS);
		string RND_POT = GetToken(POT_LIST, RND_PICK, ";");
		AddStoreItem(STORENAME, RND_POT, 1, 0);
	}

}

}
