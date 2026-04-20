#pragma context server

namespace MS
{

class PlayerClEffectsLevelup : CGameScript
{
	int DIST;
	string MY_OWNER;
	int OFSZ_NEG;
	int OFSZ_POS;
	int OFS_NEG;
	int OFS_POS;
	string THIS_LIGHT;

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.1);
		levelup_createsprite();
	}

	void client_activate()
	{
		MY_OWNER = param1;
		OFSZ_POS = 96;
		OFSZ_NEG = -96;
		OFS_POS = 72;
		OFS_NEG = -72;
		DIST = 32;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), 200, Vector3(0, 255, 0), 3.0);
		THIS_LIGHT = "game.script.last_light_id";
		ScheduleDelayedEvent(4.0, "end_effect");
	}

	void end_effect()
	{
		RemoveScript();
	}

	void levelup_createsprite()
	{
		float RND_LEFT = Random(-20, 20);
		float RND_RIGHT = Random(-20, 20);
		Vector3 SPRITE_VEL = Vector3(RND_LEFT, RND_RIGHT, 0);
		int COLOR_R = RandomInt(0, 255);
		int COLOR_G = RandomInt(0, 255);
		int COLOR_B = RandomInt(0, 255);
		string COLOR_STRING = "(";
		COLOR_STRING += COLOR_R;
		COLOR_STRING += ",";
		COLOR_STRING += COLOR_G;
		COLOR_STRING += ",";
		COLOR_STRING += COLOR_B;
		COLOR_STRING += ")";
		ClientEffect("light", THIS_LIGHT, /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), 200, COLOR_STRING, 0.09);
		string START_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		int RND_RAD = RandomInt(0, 359);
		START_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_RAD, 0), Vector3(0, DIST, -32));
		ClientEffect("tempent", "sprite", "xflare1.spr", START_POS, "setup_levelup_sprite");
		string START_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		int RND_RAD = RandomInt(0, 359);
		START_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_RAD, 0), Vector3(0, DIST, -32));
		ClientEffect("tempent", "sprite", "xflare1.spr", START_POS, "setup_levelup_sprite");
		string START_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		int RND_RAD = RandomInt(0, 359);
		START_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_RAD, 0), Vector3(0, DIST, -32));
		ClientEffect("tempent", "sprite", "xflare1.spr", START_POS, "setup_levelup_sprite");
	}

	void setup_levelup_sprite()
	{
		float RND_LEFT = Random(-20, 20);
		float RND_RIGHT = Random(-20, 20);
		Vector3 SPRITE_VEL = Vector3(RND_LEFT, RND_RIGHT, 0);
		int COLOR_R = RandomInt(0, 255);
		int COLOR_G = RandomInt(0, 255);
		int COLOR_B = RandomInt(0, 255);
		string COLOR_STRING = "(";
		COLOR_STRING += COLOR_R;
		COLOR_STRING += ",";
		COLOR_STRING += COLOR_G;
		COLOR_STRING += ",";
		COLOR_STRING += COLOR_B;
		COLOR_STRING += ")";
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 20);
		ClientEffect("tempent", "set_current_prop", "velocity", SPRITE_VEL);
		ClientEffect("tempent", "set_current_prop", "scale", 0.25);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", COLOR_STRING);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
