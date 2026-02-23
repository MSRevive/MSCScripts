#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	int TRIGGER_COUNT;

	void calruin2_trigger_touched()
	{
		TRIGGER_COUNT += 1;
		if (!(TRIGGER_COUNT > 1)) return;
		UseTrigger("combo_on");
		ScheduleDelayedEvent(30.0, "calruin2_reset_triggers");
		TRIGGER_COUNT = 0;
	}

	void calruin2_reset_triggers()
	{
		CallExternal("all", "calruin2_trigger_reset");
	}

}

}
