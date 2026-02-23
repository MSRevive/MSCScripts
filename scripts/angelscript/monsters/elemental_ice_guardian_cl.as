#pragma context server

namespace MS
{

class ElementalIceGuardianCl : CGameScript
{
	int DEATH_MODE;
	int FX_ACTIVE;
	string FX_OWNER;
	string OWNER_VEL;
	string PROJECTILE_ANGLES;
	string PROJECTILE_END;
	string PROJECTILE_SPEED;
	int SHOCK_STORM_ON;
	string STAFF_LOOP_ACTIVE;
	string STAFF_ON;
	string STAFF_POS;

	ElementalIceGuardianCl()
	{
		const string DRESS_SPRITE = "char_breath.spr";
		const int DRESS_SPRITE_NFRAMES = 30;
	}

	void client_activate()
	{
		FX_OWNER = param1;
		STAFF_ON = param2;
		LogDebug("ice_cl FX_OWNER STAFF_ON");
		FX_ACTIVE = 1;
		ScheduleDelayedEvent(45.0, "end_fx");
		dress_sprite_loop();
	}

	void guardian_death()
	{
		DEATH_MODE = 1;
		ScheduleDelayedEvent(1.0, "end_fx");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void dress_sprite_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "dress_sprite_loop");
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		OWNER_VEL = /* TODO: $getcl */ $getcl(FX_OWNER, "velocity");
		OWNER_VEL *= 0.1;
		ClientEffect("tempent", "sprite", DRESS_SPRITE, SPR_POS, "setup_cloud", "update_cloud");
		ClientEffect("tempent", "sprite", DRESS_SPRITE, SPR_POS, "setup_cloud", "update_cloud");
		ClientEffect("tempent", "sprite", DRESS_SPRITE, SPR_POS, "setup_cloud", "update_cloud");
		ClientEffect("tempent", "sprite", DRESS_SPRITE, SPR_POS, "setup_cloud", "update_cloud");
	}

	void fire_projectile()
	{
		PROJECTILE_ANGLES = param1;
		string PROJECTILE_HIT = param3;
		PROJECTILE_SPEED = param4;
		if (!(PROJECTILE_HIT))
		{
			PROJECTILE_END = param2;
			ScheduleDelayedEvent(0.5, "fire_projectile_miss_sound");
		}
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment1");
		if (!(STAFF_LOOP_ACTIVE))
		{
			STAFF_LOOP_ACTIVE = 1;
			ScheduleDelayedEvent(10.0, "staff_track_end");
			staff_track_loop();
		}
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", SPR_POS, "setup_projectile");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPR_POS, "setup_staff_glow", "update_staff_glow");
	}

	void shock_storm_on()
	{
		if (!(STAFF_LOOP_ACTIVE))
		{
			staff_track_loop();
		}
		SHOCK_STORM_ON = 1;
	}

	void shock_storm_end()
	{
		SHOCK_STORM_ON = 0;
		staff_track_end();
	}

	void shock_storm_loop()
	{
		if (!(SHOCK_STORM_ON)) return;
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.5, "shock_storm_loop");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPR_POS, "setup_staff_glow", "update_staff_glow");
	}

	void staff_track_loop()
	{
		if (!(STAFF_LOOP_ACTIVE)) return;
		ScheduleDelayedEvent(0.01, "staff_track_loop");
		STAFF_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment1");
	}

	void staff_track_end()
	{
		STAFF_LOOP_ACTIVE = 0;
	}

	void fire_projectile_miss_sound()
	{
		EmitSound3D("weapons/dagger/daggermetal2.wav", 10, PROJECTILE_END);
	}

	void update_staff_glow()
	{
		ClientEffect("tempent", "set_current_prop", "origin", STAFF_POS);
		string CUR_SIZE = "game.tempent.fuser1";
		CUR_SIZE -= 0.01;
		if (CUR_SIZE > 0)
		{
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SIZE);
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SIZE);
		}
		if (CUR_SIZE == 0)
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 20000));
		}
	}

	void setup_staff_glow()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "fade", "lifetime");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(64, 128, 255));
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "fuser1", 1.0);
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void setup_projectile()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.5);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string L_PROJECTILE_ANGLES = PROJECTILE_ANGLES;
		L_PROJECTILE_ANGLES = "x";
		ClientEffect("tempent", "set_current_prop", "angles", L_PROJECTILE_ANGLES);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(PROJECTILE_ANGLES, Vector3(0, PROJECTILE_SPEED, 0)));
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "body", 38);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 40);
		ClientEffect("tempent", "set_current_prop", "sequence", 15);
	}

	void setup_cloud()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "framerate", 60);
		ClientEffect("tempent", "set_current_prop", "frames", DRESS_SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.05);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 230, 255));
		if (!(DEATH_MODE))
		{
			ClientEffect("tempent", "set_current_prop", "gravity", 0.5);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "gravity", 0.0);
		}
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.05);
		if (!(DEATH_MODE))
		{
			string RND_PITCH = Random(70, 110);
			string RND_ANG = Random(0, 359.99);
			ClientEffect("tempent", "set_current_prop", "angles", Vector3(RND_PITCH, RND_ANG, 0));
			string CLOUD_VEL = OWNER_VEL;
			CLOUD_VEL += /* TODO: $relvel */ $relvel(Vector3(RND_PITCH, RND_ANG, 0), Vector3(0, 10, 0));
			ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
		}
		else
		{
			string RND_ANG = Random(0, 359.99);
			string RND_PITCH = Random(0, 359.99);
			ClientEffect("tempent", "set_current_prop", "angles", Vector3(RND_PITCH, RND_ANG, 0));
			string CLOUD_VEL = OWNER_VEL;
			CLOUD_VEL += /* TODO: $relvel */ $relvel(Vector3(RND_PITCH, RND_ANG, 0), Vector3(0, 50, 0));
			ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
		}
	}

	void update_cloud()
	{
		string CUR_SCALE = "game.tempent.fuser1";
		if (CUR_SCALE < 1.5)
		{
			CUR_SCALE += 0.025;
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
		}
		if (!(DEATH_MODE)) return;
		string CUR_VEL = "game.tempent.velocity";
		string CUR_ANG = "game.tempent.angles";
		CUR_VEL += /* TODO: $relvel */ $relvel(CUR_ANG, Vector3(0, 50, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", CUR_VEL);
	}

}

}
