#pragma context server

namespace MS
{

class PushGoalieRed : CGameScript
{
	string NPC_HOME_LOC;

	void OnSpawn() override
	{
		SetName("red_goalie");
		NPC_HOME_LOC = GetEntityOrigin(GetOwner());
		LogDebug("red_goalie spawn");
		SetAlive(1);
		SetCallback("think", "enable");
	}

	void extsoc_del_red_pushgoal()
	{
		DeleteEntity(GetOwner());
		DeleteEntity(GetOwner());
	}

}

}
