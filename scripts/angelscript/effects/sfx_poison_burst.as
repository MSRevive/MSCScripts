#pragma context client

namespace MS
{

class SfxPoisonBurst : CGameScript
{
	int CYCLE_ANGLE;
	string FX_CENTER;
	string FX_RADIUS;

	SfxPoisonBurst()
	{
		const string SPRITE_NAME = "poison_cloud.spr";
		const Vector3 SPRITE_COLOR = Vector3(0, 255, 0);
		const int SPRITE_RENDERAMT = 200;
		const string SPRITE_RENDERMODE = "add";
		const int SPRITE_FRAMERATE = 30;
		const int SPRITE_NFRAMES = 17;
		const float SPRITE_SCALE = 1.0;
		const string SOUND_BURST = "ambience/steamburst1.wav";
		Precache(SOUND_BURST);
	}

	void client_activate()
	{
		FX_CENTER = param1;
		FX_RADIUS = param2;
		string DO_GLOW = param3;
		string GLOW_COLOR = param4;
		if ((DO_GLOW))
		{
			ClientEffect("light", "new", FX_CENTER, FX_RADIUS, GLOW_COLOR, 1.0);
		}
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
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, 96, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPR_POS, "setup_ring_sprite");
		CYCLE_ANGLE += 20;
	}

	void setup_ring_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", SPRITE_COLOR);
		ClientEffect("tempent", "set_current_prop", "renderamt", SPRITE_RENDERAMT);
		ClientEffect("tempent", "set_current_prop", "rendermode", SPRITE_RENDERMODE);
		ClientEffect("tempent", "set_current_prop", "framerate", SPRITE_FRAMERATE);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

}

}
