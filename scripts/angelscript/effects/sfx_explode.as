#pragma context server

namespace MS
{

class SfxExplode : CGameScript
{
	int CYCLE_ANGLE;
	string FX_CENTER;
	float FX_DURATION;
	string FX_RADIUS;
	string SOUND_BURST;
	string SPRITE_COLOR;
	int SPRITE_FRAMERATE;
	string SPRITE_NAME;
	int SPRITE_NFRAMES;
	int SPRITE_RENDERAMT;
	string SPRITE_RENDERMODE;
	float SPRITE_SCALE;
	int SPRITE_VOF;

	SfxExplode()
	{
		SPRITE_NAME = "explode1.spr";
		SPRITE_COLOR = Vector3(255, 128, 64);
		SPRITE_RENDERAMT = 200;
		SPRITE_RENDERMODE = "add";
		SPRITE_FRAMERATE = 30;
		SPRITE_NFRAMES = 9;
		SPRITE_SCALE = 1.0;
		SPRITE_VOF = 32;
		SOUND_BURST = "weapons/explode3.wav";
	}

	void client_activate()
	{
		FX_CENTER = param1;
		FX_RADIUS = param2;
		FX_DURATION = 1.0;
		if (FX_RADIUS < 64)
		{
			FX_DURATION = 0.5;
		}
		if (FX_RADIUS > 256)
		{
			FX_DURATION = 2.0;
		}
		string L_FX_RADIUS = FX_RADIUS;
		L_FX_RADIUS *= 2.0;
		ClientEffect("light", "new", FX_CENTER, L_FX_RADIUS, SPRITE_COLOR, 2.0);
		ScheduleDelayedEvent(3.0, "remove_me");
		CYCLE_ANGLE = 0;
		for (int i = 0; i < 17; i++)
		{
			create_sprites();
		}
		EmitSound3D(SOUND_BURST, 10, FX_CENTER);
	}

	void remove_me()
	{
		RemoveScript();
	}

	void create_sprites()
	{
		string SPR_POS = FX_CENTER;
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, 1, SPRITE_VOF));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPR_POS, "setup_sprite", "update_sprite");
		CYCLE_ANGLE += 20;
	}

	void update_sprite()
	{
		string SPRITE_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		string MY_ANGLE = "game.tempent.fuser1";
		MY_ANGLE += 20;
		if (MY_ANGLE > 359)
		{
			int MY_ANGLE = 0;
		}
		ClientEffect("tempent", "set_current_prop", "fuser1", MY_ANGLE);
		SPRITE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, MY_ANGLE, 0), Vector3(0, FX_RADIUS, SPRITE_VOF));
	}

	void setup_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "rendercolor", SPRITE_COLOR);
		ClientEffect("tempent", "set_current_prop", "renderamt", SPRITE_RENDERAMT);
		ClientEffect("tempent", "set_current_prop", "rendermode", SPRITE_RENDERMODE);
		ClientEffect("tempent", "set_current_prop", "framerate", SPRITE_FRAMERATE);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "fuser1", CYCLE_ANGLE);
		string SPRITE_VEL = /* TODO: $relvel */ $relvel(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, 200, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", SPRITE_VEL);
	}

}

}
