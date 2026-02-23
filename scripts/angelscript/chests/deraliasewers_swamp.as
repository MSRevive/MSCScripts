#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class DeraliasewersSwamp : CGameScript
{
	DeraliasewersSwamp()
	{
		const string POT_LIST = "mana_speed;mana_immune_poison;mana_immune_cold;mana_immune_fire;mana_demon_blood;mana_gprotection;mana_bravery;mana_fbrand;mana_faura;mana_paura";
	}

	void chest_additems()
	{
		l_add_epic_potion();
		if (RandomInt(1, 4) == 1)
		{
			l_add_epic_potion();
		}
		if (RandomInt(1, 4) == 1)
		{
			l_add_epic_potion();
		}
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
