#pragma context server

namespace MS
{

class Ibarrier : CGameScript
{
	string ALWAYS_PUSH;
	int AM_BLOCKING;
	string AM_INVISIBLE;
	string BARRIER_SCRIPT_IDX;
	string CL_COLOR;
	string CL_RADIUS;
	string CYCLE_ANGLE;
	int GO_AWAY;
	int MY_BASE_DAMAGE;
	string MY_DURATION;
	string MY_OWNER;
	string MY_RADIUS;
	string NO_SOUND;
	int PLAYING_DEAD;
	string SPRITE_COLOR;
	int TOTAL_OFS;
	string sfx.npcid;

	Ibarrier()
	{
		const string SOUND_PUSH = "doors/aliendoor3.wav";
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_RADIUS = param2;
		MY_DURATION = param3;
		MY_BASE_DAMAGE = 0;
		if (param4 == 1)
		{
			AM_INVISIBLE = 1;
		}
		if (param5 == 1)
		{
			NO_SOUND = 1;
		}
		if (param6 != "PARAM6")
		{
			MY_BASE_DAMAGE = param6;
		}
		if (param7 == 1)
		{
			ALWAYS_PUSH = 1;
		}
		MY_BASE_DAMAGE = 0;
		SetRace("hated");
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
			ClientEvent("new", "all", currentscript, GetEntityIndex(GetOwner()), MY_RADIUS, SPRITE_COLOR);
		}
		BARRIER_SCRIPT_IDX = "game.script.last_sent_id";
		MY_DURATION("remove_barrier");
		AM_BLOCKING = 1;
		ScheduleDelayedEvent(0.1, "scan_loop");
	}

	void OnSpawn() override
	{
		SetName("Magical Barrier");
		SetModel("none");
		SetHealth(9000);
		SetInvincible(true);
		SetWidth(8);
		SetHeight(8);
		SetSolid("none");
		SetHearingSensitivity(11);
		SetDamageResistance("stun", 0);
		PLAYING_DEAD = 1;
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(AM_BLOCKING)) return;
		string LASTHEARD_ID = GetEntityIndex("ent_lastheard");
		if (!(GetEntityRange(LASTHEARD_ID) < MY_RADIUS)) return;
		int DO_HPUSH = 0;
		if (GetRelationship(LASTHEARD_ID) == "enemy")
		{
			int DO_HPUSH = 1;
		}
		if ((ALWAYS_PUSH))
		{
			int DO_HPUSH = 1;
		}
		if (LASTHEARD_ID == MY_OWNER)
		{
			int DO_HPUSH = 0;
		}
		if (!(DO_HPUSH)) return;
		push_out(LASTHEARD_ID);
	}

	void scan_loop()
	{
		if (!(AM_BLOCKING)) return;
		ScheduleDelayedEvent(0.25, "scan_loop");
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), MY_RADIUS, 0.0, 1.0, 0);
	}

	void game_dodamage()
	{
		int DO_PUSH = 0;
		if (GetRelationship(param2) == "enemy")
		{
			int DO_PUSH = 1;
		}
		if ((ALWAYS_PUSH))
		{
			int DO_PUSH = 1;
		}
		if (!(param2 != MY_OWNER)) return;
		push_out(GetEntityIndex(param2));
	}

	void push_out()
	{
		if (MY_BASE_DAMAGE > 0)
		{
			DoDamage(GetEntityIndex(param1), "direct", MY_BASE_DAMAGE, 1.0, MY_MASTER);
		}
		Effect("glow", GetEntityIndex(param1), Vector3(255, 255, 255), 60, 1.0, 1.0);
		string TARGET_ORG = GetEntityOrigin(param1);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
		string NEW_YAW = TARG_ANG;
		if (!(AM_SILENT))
		{
			EmitSound(GetOwner(), 0, SOUND_PUSH, 10);
		}
		SetVelocity(param1, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
	}

	void remove_barrier()
	{
		AM_BLOCKING = 0;
		ClientEvent("update", "all", BARRIER_SCRIPT_IDX, "clear_sprites");
		ScheduleDelayedEvent(2.0, "remove_me");
	}

	void remove_me()
	{
		if ((AM_INVISIBLE))
		{
			ClientEvent("remove", "all", BARRIER_SCRIPT_IDX);
		}
		ScheduleDelayedEvent(0.1, "remove_me2");
	}

	void remove_me2()
	{
		DeleteEntity(GetOwner());
	}

	void client_activate()
	{
		sfx.npcid = param1;
		CL_RADIUS = param2;
		CL_COLOR = param3;
		DEATH_DELAY("remove_me");
		ScheduleDelayedEvent(0.1, "spriteify");
	}

	void spriteify()
	{
		TOTAL_OFS = 64;
		for (int i = 0; i < 36; i++)
		{
			createsprite();
		}
	}

	void createsprite()
	{
		string l.pos = /* TODO: $getcl */ $getcl(sfx.npcid, "origin");
		if (CYCLE_ANGLE == "CYCLE_ANGLE")
		{
			CYCLE_ANGLE = 0;
		}
		CYCLE_ANGLE += 10;
		l.pos += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, CL_RADIUS, 36));
		ClientEffect("tempent", "sprite", "3dmflaora.spr", l.pos, "setup_sprite1_sparkle", "sprite_update");
	}

	void setup_sprite1_sparkle()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 90.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 180);
		ClientEffect("tempent", "set_current_prop", "rendercolor", CL_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void sprite_update()
	{
		if (!(GO_AWAY)) return;
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 400));
		ClientEffect("tempent", "set_current_prop", "fadeout", 2.0);
		ClientEffect("tempent", "set_current_prop", "gravity", -4.0);
	}

	void clear_sprites()
	{
		GO_AWAY = 1;
		sprite_update();
	}

	void remove_me()
	{
		RemoveScript();
	}

}

}
