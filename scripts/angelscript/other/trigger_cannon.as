#pragma context server

namespace MS
{

class TriggerCannon : CGameScript
{
	int USED_TRIGGER;

	TriggerCannon()
	{
		SetCallback("touch", "enable");
		SetProp(GetOwner(), "solid", 1);
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!((GetEntityName(param1)).findFirst("Cannon") >= 0)) return;
		if ((USED_TRIGGER)) return;
		USED_TRIGGER = 1;
		UseTrigger(param3);
		SetCallback("touch", "disable");
		RemoveScript();
	}

}

}
