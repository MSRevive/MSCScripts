#pragma context server

namespace MS
{

class BaseScanArea : CGameScript
{
	string BSCAN_CENTER;
	string BSCAN_OWNER;

	BaseScanArea()
	{
		BSCAN_CENTER = /* TODO: $relpos */ $relpos(0, 0, 0);
	}

	void game_dynamically_Created()
	{
		BSCAN_OWNER = param1;
		ScheduleDelayedEvent(0.25, "bscan_start_scan");
	}

	void bscan_start_scan()
	{
	}

}

}
