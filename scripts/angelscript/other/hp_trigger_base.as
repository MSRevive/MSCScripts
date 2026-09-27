#pragma context server

namespace MS
{

class HpTriggerBase : CGameScript
{
	string EVENT_NAME;
	int FOUND_ONE;
	string HOME_LOC;
	int TRIGGER_RANGE;
	int TRIGGER_REQ;

	HpTriggerBase()
	{
		TRIGGER_RANGE = 256;
		TRIGGER_REQ = 300;
		EVENT_NAME = "found_300";
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
		SetIdleAnim("");
		SetMoveAnim("");
		ScheduleDelayedEvent(0.5, "post_spawn");
		ScheduleDelayedEvent(0.1, "scan_for_players");
	}

	void post_spawn()
	{
		HOME_LOC = GetMonsterProperty("origin");
		ScheduleDelayedEvent(20.7, "reset_pos");
	}

	void scan_for_players()
	{
		if ((FOUND_ONE)) return;
		ScheduleDelayedEvent(1.0, "scan_for_players");
		string PLAYER_ID = /* TODO: $get_insphere */ $get_insphere("player", TRIGGER_RANGE);
		if ((IsValidPlayer(PLAYER_ID)))
		{
			if (GetEntityMaxHealth(PLAYER_ID) >= TRIGGER_REQ)
			{
			}
			found_worthy();
		}
		if (!(CanSee("player", TRIGGER_RANGE))) return;
		if (!(GetEntityMaxHealth(m_hLastSeen) >= TRIGGER_REQ)) return;
		found_worthy();
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if ((FOUND_ONE)) return;
		if (!(IsValidPlayer("ent_lastheard"))) return;
		if (!(GetEntityRange("ent_lastheard") < TRIGGER_RANGE)) return;
		if (!(GetEntityMaxHealth("ent_lastheard") >= TRIGGER_REQ)) return;
		found_worthy();
	}

	void found_worthy()
	{
		if ((FOUND_ONE)) return;
		FOUND_ONE = 1;
		UseTrigger(EVENT_NAME);
		ScheduleDelayedEvent(1.0, "clear_out");
	}

	void clear_out()
	{
		ScheduleDelayedEvent(0.1, "suicide_debug");
		SetInvincible(false);
		SetRace("hated");
		ScheduleDelayedEvent(0.2, "clear_out2");
	}

	void clear_out2()
	{
		DoDamage(GetEntityIndex(GetOwner()), "direct", 1000, 1.0, GetEntityIndex(GetOwner()));
	}

	void suicide_debug()
	{
		ScheduleDelayedEvent(2.0, "suicide_debug");
	}

	void reset_pos()
	{
		if (!(GetMonsterProperty("isalive"))) return;
		SetEntityOrigin(GetOwner(), HOME_LOC);
		ScheduleDelayedEvent(20.7, "reset_pos");
	}

}

}
