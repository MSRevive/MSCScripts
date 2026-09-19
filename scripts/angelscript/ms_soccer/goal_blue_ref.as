#pragma context server

namespace MS
{

class GoalBlueRef : CGameScript
{
	void OnSpawn() override
	{
		SetModel("null.mdl");
		SetWidth(3);
		SetHeight(3);
		SetGravity(0);
		SetNoPush(true);
		SetInvincible(true);
		SetName("blue_goal_ref");
	}

}

}
