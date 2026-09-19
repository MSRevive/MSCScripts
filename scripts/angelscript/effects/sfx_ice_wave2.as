#pragma context client

namespace MS
{

class SfxIceWave2 : CGameScript
{
	int ANG_COUNT;
	string ANG_INC;
	int CUR_YAW;
	string FX_ANGLE1;
	string FX_ANGLE2;
	string FX_ORIGIN;
	string FX_WIDTH;
	string FX_YAW;
	string SOUND_BURST;
	string SPRITE_COLOR;
	int SPRITE_FRAMERATE;
	string SPRITE_NAME;
	int SPRITE_NFRAMES;
	int SPRITE_RENDERAMT;
	string SPRITE_RENDERMODE;
	float SPRITE_SCALE;
	int SPRITE_SPEED;

	SfxIceWave2()
	{
		SPRITE_NAME = "fire1_fixed.spr";
		SPRITE_COLOR = Vector3(64, 64, 255);
		SPRITE_RENDERAMT = 200;
		SPRITE_RENDERMODE = "add";
		SPRITE_FRAMERATE = 30;
		SPRITE_NFRAMES = 23;
		SPRITE_SCALE = 1.5;
		SPRITE_SPEED = 400;
		SOUND_BURST = "magic/frost_reverse.wav";
		Precache(SOUND_BURST);
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_YAW = param2;
		FX_WIDTH = param3;
		FX_ANGLE1 = FX_YAW;
		FX_ANGLE1 -= FX_WIDTH;
		if (FX_ANGLE1 < 0)
		{
			FX_ANGLE1 += 359.99;
		}
		FX_ANGLE2 = FX_YAW;
		FX_ANGLE2 += FX_WIDTH;
		if (FX_ANGLE2 > 359.99)
		{
			FX_ANGLE2 -= 359.99;
		}
		ANG_COUNT = 0;
		CUR_YAW = 0;
		ANG_INC = FX_WIDTH;
		ANG_INC *= 2;
		ANG_INC /= 20;
		EmitSound3D(SOUND_BURST, 10, FX_ORIGIN);
		for (int i = 0; i < 20; i++)
		{
			make_sprites();
		}
		ScheduleDelayedEvent(4.0, "remove_fx");
	}

	void make_sprites()
	{
		CUR_YAW = FX_ANGLE1;
		CUR_YAW += ANG_COUNT;
		string SPR_POS = FX_ORIGIN;
		SPR_POS += Vector3(0, 0, 0);
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPR_POS, "setup_ring_sprite");
		ANG_COUNT += ANG_INC;
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_ring_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", SPRITE_COLOR);
		ClientEffect("tempent", "set_current_prop", "renderamt", SPRITE_RENDERAMT);
		ClientEffect("tempent", "set_current_prop", "rendermode", SPRITE_RENDERMODE);
		ClientEffect("tempent", "set_current_prop", "framerate", SPRITE_FRAMERATE);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string FLAME_TURN = /* TODO: $relvel */ $relvel(Vector3(0, CUR_YAW, 0), Vector3(0, SPRITE_SPEED, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", FLAME_TURN);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

}

}
