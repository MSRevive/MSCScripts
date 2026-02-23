#pragma context server

namespace MS
{

class MapTransitions : CGameScript
{
	string DEST_MAP;
	int GM_CHANGELEVEL;
	string GM_DEST_TRANS;
	int GM_DISABLE_TRANSITIONS;
	int VOTE_IN_PROGRESS;

	void game_transition_triggered()
	{
		string L_MAP_TITLE = param1;
		string L_MAP = param2;
		string L_LOCAL_TRANS = param3;
		GM_DEST_TRANS = param4;
		if (!(ValidateMapName(L_MAP)))
		{
			SendInfoMessageToAll("green L_MAP  does not exist on this server. Perhaps this is a future transition point?");
		}
		else
		{
			CallExternal("players", "ext_set_map", L_MAP, L_LOCAL_TRANS, GM_DEST_TRANS);
			if (GetPlayerCount() > 1)
			{
				string VOTE_TITLE = "Travel to ";
				string L_OPTIONS = "Yes!:";
				CallExternal(GAME_MASTER, "gm_create_vote", "gm_votemap", L_OPTIONS, VOTE_TITLE, "Voting begins now!", 0);
			}
			else
			{
				gm_manual_map_change(L_MAP);
			}
		}
	}

	void gm_manual_map_change()
	{
		if ((GM_CHANGELEVEL)) return;
		GM_DISABLE_TRANSITIONS = 1;
		GM_CHANGELEVEL = 1;
		DEST_MAP = param1;
		string L_DEST_SPAWN = param2;
		if (L_DEST_SPAWN == "PARAM2")
		{
			string L_DEST_SPAWN = GM_DEST_TRANS;
		}
		CallExternal("players", "ext_setspawn", L_DEST_SPAWN);
		string L_CMD = "echo Changelevel: ";
		ServerCommand("L_CMD");
		SetGlobalVar("G_WEATHER_LOCK", "clear");
		SetGlobalVar("global.map.weather", "clear;clear;clear");
		SetGlobalVar("G_OVERRIDE_WEATHER_CODE", "clear;clear;clear");
		SetGlobalVar("G_CUR_WEATHER", "clear");
		SetGlobalVar("G_MAP_ADDPARAMS", 0);
		if ((G_SERVER_LOCKED))
		{
			string L_CMD = "sv_password ";
			ServerCommand("L_CMD");
		}
		if (GetPlayerCount() > 0)
		{
			CallExternal("players", "ext_changelevel_prep");
		}
		string L_STR = "TRAVELING TO ";
		SendInfoMsg("all", "L_STR You will be reconnected shortly.");
		VOTE_IN_PROGRESS = 0;
		ScheduleDelayedEvent(5.0, "delay_changelevel");
	}

	void game_triggered()
	{
		LogDebug("game_triggered PARAM1");
		string L_TRIG = param1;
		if ((GM_CHANGELEVEL)) return;
		if ((L_TRIG).findFirst("touch_trans_") == 0)
		{
			string MAP_TO_VOTE = /* TODO: $string_from */ $string_from(L_TRIG, "touch_trans_");
			string VOTE_TITLE = "Change to ";
			string L_OPTIONS = "Yes!:";
			CallExternal(GAME_MASTER, "gm_create_vote", "gm_votemap", L_OPTIONS, VOTE_TITLE, "Voting begins now!", 0);
		}
		else
		{
			if ((L_TRIG).findFirst("force_map_") == 0)
			{
				string L_FORCEMAP = /* TODO: $string_from */ $string_from(L_TRIG, "force_map_");
				gm_manual_map_change(L_FORCEMAP);
			}
		}
	}

}

}
