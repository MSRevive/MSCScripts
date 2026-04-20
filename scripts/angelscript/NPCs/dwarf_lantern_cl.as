#pragma context client

namespace MS
{

class DwarfLanternCl : CGameScript
{
	int FX_ACTIVE;
	string FX_COLOR;
	string FX_DURATION;
	string FX_HAND;
	string FX_OWNER;
	int GLOW_RAD;
	string LEFT_HAND;
	string LIGHT_ID;
	string RIGHT_HAND;
	string SPRITE_NAME;

	DwarfLanternCl()
	{
		RIGHT_HAND = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		LEFT_HAND = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment1");
		GLOW_RAD = 128;
		SPRITE_NAME = "3dmflagry.spr";
	}

	void client_activate()
	{
		SetCallback("render", "enable");
		FX_OWNER = param1;
		FX_HAND = param2;
		FX_COLOR = param3;
		FX_DURATION = param4;
		FX_ACTIVE = 1;
		if (FX_HAND == 0)
		{
			string L_LIGHT_LOC = RIGHT_HAND;
		}
		else
		{
			string L_LIGHT_LOC = LEFT_HAND;
		}
		ClientEffect("light", "new", L_LIGHT_LOC, GLOW_RAD, FX_COLOR, FX_DURATION);
		LIGHT_ID = "game.script.last_light_id";
		ClientEffect("tempent", "sprite", SPRITE_NAME, L_LIGHT_LOC, "setup_lantern_sprite", "update_lantern_sprite");
		FX_DURATION("end_fx");
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		if (FX_HAND == 0)
		{
			string L_LIGHT_LOC = RIGHT_HAND;
		}
		else
		{
			string L_LIGHT_LOC = LEFT_HAND;
		}
		ClientEffect("light", LIGHT_ID, L_LIGHT_LOC, GLOW_RAD, FX_COLOR, FX_DURATION);
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ClientEffect("light", LIGHT_ID, L_LIGHT_LOC, GLOW_RAD, Vector3(0, 0, 0), 0.1);
		ScheduleDelayedEvent(0.5, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void update_lantern_sprite()
	{
		if ((FX_ACTIVE)) return;
		ClientEffect("tempent", "set_current_prop", "origin", Vector3(8000, 8000, 8000));
	}

	void setup_lantern_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "framerate", 4);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.75);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "rendercolor", FX_COLOR);
		ClientEffect("tempent", "set_current_prop", "follow", FX_OWNER, FX_HAND);
	}

}

}
