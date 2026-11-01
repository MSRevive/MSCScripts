#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class M2Quest2Extra : CGameScript
{
	void chest_additems()
	{
		AddStoreItem(STORENAME, "item_torch", 1, 0);
		add_noob_item();
		add_good_item();
		string L_NPLAYERS = "game.playersnb";
		if (L_NPLAYERS > 2)
		{
			add_great_item();
		}
		if (L_NPLAYERS > 4)
		{
			add_great_item();
		}
		if (RandomInt(1, 5) < L_NPLAYERS)
		{
			add_noob_arrows();
		}
		string GOLD_AMT = L_NPLAYERS;
		GOLD_AMT *= 25;
		add_gold(GOLD_AMT);
	}

}

}
