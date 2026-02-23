#pragma context server

namespace MS
{

class Barrier : CGameScript
{
	string ALWAYS_PUSH;
	int AM_BLOCKING;
	string AM_INVISIBLE;
	string AM_SILENT;
	string BARRIER_SCRIPT_IDX;
	string CL_DURATION;
	int MY_BASE_DAMAGE;
	string MY_DURATION;
	string MY_OWNER;
	string MY_RADIUS;
	int PLAYING_DEAD;
	string SCAN_TARGS;
	string SILENT_EXIT;
	string SPRITE_COLOR;

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_RADIUS = param2;
		MY_BASE_DAMAGE = 0;
		if (param3 == 1)
		{
			AM_SILENT = 1;
		}
		if (param4 == 1)
		{
			AM_INVISIBLE = 1;
		}
		if (param5 == 1)
		{
			SILENT_EXIT = 1;
		}
		if (param6 != "PARAM6")
		{
			MY_BASE_DAMAGE = param6;
		}
		if (param7 == 1)
		{
			ALWAYS_PUSH = 1;
		}
		if (param8 != "PARAM8")
		{
			MY_DURATION = param8;
			CL_DURATION = param8;
			CL_DURATION += 2.0;
			PARAM8("remove_barrier");
		}
		if (MY_BASE_DAMAGE == 0)
		{
			SPRITE_COLOR = Vector3(0, 0, 255);
		}
		if (MY_BASE_DAMAGE > 0)
		{
			SPRITE_COLOR = Vector3(255, 0, 0);
		}
		if (!(AM_INVISIBLE))
		{
			ClientEvent("new", "all", "monsters/summon/barrier_cl", GetEntityIndex(MY_OWNER), MY_RADIUS, SPRITE_COLOR, CL_DURATION);
			BARRIER_SCRIPT_IDX = "game.script.last_sent_id";
		}
		AM_BLOCKING = 1;
		ScheduleDelayedEvent(0.25, "scan_loop");
	}

	void OnSpawn() override
	{
		SetName("Magical Barrier");
		SetModel("null.mdl");
		SetIdleAnim("none");
		SetNoPush(true);
		SetHealth(9000);
		SetInvincible(true);
		SetWidth(8);
		SetHeight(8);
		SetSolid("none");
		SetRace("beloved");
		PLAYING_DEAD = 1;
	}

	void scan_loop()
	{
		if (!(AM_BLOCKING)) return;
		if (!(IsEntityAlive(MY_OWNER))) return;
		if (!((MY_OWNER !is null))) return;
		ScheduleDelayedEvent(0.5, "scan_loop");
		string SCAN_ORG = GetEntityOrigin(GetOwner());
		SCAN_ORG += "z";
		SCAN_TARGS = FindEntitiesInSphere("any", MY_RADIUS);
		if (!(SCAN_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(SCAN_TARGS, ";"); i++)
		{
			affect_targets();
		}
	}

	void affect_targets()
	{
		string CUR_TARG = GetToken(SCAN_TARGS, i, ";");
		int DO_PUSH = 0;
		if (GetRelationship(CUR_TARG) == "enemy")
		{
			int DO_PUSH = 1;
		}
		if ((ALWAYS_PUSH))
		{
			if (GetEntityIndex(CUR_TARG) != MY_OWNER)
			{
			}
			int DO_PUSH = 1;
		}
		if (!(DO_PUSH)) return;
		if (MY_BASE_DAMAGE > 0)
		{
			DoDamage(CUR_TARGET, "direct", MY_BASE_DAMAGE, 1.0, MY_OWNER);
		}
		string TARGET_ORG = GetEntityOrigin(CUR_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		if (!(AM_SILENT))
		{
			EmitSound(GetOwner(), 0, "doors/aliendoor3.wav", 10);
		}
		SetVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
	}

	void remove_barrier()
	{
		AM_BLOCKING = 0;
		ClientEvent("update", "all", BARRIER_SCRIPT_IDX, "clear_sprites");
		if (!(SILENT_EXIT))
		{
			EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
		}
		ScheduleDelayedEvent(2.0, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
