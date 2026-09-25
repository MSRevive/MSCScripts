#pragma context client

namespace MS
{

class HydraFireLesserCl : CGameScript
{
	string FOLOW_BEAM_ID1;
	string FOLOW_BEAM_ID2;
	int FX_ACTIVE;
	string FX_BREATH_AOE;
	string FX_BREATH_LIGHT_ID;
	string FX_BREATH_ON;
	string FX_BREATH_RANGE;
	string FX_BREATH_SCALE;
	string FX_BREATH_SPR_VEL;
	string FX_DURATION;
	string FX_LIGHT_ID;
	string FX_MODEL_SCALE;
	string FX_ORIGIN;
	string FX_OWNER;
	string FX_RADIUS;
	string FX_TYPE;
	string GLOW_COLOR;

	void client_activate()
	{
		SetCallback("render", "enable");
		FX_OWNER = param1;
		FX_DURATION = param2;
		FX_RADIUS = param3;
		FX_TYPE = param4;
		FX_BREATH_ON = param5;
		FX_BREATH_RANGE = param6;
		FX_BREATH_AOE = param7;
		FX_RADIUS -= 24;
		FX_MODEL_SCALE = FX_RADIUS;
		FX_MODEL_SCALE /= 48;
		FX_MODEL_SCALE += 2.5;
		LogDebug("*** $currentscript Ownr FX_OWNER dur FX_DURATION rad FX_RADIUS type FX_TYPE scal FX_MODEL_SCALE p3 PARAM3");
		if (FX_TYPE == "fire")
		{
			GLOW_COLOR = Vector3(255, 128, 64);
		}
		FX_DURATION("remove_fx");
		FX_ORIGIN = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		FX_ACTIVE = 1;
		if ((FX_BREATH_ON))
		{
			cone_breath_on(FX_BREATH_RANGE, FX_BREATH_AOE);
		}
		ClientEffect("tempent", "sprite", "weapons/projectiles.mdl", FX_ORIGIN, "setup_flame_circle", "update_flame_circle");
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), GLOW_RAD, GLOW_COLOR, 1.0);
		FX_LIGHT_ID = "game.script.last_light_id";
	}

	void game_prerender()
	{
		if (!(/* TODO: $getcl */ $getcl(FX_OWNER, "exists"))) return;
		ClientEffect("light", FX_LIGHT_ID, /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), FX_RADIUS, GLOW_COLOR, 1.0);
		if ((FX_BREATH_ON))
		{
			string L_BREATH_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
			string L_OWNER_YAW = /* TODO: $getcl */ $getcl(FX_OWNER, "angles");
			string L_OWNER_YAW = /* TODO: $vec.yaw */ $vec.yaw(L_OWNER_YAW);
			L_BREATH_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_OWNER_YAW, 0), Vector3(0, FX_BREATH_RANGE, 0));
			ClientEffect("light", FX_BREATH_LIGHT_ID, L_BREATH_POS, FX_BREATH_AOE, GLOW_COLOR, 1.0);
		}
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		FX_BREATH_ON = 0;
		ClientEffect("beam_update", "removeall");
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void update_flame_circle()
	{
		if ((FX_ACTIVE))
		{
			FX_ORIGIN = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
			FX_ORIGIN += "z";
			ClientEffect("tempent", "set_current_prop", "origin", FX_ORIGIN);
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
		ClientEffect("tempent", "set_current_prop", "scale", FX_MODEL_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
	}

	void cone_breath_on()
	{
		if (!(FX_ACTIVE)) return;
		FX_BREATH_ON = 1;
		FX_BREATH_RANGE = param1;
		FX_BREATH_AOE = param2;
		string L_BREATH_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		string L_OWNER_YAW = /* TODO: $getcl */ $getcl(FX_OWNER, "angles");
		string L_OWNER_YAW = /* TODO: $vec.yaw */ $vec.yaw(L_OWNER_YAW);
		L_BREATH_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_OWNER_YAW, 0), Vector3(0, FX_BREATH_RANGE, 0));
		FX_BREATH_SCALE = FX_BREATH_AOE;
		FX_BREATH_SCALE /= 48;
		FX_BREATH_SCALE += 2.5;
		ClientEffect("tempent", "sprite", "weapons/projectiles.mdl", FX_ORIGIN, "setup_breath_circle", "update_breath_circle");
		ClientEffect("light", "new", L_BREATH_POS, GLOW_RAD, FX_BREATH_AOE, 1.0);
		FX_BREATH_LIGHT_ID = "game.script.last_light_id";
		breath_sprites_loop();
	}

	void breath_sprites_loop()
	{
		if (!(FX_BREATH_ON)) return;
		Random(0_1, 0_3)("breath_sprites_loop");
		string L_BREATH_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		string L_OWNER_YAW = /* TODO: $getcl */ $getcl(FX_OWNER, "angles");
		string L_OWNER_YAW = /* TODO: $vec.yaw */ $vec.yaw(L_OWNER_YAW);
		L_BREATH_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_OWNER_YAW, 0), Vector3(0, FX_BREATH_RANGE, 0));
		string L_START = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment1");
		string L_END = L_BREATH_POS;
		string L_BREATH_DIR = (L_END - L_START).Normalize();
		FX_BREATH_SPR_VEL = L_BREATH_DIR;
		FX_BREATH_SPR_VEL *= Random(200, 300);
		ClientEffect("tempent", "sprite", "explode1.spr", L_START, "setup_breath_sprite", "update_breath_sprite");
		FX_BREATH_SPR_VEL = L_BREATH_DIR;
		FX_BREATH_SPR_VEL *= Random(200, 300);
		ClientEffect("tempent", "sprite", "explode1.spr", L_START, "setup_breath_sprite", "update_breath_sprite");
	}

	void cone_breath_off()
	{
		FX_BREATH_ON = 0;
	}

	void update_breath_sprite()
	{
		string CUR_SCALE = "game.tempent.fuser1";
		CUR_SCALE += 0.02;
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
	}

	void setup_breath_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 9);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.1);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "velocity", FX_BREATH_SPR_VEL);
	}

	void update_breath_circle()
	{
		if ((FX_BREATH_ON))
		{
			string L_BREATH_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
			string L_OWNER_YAW = /* TODO: $getcl */ $getcl(FX_OWNER, "angles");
			string L_OWNER_YAW = /* TODO: $vec.yaw */ $vec.yaw(L_OWNER_YAW);
			L_BREATH_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_OWNER_YAW, 0), Vector3(0, FX_BREATH_RANGE, 0));
			L_BREATH_POS += "z";
			ClientEffect("tempent", "set_current_prop", "origin", L_BREATH_POS);
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

	void setup_breath_circle()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", 51);
		ClientEffect("tempent", "set_current_prop", "framerate", 0.5);
		ClientEffect("tempent", "set_current_prop", "sequence", 8);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 100);
		ClientEffect("tempent", "set_current_prop", "scale", FX_BREATH_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 11);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
	}

	void add_beam()
	{
		LogDebug("*** add_beam dur PARAM1 att PARAM2 col1 PARAM3 col2 PARAM4");
		string L_DUR = param1;
		string L_ATTACH = param2;
		L_ATTACH += 1;
		ClientEffect("beam_follow", FX_OWNER, L_ATTACH, "lgtning.spr", L_DUR, 30, param3, 0.75);
		FOLOW_BEAM_ID1 = "game.script.last_beam_id";
		ClientEffect("beam_follow", FX_OWNER, L_ATTACH, "lgtning.spr", L_DUR, 10, param4, 0.75);
		FOLOW_BEAM_ID2 = "game.script.last_beam_id";
		PARAM1("remove_beams");
	}

	void remove_beams()
	{
		ClientEffect("beam_update", "removeall");
	}

}

}
