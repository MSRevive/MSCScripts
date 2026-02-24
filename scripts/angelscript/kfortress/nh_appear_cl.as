#pragma context client

namespace MS
{

class NhAppearCl : CGameScript
{
	int ANG_COUNT;
	int DISPLAY_KNIFE;
	string F_SPRITE_SPEED;
	string GLOW_COLOR;
	int GLOW_RAD;
	string MY_POS;
	int ROT_RATE;
	int SPRITES_ON;
	int SPRITE_SPEED;
	int START_DIST;
	int X_ANG;
	int Y_ANG;

	NhAppearCl()
	{
		GLOW_RAD = 512;
		GLOW_COLOR = Vector3(256, 128, 64);
		START_DIST = 256;
		SPRITE_SPEED = 120;
		ROT_RATE = 36;
	}

	void client_activate()
	{
		X_ANG = 0;
		Y_ANG = 0;
		MY_POS = param1;
		ANG_COUNT = 0;
		DISPLAY_KNIFE = 1;
		if (param2 != "PARAM2")
		{
			string DISPLAY_KNIFE = param2;
		}
		ClientEffect("light", "new", MY_POS, GLOW_RAD, GLOW_COLOR, 17.0);
		if ((DISPLAY_KNIFE))
		{
			ClientEffect("tempent", "sprite", "weapons/projectiles.mdl", MY_POS, "setup_knife");
		}
		SPRITES_ON = 1;
		sprite_vacuum();
		EmitSound3D("ambience/alien_humongo.wav", 10, MY_POS);
		ScheduleDelayedEvent(0.1, "spookie_sound");
		ScheduleDelayedEvent(10.0, "close_effect");
	}

	void spookie_sound()
	{
		EmitSound3D("ambience/alienflyby1.wav", 10, MY_POS);
	}

	void close_effect()
	{
		SPRITES_ON = 0;
		EmitSound3D("magic/cast.wav", 10, MY_POS);
		glitter_effect();
		if ((DISPLAY_KNIFE))
		{
			ScheduleDelayedEvent(6.0, "ting_sound");
		}
		ScheduleDelayedEvent(7.0, "end_effect");
	}

	void glitter_effect()
	{
		ScheduleDelayedEvent(0.1, "glitter_effect");
		string GLITTER_POS = MY_POS;
		GLITTER_POS += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, RandomInt(0, 20), 0));
		ClientEffect("tempent", "sprite", "3dmflaora.spr", GLITTER_POS, "setup_glitter");
	}

	void ting_sound()
	{
		string GROUND_POS = MY_POS;
		string GROUND_Z = /* TODO: $get_ground_height */ $get_ground_height(MY_POS);
		GROUND_POS = "z";
		EmitSound3D("weapons/dagger/daggermetal1.wav", 10, GROUND_POS);
	}

	void end_effect()
	{
		RemoveScript();
	}

	void sprite_vacuum()
	{
		if (!(SPRITES_ON)) return;
		ScheduleDelayedEvent(0.1, "sprite_vacuum");
		F_SPRITE_SPEED = SPRITE_SPEED;
		for (int i = 0; i < 10; i++)
		{
			sprite_sphere();
		}
		F_SPRITE_SPEED = /* TODO: $neg */ $neg(SPRITE_SPEED);
		for (int i = 0; i < 10; i++)
		{
			sprite_sphere();
		}
	}

	void sprite_sphere()
	{
		ClientEffect("tempent", "sprite", "3dmflaora.spr", MY_POS, "setup_vac_sprite");
	}

	void setup_knife()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 15.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "normal");
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		ClientEffect("tempent", "set_current_prop", "body", 44);
	}

	void setup_vac_sprite()
	{
		X_ANG += ROT_RATE;
		Y_ANG += ROT_RATE;
		if (X_ANG > 359)
		{
			X_ANG -= 359;
		}
		if (Y_ANG > 359)
		{
			Y_ANG -= 359;
		}
		Vector3 SPRITE_ANGS = Vector3(X_ANG, Y_ANG, Z_ANG);
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", 2.0);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(SPRITE_ANGS, Vector3(0, F_SPRITE_SPEED, 0)));
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "renderamt", 150);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

	void setup_glitter()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", Random(0.5, 1.5));
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 255));
		ClientEffect("tempent", "set_current_prop", "gravity", -2.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

}

}
