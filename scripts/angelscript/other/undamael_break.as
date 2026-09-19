#pragma context server

#include "monsters/debug.as"

namespace MS
{

class UndamaelBreak : CGameScript
{
	int DID_TRIGGER;
	string RAND_ID;
	string UNDAMAEL_ID;

	UndamaelBreak()
	{
		SetCallback("touch", "enable");
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if ((DID_TRIGGER)) return;
		if (!(param1 == UNDAMAEL_ID)) return;
		if ((IsValidPlayer(param1))) return;
		UseTrigger(param3);
		DID_TRIGGER = 1;
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
		DeleteEntity(GetOwner());
	}

	void undamael_spawn()
	{
		UNDAMAEL_ID = FindEntityByName("undamael");
	}

	void bd_debug()
	{
		if (RAND_ID == "RAND_ID")
		{
			SetName("pitbreak1");
			RAND_ID = RandomInt(1000, 9999);
		}
	}

}

}
