#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Packs : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "pack_archersquiver", 1, 0);
		AddStoreItem(STORENAME, "pack_bigsack", 1, 0);
		AddStoreItem(STORENAME, "pack_boh_lesser", 1, 0);
		AddStoreItem(STORENAME, "pack_heavybackpack", 1, 0);
		AddStoreItem(STORENAME, "pack_quiver", 1, 0);
		AddStoreItem(STORENAME, "pack_sackite", 1, 0);
		AddStoreItem(STORENAME, "pack_sack", 1, 0);
		AddStoreItem(STORENAME, "sheath_spellbook", 1, 0);
		AddStoreItem(STORENAME, "sheath_axe_snakeskin", 1, 0);
		AddStoreItem(STORENAME, "sheath_back", 1, 0);
		AddStoreItem(STORENAME, "sheath_back_holster", 1, 0);
		AddStoreItem(STORENAME, "sheath_back_snakeskin", 1, 0);
		AddStoreItem(STORENAME, "sheath_belt", 1, 0);
		AddStoreItem(STORENAME, "sheath_belt_holster", 1, 0);
		AddStoreItem(STORENAME, "sheath_belt_holster_snakeskin", 1, 0);
		AddStoreItem(STORENAME, "sheath_belt_snakeskin", 1, 0);
		AddStoreItem(STORENAME, "sheath_blunt_snakeskin", 1, 0);
		AddStoreItem(STORENAME, "sheath_dagger", 1, 0);
		AddStoreItem(STORENAME, "sheath_dagger_snakeskin", 1, 0);
	}

}

}
