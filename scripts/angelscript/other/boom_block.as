#pragma context server

namespace MS
{

class BoomBlock : CGameScript
{
	int EFFECT_DIST;
	string NPC_HOME_LOC;
	int PLAYING_DEAD;

	BoomBlock()
	{
		EFFECT_DIST = 1024;
	}

	void OnSpawn() override
	{
		SetInvincible(true);
		SetRace("beloved");
		PLAYING_DEAD = 1;
		SetSolid("none");
		SetNoPush(true);
		ScheduleDelayedEvent(0.1, "get_home_loc");
	}

	void get_home_loc()
	{
		NPC_HOME_LOC = GetEntityOrigin(GetOwner());
	}

	void do_boom()
	{
		string BOOM_SOURCE = param1;
		LogDebug("do_boom GetEntityRange(BOOM_SOURCE)");
		if (!(GetEntityRange(BOOM_SOURCE) < EFFECT_DIST)) return;
		string DIST_RATIO = GetEntityRange(BOOM_SOURCE);
		DIST_RATIO /= EFFECT_DIST;
		string BOOM_DELAY = /* TODO: $ratio */ $ratio(DIST_RATIO, 0.1, 1.0);
		LogDebug("do_boom BOOM_DELAY");
		BOOM_DELAY("do_bob");
	}

	void do_bob()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 200));
	}

	void reset_block()
	{
		SetVelocity(GetOwner(), Vector3(0, 0, 0));
		SetEntityOrigin(GetOwner(), NPC_HOME_LOC);
	}

	void bury_block()
	{
		SetSolid("none");
		string DOWN_16 = NPC_HOME_LOC;
		DOWN_16 += "z";
		SetEntityOrigin(GetOwner(), DOWN_16);
	}

}

}
