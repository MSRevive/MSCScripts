#pragma context client

namespace MS
{

class VgoblinChiefCl : CGameScript
{
	int CYCLE_ANGLE;
	string GLOW_COLOR;
	int GLOW_RAD;
	int N_SPR_FRAMES;
	string SKEL_ID;
	string SKEL_LIGHT_ID;
	int SMOKE_RAD;
	string SPRITE_FIRE;
	string STUN_POS;
	string STUN_RADIUS;
	string STUN_SPRITE;

	VgoblinChiefCl()
	{
		GLOW_RAD = 128;
		GLOW_COLOR = Vector3(0, 255, 0);
		SPRITE_FIRE = "poison_cloud.spr";
		N_SPR_FRAMES = 17;
		SMOKE_RAD = 128;
		STUN_SPRITE = "fire1_fixed.spr";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.25);
		string C_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		string L_POS = C_POS;
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359), 0), Vector3(0, Random(-64, 64), 0));
		ClientEffect("tempent", "sprite", "poison_cloud.spr", L_POS, "setup_smokes");
		string L_POS = C_POS;
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359), 0), Vector3(0, Random(-64, 64), 0));
		ClientEffect("tempent", "sprite", "poison_cloud.spr", L_POS, "setup_smokes");
		string L_POS = C_POS;
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359), 0), Vector3(0, Random(-64, 64), 0));
		ClientEffect("tempent", "sprite", "poison_cloud.spr", L_POS, "setup_smokes");
		string L_POS = C_POS;
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359), 0), Vector3(0, Random(-64, 64), 0));
		ClientEffect("tempent", "sprite", "poison_cloud.spr", L_POS, "setup_smokes");
	}

	void client_activate()
	{
		SKEL_ID = param1;
		if (!(SKEL_LIGHT_ID == "SKEL_LIGHT_ID")) return;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
	}

	void game_prerender()
	{
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void setup_smokes()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "world");
	}

	void dewm_plant_fx()
	{
		string SPRITE_CENTER = param1;
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "plant_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "plant_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "plant_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "plant_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "plant_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_CENTER, "plant_sprite");
	}

	void plant_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 5.0);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-125, 125), Random(-125, 125), Random(-125, 125)));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", 2);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(-1.5, -1.1));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
	}

	void stunburst_go_cl()
	{
		CYCLE_ANGLE = 0;
		const int TOTAL_OFS = 10;
		STUN_POS = param1;
		STUN_RADIUS = param2;
		string POS_GROUND = /* TODO: $get_ground_height */ $get_ground_height(STUN_POS);
		STUN_POS = "z";
		for (int i = 0; i < 17; i++)
		{
			stun_burst_fx();
		}
	}

	void stun_burst_fx()
	{
		string FLAME_POS = STUN_POS;
		FLAME_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, TOTAL_OFS, 0));
		ClientEffect("tempent", "sprite", STUN_SPRITE, FLAME_POS, "stunburst_flame");
		CYCLE_ANGLE += 20;
	}

	void stunburst_flame()
	{
		float FADE_DEL = 1.0;
		if (STUN_RADIUS > 128)
		{
			float FADE_DEL = 2.0;
		}
		int SPRITE_SPEED = 100;
		if (STUN_RADIUS > 128)
		{
			int SPRITE_SPEED = 400;
		}
		ClientEffect("tempent", "set_current_prop", "death_delay", FADE_DEL);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string FLAME_TURN = /* TODO: $relvel */ $relvel(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, SPRITE_SPEED, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", FLAME_TURN);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

}

}
