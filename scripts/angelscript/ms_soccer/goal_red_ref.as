#pragma context server

namespace MS
{

class GoalRedRef : CGameScript
{
	void OnSpawn() override
	{
		SetModel("null.mdl");
		SetWidth(3);
		SetHeight(3);
		SetGravity(0);
		SetNoPush(true);
		SetInvincible(true);
		SetName("red_goal_ref");
	}

}

}
