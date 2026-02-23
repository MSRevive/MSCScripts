#pragma context server

namespace MS
{

class FireWave : CGameScript
{
	string FLAME_ANGLE;
	string FLAME_OWNER;
	string FLAME_POSITION;
	int FLAMING;
	string HIT_TARGS;
	int IS_ACTIVE;
	string MY_CL_IDX;
	string MY_DAMAGE;
	string MY_DOT;
	string MY_DURATION;
	string MY_OWNER;
	string NPC_NOCLIP_DEST;
	int PLAYING_DEAD;

	FireWave()
	{
		const int FWD_SPEED = 10;
		const int MY_RADIUS = 76;
		const string SOUND_BURN = "ambience/burning2.wav";
		const int WALL_HEIGHT = 32;
		const int WALL_WIDTH = 2;
		const string CL_FLAME_SPRITE = "fire1_fixed.spr";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.5);
		if ((IS_ACTIVE))
		{
		}
		HIT_TARGS = /* TODO: $get_tbox */ $get_tbox("enemy", MY_RADIUS);
		if (HIT_TARGS != "none")
		{
		}
		for (int i = 0; i < GetTokenCount(HIT_TARGS, ";"); i++)
		{
			burn_targets();
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(0.1);
		if ((FLAMING))
		{
		}
		flames_shoot();
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_DAMAGE = param2;
		MY_DOT = param3;
		MY_DURATION = param4;
		SetRace(GetEntityRace(MY_OWNER));
		string OWNER_YAW = GetEntityProperty(MY_OWNER, "angles.yaw");
		NPC_NOCLIP_DEST = GetMonsterProperty("origin");
		NPC_NOCLIP_DEST += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(0, 9999, 0));
		ClientEvent("new", "all", currentscript, GetEntityIndex(GetOwner()), OWNER_YAW);
		MY_CL_IDX = "game.script.last_sent_id";
		IS_ACTIVE = 1;
		ScheduleDelayedEvent(0.1, "active_loop");
		MY_DURATION("remove_me");
	}

	void remove_me()
	{
		IS_ACTIVE = 0;
		EmitSound(GetOwner(), CHAN_ITEM, SOUND_BURN, 0);
		ClientEvent("remove", "all", MY_CL_IDX);
		ScheduleDelayedEvent(0.1, "remove_me2");
	}

	void remove_me2()
	{
		DeleteEntity(GetOwner());
	}

	void OnSpawn() override
	{
		SetName("Wave of Fire");
		SetWidth(32);
		SetHeight(32);
		SetModel("none");
		SetSolid("none");
		PLAYING_DEAD = 1;
		SetInvincible(true);
		EmitSound(GetOwner(), CHAN_ITEM, SOUND_BURN, 7);
	}

	void active_loop()
	{
		if (!(IS_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "active_loop");
		string MY_ORG = GetMonsterProperty("origin");
		MY_ORG += /* TODO: $relvel */ $relvel(0, FWD_SPEED, 0);
		MY_ORG = "z";
		MY_ORG += "z";
		SetEntityOrigin(GetOwner(), MY_ORG);
		SetMoveDest(NPC_NOCLIP_DEST);
	}

	void burn_targets()
	{
		string CUR_TARGET = GetToken(HIT_TARGS, i, ";");
		ApplyEffect(CUR_TARGET, "effects/dot_fire", 10, MY_OWNER, MY_DOT);
		AddVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(-20, 600, 30));
	}

	void client_activate()
	{
		FLAME_OWNER = param1;
		FLAME_ANGLE = Vector3(0, param2, 0);
		flames_start();
	}

	void flames_start()
	{
		FLAMING = 1;
	}

	void flames_shoot()
	{
		FLAME_POSITION = /* TODO: $getcl */ $getcl(FLAME_OWNER, "origin");
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(40, 0, WALL_HEIGHT));
		L_POS += FLAME_POSITION;
		ClientEffect("tempent", "sprite", CL_FLAME_SPRITE, L_POS, "setup_flames");
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(25, 0, WALL_HEIGHT));
		L_POS += FLAME_POSITION;
		ClientEffect("tempent", "sprite", CL_FLAME_SPRITE, L_POS, "setup_flames");
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(10, 0, WALL_HEIGHT));
		L_POS += FLAME_POSITION;
		ClientEffect("tempent", "sprite", CL_FLAME_SPRITE, L_POS, "setup_flames");
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(0, 0, WALL_HEIGHT));
		L_POS += FLAME_POSITION;
		ClientEffect("tempent", "sprite", CL_FLAME_SPRITE, L_POS, "setup_flames");
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(-10, 0, WALL_HEIGHT));
		L_POS += FLAME_POSITION;
		ClientEffect("tempent", "sprite", CL_FLAME_SPRITE, L_POS, "setup_flames");
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(-25, 0, WALL_HEIGHT));
		L_POS += FLAME_POSITION;
		ClientEffect("tempent", "sprite", CL_FLAME_SPRITE, L_POS, "setup_flames");
		string L_POS = /* TODO: $relpos */ $relpos(FLAME_ANGLE, Vector3(-40, 0, WALL_HEIGHT));
		L_POS += FLAME_POSITION;
		ClientEffect("tempent", "sprite", CL_FLAME_SPRITE, L_POS, "setup_flames");
	}

	void setup_flames()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.2);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
		ClientEffect("tempent", "set_current_prop", "scale", 1.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "all");
	}

}

}
