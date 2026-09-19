#pragma context client

namespace MS
{

class SmallarmsNhClAlt : CGameScript
{
	string HIT_TYPE;
	string IMPACT_POINT;
	string MY_OWNER;
	string ORIGIN_POINT;
	string OWNER_ANG;
	string SPRITE_SCALE;

	SmallarmsNhClAlt()
	{
		Precache("debris/glass1.wav");
	}

	void client_activate()
	{
		MY_OWNER = /* TODO: $getcl */ $getcl(param1, "index");
	}

	void shadow_knife()
	{
		ORIGIN_POINT = param1;
		IMPACT_POINT = param2;
		HIT_TYPE = param3;
		SPRITE_SCALE = param4;
		OWNER_ANG = /* TODO: $angles3d */ $angles3d(ORIGIN_POINT, IMPACT_POINT);
		OWNER_ANG = "x";
		LogDebug("ang2dest: OWNER_ANG");
		shadow_knife_fx();
		ScheduleDelayedEvent(0.01, "shadow_knife_fx");
		ScheduleDelayedEvent(0.02, "shadow_knife_fx");
		ScheduleDelayedEvent(0.03, "shadow_knife_fx");
		ScheduleDelayedEvent(0.04, "shadow_knife_fx");
		ScheduleDelayedEvent(0.05, "shadow_knife_fx");
		ScheduleDelayedEvent(0.06, "shadow_knife_fx");
		ScheduleDelayedEvent(0.07, "shadow_knife_fx");
		ScheduleDelayedEvent(0.08, "shadow_knife_fx");
		ScheduleDelayedEvent(0.09, "shadow_knife_fx");
		ScheduleDelayedEvent(0.10, "shadow_knife_fx");
		if (HIT_TYPE != "none")
		{
			ScheduleDelayedEvent(0.05, "vanish_fx");
		}
	}

	void shadow_knife_fx()
	{
		ClientEffect("tempent", "sprite", "weapons/projectiles.mdl", ORIGIN_POINT, "setup_knife");
	}

	void vanish_fx()
	{
		if (HIT_TYPE == "world")
		{
			if (SPRITE_SCALE != 2.0)
			{
			}
			EmitSound3D("debris/glass1.wav", 10, IMPACT_POINT);
		}
		if (SPRITE_SCALE == 2.0)
		{
			EmitSound3D("weapons/explode3.wav", 10, IMPACT_POINT);
		}
		ClientEffect("tempent", "sprite", "3dmflaora.spr", IMPACT_POINT, "vanish_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", IMPACT_POINT, "vanish_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", IMPACT_POINT, "vanish_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", IMPACT_POINT, "vanish_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", IMPACT_POINT, "vanish_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", IMPACT_POINT, "vanish_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", IMPACT_POINT, "vanish_sprite");
	}

	void vanish_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "fadeout", 0.5);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-200, 200), Random(-200, 200), Random(-200, 200)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", SPRITE_SCALE);
		ClientEffect("tempent", "set_current_prop", "renderamt", 180);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "gravity", 1.0);
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

	void setup_knife()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "angles", OWNER_ANG);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(OWNER_ANG, Vector3(0, 1000, 0)));
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		ClientEffect("tempent", "set_current_prop", "body", 44);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 16);
		ClientEffect("tempent", "set_current_prop", "anim", 11);
	}

}

}
