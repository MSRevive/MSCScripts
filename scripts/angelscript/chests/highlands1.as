#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Highlands1 : CGameScript
{
	void chest_additems()
	{
		add_gold(50);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "swords_spiderblade", 1, 0);
		}
		AddStoreItem(STORENAME, "blunt_warhammer", 1, 0);
		AddStoreItem(STORENAME, "drink_ale", 4, 0);
		AddStoreItem("smallarms_huggerdagger3", 1, 0);
		string N_PLAYERS = "game.playersnb";
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "shields_lironshield", 1, 0);
		}
		if (RandomInt(1, 5) == 1)
		{
			AddStoreItem(STORENAME, "armor_knight", 1, 0);
		}
		AddStoreItem(STORENAME, "proj_bolt_iron", 50, 0, 0, 25);
		if (RandomInt(1, 12) == 1)
		{
			AddStoreItem(STORENAME, "swords_katana4", 1, 0);
		}
		if (RandomInt(1, 8) == 1)
		{
			AddStoreItem(STORENAME, "swords_katana3", 1, 0);
		}
		if (RandomInt(1, 4) == 1)
		{
			AddStoreItem(STORENAME, "swords_katana2", 1, 0);
		}
		if (RandomInt(1, 3) == 1)
		{
			AddStoreItem(STORENAME, "swords_katana1", 1, 0);
		}
	}

}

}
