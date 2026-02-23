#pragma context client

namespace MS
{

class ClientSideFireball : CGameScript
{
	string FB_ORG;
	int IS_ACTIVE;
	string IS_DESTROYED;
	int RND_FB;
	string START_ANG;
	string VEL_ANGLES;

	ClientSideFireball()
	{
		const int FIREBALL_SPEED = 120;
		const string FIREBALL_SPRITE = "3dmflaora.spr";
		const string EMITTER_SPRITE = "3dmflaora.spr";
		const string SOUND_KABOOM = "weapons/explode3.wav";
		const string SOUND_LOOP = "items/torch1.wav";
		const float FREQ_LOOP_SOUND = 6.1;
		const int IS_COLORED = 0;
		const Vector3 NEW_COLOR = Vector3(255, 255, 255);
		const int SPRITE_FRAMES_SMALL = 1;
		const int SPRITE_FRAMES_LARGE = 1;
		const float SPRITE_SCALE_SMALL = 0.5;
		const float SPRITE_SCALE_LARGE = 2.0;
		const float SPRITE_SCALE_KABOOM = 3.0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(0.01, 0.05));
		if ((IS_ACTIVE))
		{
		}
		ClientEffect("tempent", "sprite", EMITTER_SPRITE, FB_ORG, "spit_flames");
		ClientEffect("tempent", "sprite", EMITTER_SPRITE, FB_ORG, "spit_flames");
		ClientEffect("tempent", "sprite", EMITTER_SPRITE, FB_ORG, "spit_flames");
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(FREQ_LOOP_SOUND);
		EmitSound3D(SOUND_LOOP, 10, FB_ORG);
	}

	void client_activate()
	{
		LogDebug("**** client_activate IS_COLORED");
		string MY_ORG = param1;
		START_ANG = param2;
		VEL_ANGLES = START_ANG;
		IS_ACTIVE = 1;
		LogDebug("client_activate MY_ORG MY_ORG");
		ClientEffect("tempent", "sprite", FIREBALL_SPRITE, MY_ORG, "setup_fireball", "update_fireball");
		EmitSound3D(SOUND_LOOP, 10, MY_ORG);
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
		FB_ORG = "game.tempent.origin";
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(VEL_ANGLES, Vector3(0, FIREBALL_SPEED, 0)));
	}

	void svr_update_fireball_vec()
	{
		VEL_ANGLES = param1;
	}

	void setup_fireball()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 20.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE_LARGE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(START_ANG, Vector3(0, FIREBALL_SPEED, 0)));
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

	void fireball_explode()
	{
		IS_ACTIVE = 0;
		RND_FB = 1000;
		ClientEffect("tempent", "sprite", FIREBALL_SPRITE, FB_ORG, "setup_kaboom");
		RND_FB = -1000;
		ClientEffect("tempent", "sprite", FIREBALL_SPRITE, FB_ORG, "setup_kaboom");
		RND_FB = 1000;
		ClientEffect("tempent", "sprite", FIREBALL_SPRITE, FB_ORG, "setup_kaboom");
		RND_FB = -1000;
		ClientEffect("tempent", "sprite", FIREBALL_SPRITE, FB_ORG, "setup_kaboom");
		fireball_end();
		EmitSound3D(SOUND_KABOOM, 10, FB_ORG);
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
