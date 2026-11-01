#pragma context client

namespace MS
{

class ArmorFauraCl : CGameScript
{
	int FOOT_BONE;
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_RADIUS;
	string GLOW_COLOR;
	int GLOW_RAD;
	string LIGHT_ID;
	string MY_OWNER;
	string OWNER_FEET;
	string OWNER_NPC;
	int V_OFS;

	ArmorFauraCl()
	{
		GLOW_RAD = 128;
		GLOW_COLOR = Vector3(255, 128, 64);
		V_OFS = -26;
		FOOT_BONE = 4;
	}

	void client_activate()
	{
		SetCallback("render", "enable");
		MY_OWNER = param1;
		FX_RADIUS = param2;
		FX_DURATION = param3;
		OWNER_NPC = param4;
		FX_RADIUS -= 24;
		LogDebug("***** Owner MY_OWNER rad FX_RADIUS dur FX_DURATION");
		FX_DURATION("remove_fx");
		OWNER_FEET = /* TODO: $getcl */ $getcl(MY_OWNER, "bonepos", FOOT_BONE);
		FX_ACTIVE = 1;
		ClientEffect("tempent", "sprite", "weapons/projectiles.mdl", OWNER_FEET, "setup_flame_circle", "update_flame_circle");
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), GLOW_RAD, GLOW_COLOR, 1.0);
		LIGHT_ID = "game.script.last_light_id";
	}

	void game_prerender()
	{
		if (!(/* TODO: $getcl */ $getcl(MY_OWNER, "exists"))) return;
		ClientEffect("light", LIGHT_ID, /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void remove_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(0.1, "remove_fx2");
	}

	void remove_fx2()
	{
		RemoveScript();
	}

	void update_flame_circle()
	{
		if ((FX_ACTIVE))
		{
			OWNER_FEET = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
			if (!(OWNER_NPC))
			{
				if ((/* TODO: $getcl */ $getcl(MY_OWNER, "ducking")))
				{
					OWNER_FEET += "z";
				}
				OWNER_FEET += "z";
			}
			else
			{
				OWNER_FEET += "z";
			}
			ClientEffect("tempent", "set_current_prop", "origin", OWNER_FEET);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "rendermode", 5);
			ClientEffect("tempent", "set_current_prop", "renderamt", 0);
			ClientEffect("tempent", "set_current_prop", "death_delay", /* TODO: $neg */ $neg(FX_DURATION));
			ClientEffect("tempent", "set_current_prop", "fadeout", 0);
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(10000, 10000, 10000));
		}
	}

	void setup_flame_circle()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", 51);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "scale", 2.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
	}

}

}
