#pragma context server

namespace MS
{

class Giver : CGameScript
{
	string ITEM_TO_GRANT;
	string MY_OWNER;
	int NO_SPAWN_STUCK_CHECK;

	Giver()
	{
		NO_SPAWN_STUCK_CHECK = 1;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		ITEM_TO_GRANT = param2;
	}

	void OnSpawn() override
	{
		SetModel("none");
		SetRace("beloved");
		ScheduleDelayedEvent(0.5, "grant_item");
	}

	void grant_item()
	{
		// TODO: offer MY_OWNER ITEM_TO_GRANT MY_OWNER
		ScheduleDelayedEvent(1.0, "me_vanish");
	}

	void me_vanish()
	{
		SetAlive(0);
		DeleteEntity(GetOwner());
	}

}

}
