#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class RandGoodNew : CGameScript
{
	int HP_REQ;
	string ITEM_EVENT;
	int MAX_GOLD_AMT;

	RandGoodNew()
	{
		ITEM_EVENT = "add_good_item";
		HP_REQ = 200;
		MAX_GOLD_AMT = 50;
	}

	void chest_additems()
	{
		add_gold_by_hp(MAX_GOLD_AMT);
		ITEM_EVENT(100, HP_REQ);
	}

}

}
