#pragma context server

namespace MS
{

class ShadTeleBase : CGameScript
{
	void OnSpawn() override
	{
		SetFly(true);
		SetRoam(false);
		SetGravity(0);
	}

	void game_postspawn()
	{
		string TOKEN_PARAMS = param4;
		string MY_LOC = GetEntityOrigin(GetOwner());
		CallExternal(GAME_MASTER, "set_shad_tele_point", MY_LOC, GetToken(TOKEN_PARAMS, 0, ";"), GetToken(TOKEN_PARAMS, 1, ";"));
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
