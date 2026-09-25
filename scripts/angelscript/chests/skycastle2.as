#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class Skycastle2 : CGameScript
{
	void chest_additems()
	{
		string P_ARROWS = "game.playersnb";
		string H_ARROWS = "game.playersnb";
		P_ARROWS *= 60;
		H_ARROWS *= 15;
		AddStoreItem(STORENAME, "health_spotion", 1, 0);
		AddStoreItem(STORENAME, "mana_mpotion", 1, 0);
		AddStoreItem(STORENAME, "proj_arrow_poison", P_ARROWS, 0, 0, 60);
		AddStoreItem(STORENAME, "proj_arrow_gholy", H_ARROWS, 0, 0, 15);
		AddStoreItem(STORENAME, "skin_bear", 50, 0);
		AddStoreItem(STORENAME, "item_crystal_return", TC_NPLAYERS, 0);
		add_epic_item();
	}

}

}
