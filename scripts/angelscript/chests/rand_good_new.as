#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class RandGoodNew : CGameScript
{
	RandGoodNew()
	{
		const string ITEM_EVENT = "add_good_item";
		const int HP_REQ = 200;
		const int MAX_GOLD_AMT = 50;
	}

	void chest_additems()
	{
		add_gold_by_hp(MAX_GOLD_AMT);
		ITEM_EVENT(100, HP_REQ);
	}

}

}
