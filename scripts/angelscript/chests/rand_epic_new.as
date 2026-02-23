#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class RandEpicNew : CGameScript
{
	RandEpicNew()
	{
		const string ITEM_EVENT = "add_epic_item";
		const int HP_REQ = 500;
		const int MAX_GOLD_AMT = 200;
	}

	void chest_additems()
	{
		add_gold_by_hp(MAX_GOLD_AMT);
		ITEM_EVENT(100, HP_REQ);
		if ((G_DEVELOPER_MODE))
		{
			SayText("ITEM_EVENT HP_REQ");
		}
	}

}

}
