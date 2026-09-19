#pragma context client

namespace MS
{

class SfxOrbitingLightCl : CGameScript
{
	string CUR_POS;
	int CYCLE_ANGLE;
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_ORIGIN;
	string FX_RADIUS;
	string FX_ROT_SPEED;
	string GLOW_COLOR;
	string GLOW_RADIUS;
	int IS_ACTIVE;
	string LIGHT_ID;

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_DURATION = param2;
		FX_RADIUS = param3;
		GLOW_RADIUS = param4;
		GLOW_COLOR = param5;
		FX_ROT_SPEED = param6;
		SetCallback("render", "enable");
		FX_ACTIVE = 1;
		CYCLE_ANGLE = 0;
		FX_DURATION("end_fx");
		ClientEffect("light", "new", FX_ORIGIN, GLOW_RADIUS, GLOW_COLOR, 1.0);
		LIGHT_ID = "game.script.last_light_id";
		ClientEffect("tempent", "sprite", "3dmflaora.spr", FX_ORIGIN, "setup_sprite", "update_sprite");
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		CYCLE_ANGLE += FX_ROT_SPEED;
		if (CYCLE_ANGLE > 359.99)
		{
			CYCLE_ANGLE = 0;
		}
		CUR_POS = FX_ORIGIN;
		CUR_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, FX_RADIUS, 0));
		ClientEffect("light", LIGHT_ID, CUR_POS, GLOW_RADIUS, GLOW_COLOR, 1.0);
	}

	void update_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "origin", CUR_POS);
	}

	void end_fx()
	{
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "scale", 1);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

}

}
