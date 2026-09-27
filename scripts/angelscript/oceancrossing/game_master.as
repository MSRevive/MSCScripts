#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	void OnSpawn() override
	{
		string L_SKY = FindEntityByName("skybox");
		SetProp(L_SKY, "setbody", 0);
		ScheduleDelayedEvent(0.01, "game_think");
	}

	void game_triggered()
	{
		string L_OCEAN = FindEntityByName("ocean");
		string L_SKY = FindEntityByName("skybox");
		if (param1 == "deralia_start")
		{
			SetProp(L_OCEAN, "skin", 2);
			SetProp(L_SKY, "setbody", 0);
			UseTrigger("relay_envlightnight");
		}
		else
		{
			if (param1 == "ara_start")
			{
				SetProp(L_SKY, "setbody", 0);
				UseTrigger("relay_envlightsunset");
			}
			else
			{
				if (param1 == "isles_start")
				{
					SetProp(L_OCEAN, "skin", 3);
				}
				else
				{
					if (param1 == "tundra_start")
					{
						SetGlobalVar("G_WEATHER_LOCK", "snow");
						CallExternal("players", "ext_weather_change", "snow");
						SetProp(L_OCEAN, "skin", 1);
						SetProp(L_OCEAN, "sequence", 1);
					}
				}
			}
		}
		if (param1 == "cannon_fired")
		{
			SetProp(L_OCEAN, "sequence", 1);
			CallExternal("players", "ext_weather_change", "clear");
		}
	}

	void player_joined()
	{
		if ((LOCK_TO_NIGHT))
		{
			CallExternal(param1, "ext_environment_change", "night");
		}
		if (LOCK_SKY != "LOCK_SKY")
		{
			CallExternal(param1, "ext_change_sky", LOCK_SKY);
		}
	}

	void game_think()
	{
		string L_SKY = FindEntityByName("skybox");
		string L_NUM = RUN_NUM;
		L_NUM %= 50;
		L_NUM /= 50;
		L_NUM *= 6.28;
		string L_ANG = sin(L_NUM);
		SetProp(L_SKY, "angles", Vector3(L_ANG, 0, 0));
		RUN_NUM += 1;
		ScheduleDelayedEvent(0.01, "game_think");
	}

}

}
