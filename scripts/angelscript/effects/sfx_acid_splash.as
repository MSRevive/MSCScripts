#pragma context client

namespace MS
{

class SfxAcidSplash : CGameScript
{
	int CYCLE_ANGLE;
	string FX_CENTER;
	string FX_RADIUS;
	string SOUND_BURST;
	string SPRITE_COLOR;
	int SPRITE_FRAMERATE;
	string SPRITE_NAME;
	int SPRITE_NFRAMES;
	int SPRITE_RENDERAMT;
	string SPRITE_RENDERMODE;
	float SPRITE_SCALE;

	SfxAcidSplash()
	{
		SPRITE_NAME = "bloodspray.spr";
		SPRITE_COLOR = Vector3(0, 255, 0);
		SPRITE_RENDERAMT = 255;
		SPRITE_RENDERMODE = "texture";
		SPRITE_FRAMERATE = 10;
		SPRITE_NFRAMES = 10;
		SPRITE_SCALE = 3.0;
		SOUND_BURST = "gonarch/gon_birth1.wav";
		Precache(SOUND_BURST);
	}

	void client_activate()
	{
		FX_CENTER = param1;
		FX_RADIUS = param2;
		if ((FX_RADIUS).findFirst(PARAM) == 0)
		{
			FX_RADIUS = 200;
		}
		int DO_GLOW = 1;
		Vector3 GLOW_COLOR = Vector3(64, 255, 0);
		ClientEffect("light", "new", FX_CENTER, 128, GLOW_COLOR, 1.0);
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
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, 10, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPR_POS, "setup_ring_sprite", "update_ring_sprite");
		CYCLE_ANGLE += 20;
	}

	void update_ring_sprite()
	{
		string CUR_SIZE = "game.tempent.fuser1";
		CUR_SIZE -= 0.05;
		if (!(CUR_SIZE > 0)) return;
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SIZE);
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SIZE);
	}

	void setup_ring_sprite()
	{
		float FADE_DEL = 1.0;
		int SPRITE_SPEED = 200;
		if (FX_RADIUS > 256)
		{
			FX_RADIUS += SPRITE_SPEED;
		}
		ClientEffect("tempent", "set_current_prop", "death_delay", FADE_DEL);
		ClientEffect("tempent", "set_current_prop", "rendercolor", SPRITE_COLOR);
		ClientEffect("tempent", "set_current_prop", "renderamt", SPRITE_RENDERAMT);
		ClientEffect("tempent", "set_current_prop", "rendermode", SPRITE_RENDERMODE);
		ClientEffect("tempent", "set_current_prop", "framerate", SPRITE_FRAMERATE);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		string FLAME_TURN = /* TODO: $relvel */ $relvel(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, SPRITE_SPEED, 300));
		ClientEffect("tempent", "set_current_prop", "velocity", FLAME_TURN);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "fuser1", 3.0);
	}

}

}
