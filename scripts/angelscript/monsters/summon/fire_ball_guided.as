#pragma context server

namespace MS
{

class FireBallGuided : CGameScript
{
	int COLLIDE_RANGE;
	int DETECT_RANGE;
	string FIRST_TARG;
	float FREQ_HUNT;
	float FREQ_MOVE;
	int IS_ACTIVE;
	string MY_AOE;
	string MY_BASE_DMG;
	string MY_DEST;
	string MY_DURATION;
	string MY_OWNER;
	int MY_SPEED;
	string MY_TARGET;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string PREV_POV;
	string PUSH_LIST;
	string SOUND_EXPLODE;
	string SPRITE_EXPLODE;
	string SPRITE_FIRE;

	FireBallGuided()
	{
		SPRITE_EXPLODE = "bigsmoke.spr";
		SOUND_EXPLODE = "weapons/explode3.wav";
		SPRITE_FIRE = "firemagic.spr";
		DETECT_RANGE = 64;
		COLLIDE_RANGE = 16;
		MY_SPEED = 300;
		FREQ_HUNT = 1.0;
		FREQ_MOVE = 0.5;
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_BASE_DMG = param2;
		MY_DURATION = param3;
		MY_AOE = param4;
		FIRST_TARG = param5;
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		SetRace(GetEntityRace(MY_OWNER));
		if (!(OWNER_ISPLAYER))
		{
			MY_TARGET = GetEntityProperty(MY_OWNER, "scriptvar");
		}
		if ((OWNER_ISPLAYER))
		{
			MY_TARGET = GetEntityProperty(MY_OWNER, "target");
		}
		if ((IsEntityAlive(FIRST_TARG)))
		{
			MY_TARGET = FIRST_TARG;
		}
		if (!(IsEntityAlive(MY_TARGET)))
		{
			find_new_target();
		}
		MY_DEST = GetEntityOrigin(MY_TARGET);
		MY_DURATION("go_splodie");
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(0.01, "hunt_cycle");
		ScheduleDelayedEvent(0.1, "move_cycle");
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, MY_SPEED, 0));
	}

	void OnSpawn() override
	{
		SetName("fire ball");
		SetHealth(30);
		SetFly(true);
		SetWidth(32);
		SetHeight(32);
		SetModel("weapons/projectiles.mdl");
		PLAYING_DEAD = 1;
		SetMonsterClip(0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		EmitSound(GetOwner(), 0, "weapons/rocketfire1.wav", 10);
		SetModelBody(0, 40);
		SetIdleAnim("idle_icebolt");
		SetSolid("none");
	}

	void hunt_cycle()
	{
		if (!(IS_ACTIVE)) return;
		FREQ_HUNT("hunt_cycle");
		if (!(IsEntityAlive(MY_TARGET)))
		{
			find_new_target();
		}
		if (!(IsEntityAlive(MY_TARGET)))
		{
			string OWNER_ANG = GetEntityAngles(MY_OWNER);
			SetAngles("face");
			MY_DEST = /* TODO: $relpos */ $relpos(0, 1000, 0);
		}
		else
		{
			MY_DEST = GetEntityOrigin(MY_TARGET);
		}
		float RND_FB = Random(0, 64);
		float RND_RL = Random(-64, 64);
		float RND_UD = Random(0, 64);
		MY_DEST += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(RND_RL, RND_FB, RND_UD));
		if (PREV_POV != "PREV_POV")
		{
			if (GetMonsterProperty("origin") == PREV_POV)
			{
			}
			go_splodie("stuck");
		}
		PREV_POV = GetMonsterProperty("origin");
		string HIT_WALL = TraceLine(GetMonsterProperty("origin"), MY_DEST);
		if (Distance(GetMonsterProperty("origin"), HIT_WALL) < COLLIDE_RANGE)
		{
			go_splodie("hitwall");
		}
		string FLOOR_Z = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
		string FLOOR_ORG = GetMonsterProperty("origin");
		FLOOR_ORG = "z";
		if (!(Distance(GetMonsterProperty("origin"), FLOOR_ORG) < COLLIDE_RANGE)) return;
		go_splodie("hitground");
	}

	void move_cycle()
	{
		if (!(IS_ACTIVE)) return;
		FREQ_MOVE("move_cycle");
		if (GetEntityRange(MY_TARGET) < DETECT_RANGE)
		{
			go_splodie("hittarget");
		}
		SetMoveDest(MY_DEST);
		MY_DEST += /* TODO: $relvel */ $relvel(0, MY_SPEED, 0);
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, MY_SPEED, 0));
	}

	void find_new_target()
	{
		string TARGET_LIST = FindEntitiesInSphere("enemy", 1024);
		if (GetTokenCount(TARGET_LIST, ";") > 0)
		{
			ScrambleTokens(TARGET_LIST, ";");
			MY_TARGET = GetToken(TARGET_LIST, 0, ";");
		}
		MY_DEST = GetEntityOrigin(MY_TARGET);
		if ((IsEntityAlive(MY_TARGET))) return;
		string OWNER_ANG = GetEntityAngles(MY_OWNER);
		SetAngles("face");
	}

	void go_splodie()
	{
		if (MY_LIGHT_SCRIPT != "MY_LIGHT_SCRIPT")
		{
			ClientEvent("remove", "all", MY_LIGHT_SCRIPT);
		}
		Effect("tempent", "spray", SPRITE_EXPLODE, GetMonsterProperty("origin"), 0, 1, 0, 0);
		SetModel("none");
		XDoDamage(GetMonsterProperty("origin"), MY_AOE, MY_BASE_DMG, 0.1, MY_OWNER, MY_OWNER, "spellcasting.fire", "fire");
		PUSH_LIST = FindEntitiesInSphere("enemy", MY_AOE);
		if (PUSH_LIST != "none")
		{
			for (int i = 0; i < GetTokenCount(PUSH_LIST, ";"); i++)
			{
				push_loop();
			}
		}
		EmitSound(GetOwner(), 0, SOUND_EXPLODE, 10);
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void push_loop()
	{
		string CUR_TARGET = GetToken(PUSH_LIST, i, ";");
		LogDebug("push_loop GetEntityName(CUR_TARGET) of PUSH_LIST");
		string TARGET_ORG = GetEntityOrigin(CUR_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		SetVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 110)));
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModel("none");
		SetIdleAnim("none");
		SetAnimFrameRate(0);
		SetAlive(1);
		go_splodie("slain");
	}

}

}
