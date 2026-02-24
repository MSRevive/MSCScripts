#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class RandEpicNew : CGameScript
{
	int HP_REQ;
	string ITEM_EVENT;
	int MAX_GOLD_AMT;

	RandEpicNew()
	{
		ITEM_EVENT = "add_epic_item";
		HP_REQ = 500;
		MAX_GOLD_AMT = 200;
	}

	void chest_additems()
	{
		add_gold_by_hp(MAX_GOLD_AMT);
		ITEM_EVENT(100, HP_REQ);
		if ((G_DEVELOPER_MODE))
		{
			SayText(ITEM_EVENT + HP_REQ);
		}
	}

}

}
