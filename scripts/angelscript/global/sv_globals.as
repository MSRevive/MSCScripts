#pragma context server

namespace MS
{

class SvGlobals : CGameScript
{
	SvGlobals()
	{
		SetGlobalVar("NO_ADVANCED_SEARCHES", 0);
		SetGlobalVar("G_VALID_SPAWN", 0);
		SetGlobalVar("MAX_SUMMONS", 10);
		SetGlobalVar("CURRENT_SUMMONS", 0);
		SetGlobalVar("global.map.weather", "clear;clear;clear");
		SetGlobalVar("G_OVERRIDE_WEATHER_CODE", 0);
		SetGlobalVar("G_NO_STEP_ADJ", 0);
		SetGlobalVar("G_HELP_ON", 0);
		SetGlobalVar("G_CRITICAL_NPCS", "");
		SetGlobalVar("G_SIEGE_MAP", "G_SIEGE_MAP");
		SetGlobalVar("G_FORCE_SPAWN_WEATHER", "G_FORCE_SPAWN_WEATHER");
		SetGlobalVar("G_EXP_MULTI", 1.0);
		SetGlobalVar("G_NO_DROP", 0);
		SetGlobalVar("G_UNDAMAEL_VULNERABLE", 0);
		SetGlobalVar("G_SHAD_PRESENT", 0);
		SetGlobalVar("G_SORC_NEXT_TELE", 0);
		SetGlobalVar("G_MUMMY_NEXT_REBIRTH", 0);
		SetGlobalVar("G_SKELE_NEXT_REBIRTH", 0);
		SetGlobalVar("G_GUARDIAN_CHARGER", "G_GUARDIAN_CHARGER");
		SetGlobalVar("G_SORC_TELE_POINTS", 0);
		SetGlobalVar("G_SORC_CHIEF_PRESENT", 0);
		SetGlobalVar("G_TELF_ESCORTS", 0);
		SetGlobalVar("G_ONE_SHOT", 0);
		SetGlobalVar("G_WEATHER_LOCK", 0);
		SetGlobalVar("G_NPC_COMBAT_MAP", 0);
		SetGlobalVar("G_TELF_LEADER_COUNTER", 0);
		SetGlobalVar("G_CURRENT_WEATHER", 0);
		SetGlobalVar("G_TRACK_DEATHS", 0);
		SetGlobalVar("G_TRACK_DEATHS_TRIGGER", 0);
		SetGlobalVar("G_TRACK_DEATHS_EVENT", 0);
		SetGlobalVar("G_SERVER_LOCKED", 0);
		SetGlobalVar("G_SADJ_DEATHS", 0);
		SetGlobalVar("G_SADJ_LEVELS", 0);
		SetGlobalVar("G_GAVE_TOME1", 0);
		SetGlobalVar("G_GAVE_TOME2", 0);
		SetGlobalVar("G_GAVE_TOME3", 0);
		SetGlobalVar("G_GAVE_TOME4", 0);
		SetGlobalVar("G_GAVE_TOME5", 0);
		SetGlobalVar("G_GAVE_TOME6", 0);
		SetGlobalVar("G_GAVE_TOME7", 0);
		SetGlobalVar("G_GAVE_ARTI1", 0);
		SetGlobalVar("G_LAST_GABE_TARGET", 0);
		SetGlobalVar("G_APRIL_FOOLS_MODE", 0);
		SetGlobalVar("G_DEVELOPER_MODE", 0);
		SetGlobalVar("G_TRACK_HP", 0);
		SetGlobalVar("G_TRACK_KILLS", 0);
		SetGlobalVar("G_LAST_VICTORY", 0);
		SetGlobalVar("G_NPC_SUMMON_COUNT", 0);
		SetGlobalVar("G_FLAMES_EAGLES", 0);
		SetGlobalVar("G_ALERT_CYCLE", 0);
		SetGlobalVar("G_SPECIAL_COMMANDS", 0);
		SetGlobalVar("G_CHEST_TRACKER", 0);
		if (/* TODO: $g_get_array_amt */ $g_get_array_amt(G_ARRAY_DONATORS) == -1)
		{
			CreateGlobalArray("G_ARRAY_DONATORS");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:0:452876");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:1:1339151");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:0:15435276");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:1:5168669");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:1:4985228");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:1:838591");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:0:17717134");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:1:1184501");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:0:23328455");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:1:20479631");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:1:8122893");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:1:10951502");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:1:33635060");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:1:11447863");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:0:12864684");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:0:5900395");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:1:13564511");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:0:20630963");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:0:7019991");
			GlobalArrayAdd("G_ARRAY_DONATORS", "STEAM_0:0:69835");
		}
		if (/* TODO: $g_get_array_amt */ $g_get_array_amt(ARRAY_CRESTS) == -1)
		{
			CreateGlobalArray("ARRAY_CRESTS");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_crow");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_cwog");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_darktide");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_forestcroth");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_hov");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_pirates");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_torkalath");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_valor");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_wildfire");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_bou");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_gag");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_fmu");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_yoku");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_rip");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_gow");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_crew");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_wario");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_tfl");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_justice");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_revenge");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_socialist");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_pos");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_barnum");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_fellowship");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_hod");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_tdk");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_torkie");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_cloak_blue");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_neko");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_wotn");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_w_2");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_sor");
			GlobalArrayAdd("ARRAY_CRESTS", "crest_noclicky");
			CreateGlobalArray("ARRAY_CREST_OWNERS");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "STEAM_0:1:11447863");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "STEAM_0:1:759168");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "STEAM_0:1:7087443");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "STEAM_0:1:1679220");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "STEAM_0:0:5003092");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "STEAM_0:1:3695755;STEAM_0:0:3686251");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "none");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "STEAM_0:0:69835");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "STEAM_0:1:8122893");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "STEAM_0:1:7087443");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "STEAM_0:0:5900395");
			GlobalArrayAdd("ARRAY_CREST_OWNERS", "STEAM_0:0:10987306");
		}
		if (/* TODO: $g_get_array_amt */ $g_get_array_amt(G_ARRAY_DEVELOPERS) == -1)
		{
			CreateGlobalArray("G_ARRAY_DEVELOPERS");
			GlobalArrayAdd("G_ARRAY_DEVELOPERS", "STEAM_0:1:3967789");
			GlobalArrayAdd("G_ARRAY_DEVELOPERS", "STEAM_0:1:19627420");
			GlobalArrayAdd("G_ARRAY_DEVELOPERS", "STEAM_0:0:20470108");
			GlobalArrayAdd("G_ARRAY_DEVELOPERS", "STEAM_0:0:5003092");
			GlobalArrayAdd("G_ARRAY_DEVELOPERS", "STEAM_0:1:8122893");
			GlobalArrayAdd("G_ARRAY_DEVELOPERS", "STEAM_0:0:3937474");
			GlobalArrayAdd("G_ARRAY_DEVELOPERS", "STEAM_0:1:4985228");
			GlobalArrayAdd("G_ARRAY_DEVELOPERS", "STEAM_0:1:1955506");
			GlobalArrayAdd("G_ARRAY_DEVELOPERS", "STEAM_0:0:58762201");
		}
		SetGlobalVar("G_TROLLCANO_OWNERS", "STEAM_0:0:19648837;STEAM_0:1:8122893");
		SetGlobalVar("G_DEVSTAFF_OWNERS", "STEAM_0:1:4985228;STEAM_0:1:8122893;STEAM_0:0:5003092;STEAM_0:0:20630963;");
	}

}

}
