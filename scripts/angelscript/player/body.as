#pragma context server

namespace MS
{

class Body : CGameScript
{
	string MY_OWNER;
	int PLAYING_DEAD;

	Body()
	{
	}

	void OnSpawn() override
	{
		SetModel("armor/p_armorvest.mdl");
		SetName("Player Body");
		SetWidth(32);
		SetHeight(72);
		SetModelBody(0, 1);
		SetModelBody(1, 1);
		SetModelBody(2, 0);
		SetModelBody(3, 1);
		SetModelBody(4, 9);
		SetRace("beloved");
		PLAYING_DEAD = 1;
		SetInvincible(true);
		SetProp(GetOwner(), "skin", 0);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		SetName("GetEntityName(MY_OWNER) body");
		ScheduleDelayedEvent(0.1, "do_latch");
	}

	void do_latch()
	{
		Effect("beam", "update", GetOwner(), "start_target", MY_OWNER, 0);
		Effect("beam", "update", GetOwner(), "end_target", MY_OWNER, 0);
		SetProp(MY_OWNER, "rendermode", 5);
		SetProp(MY_OWNER, "renderamt", 0);
	}

	void ext_bodyparts()
	{
		SetModelBody(0, param1);
		SetModelBody(1, param2);
		SetModelBody(2, param3);
		SetModelBody(3, param4);
		SetModelBody(4, param5);
	}

	void ext_skin()
	{
		SetProp(GetOwner(), "skin", param1);
	}

}

}
