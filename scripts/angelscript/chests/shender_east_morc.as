#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class ShenderEastMorc : CGameScript
{
	void OnSpawn() override
	{
		G_GAVE_ARTI1 += 1;
	}

	void chest_additems()
	{
		if (G_GAVE_ARTI1 == 1)
		{
			add_epic_arrows();
			string GOLD_AMT = GetPlayerCount();
			GOLD_AMT *= 50;
			add_gold(GOLD_AMT);
		}
		if (G_GAVE_ARTI1 == 2)
		{
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
			string GOLD_AMT = "game.playersnb";
			GOLD_AMT *= 500;
			add_gold(GOLD_AMT);
		}
		if (G_GAVE_ARTI1 == 3)
		{
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
			AddStoreItem(STORENAME, "mana_faura", 1, 0);
			if ("game.playersnb" > 1)
			{
				AddStoreItem(STORENAME, "mana_immune_cold", 1, 0);
			}
			string GOLD_AMT = "game.playersnb";
			GOLD_AMT *= 2000;
			add_gold(GOLD_AMT);
		}
	}

}

}
