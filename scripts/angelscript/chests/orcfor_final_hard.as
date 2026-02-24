#pragma context server

#include "chests/orcfor_base.as"

namespace MS
{

class OrcforFinalHard : CGameScript
{
	void chest_additems()
	{
		add_gold((500 * G_GAVE_ARTI1));
		if (G_GAVE_ARTI1 == 1)
		{
			add_great_item();
			add_epic_item();
			add_great_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 == 2)
		{
			add_epic_item();
			add_epic_item();
			add_great_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 == 3)
		{
			add_epic_item();
			add_epic_item();
			add_epic_item();
			add_epic_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 == 4)
		{
			add_epic_item();
			add_epic_item();
			add_epic_item();
			add_epic_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 == 5)
		{
			add_epic_item();
			add_epic_item();
			add_epic_item();
			add_epic_item();
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 > 5)
		{
			add_epic_item();
			add_epic_item();
			add_epic_item();
			add_epic_item();
			add_epic_item();
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
		}
		if (RandomInt(1, 30) == 1)
		{
			AddStoreItem(STORENAME, "mana_paura", 1, 0);
		}
		if (RandomInt(1, 30) == 1)
		{
			AddStoreItem(STORENAME, "mana_faura", 1, 0);
		}
		if (RandomInt(1, 30) == 1)
		{
			AddStoreItem(STORENAME, "mana_fbrand", 1, 0);
		}
		if (RandomInt(1, 30) == 1)
		{
			AddStoreItem(STORENAME, "mana_font", 1, 0);
		}
	}

}

}
