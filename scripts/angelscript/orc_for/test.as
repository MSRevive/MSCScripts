#pragma context server

#include "monsters/debug.as"

namespace MS
{

class Test : CGameScript
{
	string NEXT_PUSH;
	string PUSH_TARG;

	Test()
	{
		SetCallback("touch", "enable");
	}

	void OnSpawn() override
	{
		SetModel("misc/treasure.mdl");
		SetWidth(32);
		SetHeight(32);
		SetHealth(1000);
		SetRace("hated");
		SetProp(GetOwner(), "movetype", 7);
		SetProp(GetOwner(), "solid", 2);
		SetGravity(0);
		if (!(true)) return;
		ScheduleDelayedEvent(0.25, "snap_to_ground");
	}

	void snap_to_ground()
	{
		string MY_POS = GetEntityOrigin(GetOwner());
		MY_POS = "z";
		SetEntityOrigin(GetOwner(), MY_POS);
	}

	void ext_forward()
	{
		SetProp(GetOwner(), "movetype", 7);
		SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, 1000, 0)));
	}

	void ext_backwards()
	{
		SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, -1000, 0)));
		SetProp(GetOwner(), "movetype", 7);
	}

	void ext_reset()
	{
		SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, 0, 0)));
		SetEntityOrigin(GetOwner(), Vector3(0, 0, 0));
		SetProp(GetOwner(), "solid", 2);
		SetProp(GetOwner(), "movetype", 7);
	}

	void ext_down()
	{
		SetProp(GetOwner(), "solid", 2);
		SetProp(GetOwner(), "movetype", 7);
		SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, 0, -100)));
		SetProp(GetOwner(), "solid", 2);
		SetProp(GetOwner(), "movetype", 7);
	}

	void ext_up()
	{
		SetProp(GetOwner(), "solid", 2);
		SetProp(GetOwner(), "movetype", 7);
		SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(Vector3(0, 0, 0), Vector3(0, 0, 100)));
		SetProp(GetOwner(), "solid", 2);
		SetProp(GetOwner(), "movetype", 7);
	}

	void OnTouch(CBaseEntity@ other) override
	{
		PUSH_TARG = param1;
		ScheduleDelayedEvent(0.1, "do_repel", GetEntityIndex(param1));
	}

	void do_repel()
	{
		if (!(GetGameTime() > NEXT_PUSH)) return;
		NEXT_PUSH = GetGameTime();
		NEXT_PUSH += 0.25;
		LogDebug("do_repel GetEntityName(param1) GetEntityOrigin(GetOwner())");
		string CUR_TARG = PUSH_TARG;
		DoDamage(CUR_TARG, "direct", 0.1, 1.0, GetOwner());
		string TARGET_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		string NEW_YAW = TARG_ANG;
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 800, 110)));
	}

	void game_blocked()
	{
		LogDebug("game_blocked GetEntityName(param1)");
		do_repel(GetEntityIndex(param1));
	}

}

}
