#pragma context client

namespace MS
{

class WormAbyssalCl : CGameScript
{
	string ATTACH_EYE;
	string BEAM_DEST;
	float BEAM_FADE_COUNT;
	int BEAM_LIGHT_ACTIVE;
	string BEAM_LIGHT_ID;
	float BEAM_SPRITE_GROW;
	int BEAM_SPRITE_ON;
	int BEAM_SPRITE_START_SHRINK;
	int CYCLE_ANGLE;
	float EYE_BEAM_BRIGHT;
	int EYE_BEAM_ROT;
	int FOLLOW_BEAMS_ON;
	string FOLOW_BEAM_ID1;
	string FOLOW_BEAM_ID2;
	int FX_ACTIVE;
	string FX_CENTER;
	string FX_DURATION;
	float FX_MAX_SCALE;
	string FX_OWNER;
	string FX_RADIUS;
	string POS_BEAM_LIGHT;
	int POS_BEAM_RAD;
	string SOUND_BURST;
	int SPHERE_ACTIVE;
	string SPRITE_COLOR;
	int SPRITE_FRAMERATE;
	string SPRITE_NAME;
	int SPRITE_NFRAMES;
	int SPRITE_RENDERAMT;
	string SPRITE_RENDERMODE;
	float SPRITE_SCALE;
	string TOKEN_BEAMS;

	WormAbyssalCl()
	{
		ATTACH_EYE = "attachment0";
		SPRITE_NAME = "fire1_fixed.spr";
		SPRITE_COLOR = Vector3(255, 0, 255);
		SPRITE_RENDERAMT = 200;
		SPRITE_RENDERMODE = "add";
		SPRITE_FRAMERATE = 30;
		SPRITE_NFRAMES = 23;
		SPRITE_SCALE = 2.0;
		SOUND_BURST = "magic/boom.wav";
		SetCallback("render", "enable");
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = param2;
		FX_ACTIVE = 1;
		FX_MAX_SCALE = 10.0;
		FX_DURATION("remove_fx");
	}

	void dark_burst()
	{
		FX_CENTER = param1;
		FX_RADIUS = param2;
		string L_LIGHT_RAD = FX_RADIUS;
		L_LIGHT_RAD *= 1.5;
		ClientEffect("light", "new", FX_CENTER, L_LIGHT_RAD, SPRITE_COLOR, 1.0);
		EmitSound3D(SOUND_BURST, 10, FX_CENTER);
		CYCLE_ANGLE = 0;
		for (int i = 0; i < 17; i++)
		{
			create_sprites();
		}
	}

	void create_sprites()
	{
		string L_SPR_POS = FX_CENTER;
		L_SPR_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, 10, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, L_SPR_POS, "setup_ring_sprite");
		CYCLE_ANGLE += 20;
	}

	void setup_ring_sprite()
	{
		float L_FADE_DEL = 1.0;
		int L_SPRITE_SPEED = 100;
		if (FX_RADIUS > 128)
		{
			float L_FADE_DEL = 2.0;
			int L_SPRITE_SPEED = 400;
		}
		ClientEffect("tempent", "set_current_prop", "death_delay", L_FADE_DEL);
		ClientEffect("tempent", "set_current_prop", "rendercolor", SPRITE_COLOR);
		ClientEffect("tempent", "set_current_prop", "renderamt", SPRITE_RENDERAMT);
		ClientEffect("tempent", "set_current_prop", "rendermode", SPRITE_RENDERMODE);
		ClientEffect("tempent", "set_current_prop", "framerate", SPRITE_FRAMERATE);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string FLAME_TURN = /* TODO: $relvel */ $relvel(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, L_SPRITE_SPEED, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", FLAME_TURN);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

	void beam_charge()
	{
		POS_BEAM_LIGHT = param1;
		POS_BEAM_RAD = 1;
		BEAM_LIGHT_ACTIVE = 1;
		ClientEffect("light", "new", POS_BEAM_LIGHT, POS_BEAM_RAD, Vector3(255, 128, 255), 3.0);
		BEAM_LIGHT_ID = "game.script.last_light_id";
		ClientEffect("beam_update", "removeall");
		ClientEffect("beam_follow", FX_OWNER, 1, "lgtning.spr", 10.0, 30, Vector3(1, 0, 1), 0.75);
		FOLOW_BEAM_ID1 = "game.script.last_beam_id";
		ClientEffect("beam_follow", FX_OWNER, 1, "lgtning.spr", 10.0, 5, Vector3(1, 0.75, 1), 0.75);
		FOLOW_BEAM_ID2 = "game.script.last_beam_id";
		FOLLOW_BEAMS_ON = 1;
		BEAM_SPRITE_ON = 1;
		BEAM_SPRITE_GROW = 0.02;
		ClientEffect("tempent", "sprite", "3dmflaora.spr", /* TODO: $getcl */ $getcl(FX_OWNER, ATTACH_EYE), "setup_beam_sprite", "update_beam_sprite");
	}

	void game_prerender()
	{
		if ((BEAM_LIGHT_ACTIVE))
		{
			if (POS_BEAM_RAD < 384)
			{
				POS_BEAM_RAD += 10;
			}
			ClientEffect("light", BEAM_LIGHT_ID, POS_BEAM_LIGHT, POS_BEAM_RAD, Vector3(255, 128, 255), 5.0);
		}
		else
		{
			ClientEffect("light", BEAM_LIGHT_ID, Vector3(10000, 10000, 10000), POS_BEAM_RAD, Vector3(0, 0, 0), 0.1);
		}
	}

	void beam_fire()
	{
		BEAM_SPRITE_START_SHRINK = 1;
		BEAM_SPRITE_GROW = -0.04;
		BEAM_FADE_COUNT = 0.75;
		fade_beams_loop();
		ScheduleDelayedEvent(2.0, "beam_light_off");
		BEAM_DEST = param1;
		EYE_BEAM_ROT = 0;
		TOKEN_BEAMS = "";
		for (int i = 0; i < 8; i++)
		{
			setup_eye_beams();
		}
		EYE_BEAM_BRIGHT = 1.0;
		ScheduleDelayedEvent(2.0, "eye_beam_fade_cycle");
		EmitSound3D("magic/sff_explsonic.wav", 10, BEAM_DEST);
		SPHERE_ACTIVE = 1;
		ClientEffect("tempent", "model", "monsters/zubat_sphere.mdl", BEAM_DEST, "setup_sphere", "update_sphere");
		ScheduleDelayedEvent(5.0, "end_sphere");
		ClientEffect("tempent", "sprite", "3dmflagry.spr", BEAM_DEST, "setup_beam_end_sprite");
	}

	void setup_eye_beams()
	{
		string L_BEAM_END = BEAM_DEST;
		L_BEAM_END += /* TODO: $relpos */ $relpos(Vector3(EYE_BEAM_ROT, 0, 0), Vector3(0, 48, 0));
		ClientEffect("beam_end", FX_OWNER, 1, L_BEAM_END, "lgtning.spr", 5.0, 30, 0, 1.0, 100, 30, Vector3(1, 0, 1));
		if (TOKEN_BEAMS.length() > 0) TOKEN_BEAMS += ";";
		TOKEN_BEAMS += "game.script.last_beam_id";
		LogDebug("*** addbeam game.script.last_beam_id");
		ClientEffect("beam_end", FX_OWNER, 1, L_BEAM_END, "lgtning.spr", 5.0, 5, 0, 1.0, 100, 30, Vector3(1, 0.5, 1));
		if (TOKEN_BEAMS.length() > 0) TOKEN_BEAMS += ";";
		TOKEN_BEAMS += "game.script.last_beam_id";
		LogDebug("*** addbeam game.script.last_beam_id");
		EYE_BEAM_ROT += 45;
	}

	void eye_beam_fade_cycle()
	{
		EYE_BEAM_BRIGHT -= 0.05;
		if (EYE_BEAM_BRIGHT >= 0)
		{
			LogDebug("*** eye_beam_fade_cycle [ GetTokenCount(TOKEN_BEAMS, ";") ] TOKEN_BEAMS");
			for (int i = 0; i < GetTokenCount(TOKEN_BEAMS, ";"); i++)
			{
				eye_beam_fade_loop();
			}
			ScheduleDelayedEvent(0.01, "eye_beam_fade_cycle");
		}
	}

	void eye_beam_fade_loop()
	{
		string CUR_BEAM = GetToken(TOKEN_BEAMS, i, ";");
		LogDebug("*** fadebeam CUR_BEAM");
		ClientEffect("beam_update", CUR_BEAM, "brightness", EYE_BEAM_BRIGHT);
	}

	void beam_light_off()
	{
		BEAM_LIGHT_ACTIVE = 0;
	}

	void fade_beams_loop()
	{
		BEAM_FADE_COUNT -= 0.01;
		if (BEAM_FADE_COUNT > 0)
		{
			ClientEffect("beam_update", FOLOW_BEAM_ID1, "brightness", BEAM_FADE_COUNT);
			ClientEffect("beam_update", FOLOW_BEAM_ID2, "brightness", BEAM_FADE_COUNT);
			ScheduleDelayedEvent(0.1, "fade_beams_loop");
		}
		else
		{
			ClientEffect("beam_update", FOLOW_BEAM_ID1, "remove");
			ClientEffect("beam_update", FOLOW_BEAM_ID2, "remove");
			FOLLOW_BEAMS_ON = 0;
		}
	}

	void setup_beam_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 20);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.5);
		ClientEffect("tempent", "set_current_prop", "iuser1", 200);
		ClientEffect("tempent", "set_current_prop", "follow", FX_OWNER, 0);
	}

	void setup_beam_end_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 8);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "scale", 6);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

	void update_beam_sprite()
	{
		if ((BEAM_SPRITE_ON))
		{
			string L_CUR_SCALE = "game.tempent.fuser1";
			L_CUR_SCALE += BEAM_SPRITE_GROW;
			if ((BEAM_SPRITE_START_SHRINK))
			{
				BEAM_SPRITE_START_SHRINK = 0;
				ClientEffect("tempent", "set_current_prop", "fade", "lifetime");
			}
			if (L_CUR_SCALE <= 0)
			{
				BEAM_SPRITE_ON = 0;
			}
			else
			{
				ClientEffect("tempent", "set_current_prop", "scale", L_CUR_SCALE);
				ClientEffect("tempent", "set_current_prop", "fuser1", L_CUR_SCALE);
			}
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(10000, 1000, 1000));
			ClientEffect("tempent", "set_current_prop", "renderamt", 0);
			ClientEffect("tempent", "set_current_prop", "death_delay", 0);
		}
	}

	void setup_sphere()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 4.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", 2.0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.25);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 999);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(64, 64, 255));
		ClientEffect("tempent", "set_current_prop", "color", Vector3(64, 64, 255));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.25);
	}

	void update_sphere()
	{
		if ((SPHERE_ACTIVE))
		{
			string CUR_SCALE = "game.tempent.fuser1";
			if (CUR_SCALE < FX_MAX_SCALE)
			{
			}
			CUR_SCALE += 0.05;
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 2000));
		}
	}

	void end_sphere()
	{
		SPHERE_ACTIVE = 0;
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		BEAM_LIGHT_ACTIVE = 0;
		BEAM_SPRITE_ON = 0;
		follow_beams_off();
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void follow_beams_off()
	{
		if (!(FOLLOW_BEAMS_ON)) return;
		ClientEffect("beam_update", "removeall");
		FOLLOW_BEAMS_ON = 0;
	}

	void remove_fx()
	{
		RemoveScript();
	}

}

}
