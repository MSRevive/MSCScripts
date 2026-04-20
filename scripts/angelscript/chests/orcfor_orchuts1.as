#pragma context server

#include "chests/orcfor_base.as"

namespace MS
{

class OrcforOrchuts1 : CGameScript
{
	void chest_additems()
	{
		add_gold((200 * G_GAVE_ARTI1));
		if (G_GAVE_ARTI1 == 1)
		{
			add_noob_item();
			add_good_arrows();
			add_good_arrows();
			add_great_item();
		}
		if (G_GAVE_ARTI1 == 2)
		{
			add_noob_item();
			add_great_item();
			add_good_arrows();
			add_great_arrows();
		}
		if (G_GAVE_ARTI1 == 3)
		{
			add_great_item();
			add_epic_item();
			add_great_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 == 4)
		{
			add_epic_item();
			add_great_arrows();
			add_great_arrows();
			add_epic_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 == 5)
		{
			add_epic_item();
			add_great_arrows();
			add_great_arrows();
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 > 5)
		{
			add_epic_item();
			add_epic_item();
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
		}
	}

}

}
