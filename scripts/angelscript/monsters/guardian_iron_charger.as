#pragma context server

#include "monsters/base_temporary.as"

namespace MS
{

class GuardianIronCharger : CGameScript
{
	void OnSpawn() override
	{
		SetGravity(0);
		ScheduleDelayedEvent(0.01, "mark_position");
	}

	void mark_position()
	{
		SetGlobalVar("G_GUARDIAN_CHARGER", GetEntityOrigin(GetOwner()));
	}

}

}
