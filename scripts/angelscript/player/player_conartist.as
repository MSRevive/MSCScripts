#pragma context client

namespace MS
{

class PlayerConartist : CGameScript
{
	string DISCO_MODE;
	string DIST;
	string LEVELUP_SPRITES;
	string LIGHT_RAD;
	string LVL_LIGHT;
	string MY_OWNER;
	string OFSZ_NEG;
	string OFSZ_POS;
	string OFS_NEG;
	string OFS_POS;

	void client_activate()
	{
		if (param1 == "glow")
		{
			ClientEffect("light", "new", /* TODO: $getcl */ $getcl(param2, "origin"), param3, param4, param5);
		}
		if (param1 == "levelup")
		{
			MY_OWNER = param2;
			OFSZ_POS = 96;
			OFSZ_NEG = -96;
			OFS_POS = 72;
			OFS_NEG = -72;
			DIST = 32;
			ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), 200, Vector3(0, 255, 0), 3.0);
			LVL_LIGHT = "game.script.last_light_id";
			LEVELUP_SPRITES = 1;
			LIGHT_RAD = 200;
			sprite_spoog();
			ScheduleDelayedEvent(4.0, "end_fx_levelup");
		}
		if (param1 == "disco")
		{
			MY_OWNER = param2;
			OFSZ_POS = 96;
			OFSZ_NEG = -96;
			OFS_POS = 72;
			OFS_NEG = -72;
			DIST = 32;
			DISCO_MODE = 1;
			ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), 255, Vector3(0, 255, 0), 3.0);
			LVL_LIGHT = "game.script.last_light_id";
			LIGHT_RAD = 512;
			LEVELUP_SPRITES = 1;
			sprite_spoog();
		}
	}

	void game_prerender()
	{
		if (!(GetMonsterProperty("isalive") == 1)) return;
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, 256, Vector3(0, 255, 0), 5.0);
	}

	void sprite_spoog()
	{
		if (!(LEVELUP_SPRITES)) return;
		levelup_createsprite();
		ScheduleDelayedEvent(0.1, "sprite_spoog");
	}

	void end_fx_levelup()
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
		ClientEffect("light", LVL_LIGHT, /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), LIGHT_RAD, COLOR_STRING, 0.1);
		if ((DISCO_MODE))
		{
			DIST = RandomInt(16, 128);
		}
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
		float SCALE_SIZE = 0.25;
		if ((DISCO_MODE))
		{
			float SCALE_SIZE = Random(0.25, 1.0);
		}
		float DEATH_DELAY = 1.0;
		if ((DISCO_MODE))
		{
			float DEATH_DELAY = 2.5;
		}
		ClientEffect("tempent", "set_current_prop", "death_delay", DEATH_DELAY);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 20);
		ClientEffect("tempent", "set_current_prop", "velocity", SPRITE_VEL);
		ClientEffect("tempent", "set_current_prop", "scale", SCALE_SIZE);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", COLOR_STRING);
		ClientEffect("tempent", "set_current_prop", "gravity", -0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
