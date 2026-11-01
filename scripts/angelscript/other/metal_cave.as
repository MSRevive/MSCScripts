#pragma context server

namespace MS
{

class MetalCave : CGameScript
{
	int DEBUG_ANG;
	int PLAYING_DEAD;

	void OnSpawn() override
	{
		SetModel("terrain/metal_caverns_01b.mdl");
		SetName("metal_cave");
		SetSolid("none");
		SetInvincible(true);
		SetNoPush(true);
		SetGravity(0);
		SetFly(true);
		SetName("");
		SetRoam(false);
		PLAYING_DEAD = 1;
		DEBUG_ANG = 0;
		SetAngles("face");
		ScheduleDelayedEvent(0.5, "refresh_cl_fx");
	}

	void refresh_cl_fx()
	{
		ClientEvent("update", "all", "const.localplayer.scriptID", "cl_metal_cave_light", GetEntityIndex(GetOwner()));
	}

	void ext_refresh_cl_fx()
	{
		refresh_cl_fx();
	}

	void ext_turn()
	{
		if (param1 == "PARAM1")
		{
			DEBUG_ANG += 5;
			string PARAM1 = DEBUG_ANG;
		}
		SetAngles("face");
		LogDebug("ext_turn PARAM1");
	}

	void ext_clearout()
	{
		ClientEvent("update", "all", "const.localplayer.scriptID", "cl_metal_cave_light_end", GetEntityIndex(GetOwner()));
		GetAllPlayers(PLAYER_LIST);
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			tele_players();
		}
	}

	void tele_players()
	{
		string CUR_TARG = GetToken(PLAYER_LIST, i, ";");
		if (GetEntityProperty(CUR_TARG, "range2d") < 896)
		{
			// TODO: tospawn CUR_TARG from_tear
		}
	}

}

}
