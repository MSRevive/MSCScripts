#pragma context client

namespace MS
{

class PlayerClEffectsWeather : CGameScript
{
	string CUR_WEATHER_RAIN_DROP_RATE;
	string CUR_WEATHER_RAIN_VOL;
	string CUR_WEATHER_SNOW_DROP_RATE;
	string DEST_WEATHER_FOG_COLOR;
	int DEST_WEATHER_FOG_DENSITY;
	int DEST_WEATHER_FOG_END;
	int DEST_WEATHER_FOG_START;
	int DEST_WEATHER_FOG_UNDERGROUND;
	int DEST_WEATHER_RAIN_DROP_RATE;
	int DEST_WEATHER_RAIN_VOL;
	int DEST_WEATHER_SNOW_DROP_RATE;
	string DEST_WEATHER_TINT;
	int DEST_WEATHER_TINT_UNDERGROUND;
	float FREQ_SNOW_CHAR_BREATH;
	float FREQ_STORM_LIGHTNING;
	float FREQ_WEATHER_RAIN_SOUND;
	float FREQ_WEATHER_SNOW_SOUND;
	string PREV_WEATHER;
	string SOUND_DAY;
	string SOUND_NIGHT;
	string SOUND_RAIN;
	string SOUND_RAIN_START;
	string SOUND_SNOW;
	string TOD_STATE;
	int WEATHER_CHANNEL;
	int WEATHER_CURRENT_AMB_VOL;
	string WEATHER_FOG_COLOR;
	int WEATHER_FOG_DENSITY;
	int WEATHER_FOG_END;
	int WEATHER_FOG_NIGHT;
	int WEATHER_FOG_ON;
	int WEATHER_FOG_START;
	int WEATHER_FOG_UNDERGROUND;
	string WEATHER_FORCE_CHANGE_TYPE;
	string WEATHER_IN_TRANSITION;
	int WEATHER_LIGHTNING_ON;
	int WEATHER_LOOP_ON;
	string WEATHER_PARAM;
	string WEATHER_PLAYER_UNDERGROUND;
	string WEATHER_PLAYER_UNDERGROUND_COUNT;
	int WEATHER_RAIN_DROP_MAXRATE;
	int WEATHER_RAIN_DROP_RATE;
	string WEATHER_RAIN_EVENT;
	string WEATHER_RAIN_FOG_COLOR;
	float WEATHER_RAIN_FOG_DENSITY;
	int WEATHER_RAIN_FOG_END;
	int WEATHER_RAIN_FOG_ON;
	int WEATHER_RAIN_FOG_START;
	int WEATHER_RAIN_FOG_UNDERGROUND;
	int WEATHER_RAIN_MAXVOL;
	int WEATHER_RAIN_MIST;
	int WEATHER_RAIN_ON;
	int WEATHER_RAIN_RADIUS;
	string WEATHER_RAIN_TINT_DAY;
	string WEATHER_RAIN_TINT_DUSK;
	string WEATHER_RAIN_TINT_NIGHT;
	int WEATHER_RAIN_VOL;
	string WEATHER_RAIN_ZVELOCITY;
	int WEATHER_SNOW_DROP_RATE;
	string WEATHER_SNOW_EVENT;
	string WEATHER_SNOW_FOG_COLOR;
	string WEATHER_SNOW_FOG_COLOR_DUSK;
	string WEATHER_SNOW_FOG_COLOR_NIGHT;
	float WEATHER_SNOW_FOG_DENSITY;
	int WEATHER_SNOW_FOG_END;
	int WEATHER_SNOW_FOG_ON;
	int WEATHER_SNOW_FOG_START;
	int WEATHER_SNOW_FOG_UNDERGROUND;
	string WEATHER_SNOW_NEXT_SOUND;
	int WEATHER_SNOW_ON;
	int WEATHER_SNOW_RADIUS;
	int WEATHER_SNOW_RATE;
	string WEATHER_SNOW_TINT;
	int WEATHER_SPIN_RATIO;
	string WEATHER_SPRITE_BREATH;
	string WEATHER_SPRITE_RAIN;
	string WEATHER_SPRITE_RAIN_MIST;
	string WEATHER_SPRITE_RAIN_RIPPLE;
	string WEATHER_SPRITE_RAIN_SPLASH;
	string WEATHER_SPRITE_SNOW;
	int WEATHER_STORM_DROP_MAXRATE;
	int WEATHER_STORM_MAXVOL;
	string WEATHER_TINT;
	int WEATHER_TINT_ON;
	int WEATHER_TINT_UNDERGROUND;
	float WEATHER_TOD_DAY_LIGHTGAMMA;
	string WEATHER_TOD_DAY_TINT;
	string WEATHER_TOD_DUSK_TINT;
	float WEATHER_TOD_LIGHTGAMMA;
	string WEATHER_TOD_NIGHT_FOG_COLOR;
	float WEATHER_TOD_NIGHT_FOG_DENSITY;
	int WEATHER_TOD_NIGHT_FOG_END;
	int WEATHER_TOD_NIGHT_FOG_START;
	float WEATHER_TOD_NIGHT_LIGHTGAMMA;
	string WEATHER_TOD_NIGHT_TINT;
	string WEATHER_TO_FORCE;
	string WEATHER_TYPE;
	string WEATHER_VOL_SPIN_POINT;
	int WEATHER_WAS_RAIN;
	int WEATHER_WAS_SNOW;
	string WEATHER_WIND_STRENGTH;

	PlayerClEffectsWeather()
	{
		WEATHER_CHANNEL = 5;
		SOUND_RAIN = "weather/rain.wav";
		SOUND_RAIN_START = "weather/rain_start.wav";
		SOUND_DAY = "amb/birds01.wav";
		SOUND_NIGHT = "amb/wolf01.wav";
		SOUND_SNOW = "amb/wind.wav";
		FREQ_WEATHER_SNOW_SOUND = 7.0;
		FREQ_WEATHER_RAIN_SOUND = 14.6;
		Precache(SOUND_RAIN);
		WEATHER_SPRITE_RAIN = "rain.spr";
		WEATHER_SPRITE_RAIN_SPLASH = "rain_splash.spr";
		WEATHER_SPRITE_RAIN_MIST = "rain_mist.spr";
		WEATHER_SPRITE_RAIN_RIPPLE = "rain_ripple.spr";
		WEATHER_SPRITE_SNOW = "snow1.spr";
		WEATHER_SPRITE_BREATH = "char_breath.spr";
		WEATHER_RAIN_DROP_MAXRATE = 10;
		WEATHER_RAIN_MAXVOL = 5;
		WEATHER_RAIN_TINT_NIGHT = 0.1 + "," + 0.1 + "," + 0.1 + "," + 0.3;
		WEATHER_RAIN_TINT_DAY = 0.1 + "," + 0.1 + "," + 0.1 + "," + 0.3;
		WEATHER_RAIN_TINT_DUSK = 0.1 + "," + 0.1 + "," + 0.1 + "," + 0.3;
		WEATHER_RAIN_FOG_COLOR = Vector3(0.4, 0.4, 0.5);
		WEATHER_RAIN_FOG_DENSITY = 0.0007;
		WEATHER_RAIN_FOG_START = 0;
		WEATHER_RAIN_FOG_END = 4000;
		WEATHER_RAIN_FOG_ON = 1;
		WEATHER_RAIN_FOG_UNDERGROUND = 0;
		WEATHER_RAIN_RADIUS = 1024;
		WEATHER_STORM_DROP_MAXRATE = 20;
		WEATHER_STORM_MAXVOL = 10;
		FREQ_STORM_LIGHTNING = Random(20.0, 30.0);
		WEATHER_SNOW_DROP_RATE = 5;
		WEATHER_SNOW_TINT = 0 + "," + 0 + "," + 0 + "," + 0;
		WEATHER_SNOW_FOG_COLOR = Vector3(1, 1, 1);
		WEATHER_SNOW_FOG_DENSITY = 0.4;
		WEATHER_SNOW_FOG_START = 64;
		WEATHER_SNOW_FOG_END = 2048;
		WEATHER_SNOW_FOG_ON = 1;
		WEATHER_SNOW_FOG_COLOR_NIGHT = Vector3(0.8, 0.8, 0.8);
		WEATHER_SNOW_FOG_COLOR_DUSK = Vector3(0.9, 0.8, 0.8);
		WEATHER_SNOW_FOG_UNDERGROUND = 0;
		WEATHER_SNOW_RATE = 4;
		FREQ_SNOW_CHAR_BREATH = Random(10.0, 30.0);
		WEATHER_SNOW_RADIUS = 1024;
		WEATHER_TOD_DAY_TINT = 0 + "," + 0 + "," + 0 + "," + 0;
		WEATHER_TOD_DAY_LIGHTGAMMA = 2.5;
		WEATHER_TOD_DUSK_TINT = 0.8156 + "," + 0.368627 + "," + 0.007843 + "," + 0.1;
		WEATHER_TOD_LIGHTGAMMA = 5.0;
		WEATHER_TOD_NIGHT_TINT = 0.02 + "," + 0.02 + "," + 0.3 + "," + 0.1;
		WEATHER_TOD_NIGHT_LIGHTGAMMA = 4.0;
		WEATHER_TOD_NIGHT_FOG_COLOR = Vector3(0, 0, 0);
		WEATHER_TOD_NIGHT_FOG_DENSITY = 0.05;
		WEATHER_TOD_NIGHT_FOG_START = 256;
		WEATHER_TOD_NIGHT_FOG_END = 1024;
		TOD_STATE = "day";
		WEATHER_TYPE = "clear";
		WEATHER_IN_TRANSITION = "";
		WEATHER_TYPE = "clear";
		WEATHER_LOOP_ON = 0;
		WEATHER_SNOW_ON = 0;
		WEATHER_RAIN_ON = 0;
		WEATHER_LIGHTNING_ON = 0;
		WEATHER_RAIN_EVENT = "weather_rain_makesprite";
		WEATHER_SNOW_EVENT = "weather_snow_makesprite";
		WEATHER_SNOW_DROP_RATE = 0;
		WEATHER_RAIN_DROP_RATE = 0;
		DEST_WEATHER_SNOW_DROP_RATE = 0;
		DEST_WEATHER_RAIN_DROP_RATE = 0;
		WEATHER_RAIN_VOL = 0;
		DEST_WEATHER_RAIN_VOL = 0;
		WEATHER_TINT_ON = 0;
		WEATHER_TINT = 0 + "," + 0 + "," + 0 + "," + 0;
		DEST_WEATHER_TINT = 0 + "," + 0 + "," + 0 + "," + 0;
		WEATHER_FOG_ON = 0;
		WEATHER_FOG_COLOR = Vector3(0, 0, 0);
		WEATHER_FOG_DENSITY = 0;
		WEATHER_FOG_START = 0;
		WEATHER_FOG_END = 0;
		DEST_WEATHER_FOG_COLOR = Vector3(0, 0, 0);
		DEST_WEATHER_FOG_DENSITY = 0;
		DEST_WEATHER_FOG_START = 0;
		DEST_WEATHER_FOG_END = 0;
		WEATHER_FOG_NIGHT = 0;
		WEATHER_FOG_UNDERGROUND = 0;
		DEST_WEATHER_FOG_UNDERGROUND = 0;
		WEATHER_TINT_UNDERGROUND = 0;
		DEST_WEATHER_TINT_UNDERGROUND = 0;
		WEATHER_RAIN_MIST = 0;
		WEATHER_FORCE_CHANGE_TYPE = "none";
		WEATHER_CURRENT_AMB_VOL = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		if (!(WEATHER_FOG_UNDERGROUND))
		{
			if ((WEATHER_FOG_ON))
			{
			}
			weather_check_sky();
			int DID_SKY_CHECK = 1;
			if ((WEATHER_PLAYER_UNDERGROUND))
			{
				SetEnvironment("fog.enabled", 0);
			}
			else
			{
				SetEnvironment("fog.enabled", 1);
			}
		}
		if (!(WEATHER_TINT_UNDERGROUND))
		{
			if ((WEATHER_TINT_ON))
			{
			}
			if (!(DID_SKY_CHECK))
			{
				weather_check_sky();
			}
			if ((WEATHER_PLAYER_UNDERGROUND))
			{
				SetEnvironment("screen.tint", 0 + "," + 0 + "," + 0 + "," + 0);
			}
			else
			{
				SetEnvironment("screen.tint", WEATHER_TINT);
			}
		}
	}

	void tod_change()
	{
	}

	void weather_force_change()
	{
		if (param1 == "storm")
		{
			string PARAM1 = "rain_storm";
		}
		WEATHER_IN_TRANSITION = 0;
		weather_clear("abort");
		WEATHER_TO_FORCE = param1;
		ScheduleDelayedEvent(0.5, "weather_force_change2");
	}

	void weather_force_change2()
	{
		weather_finalize(WEATHER_TO_FORCE);
	}

	void weather_change()
	{
		string L_WEATHER = param1;
		if (L_WEATHER == "storm")
		{
			string L_WEATHER = "rain_storm";
		}
		PREV_WEATHER = WEATHER_TYPE;
		WEATHER_TYPE = L_WEATHER;
		WEATHER_PARAM = param2;
		if (!(PREV_WEATHER != WEATHER_TYPE)) return;
		if ((WEATHER_TYPE).findFirst("fog") >= 0)
		{
			weather_find_dest_fog();
		}
		weather_start_transition();
	}

	void weather_find_dest_fog()
	{
		if (WEATHER_TYPE == "fog_white")
		{
			weather_dest_fog("(1,1,1)", 1.4, 32, 2048, 1);
		}
		if (WEATHER_TYPE == "fog_thick")
		{
			weather_dest_fog("(0.9,0.9,0.9)", 5.4, 50, 500, 1);
		}
		if (WEATHER_TYPE == "fog_green")
		{
			weather_dest_fog("(0,1,0)", 1.4, 32, 2048, 1);
		}
		if (WEATHER_TYPE == "fog_red")
		{
			weather_dest_fog("(1,0,0)", 1.4, 32, 2048, 1);
		}
		if (WEATHER_TYPE == "fog_blue")
		{
			weather_dest_fog("(0.8,0.8,1.0)", 1.4, 32, 2048, 1);
		}
		if (WEATHER_TYPE == "fog_brown")
		{
			weather_dest_fog("(0.6,0.5,0.2)", 5.4, 50, 500, 1);
		}
		if (WEATHER_TYPE == "fog_black")
		{
			weather_dest_fog("(0.0,0,0.0,0.599)", 1.5, 50, 500, 1);
		}
		if (WEATHER_TYPE == "fog_custom")
		{
			weather_dest_fog(WEATHER_PARAM, 1.4, 32, 2048, 1);
		}
		if (WEATHER_TYPE == "fog_dragon_red")
		{
			weather_dest_fog("(1,0,0)", 0.4, 512, 2048, 1);
		}
		if (WEATHER_TYPE == "fog_dragon_black")
		{
			weather_dest_fog("(0.0,0,0.0,0.599)", 0.4, 512, 2048, 1);
		}
		if (WEATHER_TYPE == "fog_dragon_white")
		{
			WEATHER_SNOW_ON = 1;
			weather_dest_fog("(0.25,0.25,0.5)", 0.4, 512, 2048, 1);
		}
	}

	void weather_clear()
	{
		WEATHER_WAS_SNOW = 0;
		WEATHER_WAS_RAIN = 0;
		if ((WEATHER_SNOW_ON))
		{
			int DO_SPIN_DOWN = 1;
			WEATHER_WAS_SNOW = 1;
		}
		if ((WEATHER_RAIN_ON))
		{
			int DO_SPIN_DOWN = 1;
			WEATHER_WAS_RAIN = 1;
		}
		if ((DO_SPIN_DOWN))
		{
			WEATHER_VOL_SPIN_POINT = WEATHER_CURRENT_AMB_VOL;
			weather_spin_down_sound();
		}
		else
		{
			SetSoundVolume(WEATHER_CHANNEL);
		}
		WEATHER_CURRENT_AMB_VOL = 0;
		WEATHER_LOOP_ON = 0;
		WEATHER_IN_TRANSITION = 0;
		WEATHER_RAIN_ON = 0;
		WEATHER_SNOW_ON = 0;
		WEATHER_LIGHTNING_ON = 0;
		WEATHER_FOG_ON = 0;
		WEATHER_TINT_ON = 0;
		WEATHER_TINT = 0 + "," + 0 + "," + 0 + "," + 0;
		WEATHER_FOG_COLOR = Vector3(0, 0, 0);
		WEATHER_FOG_DENSITY = 0;
		if (TOD_STATE != "night")
		{
			int CLEAR_FOG = 1;
		}
		if (param1 == "abort")
		{
			int CLEAR_FOG = 1;
		}
		if ((CLEAR_FOG))
		{
			SetEnvironment("fog.enabled", 0);
			SetEnvironment("fog.color", 0);
			SetEnvironment("fog.density", 0);
			SetEnvironment("fog.start", 0);
			SetEnvironment("fog.end", 0);
			SetEnvironment("fog.type", "linear");
		}
		if (TOD_STATE == "day")
		{
			int CLEAR_TINT = 1;
		}
		if (param1 == "abort")
		{
			int CLEAR_TINT = 1;
		}
		if ((CLEAR_TINT))
		{
			SetEnvironment("screen.tint", 0 + "," + 0 + "," + 0 + "," + 0);
		}
	}

	void weather_spin_down_sound()
	{
		WEATHER_VOL_SPIN_POINT -= 0.1;
		if (WEATHER_VOL_SPIN_POINT == 0)
		{
			if ((WEATHER_WAS_RAIN))
			{
				SetSoundVolume(WEATHER_CHANNEL);
			}
			if ((WEATHER_WAS_SNOW))
			{
				SetSoundVolume(WEATHER_CHANNEL);
			}
		}
		if (WEATHER_VOL_SPIN_POINT > 0)
		{
			ScheduleDelayedEvent(0.1, "weather_spin_down_sound");
		}
		if ((WEATHER_WAS_RAIN))
		{
			SetSoundVolume(WEATHER_CHANNEL);
		}
		if ((WEATHER_WAS_SNOW))
		{
			SetSoundVolume(WEATHER_CHANNEL);
		}
	}

	void weather_dest_fog()
	{
		DEST_WEATHER_FOG_COLOR = param1;
		DEST_WEATHER_FOG_DENSITY = param2;
		DEST_WEATHER_FOG_START = param3;
		DEST_WEATHER_FOG_END = param4;
		WEATHER_FOG_UNDERGROUND = param5;
	}

	void weather_set_fog()
	{
		WEATHER_FOG_COLOR = param1;
		WEATHER_FOG_DENSITY = param2;
		WEATHER_FOG_START = param3;
		WEATHER_FOG_END = param4;
		WEATHER_FOG_UNDERGROUND = param5;
		if (!(WEATHER_FOG_UNDERGROUND))
		{
			if ((WEATHER_PLAYER_UNDERGROUND))
			{
			}
			int DELAY_FOG = 1;
		}
		if (!(DELAY_FOG))
		{
			SetEnvironment("fog.enabled", 1);
		}
		SetEnvironment("fog.color", WEATHER_FOG_COLOR);
		SetEnvironment("fog.density", WEATHER_FOG_DENSITY);
		SetEnvironment("fog.start", WEATHER_FOG_START);
		SetEnvironment("fog.end", WEATHER_FOG_END);
		if ((WEATHER_TYPE).findFirst("rain") >= 0)
		{
			SetEnvironment("fog.type", "exp");
		}
		else
		{
			SetEnvironment("fog.type", "linear");
		}
		WEATHER_FOG_ON = 1;
	}

	void weather_start_transition()
	{
		if ((WEATHER_IN_TRANSITION))
		{
			weather_force_change(WEATHER_TYPE);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((TOD_IN_TRANSITION))
		{
			weather_force_change(WEATHER_TYPE);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((WEATHER_IN_TRANSITION)) return;
		WEATHER_IN_TRANSITION = 1;
		if (WEATHER_TYPE == "clear")
		{
			DEST_WEATHER_FOG_COLOR = Vector3(0, 0, 0);
			DEST_WEATHER_FOG_DENSITY = 0;
			DEST_WEATHER_FOG_START = 0;
			DEST_WEATHER_FOG_END = 10000;
			DEST_WEATHER_SNOW_DROP_RATE = 0;
			DEST_WEATHER_RAIN_DROP_RATE = 0;
			DEST_WEATHER_RAIN_VOL = 0;
			DEST_WEATHER_TINT = 0 + "," + 0 + "," + 0 + "," + 0;
		}
		if ((WEATHER_TYPE).findFirst("fog") >= 0)
		{
			DEST_WEATHER_RAIN_VOL = 0;
		}
		if (WEATHER_TYPE == "rain")
		{
			EmitSound(GetOwner(), WEATHER_CHANNEL, SOUND_RAIN_START, 6);
			DEST_WEATHER_FOG_COLOR = WEATHER_RAIN_FOG_COLOR;
			DEST_WEATHER_FOG_DENSITY = WEATHER_RAIN_FOG_DENSITY;
			DEST_WEATHER_FOG_START = WEATHER_RAIN_FOG_START;
			DEST_WEATHER_FOG_END = WEATHER_RAIN_FOG_END;
			DEST_WEATHER_SNOW_DROP_RATE = 0;
			DEST_WEATHER_RAIN_DROP_RATE = WEATHER_RAIN_DROP_MAXRATE;
			DEST_WEATHER_RAIN_VOL = WEATHER_RAIN_MAXVOL;
			WEATHER_RAIN_ZVELOCITY = Random(-500, -200);
			int DEST_FOG_ON = 1;
			if (TOD_STATE == "day")
			{
				DEST_WEATHER_TINT = WEATHER_RAIN_TINT_DAY;
			}
			if (TOD_STATE == "dusk")
			{
				DEST_WEATHER_TINT = WEATHER_RAIN_TINT_DUSK;
			}
			if (TOD_STATE == "night")
			{
				DEST_WEATHER_TINT = WEATHER_RAIN_TINT_NIGHT;
			}
			if (!(WEATHER_LOOP_ON))
			{
			}
			weather_loop_start();
		}
		if (WEATHER_TYPE == "rain_storm")
		{
			EmitSound(GetOwner(), WEATHER_CHANNEL, SOUND_RAIN_START, 10);
			DEST_WEATHER_FOG_COLOR = WEATHER_RAIN_FOG_COLOR;
			DEST_WEATHER_FOG_DENSITY = WEATHER_RAIN_FOG_DENSITY;
			DEST_WEATHER_FOG_START = WEATHER_RAIN_FOG_START;
			DEST_WEATHER_FOG_END = WEATHER_RAIN_FOG_END;
			DEST_WEATHER_SNOW_DROP_RATE = 0;
			DEST_WEATHER_RAIN_DROP_RATE = WEATHER_STORM_DROP_MAXRATE;
			DEST_WEATHER_RAIN_VOL = WEATHER_STORM_MAXVOL;
			WEATHER_RAIN_ZVELOCITY = Random(-1000, -900);
			WEATHER_LIGHTNING_ON = 1;
			int DEST_FOG_ON = 1;
			if (TOD_STATE == "day")
			{
				DEST_WEATHER_TINT = WEATHER_RAIN_TINT_DAY;
			}
			if (TOD_STATE == "dusk")
			{
				DEST_WEATHER_TINT = WEATHER_RAIN_TINT_DUSK;
			}
			if (TOD_STATE == "night")
			{
				DEST_WEATHER_TINT = WEATHER_RAIN_TINT_NIGHT;
			}
			if (!(WEATHER_LOOP_ON))
			{
			}
			weather_loop_start();
		}
		if (WEATHER_TYPE == "snow")
		{
			DEST_WEATHER_FOG_COLOR = WEATHER_SNOW_FOG_COLOR;
			WEATHER_SNOW_FOG_DENSITY = 0.4;
			WEATHER_SNOW_FOG_START = 64;
			DEST_WEATHER_FOG_DENSITY = WEATHER_SNOW_FOG_DENSITY;
			DEST_WEATHER_FOG_START = WEATHER_SNOW_FOG_START;
			DEST_WEATHER_FOG_END = WEATHER_SNOW_FOG_END;
			DEST_WEATHER_SNOW_DROP_RATE = WEATHER_SNOW_DROP_RATE;
			DEST_WEATHER_RAIN_DROP_RATE = 0;
			DEST_WEATHER_RAIN_VOL = 0;
			DEST_WEATHER_TINT = WEATHER_SNOW_TINT;
			WEATHER_SNOW_ON = 1;
			WEATHER_LIGHTNING_ON = 0;
			int DEST_FOG_ON = 1;
			if (!(WEATHER_LOOP_ON))
			{
			}
			weather_loop_start();
		}
		if (WEATHER_RAIN_VOL == 0)
		{
			if (DEST_WEATHER_RAIN_VOL > 0)
			{
			}
			EmitSound(GetOwner(), WEATHER_CHANNEL, SOUND_RAIN, 0.001);
			WEATHER_RAIN_ON = 1;
		}
		if ((DEST_FOG_ON))
		{
			if (!(WEATHER_FOG_ON))
			{
			}
			SetEnvironment("fog.enabled", 1);
			SetEnvironment("fog.color", 0);
			SetEnvironment("fog.density", 0);
			SetEnvironment("fog.start", 0);
			SetEnvironment("fog.end", 10000);
			SetEnvironment("fog.type", "linear");
			WEATHER_FOG_ON = 1;
		}
		CUR_WEATHER_SNOW_DROP_RATE = WEATHER_SNOW_DROP_RATE;
		CUR_WEATHER_RAIN_DROP_RATE = WEATHER_RAIN_DROP_RATE;
		CUR_WEATHER_RAIN_VOL = WEATHER_RAIN_VOL;
		WEATHER_SPIN_RATIO = 0;
		weather_transition_loop();
	}

	void weather_transition_loop()
	{
		if (!(WEATHER_IN_TRANSITION)) return;
		WEATHER_SPIN_RATIO += 0.1;
		if (WEATHER_SPIN_RATIO == 1.0)
		{
			weather_finalize(WEATHER_TYPE);
			int EXIT_SUB = 1;
		}
		else
		{
			ScheduleDelayedEvent(0.1, "weather_transition_loop");
		}
		if ((EXIT_SUB)) return;
		string W_RATIO = WEATHER_SPIN_RATIO;
		if (WEATHER_TINT != DEST_WEATHER_TINT)
		{
			string C_R = (WEATHER_TINT).x;
			string C_G = (WEATHER_TINT).z;
			string C_B = (WEATHER_TINT).y;
			string D_R = (DEST_WEATHER_TINT).x;
			string D_G = (DEST_WEATHER_TINT).z;
			string D_B = (DEST_WEATHER_TINT).y;
			string T_R = /* TODO: $ratio */ $ratio(W_RATIO, C_R, D_R);
			string T_G = /* TODO: $ratio */ $ratio(W_RATIO, C_G, D_G);
			string T_B = /* TODO: $ratio */ $ratio(W_RATIO, C_B, D_B);
			SetEnvironment("screen.tint", Vector3(T_R, T_G, T_B));
		}
		if ((WEATHER_RAIN_ON))
		{
			if (DEST_WEATHER_RAIN_DROP_RATE != CUR_WEATHER_RAIN_DROP_RATE)
			{
				WEATHER_RAIN_DROP_RATE = /* TODO: $ratio */ $ratio(W_RATIO, CUR_WEATHER_RAIN_DROP_RATE, DEST_WEATHER_RAIN_DROP_RATE);
			}
		}
		if ((WEATHER_SNOW_ON))
		{
			if (DEST_WEATHER_SNOW_DROP_RATE != CUR_WEATHER_SNOW_DROP_RATE)
			{
				WEATHER_SNOW_DROP_RATE = /* TODO: $ratio */ $ratio(W_RATIO, CUR_WEATHER_SNOW_DROP_RATE, DEST_WEATHER_SNOW_DROP_RATE);
			}
		}
		if (DEST_WEATHER_RAIN_VOL > 0)
		{
			SetSoundVolume(WEATHER_CHANNEL);
		}
		if (!(WEATHER_FOG_ON)) return;
		if (WEATHER_FOG_COLOR != DEST_WEATHER_FOG_COLOR)
		{
			string C_R = (WEATHER_FOG_COLOR).x;
			string C_G = (WEATHER_FOG_COLOR).z;
			string C_B = (WEATHER_FOG_COLOR).y;
			string D_R = (DEST_WEATHER_FOG_COLOR).x;
			string D_G = (DEST_WEATHER_FOG_COLOR).z;
			string D_B = (DEST_WEATHER_FOG_COLOR).y;
			string T_R = /* TODO: $ratio */ $ratio(W_RATIO, C_R, D_R);
			string T_G = /* TODO: $ratio */ $ratio(W_RATIO, C_G, D_G);
			string T_B = /* TODO: $ratio */ $ratio(W_RATIO, C_B, D_B);
			SetEnvironment("fog.color", Vector3(T_R, T_G, T_B));
		}
		if (WEATHER_FOG_DENSITY != DEST_WEATHER_FOG_DENSITY)
		{
			SetEnvironment("fog.density", /* TODO: $ratio */ $ratio(W_RATIO, WEATHER_FOG_DENSITY, DEST_WEATHER_FOG_DENSITY));
		}
		if (WEATHER_FOG_START != DEST_WEATHER_FOG_START)
		{
			SetEnvironment("fog.start", /* TODO: $ratio */ $ratio(W_RATIO, WEATHER_FOG_START, DEST_WEATHER_FOG_START));
		}
		if (WEATHER_FOG_END != DEST_WEATHER_FOG_END)
		{
			SetEnvironment("fog.end", /* TODO: $ratio */ $ratio(W_RATIO, WEATHER_FOG_END, DEST_WEATHER_FOG_END));
		}
	}

	void weather_finalize()
	{
		WEATHER_IN_TRANSITION = 0;
		if (param1 != WEATHER_TYPE)
		{
			WEATHER_TYPE = param1;
		}
		if (WEATHER_TYPE == "clear")
		{
			weather_clear();
		}
		if (WEATHER_TYPE == "rain")
		{
			WEATHER_FOG_COLOR = WEATHER_RAIN_FOG_COLOR;
			WEATHER_FOG_DENSITY = WEATHER_RAIN_FOG_DENSITY;
			WEATHER_FOG_START = WEATHER_RAIN_FOG_START;
			WEATHER_FOG_END = WEATHER_RAIN_FOG_END;
			WEATHER_SNOW_DROP_RATE = 0;
			WEATHER_RAIN_DROP_RATE = WEATHER_RAIN_DROP_MAXRATE;
			WEATHER_RAIN_VOL = WEATHER_RAIN_MAXVOL;
			WEATHER_FOG_ON = 1;
			WEATHER_FOG_UNDERGROUND = 0;
			WEATHER_TINT_ON = 1;
			WEATHER_TINT_UNDERGROUND = 0;
			WEATHER_WIND_STRENGTH = 0;
			WEATHER_RAIN_ZVELOCITY = Random(-500, -200);
			WEATHER_CURRENT_AMB_VOL = 6;
			EmitSound(GetOwner(), WEATHER_CHANNEL, SOUND_RAIN, WEATHER_RAIN_MAXVOL);
			SetSoundVolume(WEATHER_CHANNEL);
			WEATHER_LIGHTNING_ON = 0;
			WEATHER_SNOW_ON = 0;
			WEATHER_RAIN_ON = 1;
			if (TOD_STATE == "day")
			{
				WEATHER_TINT = WEATHER_RAIN_TINT_DAY;
			}
			if (TOD_STATE == "dusk")
			{
				WEATHER_TINT = WEATHER_RAIN_TINT_DUSK;
			}
			if (TOD_STATE == "night")
			{
				WEATHER_TINT = WEATHER_RAIN_TINT_NIGHT;
			}
			weather_loop_start();
		}
		if (WEATHER_TYPE == "rain_storm")
		{
			WEATHER_FOG_COLOR = WEATHER_RAIN_FOG_COLOR;
			WEATHER_FOG_DENSITY = WEATHER_RAIN_FOG_DENSITY;
			WEATHER_FOG_START = WEATHER_RAIN_FOG_START;
			WEATHER_FOG_END = WEATHER_RAIN_FOG_END;
			WEATHER_SNOW_DROP_RATE = 0;
			WEATHER_RAIN_DROP_RATE = WEATHER_STORM_DROP_MAXRATE;
			WEATHER_RAIN_VOL = WEATHER_RAIN_MAXVOL;
			WEATHER_FOG_ON = 1;
			WEATHER_FOG_UNDERGROUND = 0;
			WEATHER_TINT_ON = 1;
			WEATHER_TINT_UNDERGROUND = 0;
			WEATHER_WIND_STRENGTH = Random(0, 200);
			WEATHER_RAIN_ZVELOCITY = Random(-1000, -900);
			WEATHER_CURRENT_AMB_VOL = 10;
			EmitSound(GetOwner(), WEATHER_CHANNEL, SOUND_RAIN, WEATHER_STORM_MAXVOL);
			SetSoundVolume(WEATHER_CHANNEL);
			WEATHER_LIGHTNING_ON = 1;
			WEATHER_SNOW_ON = 0;
			WEATHER_RAIN_ON = 1;
			if (TOD_STATE == "day")
			{
				WEATHER_TINT = WEATHER_RAIN_TINT_DAY;
			}
			if (TOD_STATE == "dusk")
			{
				WEATHER_TINT = WEATHER_RAIN_TINT_DUSK;
			}
			if (TOD_STATE == "night")
			{
				WEATHER_TINT = WEATHER_RAIN_TINT_NIGHT;
			}
			weather_loop_start();
		}
		if (WEATHER_TYPE == "snow")
		{
			WEATHER_FOG_COLOR = WEATHER_SNOW_FOG_COLOR;
			WEATHER_FOG_DENSITY = WEATHER_SNOW_FOG_DENSITY;
			WEATHER_FOG_START = WEATHER_SNOW_FOG_START;
			WEATHER_FOG_END = WEATHER_SNOW_FOG_END;
			WEATHER_SNOW_DROP_RATE = 5;
			WEATHER_RAIN_DROP_RATE = 0;
			WEATHER_RAIN_VOL = 0;
			WEATHER_FOG_ON = 1;
			WEATHER_FOG_UNDERGROUND = 0;
			WEATHER_TINT_ON = 0;
			WEATHER_TINT = 0 + "," + 0 + "," + 0 + "," + 0;
			WEATHER_TINT_UNDERGROUND = 0;
			WEATHER_CURRENT_AMB_VOL = 10;
			WEATHER_SNOW_NEXT_SOUND = GetGameTime();
			WEATHER_SNOW_NEXT_SOUND += FREQ_WEATHER_SNOW_SOUND;
			WEATHER_LIGHTNING_ON = 0;
			WEATHER_SNOW_ON = 1;
			WEATHER_RAIN_ON = 0;
			weather_loop_start();
			int WEATHER_CYCLES = 1;
		}
		if ((WEATHER_TYPE).findFirst("fog") >= 0)
		{
			WEATHER_FOG_ON = 1;
			WEATHER_FOG_UNDERGROUND = 1;
			WEATHER_TINT_ON = 0;
			WEATHER_TINT_UNDERGROUND = 0;
			WEATHER_FOG_ON = 1;
			WEATHER_LIGHTNING_ON = 0;
			WEATHER_SNOW_ON = 0;
			WEATHER_RAIN_ON = 0;
			WEATHER_LOOP_ON = 0;
			weather_find_dest_fog();
			int DID_FOG_SETUP = 1;
			weather_set_fog(DEST_WEATHER_FOG_COLOR, DEST_WEATHER_FOG_DENSITY, DEST_WEATHER_FOG_START, DEST_WEATHER_FOG_END, WEATHER_FOG_UNDERGROUND);
		}
		if ((WEATHER_FOG_ON))
		{
			if (!(DID_FOG_SETUP))
			{
			}
			weather_set_fog(WEATHER_FOG_COLOR, WEATHER_FOG_DENSITY, WEATHER_FOG_START, WEATHER_FOG_END, WEATHER_FOG_UNDERGROUND);
		}
		SetEnvironment("screen.tint", WEATHER_TINT);
	}

	void weather_loop_start()
	{
		if ((WEATHER_LOOP_ON)) return;
		WEATHER_LOOP_ON = 1;
		weather_loop();
	}

	void weather_loop()
	{
		if (!(WEATHER_LOOP_ON)) return;
		ScheduleDelayedEvent(0.1, "weather_loop");
		if ((WEATHER_RAIN_ON))
		{
			if (!(WEATHER_PLAYER_UNDERGROUND))
			{
			}
			for (int i = 0; i < int(WEATHER_RAIN_DROP_RATE); i++)
			{
				weather_make_rain();
			}
			if (GetGameTime() > NEXT_RAIN_SOUND)
			{
				NEXT_RAIN_SOUND = GetGameTime();
				NEXT_RAIN_SOUND += FREQ_WEATHER_RAIN_SOUND;
				EmitSound(GetOwner(), WEATHER_CHANNEL, SOUND_RAIN, WEATHER_CURRENT_AMB_VOL);
			}
		}
		if ((WEATHER_SNOW_ON))
		{
			if (!(WEATHER_PLAYER_UNDERGROUND))
			{
			}
			for (int i = 0; i < WEATHER_SNOW_RATE; i++)
			{
				weather_make_snow();
			}
			if (GetGameTime() > NEXT_SNOW_SOUND)
			{
				NEXT_SNOW_SOUND = GetGameTime();
				NEXT_SNOW_SOUND += FREQ_WEATHER_SNOW_SOUND;
				EmitSound(GetOwner(), WEATHER_CHANNEL, SOUND_SNOW, "const.snd.maxvol");
			}
		}
	}

	void weather_make_rain()
	{
		string DROP_POS = /* TODO: $getcl */ $getcl("game.localplayer.index", "origin");
		float DROP_X_ADJ = Random(/* TODO: $neg */ $neg(WEATHER_RAIN_RADIUS), WEATHER_RAIN_RADIUS);
		float DROP_Y_ADJ = Random(/* TODO: $neg */ $neg(WEATHER_RAIN_RADIUS), WEATHER_RAIN_RADIUS);
		DROP_POS += "x";
		DROP_POS += "y";
		DROP_POS = "z";
		if (!(/* TODO: $get_under_sky */ $get_under_sky(DROP_POS))) return;
		ClientEffect("tempent", "sprite", WEATHER_SPRITE_RAIN, DROP_POS, WEATHER_RAIN_EVENT, "none", "weather_drop_splash");
	}

	void weather_make_snow()
	{
		string DROP_POS = /* TODO: $getcl */ $getcl("game.localplayer.index", "origin");
		float DROP_X_ADJ = Random(/* TODO: $neg */ $neg(WEATHER_SNOW_RADIUS), WEATHER_SNOW_RADIUS);
		float DROP_Y_ADJ = Random(/* TODO: $neg */ $neg(WEATHER_SNOW_RADIUS), WEATHER_SNOW_RADIUS);
		DROP_POS += "x";
		DROP_POS += "y";
		DROP_POS = "z";
		if (!(/* TODO: $get_under_sky */ $get_under_sky(DROP_POS))) return;
		ClientEffect("tempent", "sprite", WEATHER_SPRITE_SNOW, DROP_POS, "weather_make_snowflake");
	}

	void weather_check_sky()
	{
		string MY_ID = "game.localplayer.index";
		string MY_ORG = /* TODO: $getcl */ $getcl(MY_ID, "origin");
		int PLAYER_UNDER_SKY = 0;
		PLAYER_UNDER_SKY += /* TODO: $get_under_sky */ $get_under_sky(MY_ORG);
		string MY_ANG = /* TODO: $getcl */ $getcl(MY_ID, "viewangles");
		MY_ORG += "z";
		string TRACE_START = MY_ORG;
		string TRACE_END = MY_ORG;
		TRACE_END += /* TODO: $relpos */ $relpos(MY_ANG, Vector3(0, 100, 0));
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		PLAYER_UNDER_SKY += /* TODO: $get_under_sky */ $get_under_sky(TRACE_LINE);
		if (PLAYER_UNDER_SKY == 0)
		{
			WEATHER_PLAYER_UNDERGROUND_COUNT += 1;
			if (WEATHER_PLAYER_UNDERGROUND_COUNT >= 10)
			{
				WEATHER_PLAYER_UNDERGROUND = 1;
				WEATHER_PLAYER_UNDERGROUND_COUNT = 10;
			}
		}
		else
		{
			WEATHER_PLAYER_UNDERGROUND_COUNT = 0;
			WEATHER_PLAYER_UNDERGROUND = 0;
		}
	}

	void weather_rain_makesprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.2);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(1.0, 1.5));
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		ClientEffect("tempent", "set_current_prop", "cb_hitwater", "weather_drop_splash_Water");
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 50);
		if (WEATHER_TYPE == "rain_storm")
		{
			if (WEATHER_WIND_STRENGTH > 0)
			{
			}
			string L_WIND_DIR = WEATHER_WIND_DIR;
			L_WIND_DIR *= WEATHER_WIND_DIR;
			ClientEffect("tempent", "set_current_prop", "velocity", L_WIND_DIR);
		}
		ClientEffect("tempent", "set_current_prop", "velocity.z", WEATHER_RAIN_ZVELOCITY);
	}

	void weather_drop_splash_Water()
	{
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(90, 0, 0));
		ClientEffect("tempent", "set_current_prop", "sprite", WEATHER_SPRITE_RAIN_RIPPLE);
		ClientEffect("tempent", "set_current_prop", "maxs", Vector3(0, 0, 128));
		ClientEffect("tempent", "set_current_prop", "origin", "game.tempent.waterorigin");
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "framerate", 8);
		ClientEffect("tempent", "set_current_prop", "frames", 15);
		ClientEffect("tempent", "set_current_prop", "scale", 1);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 50);
	}

	void weather_drop_splash()
	{
		ClientEffect("tempent", "set_current_prop", "sprite", SPRITE_SPLASH);
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.8);
		ClientEffect("tempent", "set_current_prop", "framerate", 6);
		ClientEffect("tempent", "set_current_prop", "frames", 3);
		ClientEffect("tempent", "set_current_prop", "scale", 0.3);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		WEATHER_RAIN_MIST += 1;
		if (!(WEATHER_RAIN_MIST > 4)) return;
		WEATHER_RAIN_MIST = 0;
		string L_POS = "game.tempent.origin";
		ClientEffect("tempent", "sprite", WEATHER_SPRITE_RAIN_MIST, L_POS, "weather_create_drop_mist");
	}

	void weather_create_drop_mist()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 12);
		ClientEffect("tempent", "set_current_prop", "scale", 10);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.00105);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-15, 15), Random(-15, 15), 0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 10);
	}

	void weather_make_snowflake()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.1, 0.2));
		ClientEffect("tempent", "set_current_prop", "velocity.z", -100);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(0.1, 0.3));
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
	}

	void weather_snow_breath()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 30);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.01);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 30);
	}

}

}
