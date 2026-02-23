#pragma context server

#include "effects/base_effect.as"

namespace MS
{

class AddDynamicSpawn : CGameScript
{
	int DYNS_ACTIVE;
	string DYNS_CHECK_SIGHT;
	string DYNS_FLYER;
	int DYNS_FOUND_VALID;
	float DYNS_FREQ;
	string DYNS_GLOBAL;
	string DYNS_IN_VIEW;
	string DYNS_LOWEST_TRANGE;
	string DYNS_SPAWN_POINT;
	string DYNS_STARTED;
	string DYNS_TEST_PLAYER;
	int DYNS_TEST_PLAYER_TRANGE;
	string DYNS_VALID_TARGETS;
	string DYNS_WINNER;
	string DYN_SPAWNER;
	string DYN_SPAWNER_MAXS;
	string DYN_SPAWNER_MINS;
	int EFFECT_IGNORE_CLEARFX;
	int PLAYING_DEAD;

	AddDynamicSpawn()
	{
		const string EFFECT_ID = "dynamic_spawn";
		const string EFFECT_FLAGS = "nostack";
		EFFECT_IGNORE_CLEARFX = 1;
	}

	void game_activate()
	{
		if (param1 == "world")
		{
			DYNS_GLOBAL = 1;
			if ((param2).findFirst("PARAM") == 0)
			{
				if ((param2).substr(0, 1) > 0)
				{
					DYNS_SRADIUS = param2;
				}
				else
				{
					DYNS_SRADIUS = 512;
				}
			}
			else
			{
				DYNS_SRADIUS = 512;
			}
		}
		DYNS_STARTED = GetGameTime();
		SetEntityOrigin(GetOwner(), Vector3(40000, 40000, 4000));
		CallExternal(GetOwner(), "npcatk_suspend_ai");
		PLAYING_DEAD = 1;
		if (!(DYNS_GLOBAL))
		{
			DYN_SPAWNER = GetSpawner(GetOwner());
			DYN_SPAWNER_MINS = GetEntityProperty(DYN_SPAWNER, "absmin");
			DYN_SPAWNER_MAXS = GetEntityProperty(DYN_SPAWNER, "absmax");
		}
		if (NPC_FLIGHT != "NPC_FLIGHT")
		{
			DYNS_FLYER = 1;
		}
		if ((GetEntityProperty(GetOwner(), "fly")))
		{
			DYNS_FLYER = 1;
		}
		DYNS_ACTIVE = 1;
		DYNS_FREQ = 0.1;
		ScheduleDelayedEvent(0.1, "dyns_hunt_find_location");
	}

	void dyns_hunt_find_location()
	{
		if (!(DYNS_ACTIVE)) return;
		DYNS_FREQ("dyns_hunt_find_location");
		if (GetPlayerCount() == 0)
		{
			DYNS_FREQ = 1.0;
		}
		if (!(GetPlayerCount() > 0)) return;
		DYNS_FREQ = 0.1;
		GetAllPlayers(DYNS_TARGETS);
		DYNS_FOUND_VALID = 0;
		DYNS_VALID_TARGETS = "";
		if (!(DYNS_GLOBAL))
		{
			for (int i = 0; i < GetTokenCount(DYNS_TARGETS, ";"); i++)
			{
				dyns_find_validate();
			}
		}
		else
		{
			DYNS_FOUND_VALID = 1;
			DYNS_VALID_TARGETS = DYNS_TARGETS;
		}
		if (!(DYNS_FOUND_VALID)) return;
		LogDebug("dyns_hunt_find_location");
		string L_RND = RandomInt(1, 5);
		if ((DYNS_GLOBAL))
		{
			int L_RND = 1;
		}
		if (L_RND < 5)
		{
			if (!(DYNS_GLOBAL))
			{
				string L_X = Random((DYN_SPAWNER_MINS).x, (DYN_SPAWNER_MAXS).x);
				string L_Y = Random((DYN_SPAWNER_MINS).y, (DYN_SPAWNER_MAXS).y);
				string L_Z = Random((DYN_SPAWNER_MINS).z, (DYN_SPAWNER_MAXS).z);
				DYNS_CHECK_SIGHT = Vector3(L_X, L_Y, L_Z);
			}
			else
			{
				DYNS_CHECK_SIGHT = /* TODO: $func */ $func("func_dyns_findspawnpoint");
			}
			if (DYNS_CHECK_SIGHT == "none")
			{
				return;
			}
			if (!(DYNS_FLYER))
			{
				DYNS_CHECK_SIGHT = "z";
			}
			DYNS_IN_VIEW = 0;
			for (int i = 0; i < GetTokenCount(DYNS_TARGETS, ";"); i++)
			{
				dyns_check_inview();
			}
			if (!(DYNS_IN_VIEW))
			{
			}
			DYNS_SPAWN_POINT = DYNS_CHECK_SIGHT;
			string L_LEGIT = /* TODO: $func */ $func("func_dyns_test_point", DYNS_SPAWN_POINT);
		}
		else
		{
			string L_N_TARGS = GetTokenCount(DYNS_VALID_TARGETS, ";");
			if (L_N_TARGS > 1)
			{
				string L_PLAYER_IDX = RandomInt(0, /* TODO: $math(subtract) */ L_N_TARGS);
			}
			else
			{
				int L_PLAYER_IDX = 0;
			}
			string L_PLAYER = GetToken(DYNS_VALID_TARGETS, L_PLAYER_IDX, ";");
			string L_PLAYER_VIEW = GetEntityProperty(L_PLAYER, "viewangles");
			string L_PLAYER_VIEW_YAW = /* TODO: $vec.yaw */ $vec.yaw(L_PLAYER_VIEW);
			L_PLAYER_VIEW_YAW -= 180;
			if (L_PLAYER_VIEW_YAW < 0)
			{
				L_PLAYER_VIEW_YAW += 360;
			}
			L_PLAYER_VIEW = "y";
			string L_PLAYER_POS = GetEntityOrigin(L_PLAYER);
			string L_PLAYER_BACK = Random(32, 128);
			L_PLAYER_BACK += GetEntityWidth(GetOwner());
			L_PLAYER_POS += /* TODO: $relpos */ $relpos(L_PLAYER_VIEW, Vector3(0, L_PLAYER_BACK, 0));
			DYNS_CHECK_SIGHT = L_PLAYER_POS;
			if (!(DYNS_FLYER))
			{
				DYNS_CHECK_SIGHT = "z";
			}
			DYNS_IN_VIEW = 0;
			for (int i = 0; i < GetTokenCount(DYNS_TARGETS, ";"); i++)
			{
				dyns_check_inview();
			}
			if (!(DYNS_IN_VIEW))
			{
			}
			DYNS_SPAWN_POINT = DYNS_CHECK_SIGHT;
			string L_LEGIT = /* TODO: $func */ $func("func_dyns_test_point", DYNS_SPAWN_POINT);
		}
		if (!(L_LEGIT)) return;
		dyns_finalize();
	}

	void dyns_finalize()
	{
		int L_DYNS_TEST_MODE = 0;
		if (!(L_DYNS_TEST_MODE))
		{
			PLAYING_DEAD = 0;
			CallExternal(GetOwner(), "npcatk_resume_ai");
			DYNS_ACTIVE = 0;
			CallExternal(GetOwner(), "set_home_loc", GetEntityOrigin(GetOwner()));
			RemoveScript();
		}
		else
		{
			SetRoam(false);
			CallExternal(GetOwner(), "npcatk_suspend_ai");
			EmitSound(GetOwner(), 0, "magic/cast.wav", 10);
			DYNS_ACTIVE = 0;
			ScheduleDelayedEvent(5.0, "dyns_loop_test");
		}
	}

	void dyns_loop_test()
	{
		game_activate();
	}

	void dyns_find_validate()
	{
		string L_CUR_TARG = GetToken(DYNS_TARGETS, i, ";");
		if (!(/* TODO: $within_box */ $within_box(L_CUR_TARG, 0, DYN_SPAWNER_MINS, DYN_SPAWNER_MAXS))) return;
		DYNS_FOUND_VALID = 1;
		if (DYNS_VALID_TARGETS.length() > 0) DYNS_VALID_TARGETS += ";";
		DYNS_VALID_TARGETS += L_CUR_TARG;
	}

	void dyns_check_inview()
	{
		string L_CUR_TARG = GetToken(DYNS_TARGETS, i, ";");
		string L_TARG_ORG = GetEntityOrigin(L_CUR_TARG);
		string L_TARG_ANG = GetEntityProperty(L_CUR_TARG, "viewangles");
		if ((WithinCone2D(DYNS_CHECK_SIGHT, L_TARG_ORG, L_TARG_ANG)))
		{
			string L_TRACE_START = L_TARG_ORG;
			string L_MY_HEIGHT = GetEntityHeight(GetOwner());
			string L_TRACE_END = /* TODO: $math(vectoradd) */ DYNS_CHECK_SIGHT;
			string L_TRACE_LINE = TraceLine(L_TRACE_START, L_TRACE_END);
			if (L_TRACE_LINE != L_TRACE_END)
			{
				return;
			}
		}
		else
		{
			return;
		}
		DYNS_IN_VIEW = 1;
	}

	void func_dyns_test_point()
	{
		string L_OLD_ORG = GetEntityOrigin(GetOwner());
		string L_TELE_POINT = param1;
		SetEntityOrigin(GetOwner(), L_TELE_POINT);
		string reg.npcmove.endpos = L_TELE_POINT;
		string L_MY_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		reg.npcmove.endpos += /* TODO: $relpos */ $relpos(Vector3(0, L_MY_ANG, 0), Vector3(-16, 0, 0));
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner());
		int L_IS_LEGIT = 1;
		if ("game.ret.npcmove.dist" == 0)
		{
			int L_IS_LEGIT = 0;
			string L_DEBUG = "cant_move";
		}
		if (!(DYNS_GLOBAL))
		{
		}
		if (!(L_IS_LEGIT))
		{
			LogDebug("func_dyns_test_point L_DEBUG");
			SetEntityOrigin(GetOwner(), L_OLD_ORG);
			return;
			return;
		}
		else
		{
			LogDebug("func_dyns_test_point valid");
			return;
			return;
		}
	}

	void func_dyns_findspawnpoint()
	{
		if (GetPlayerCount() == 1)
		{
			string L_PLAYER = GetToken(DYNS_VALID_TARGETS, 0, ";");
		}
		else
		{
			string L_RND = RandomInt(0, GetPlayerCount());
			string L_PLAYER = GetToken(DYNS_VALID_TARGETS, L_RND, ";");
		}
		string L_SPAWN_POINT = GetEntityOrigin(L_PLAYER);
		if (/* TODO: $math(subtract) */ GetGameTime() < 3)
		{
			string L_ANG = GetEntityProperty(L_PLAYER, "viewangles");
			string L_ANG = /* TODO: $vec.yaw */ $vec.yaw(L_ANG);
			L_ANG += Random(-100, 100);
		}
		else
		{
			string L_ANG = Random(0, 359.99);
		}
		string L_DIST = GetEntityWidth(GetOwner());
		L_DIST *= 2.0;
		L_DIST += Random(0, DYNS_SRADIUS);
		string L_Z = Random(0, 64);
		L_SPAWN_POINT += /* TODO: $relpos */ $relpos(Vector3(0, L_ANG, 0), Vector3(0, L_DIST, L_Z));
		return;
		return;
	}

	void dyns_find_popular_eloop()
	{
		string L_IDX = i;
		DYNS_TEST_PLAYER = GetToken(DYNS_VALID_TARGETS, L_IDX, ";");
		DYNS_TEST_PLAYER_TRANGE = 0;
		for (int i = 0; i < DYNS_NPLAYERS; i++)
		{
			dyns_test_popular_eeloop();
		}
		if (DYNS_TEST_PLAYER_TRANGE < DYNS_LEAST_AUTISTIC)
		{
			DYNS_LOWEST_TRANGE = DYNS_TEST_PLAYER_TRANGE;
			DYNS_WINNER = DYNS_TEST_PLAYER;
		}
	}

	void dyns_test_popular_eeloop()
	{
		string L_TEST_AGAINST = GetToken(DYNS_VALID_TARGETS, i, ";");
		string L_TEST_SUBJECT_ORG = GetEntityOrigin(DYNS_TEST_PLAYER);
		string L_TEST_TARGET_ORG = GetEntityOrigin(L_TEST_AGAINST);
		DYNS_TEST_PLAYER_TRANGE += Distance(L_TEST_SUBJECT_ORG, L_TEST_TARGET_ORG);
	}

}

}
