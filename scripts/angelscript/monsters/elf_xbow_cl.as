#pragma context client

namespace MS
{

class ElfXbowCl : CGameScript
{
	string BOLT_ANGLES;
	string BOLT_END;
	string BOLT_EXPLODE;
	int BOLT_SPEED;
	string BOLT_START;

	ElfXbowCl()
	{
		const string SPRITE_EXPLODE = "explode1.spr";
		const string SOUND_BOLT_HIT = "weapons/bow/bolthit1.wav";
		const string SOUND_EXPLODE = "weapons/explode3.wav";
		const string MODEL_BOLT = "weapons/bows/boltexplosive.mdl";
		Precache(MODEL_BOLT);
		Precache(SPRITE_EXPLODE);
		Precache(SOUND_BOLT_HIT);
		Precache(SOUND_EXPLODE);
	}

	void client_activate()
	{
		string L_DUR = param1;
		L_DUR += 0.1;
		L_DUR("remove_fx");
	}

	void fire_bolt()
	{
		BOLT_START = param1;
		BOLT_END = param2;
		BOLT_ANGLES = param3;
		BOLT_EXPLODE = param4;
		BOLT_SPEED = 1000;
		for (int i = 0; i < 5; i++)
		{
			shadow_bolts();
		}
		ScheduleDelayedEvent(0.05, "hit_wall");
		string DBG_BOLT_END = BOLD_START;
		DBG_BOLT_END += /* TODO: $relpos */ $relpos(BOLT_ANGLES, Vector3(0, 2048, 0));
		if ((BOLT_EXPLODE))
		{
			ScheduleDelayedEvent(0.1, "do_splodie");
		}
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void shadow_bolts()
	{
		ClientEffect("tempent", "model", MODEL_BOLT, BOLT_START, "setup_bolt");
		BOLT_SPEED -= 100;
	}

	void hit_wall()
	{
		EmitSound3D("weapons/bow/bolthit1.wav", 10, BOLT_END);
	}

	void do_splodie()
	{
		EmitSound3D("weapons/explode3.wav", 10, BOLT_END);
		ClientEffect("tempent", "sprite", SPRITE_EXPLODE, BOLT_END, "explode_sprite");
		ClientEffect("light", "new", BOLT_END, 256, Vector3(255, 128, 64), 1.0);
	}

	void explode_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.6);
		ClientEffect("tempent", "set_current_prop", "fadeout", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.25);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 15);
		ClientEffect("tempent", "set_current_prop", "frames", 9);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
	}

	void setup_bolt()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "angles", BOLT_ANGLES);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(BOLT_ANGLES, Vector3(0, BOLT_SPEED, 0)));
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

}

}
