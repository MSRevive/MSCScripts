#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	int TIME_OF_DAY;

	void OnSpawn() override
	{
		string L_SKY = FindEntityByName("skybox");
		SetProp(L_SKY, "setbody", 0);
		TIME_OF_DAY = 0;
	}

	void game_triggered()
	{
		if (param1 == "jl_met")
		{
			CallExternal(FindEntityByName("ishmeea"), "ext_met_leofing");
		}
		if (param1 == "cv_met")
		{
			CallExternal(FindEntityByName("leofing"), "ext_met_ishmeea");
		}
		if (param1 == "jl_celldoor1break")
		{
			CallExternal(FindEntityByName("leofing"), "ext_cell_key");
		}
		if (param1 == "counter_ish")
		{
			CallExternal(FindEntityByName("ishmeea"), "ext_collected");
			CallExternal(FindEntityByName("alfgar"), "ext_zombify");
		}
		if (param1 == "tele_ishmeea")
		{
			CallExternal(FindEntityByName("ishmeea"), "ext_tele_triggered");
		}
		if (param1 == "chapel_start")
		{
			CallExternal(FindEntityByName("ishmeea"), "ext_chapel_start");
			CallExternal(FindEntityByName("idemark"), "ext_chapel_start");
		}
		if (param1 == "final_boss_die")
		{
			CallExternal(FindEntityByName("ishmeea"), "ext_boss_died");
		}
		if (param1 == "relay_envlightday")
		{
			string L_SKY = FindEntityByName("skybox");
			SetProp(L_SKY, "setbody", 0);
			TIME_OF_DAY = 0;
		}
		if (param1 == "relay_envlightsunset")
		{
			string L_SKY = FindEntityByName("skybox");
			SetProp(L_SKY, "setbody", 0);
			TIME_OF_DAY = 1;
		}
		if (param1 == "relay_envlightnight")
		{
			string L_SKY = FindEntityByName("skybox");
			SetProp(L_SKY, "setbody", 0);
		}
	}

}

}
