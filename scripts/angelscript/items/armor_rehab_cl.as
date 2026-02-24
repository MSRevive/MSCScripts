#pragma context server

namespace MS
{

class ArmorRehabCl : CGameScript
{
	int FX_ACTIVE;
	string FX_COLOR;
	string MY_OWNER;
	int OFSZ_NEG;
	int OFSZ_POS;
	int OFS_NEG;
	int OFS_POS;
	string SPR_COLOR;
	int SPR_RAD;
	string THIS_LIGHT;

	void client_activate()
	{
		MY_OWNER = param1;
		FX_COLOR = param2;
		if (FX_COLOR == 1)
		{
			SPR_COLOR = Vector3(255, 0, 0);
		}
		if (FX_COLOR == 2)
		{
			SPR_COLOR = Vector3(255, 255, 0);
		}
		if (FX_COLOR == 3)
		{
			SPR_COLOR = Vector3(64, 64, 255);
		}
		if (FX_COLOR == 4)
		{
			SPR_COLOR = Vector3(0, 255, 0);
		}
		OFSZ_POS = 96;
		OFSZ_NEG = -96;
		OFS_POS = 72;
		OFS_NEG = -72;
		SPR_RAD = 32;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), 200, SPR_COLOR, 3.0);
		THIS_LIGHT = "game.script.last_light_id";
		FX_ACTIVE = 1;
		fx_loop();
		ScheduleDelayedEvent(2.0, "end_fx");
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.05, "fx_loop");
		create_element_sprites();
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		FX_ACTIVE = 0;
	}

	void create_element_sprites()
	{
		float RND_LEFT = Random(-20, 20);
		float RND_RIGHT = Random(-20, 20);
		Vector3 SPRITE_VEL = Vector3(RND_LEFT, RND_RIGHT, 0);
		ClientEffect("light", THIS_LIGHT, /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), 200, SPR_COLOR, 0.09);
		string START_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		int RND_RAD = RandomInt(0, 359);
		START_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_RAD, 0), Vector3(0, SPR_RAD, -30));
		ClientEffect("tempent", "sprite", "xflare1.spr", START_POS, "setup_element_sprite");
		string START_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		int RND_RAD = RandomInt(0, 359);
		START_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_RAD, 0), Vector3(0, SPR_RAD, -30));
		ClientEffect("tempent", "sprite", "xflare1.spr", START_POS, "setup_element_sprite");
		string START_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		int RND_RAD = RandomInt(0, 359);
		START_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_RAD, 0), Vector3(0, SPR_RAD, -30));
		ClientEffect("tempent", "sprite", "xflare1.spr", START_POS, "setup_element_sprite");
	}

	void setup_element_sprite()
	{
		float RND_LEFT = Random(-20, 20);
		float RND_RIGHT = Random(-20, 20);
		Vector3 SPRITE_VEL = Vector3(RND_LEFT, RND_RIGHT, 0);
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 20);
		ClientEffect("tempent", "set_current_prop", "velocity", SPRITE_VEL);
		ClientEffect("tempent", "set_current_prop", "scale", 0.25);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", SPR_COLOR);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		string MY_VEL = /* TODO: $getcl */ $getcl(MY_OWNER, "velocity");
		string MY_ANG = /* TODO: $getcl */ $getcl(MY_OWNER, "angles");
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(MY_ANG, Vector3(0, MY_VEL, 0)));
	}

}

}
