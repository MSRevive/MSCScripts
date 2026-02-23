#pragma context server

#include "chests/orcfor_base.as"

namespace MS
{

class OrcforGobtown1 : CGameScript
{
	void chest_additems()
	{
		add_gold(/* TODO: $math(multiply) */ 100);
		if (G_GAVE_ARTI1 == 1)
		{
			add_noob_item();
			add_good_item();
			add_good_arrows();
		}
		if (G_GAVE_ARTI1 == 2)
		{
			add_great_item();
			add_great_item();
			add_good_arrows();
		}
		if (G_GAVE_ARTI1 == 3)
		{
			add_great_item();
			add_epic_item();
			add_good_arrows();
		}
		if (G_GAVE_ARTI1 == 4)
		{
			add_great_item();
			add_epic_item();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 == 5)
		{
			add_epic_item();
			add_epic_arrows();
			add_epic_arrows();
		}
		if (G_GAVE_ARTI1 > 5)
		{
			add_epic_item();
			add_epic_arrows();
			add_epic_arrows();
			add_epic_arrows();
		}
	}

}

}
