#pragma context server

#include "chests/orcfor_base.as"

namespace MS
{

class OrcforArchers2 : CGameScript
{
	void chest_additems()
	{
		add_gold((100 * G_GAVE_ARTI1));
		if (G_GAVE_ARTI1 == 1)
		{
			add_noob_item();
			add_good_item();
			add_good_arrows();
		}
		if (G_GAVE_ARTI1 == 2)
		{
			add_noob_item();
			add_good_item();
			add_great_item();
			add_good_arrows();
		}
		if (G_GAVE_ARTI1 == 3)
		{
			add_good_item();
			add_great_item();
			add_great_item();
			add_great_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 == 4)
		{
			add_good_item();
			add_great_item();
			add_great_arrows();
			add_great_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 == 5)
		{
			add_great_item();
			add_great_item();
			add_great_arrows();
			add_great_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 > 5)
		{
			add_great_item();
			add_great_arrows();
			add_epic_arrows();
			add_epic_arrows();
		}
	}

}

}
