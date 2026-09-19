#pragma context server

namespace MS
{

class SfxLightning : CGameScript
{
	string LIGHTNING_SOUND;
	string LIGHTNING_SPRITE;
	string LIGHTNING_SPRITE_SPARKS;
	string LIGHT_COLOR;
	string SHN;
	int SPARK_HORIZONTAL_NOISE;
	string l.grnd;
	string sfx.amt;
	string sfx.duration;
	string sfx.end;
	string sfx.sparkscale;
	string sfx.start;
	string sfx.width;

	SfxLightning()
	{
		LIGHTNING_SPRITE = "lgtning.spr";
		LIGHTNING_SPRITE_SPARKS = "3dmflaora.spr";
		LIGHT_COLOR = Vector3(1, 0.5, 2);
		LIGHTNING_SOUND = "weather/lightning.wav";
		SPARK_HORIZONTAL_NOISE = 30;
		SHN = SPARK_HORIZONTAL_NOISE;
		Precache(LIGHTNING_SPRITE);
		Precache(LIGHTNING_SPRITE_SPARKS);
	}

	void client_activate()
	{
		sfx.start = param1;
		sfx.end = param2;
		sfx.duration = param3;
		sfx.amt = param4;
		sfx.width = /* TODO: $get_skill_ratio */ $get_skill_ratio(sfx.amt, 1, 25);
		sfx.sparkscale = /* TODO: $get_skill_ratio */ $get_skill_ratio(sfx.amt, 0.1, 0.2);
		l.grnd = /* TODO: $get_ground_height */ $get_ground_height(sfx.start);
		if (l.grnd != "none")
		{
			sfx.start = "z";
		}
		effect_start();
		effect_die();
	}

	void effect_start()
	{
		ClientEffect("beam_points", sfx.start, sfx.end, LIGHTNING_SPRITE, sfx.duration, sfx.width, ".4", ".5", 1, 30, LIGHT_COLOR);
		EmitSound3D(LIGHTNING_SOUND, 7, sfx.start);
		for (int i = 0; i < RandomInt(6, 8); i++)
		{
			effect_createball();
		}
	}

	void effect_createball()
	{
		ClientEffect("tempent", "sprite", LIGHTNING_SPRITE_SPARKS, sfx.start, "effect_setupball_tempent");
	}

	void effect_setupball_tempent()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", Random(0.6, 1));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 2);
		float l.x = Random(/* TODO: $neg */ $neg(SHN), SHN);
		float l.y = Random(/* TODO: $neg */ $neg(SHN), SHN);
		float l.z = Random(-300, -30);
		Vector3 l.vel = Vector3(l.x, l.y, l.z);
		ClientEffect("tempent", "set_current_prop", "velocity", l.vel);
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "scale", sfx.sparkscale);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

	void effect_die()
	{
		RemoveScript();
	}

}

}
