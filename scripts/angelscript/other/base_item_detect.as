#pragma context server

namespace MS
{

class BaseItemDetect : CGameScript
{
	string HOME_LOC;
	int PLAYING_DEAD;
	int SCAN_RANGE;
	string SEARCH_ITEM;

	BaseItemDetect()
	{
		SEARCH_ITEM = "health_apple";
		SCAN_RANGE = 64;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(3.0);
		GetAllPlayers(L_PLAYERS);
		for (int i = 0; i < GetTokenCount(L_PLAYERS, ";"); i++)
		{
			check_near();
		}
	}

	void OnSpawn() override
	{
		SetRace("beloved");
		SetBloodType("none");
		SetModel("none");
		SetInvincible(true);
		SetHealth(1);
		SetFly(true);
		SetWidth(32);
		SetHeight(32);
		SetSolid("none");
		SetHearingSensitivity(8);
		SetRoam(false);
		SetMoveSpeed(0.0);
		SetNoPush(true);
		SetIdleAnim("");
		SetMoveAnim("");
		PLAYING_DEAD = 1;
		ScheduleDelayedEvent(0.5, "post_spawn");
	}

	void post_spawn()
	{
		HOME_LOC = GetMonsterProperty("origin");
		ScheduleDelayedEvent(20.7, "reset_pos");
	}

	void reset_pos()
	{
		if (!(GetMonsterProperty("isalive"))) return;
		SetEntityOrigin(GetOwner(), HOME_LOC);
		ScheduleDelayedEvent(20.7, "reset_pos");
	}

	void check_near()
	{
		string CUR_PLAYER = GetToken(L_PLAYERS, i, ";");
		if (!(GetEntityRange(CUR_PLAYER) < SCAN_RANGE)) return;
		if (!(ItemExists(CUR_PLAYER, SEARCH_ITEM))) return;
		item_detected(CUR_PLAYER);
	}

}

}
