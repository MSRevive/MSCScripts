#pragma context server

#include "other/base_item_detect.as"
#include "monsters/debug.as"

namespace MS
{

class GraveWatcher : CGameScript
{
	int ITEM_FOUND;

	GraveWatcher()
	{
		const string SEARCH_ITEM = "item_fstatue";
		const int SCAN_RANGE = 64;
	}

	void item_detected()
	{
		if ((ITEM_FOUND)) return;
		SetName("Feldar s Grave");
		ITEM_FOUND = 1;
		OpenMenu(param1);
	}

	void game_menu_getoptions()
	{
		if (!(ITEM_FOUND)) return;
		if (!(ItemExists(param1, SEARCH_ITEM))) return;
		string reg.mitem.title = "Place the Statuette";
		string reg.mitem.type = "payment";
		string reg.mitem.cb_failed = "payment_failed";
		string reg.mitem.data = SEARCH_ITEM;
		string reg.mitem.callback = "statue_return";
		string reg.mitem.title = "Leave";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "player_opted_out";
	}

	void statue_return()
	{
		UseTrigger("got_statue");
		string KEEPER_ID = FindEntityByName("lkeeper");
		CallExternal(KEEPER_ID, "quest_done_grave");
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void player_opted_out()
	{
		UseTrigger("player_refused");
		ScheduleDelayedEvent(3.0, "reset_scan");
	}

	void payment_failed()
	{
		ScheduleDelayedEvent(3.0, "reset_scan");
	}

	void reset_scan()
	{
		ITEM_FOUND = 0;
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
