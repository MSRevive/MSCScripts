#pragma context server

#include "player/player_cl_effects_special.as"

namespace MS
{

class PlayerClEffectsWorld : CGameScript
{
	string AFT_SKYNAME;
	string AFT_SOUND;
	int AFT_START_HOUR;
	string AFT_STATE;
	int AM_FADING;
	string CLPLR_TOD_STATE;
	string CL_TOD_LOCK;
	string CURRENT_TOD_STATE;
	string DAY_SKYNAME;
	string DAY_SOUND;
	int DAY_START_HOUR;
	string DAY_STATE;
	int DUSK_FADE_COUNT;
	int FADE_COUNT;
	int NIGHT_FADE_COUNT;
	string NIGHT_SKYNAME;
	string NIGHT_SOUND;
	int NIGHT_START_HOUR;
	string NIGHT_STATE;
	string PREV_STATE;

	PlayerClEffectsWorld()
	{
		DAY_SKYNAME = "game.map.skyname";
		DAY_SOUND = "amb/birds01.wav";
		DAY_START_HOUR = 6;
		DAY_STATE = "day";
		AFT_SKYNAME = DAY_SKYNAME;
		AFT_SOUND = "none";
		AFT_START_HOUR = 17;
		AFT_STATE = "aft";
		NIGHT_SKYNAME = "space";
		NIGHT_SOUND = "amb/wolf01.wav";
		NIGHT_START_HOUR = 20;
		NIGHT_STATE = "night";
		SetGlobalVar("clglobal.daystate", DAY_STATE);
	}

	void recv_time_initial()
	{
		if (!("clglobal.time.hour" >= NIGHT_START_HOUR)) return;
		SetGlobalVar("clglobal.daystate", NIGHT_STATE);
	}

	void recv_time()
	{
		string l.olddaytime = "clglobal.daystate";
		SetGlobalVar("clglobal.time.hour", param1);
		SetGlobalVar("clglobal.time.min", param2);
		SetGlobalVar("clglobal.time.text", param3);
		PREV_STATE = "clglobal.daystate";
		if ("clglobal.time.hour" < NIGHT_START_HOUR)
		{
			if ("clglobal.time.hour" >= AFT_START_HOUR)
			{
				change_to_aft();
			}
			else
			{
				if ("clglobal.time.hour" >= DAY_START_HOUR)
				{
					CallExternal("all", "environment_change", DAY_STATE);
				}
				else
				{
					change_to_night();
				}
			}
		}
		else
		{
			change_to_night();
		}
		time_change(l.olddaytime, "clglobal.daystate");
	}

	void change_to_night()
	{
		if (!("global.map.allownight"))
		{
			CallExternal("all", "environment_change", DAY_STATE);
		}
		else
		{
			CallExternal("all", "environment_change", NIGHT_STATE);
		}
	}

	void change_to_aft()
	{
		if (!("global.map.allownight"))
		{
			CallExternal("environment_change", "DAY_STATE");
		}
		else
		{
			CallExternal("all", "environment_change", AFT_STATE);
		}
	}

	void environment_change()
	{
		if (CL_TOD_LOCK != "none")
		{
			if (param1 != CL_TOD_LOCK)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		CURRENT_TOD_STATE = param1;
		if (param1 == DAY_STATE)
		{
			if ((AM_FADING))
			{
				finalize_state(DAY_STATE);
			}
			if (!(AM_FADING))
			{
			}
			if (PREV_STATE == NIGHT_STATE)
			{
				if (!(AM_FADING))
				{
				}
				AM_FADING = 1;
				FADE_COUNT = 1000;
				fade_to_day();
			}
			else
			{
				finalize_state(DAY_STATE);
			}
		}
		else
		{
			if (param1 == AFT_STATE)
			{
				if ((AM_FADING))
				{
					finalize_state(AFT_STATE);
				}
				if (!(AM_FADING))
				{
				}
				if (PREV_STATE == DAY_STATE)
				{
					if (!(AM_FADING))
					{
					}
					AM_FADING = 1;
					DUSK_FADE_COUNT = 1000;
					fade_to_dusk();
				}
				else
				{
					SetGlobalVar("clglobal.daystate", AFT_STATE);
					SetEnvironment("sky.texture", AFT_SKYNAME);
					SetEnvironment("lightgamma", 5);
					SetEnvironment("fog.enabled", 0);
					SetEnvironment("screen.tint", 0.8156 + "," + 0.368627 + "," + 0.007843 + "," + 0.1);
				}
			}
			else
			{
				if (param1 == NIGHT_STATE)
				{
					if ((AM_FADING))
					{
						finalize_state(NIGHT_STATE);
					}
					if (!(AM_FADING))
					{
					}
					if (PREV_STATE == AFT_STATE)
					{
						if (!(AM_FADING))
						{
						}
						AM_FADING = 1;
						SetEnvironment("fog.density", 0.05);
						SetEnvironment("fog.color", Vector3(0, 0, 0));
						SetEnvironment("fog.start", 4096);
						SetEnvironment("fog.end", 4864);
						SetEnvironment("fog.type", "linear");
						SetEnvironment("fog.enabled", 1);
						NIGHT_FADE_COUNT = 1000;
						fade_to_night();
					}
					else
					{
						finalize_state(NIGHT_STATE);
					}
				}
			}
		}
	}

	void finalize_state()
	{
		LogDebug("**** finalize_state PARAM1");
		AM_FADING = 0;
		NIGHT_FADE_COUNT = -1;
		FADE_COUNT = -1;
		DUSK_FADE_COUNT = -1;
		CLPLR_TOD_STATE = param1;
		if (param1 == DAY_STATE)
		{
			SetGlobalVar("clglobal.daystate", DAY_STATE);
			SetEnvironment("sky.texture", DAY_SKYNAME);
			SetEnvironment("lightgamma", 2.5);
			SetEnvironment("fog.enabled", 0);
			SetEnvironment("screen.tint", 0 + "," + 0 + "," + 0 + "," + 0);
		}
		else
		{
			if (param1 == AFT_STATE)
			{
				SetGlobalVar("clglobal.daystate", AFT_STATE);
				SetEnvironment("sky.texture", AFT_SKYNAME);
				SetEnvironment("lightgamma", 5);
				SetEnvironment("fog.enabled", 0);
				SetEnvironment("screen.tint", 0.8156 + "," + 0.368627 + "," + 0.007843 + "," + 0.1);
			}
			else
			{
				if (param1 == NIGHT_STATE)
				{
					SetGlobalVar("clglobal.daystate", NIGHT_STATE);
					SetEnvironment("fog.enabled", 1);
					SetEnvironment("fog.density", 0.05);
					SetEnvironment("fog.start", 256);
					SetEnvironment("fog.end", 1024);
					SetEnvironment("fog.type", "linear");
					SetEnvironment("fog.color", Vector3(0, 0, 0));
					SetEnvironment("screen.tint", 0.0200 + "," + 0.020000 + "," + 0.300000 + "," + 0.1);
					SetEnvironment("lightgamma", 4);
				}
			}
		}
	}

	void fade_to_night()
	{
		if (NIGHT_FADE_COUNT == 0)
		{
			finalize_state(NIGHT_STATE);
			EmitSound(GetOwner(), "const.snd.static", NIGHT_SOUND, "const.snd.maxvol");
		}
		if (!(NIGHT_FADE_COUNT > 0)) return;
		ScheduleDelayedEvent(0.01, "fade_to_night");
		NIGHT_FADE_COUNT -= 1;
		string PROGRESS_RATIO = NIGHT_FADE_COUNT;
		PROGRESS_RATIO /= 1000;
		string FOG_START = /* TODO: $get_skill_ratio */ $get_skill_ratio(PROGRESS_RATIO, 256, 4096);
		int FOG_END = 768;
		FOG_END += FOG_START;
		string TINT_R = /* TODO: $get_skill_ratio */ $get_skill_ratio(PROGRESS_RATIO, 0.02, 0.8156);
		string TINT_G = /* TODO: $get_skill_ratio */ $get_skill_ratio(PROGRESS_RATIO, 0.02, 0.368627);
		string TINT_B = /* TODO: $get_skill_ratio */ $get_skill_ratio(PROGRESS_RATIO, 0.3, 0.007843);
		string TINT_STR = "(";
		TINT_STR += TINT_R;
		TINT_STR += ",";
		TINT_STR += TINT_B;
		TINT_STR += ",";
		TINT_STR += TINT_G;
		TINT_STR += ",0.1)";
		SetEnvironment("fog.start", FOG_START);
		SetEnvironment("fog.end", FOG_END);
		SetWorldLightGamma(LIGHT_GAMMA);
		SetEnvironment("screen.tint", TINT_STR);
	}

	void fade_to_dusk()
	{
		DUSK_FADE_COUNT = 0;
		if (DUSK_FADE_COUNT == 0)
		{
			finalize_state(AFT_STATE);
		}
		if (!(DUSK_FADE_COUNT > 0)) return;
		ScheduleDelayedEvent(0.01, "fade_to_dusk");
		DUSK_FADE_COUNT -= 1;
		string PROGRESS_RATIO = DUSK_FADE_COUNT;
		PROGRESS_RATIO /= 1000;
		string LIGHT_GAMMA = /* TODO: $get_skill_ratio */ $get_skill_ratio(PROGRESS_RATIO, 4.0, 2.5);
		string TINT_ALPHA = /* TODO: $get_skill_ratio */ $get_skill_ratio(PROGRESS_RATIO, 0.1, 0);
		SetEnvironment("lightgamma", LIGHT_GAMMA);
		string SCREEN_STR = "(0.8156,0.368627,0.007843,";
		SCREEN_STR += TINT_ALPHA;
		SCREEN_STR += ")";
		SetEnvironment("screen.tint", SCREEN_STR);
		SetWorldLightGamma(LIGHT_GAMMA);
	}

	void fade_to_day()
	{
		if (FADE_COUNT == 0)
		{
			finalize_state(DAY_STATE);
			EmitSound(GetOwner(), "const.snd.static", DAY_SOUND, "const.snd.maxvol");
		}
		if (!(FADE_COUNT > 0)) return;
		ScheduleDelayedEvent(0.01, "fade_to_day");
		FADE_COUNT -= 1;
		string PROGRESS_RATIO = FADE_COUNT;
		PROGRESS_RATIO /= 1000;
		string LIGHT_GAMMA = /* TODO: $get_skill_ratio */ $get_skill_ratio(PROGRESS_RATIO, 2.5, 4.0);
		string FOG_DENSI = /* TODO: $get_skill_ratio */ $get_skill_ratio(PROGRESS_RATIO, 0.0, 0.1);
		string FOG_START = /* TODO: $get_skill_ratio */ $get_skill_ratio(PROGRESS_RATIO, 4096, 256);
		string TINT_ALPHA = /* TODO: $get_skill_ratio */ $get_skill_ratio(PROGRESS_RATIO, 0, 0.1);
		string SCREEN_STR = "(0.0200,0.020000,0.300000,";
		SCREEN_STR += TINT_ALPHA;
		SCREEN_STR += ")";
		int FOG_END = 1024;
		FOG_END += FOG_START;
		SetEnvironment("fog.density", FOG_DENSI);
		SetEnvironment("fog.start", FOG_START);
		SetEnvironment("fog.end", FOG_END);
		SetEnvironment("screen.tint", SCREEN_STR);
		SetWorldLightGamma(LIGHT_GAMMA);
	}

	void time_change()
	{
		if (!(param1 != param2)) return;
		string l.daytime = param2;
		if (l.daytime == DAY_STATE)
		{
			EmitSound(GetOwner(), "const.snd.static", DAY_SOUND, "const.snd.maxvol");
		}
		else
		{
			if (l.daytime == AFT_STATE)
			{
			}
			else
			{
				if (l.daytime == NIGHT_STATE)
				{
					EmitSound(GetOwner(), "const.snd.static", NIGHT_SOUND, "const.snd.maxvol");
				}
			}
		}
	}

	void lock_tod()
	{
		CL_TOD_LOCK = param1;
	}

	void reset_tod()
	{
		SetEnvironment("sky.texture", DAY_SKYNAME);
		SetEnvironment("lightgamma", 2.5);
		SetEnvironment("fog.enabled", 0);
		SetEnvironment("fog.density", 0);
		SetEnvironment("screen.tint", 0 + "," + 0 + "," + 0 + "," + 0);
		string L_CURRENT_TOD_STATE = CURRENT_TOD_STATE;
		if (L_CURRENT_TOD_STATE == "CURRENT_TOD_STATE")
		{
			string L_CURRENT_TOD_STATE = "day";
		}
		finalize_state(L_CURRENT_TOD_STATE);
	}

	void clear_weather()
	{
		SetEnvironment("sky.texture", DAY_SKYNAME);
		SetEnvironment("lightgamma", 2.5);
		SetEnvironment("fog.enabled", 0);
		SetEnvironment("screen.tint", 0 + "," + 0 + "," + 0 + "," + 0);
		finalize_state(CLPLR_TOD_STATE);
	}

	void change_sky()
	{
		SetEnvironment("sky.texture", param1);
		SendInfoMsg("all", param1 + " game.map.skyname");
	}

}

}
