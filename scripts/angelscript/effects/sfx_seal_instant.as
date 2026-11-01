#pragma context client

namespace MS
{

class SfxSealInstant : CGameScript
{
	int CYCLE_ANGLE;
	int FX_ACTIVE;
	float FX_DURATION;
	string FX_ORIGIN;
	string LIGHT_RADIUS;
	string SEAL_BODY;
	string SEAL_COLOR;
	string SEAL_MODEL;
	int SEAL_PITCH;
	string SEAL_RAD;
	string SEAL_SOUND;
	string SEAL_TYPE;
	string SPRITE_COLOR;
	int SPRITE_FRAMERATE;
	string SPRITE_NAME;
	int SPRITE_NFRAMES;
	int SPRITE_RENDERAMT;
	string SPRITE_RENDERMODE;
	float SPRITE_SCALE;

	SfxSealInstant()
	{
		SEAL_MODEL = "weapons/magic/seals.mdl";
		FX_DURATION = 2.0;
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		SEAL_TYPE = param2;
		SEAL_RAD = param3;
		SEAL_BODY = param4;
		SEAL_PITCH = 100;
		if (SEAL_TYPE == "fire")
		{
			SEAL_COLOR = Vector3(255, 0, 0);
			SEAL_SOUND = "ambience/steamburst1.wav";
			fire_aura();
		}
		else
		{
			if (SEAL_TYPE == "cold")
			{
				SEAL_COLOR = Vector3(128, 128, 255);
				SEAL_SOUND = "magic/freeze.wav";
				cold_aura();
			}
			else
			{
				if (SEAL_TYPE == "lightning")
				{
					SEAL_COLOR = Vector3(255, 255, 0);
					SEAL_SOUND = "magic/lightning_strike2.wav";
					lightning_aura();
				}
				else
				{
					if (SEAL_TYPE == "poison")
					{
						SEAL_COLOR = Vector3(0, 255, 0);
						SEAL_SOUND = "ambience/steamburst1.wav";
						SEAL_PITCH = 60;
						poison_aura();
					}
				}
			}
		}
		ScheduleDelayedEvent(2.0, "end_fx");
		FX_ACTIVE = 1;
		EmitSound3D(SEAL_SOUND, 10, FX_ORIGIN, 0.8, 0, SEAL_PITCH);
		ClientEffect("tempent", "model", SEAL_MODEL, FX_ORIGIN, "setup_seal_instant");
		LIGHT_RADIUS = SEAL_RAD;
		LIGHT_RADIUS *= 1.11;
		ClientEffect("light", "new", FX_ORIGIN, LIGHT_RADIUS, SEAL_COLOR, FX_DURATION);
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

	void setup_seal_instant()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 40);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "body", SEAL_BODY);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
	}

	void fire_aura()
	{
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", FX_ORIGIN, "make_aura");
	}

	void make_aura()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", 51);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 8.0);
	}

	void cold_aura()
	{
		ClientEffect("tempent", "model", "weapons/projectiles.mdl", FX_ORIGIN, "setup_shpere");
	}

	void setup_shpere()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "body", 1);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "frames", 255);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

	void lightning_aura()
	{
		CYCLE_ANGLE = 0;
		for (int i = 0; i < 17; i++)
		{
			create_beams();
		}
	}

	void create_beams()
	{
		string CL_BEAM_START = FX_ORIGIN;
		string BEAM_RAD = SEAL_RAD;
		BEAM_RAD *= 0.8;
		CL_BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, BEAM_RAD, 0));
		string CL_BEAM_END = CL_BEAM_START;
		CL_BEAM_END += "z";
		ClientEffect("beam_points", CL_BEAM_START, CL_BEAM_END, "lgtning.spr", 1.0, 5.0, 3.0, 200, 50, 30, Vector3(1.0, 1.0, 0.0));
		CYCLE_ANGLE += 20;
	}

	void poison_aura()
	{
		SPRITE_NAME = "poison_cloud.spr";
		SPRITE_COLOR = Vector3(0, 255, 0);
		SPRITE_RENDERAMT = 200;
		SPRITE_RENDERMODE = "add";
		SPRITE_FRAMERATE = 30;
		SPRITE_NFRAMES = 17;
		SPRITE_SCALE = 1.0;
		CYCLE_ANGLE = 0;
		for (int i = 0; i < 17; i++)
		{
			create_sprites();
		}
	}

	void create_sprites()
	{
		string SPR_POS = FX_ORIGIN;
		SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, 10, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPR_POS, "setup_ring_sprite");
		CYCLE_ANGLE += 20;
	}

	void setup_ring_sprite()
	{
		float FADE_DEL = 1.0;
		int SPRITE_SPEED = 100;
		if (FX_RADIUS > 128)
		{
			float FADE_DEL = 2.0;
			int SPRITE_SPEED = 400;
		}
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", SPRITE_COLOR);
		ClientEffect("tempent", "set_current_prop", "renderamt", SPRITE_RENDERAMT);
		ClientEffect("tempent", "set_current_prop", "rendermode", SPRITE_RENDERMODE);
		ClientEffect("tempent", "set_current_prop", "framerate", SPRITE_FRAMERATE);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string SPRITE_TURN = /* TODO: $relvel */ $relvel(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, SPRITE_SPEED, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", SPRITE_TURN);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

}

}
