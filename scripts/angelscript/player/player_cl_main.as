#pragma context server

namespace MS
{

class PlayerClMain : CGameScript
{
	string NEXT_BREATH;
	string PLR_GENDER;
	string PLR_RACE;

	PlayerClMain()
	{
	}

	void game_think()
	{
		if (!(GetGameTime() > NEXT_BREATH)) return;
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += 0.1;
		player_breathe();
	}

	void game_jump()
	{
	}

	void game_jump_land()
	{
	}

	void game_hitground()
	{
		player_hitgroundhard(param1);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
	}

	void set_cl_gender_race()
	{
		PLR_GENDER = param1;
		PLR_RACE = param2;
		LogDebug("set_cl_gender_race PLR_GENDER PLR_RACE");
	}

}

}
