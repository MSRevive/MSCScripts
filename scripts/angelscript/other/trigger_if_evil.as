#pragma context server

namespace MS
{

class TriggerIfEvil : CGameScript
{
	TriggerIfEvil()
	{
		SetCallback("touch", "enable");
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(GetEntityRace(param1) != "human")) return;
		if (!(GetEntityRace(param1) != "hguard")) return;
		UseTrigger(param3);
		SetCallback("touch", "disable");
		RemoveScript();
	}

	void game_used()
	{
		LogDebug("used by GetEntityName(param1)");
	}

}

}
