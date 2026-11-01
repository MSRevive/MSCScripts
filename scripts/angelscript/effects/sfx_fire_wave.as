#pragma context client

namespace MS
{

class SfxFireWave : CGameScript
{
	string FX_ORG;
	string FX_YAW;
	string GLOW_COLOR;
	string SPRITE_COLOR;
	int SPRITE_FRAMERATE;
	string SPRITE_NAME;
	int SPRITE_NFRAMES;
	string SPRITE_OFS;
	int SPRITE_RENDERAMT;
	string SPRITE_RENDERMODE;
	float SPRITE_SCALE;
	int SPRITE_STEP;

	SfxFireWave()
	{
		SPRITE_NAME = "fire1_fixed.spr";
		SPRITE_COLOR = Vector3(255, 255, 255);
		SPRITE_RENDERAMT = 200;
		SPRITE_RENDERMODE = "add";
		SPRITE_FRAMERATE = 30;
		SPRITE_NFRAMES = 23;
		SPRITE_SCALE = 2.0;
		GLOW_COLOR = Vector3(255, 128, 0);
	}

	void client_activate()
	{
		FX_ORG = param1;
		FX_YAW = param2;
		ClientEffect("light", "new", FX_ORG, 128, GLOW_COLOR, 4.0);
		SPRITE_STEP = 0;
		setup_fire_wave();
	}

	void setup_fire_wave()
	{
		string N_SPRITES = SPRITE_STEP;
		N_SPRITES += 1;
		SPRITE_OFS = SPRITE_STEP;
		SPRITE_OFS *= -32;
		for (int i = 0; i < N_SPRITES; i++)
		{
			setup_fire_sprites();
		}
		SPRITE_STEP += 1;
		if (SPRITE_STEP == 12)
		{
			ScheduleDelayedEvent(5.0, "remove_fx");
		}
		if (!(SPRITE_STEP < 12)) return;
		ScheduleDelayedEvent(0.25, "setup_fire_wave");
	}

	void setup_fire_sprites()
	{
		string SPR_POS = FX_ORG;
		string ROW_OFS = SPRITE_STEP;
		ROW_OFS *= 32;
		string COL_OFS = i;
		COL_OFS *= 32;
		SPRITE_OFS += COL_OFS;
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, FX_YAW, 0), Vector3(SPRITE_OFS, ROW_OFS, 0));
		string GROUND_POS = /* TODO: $get_ground_height */ $get_ground_height(SPR_POS);
		SPR_POS = "z";
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPR_POS, "setup_fire_sprite");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_fire_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 4.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", SPRITE_COLOR);
		ClientEffect("tempent", "set_current_prop", "renderamt", SPRITE_RENDERAMT);
		ClientEffect("tempent", "set_current_prop", "rendermode", SPRITE_RENDERMODE);
		ClientEffect("tempent", "set_current_prop", "framerate", SPRITE_FRAMERATE);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

}

}
