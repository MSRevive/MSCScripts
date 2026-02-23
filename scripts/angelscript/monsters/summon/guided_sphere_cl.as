#pragma context client

namespace MS
{

class GuidedSphereCl : CGameScript
{
	string FB_ORG;
	string FB_SERVER_ORG;
	int IS_ACTIVE;
	int IS_COLORED;
	string IS_DESTROYED;
	string MY_OWNER;
	string MY_TARGET;
	string NEW_COLOR;
	string OWNER_HANDPOS;
	string OWNER_HAND_IDX;
	string SPHERE_TYPE;
	string VEL_ANGLES;

	GuidedSphereCl()
	{
		const int FIREBALL_SPEED = 120;
		const string FIREBALL_SPRITE = "3dmflaora.spr";
		const string EMITTER_SPRITE = "3dmflaora.spr";
		IS_COLORED = 0;
		NEW_COLOR = Vector3(255, 255, 255);
		const int SPRITE_FRAMES_SMALL = 1;
		const int SPRITE_FRAMES_LARGE = 1;
		const float SPRITE_SCALE_SMALL = 0.5;
		const float SPRITE_SCALE_LARGE = 2.0;
		const float SPRITE_SCALE_KABOOM = 3.0;
		const string SOUND_UPDATE1 = "debris/zap1.wav";
		const string SOUND_UPDATE2 = "debris/zap3.wav";
		const string SOUND_UPDATE3 = "debris/zap3.wav";
		const int SPHERE_RADIUS = 64;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(3.0);
		if ((IS_ACTIVE))
		{
		}
		ClientEffect("tempent", "sprite", FIREBALL_SPRITE, FB_ORG, "setup_fireball", "update_fireball");
		OWNER_HANDPOS = /* TODO: $getcl */ $getcl(MY_OWNER, OWNER_HAND_IDX);
		ClientEffect("beam_points", OWNER_HANDPOS, FB_ORG, "lgtning.spr", 0.5, 3.0, 0.5, 255, 50, 30, Vector3(255, 255, 0));
		string RND_SOUND = RandomInt(1, 3);
		if (RND_SOUND == 1)
		{
			EmitSound3D(SOUND_UPDATE1, 10, FB_ORG);
		}
		if (RND_SOUND == 2)
		{
			EmitSound3D(SOUND_UPDATE2, 10, FB_ORG);
		}
		if (RND_SOUND == 3)
		{
			EmitSound3D(SOUND_UPDATE3, 10, FB_ORG);
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(0.30);
		OWNER_HANDPOS = /* TODO: $getcl */ $getcl(MY_OWNER, OWNER_HAND_IDX);
		ClientEffect("beam_points", OWNER_HANDPOS, FB_ORG, "lgtning.spr", 0.25, 1.0, 0.25, 255, 50, 30, Vector3(255, 255, 0));
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(0.5);
		if ((IS_ACTIVE))
		{
		}
		string TARG_ORG = /* TODO: $getcl */ $getcl(MY_TARGET, "origin");
		string TARG_DIST = Distance(FB_ORG, TARG_ORG);
		if (TARG_DIST > 0)
		{
		}
		if (TARG_DIST < SPHERE_RADIUS)
		{
		}
		EmitSound3D("magic/alien_frantic_1sec_noloop.wav", 10, FB_ORG);
	}

	void OnRepeatTimer_3()
	{
		SetRepeatDelay(1.0);
		if ((IS_ACTIVE))
		{
		}
		EmitSound3D("magic/alien_beacon_1sec_noloop.wav", 10, FB_ORG);
	}

	void client_activate()
	{
		string MY_ORG = param1;
		VEL_ANGLES = param2;
		SPHERE_TYPE = param3;
		MY_OWNER = param4;
		OWNER_HAND_IDX = "attachment";
		OWNER_HAND_IDX += param5;
		MY_TARGET = param6;
		LogDebug("**** MY_ORG VEL_ANGLES SPHERE_TYPE");
		IS_ACTIVE = 1;
		FB_SERVER_ORG = MY_ORG;
		ClientEffect("tempent", "sprite", FIREBALL_SPRITE, MY_ORG, "setup_fireball", "update_fireball");
		EmitSound3D("magic/alien_beacon_noloop.wav", 10, FB_ORG);
		ScheduleDelayedEvent(21.0, "fireball_end");
	}

	void update_fireball()
	{
		if (!(IS_ACTIVE))
		{
			if (!(IS_DESTROYED))
			{
			}
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
			IS_DESTROYED = 1;
		}
		if (!(IS_ACTIVE)) return;
		string F_FIREBALL_SPEED = FIREBALL_SPEED;
		FB_ORG = "game.tempent.origin";
		string FB_ANGLES = "game.tempent.angles";
		string SERVER_CLIENT_DIFFERENCE = Distance(FB_ORG, FB_SERVER_ORG);
		if (SERVER_CLIENT_DIFFERENCE > 128)
		{
			ClientEffect("tempent", "set_current_prop", "origin", FB_SERVER_ORG);
			ClientEffect("beam_points", OWNER_HANDPOS, FB_ORG, "lgtning.spr", 0.25, 1.0, 0.25, 255, 50, 30, Vector3(255, 255, 0));
			EmitSound3D(SOUND_UPDATE, 10, FB_ORG);
			ClientEffect("tempent", "sprite", EMITTER_SPRITE, FB_ORG, "spit_flames");
			ClientEffect("tempent", "sprite", EMITTER_SPRITE, FB_ORG, "spit_flames");
			ClientEffect("tempent", "sprite", EMITTER_SPRITE, FB_ORG, "spit_flames");
		}
		else
		{
			string IN_CONE = /* TODO: $within_cone */ $within_cone(FB_SERVER_ORG, FB_ORG, FB_ANGLES, 10);
			if ((IN_CONE))
			{
				F_FIREBALL_SPEED *= 1.5;
			}
			else
			{
				F_FIREBALL_SPEED *= 0.75;
			}
		}
		ClientEffect("tempent", "set_current_prop", "angles", VEL_ANGLES);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(VEL_ANGLES, Vector3(0, F_FIREBALL_SPEED, 0)));
	}

	void svr_update_fireball_vec()
	{
		VEL_ANGLES = param1;
		FB_SERVER_ORG = param2;
		MY_TARGET = param3;
		OWNER_HANDPOS = /* TODO: $getcl */ $getcl(MY_OWNER, OWNER_HAND_IDX);
	}

	void setup_fireball()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE_LARGE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(VEL_ANGLES, Vector3(0, FIREBALL_SPEED, 0)));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_FRAMES_LARGE);
		ClientEffect("tempent", "set_current_prop", "update", 1);
		if ((IS_COLORED))
		{
			ClientEffect("tempent", "set_current_prop", "rendercolor", NEW_COLOR);
		}
	}

	void spit_flames()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "fadeout", 0.5);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(VEL_ANGLES, Vector3(Random(-120, 120), /* TODO: $neg */ $neg(FIREBALL_SPEED), RandomInt(0, 120))));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE_SMALL);
		ClientEffect("tempent", "set_current_prop", "renderamt", 180);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "gravity", 1.0);
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_SCALE_SMALL);
		if ((IS_COLORED))
		{
			ClientEffect("tempent", "set_current_prop", "rendercolor", NEW_COLOR);
		}
	}

	void setup_kaboom()
	{
		string RND_YAW = Random(0, 359);
		string RND_PITCH = Random(0, 359);
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "fadeout", 0.5);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(RND_PITCH, RND_YAW, 0), Vector3(0, RND_FB, 0)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE_KABOOM);
		ClientEffect("tempent", "set_current_prop", "renderamt", 180);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_FRAMES_LARGE);
		if ((IS_COLORED))
		{
			ClientEffect("tempent", "set_current_prop", "rendercolor", NEW_COLOR);
		}
	}

	void fireball_end()
	{
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "end_effect");
	}

	void end_effect()
	{
		RemoveScript();
	}

}

}
