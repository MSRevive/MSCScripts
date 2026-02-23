#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class DragooncavesSecret : CGameScript
{
	DragooncavesSecret()
	{
		const string EPIC_POTION_LIST = "mana_faura;mana_paura;mana_speed;mana_gprotection;mana_immune_cold;mana_immune_fire;mana_immune_poison;mana_demon_blood;mana_regen;mana_leadfoot;mana_immune_lightning";
		const string GOOD_POTION_LIST = "mana_resist_cold;mana_resist_cold;mana_resist_fire;mana_vampire;mana_prot_spiders";
	}

	void chest_additems()
	{
		add_gold(550);
		add_noob_item();
		dra_add_random_pot();
		dra_add_random_pot();
		string N_POTIONS = GetTokenCount(EPIC_POTION_LIST, ";");
		N_POTIONS -= 1;
		string RND_POTION = RandomInt(0, N_POTIONS);
		AddStoreItem(STORENAME, GetToken(EPIC_POTION_LIST, RND_POTION, ";"), 1, 0);
		if (!(RandomInt(1, 3) == 1)) return;
		dra_add_random_pot();
	}

	void dra_add_random_pot()
	{
		string N_POTIONS = GetTokenCount(GOOD_POTION_LIST, ";");
		N_POTIONS -= 1;
		string RND_POTION = RandomInt(0, N_POTIONS);
		AddStoreItem(STORENAME, GetToken(GOOD_POTION_LIST, RND_POTION, ";"), 1, 0);
	}

}

}
