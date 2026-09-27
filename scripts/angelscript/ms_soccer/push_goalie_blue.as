#pragma context server

namespace MS
{

class PushGoalieBlue : CGameScript
{
	string NPC_HOME_LOC;

	void OnSpawn() override
	{
		SetName("blue_goalie");
		NPC_HOME_LOC = GetEntityOrigin(GetOwner());
		LogDebug("blue_goalie spawn");
		SetAlive(1);
		SetCallback("think", "enable");
	}

	void extsoc_del_blue_pushgoal()
	{
		DeleteEntity(GetOwner());
		DeleteEntity(GetOwner());
	}

}

}
