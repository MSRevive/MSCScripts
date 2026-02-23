#pragma context client

namespace MS
{

class FireFistCl : CGameScript
{
	string BONE_IDX;
	int CUR_FRAME;
	string SKEL_ID;
	string SKEL_LIGHT_ID;

	FireFistCl()
	{
		const string SPRITE_FIRE = "fire1_fixed.spr";
		const int GLOW_RAD = 128;
		const Vector3 GLOW_COLOR = Vector3(255, 255, 128);
	}

	void client_activate()
	{
		SKEL_ID = param1;
		BONE_IDX = param2;
		if (!(SKEL_LIGHT_ID == "SKEL_LIGHT_ID")) return;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		ClientEffect("frameent", "sprite", SPRITE_FIRE, /* TODO: $getcl */ $getcl(SKEL_ID, "bonepos", BONE_IDX), "setup_flame");
		CUR_FRAME = 0;
		SKEL_LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
	}

	void game_prerender()
	{
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
		ClientEffect("frameent", "sprite", SPRITE_FIRE, /* TODO: $getcl */ $getcl(SKEL_ID, "bonepos", BONE_IDX), "setup_flame");
	}

	void setup_flame()
	{
		string L_ATTACH_MDL_ID = SKEL_ID;
		int L_ATTACH_BODY = 1;
		ClientEffect("frameent", "set_current_prop", "owner", L_ATTACH_MDL_ID);
		ClientEffect("frameent", "set_current_prop", "skin", L_ATTACH_MDL_ID);
		ClientEffect("frameent", "set_current_prop", "aiment", L_ATTACH_MDL_ID);
		ClientEffect("frameent", "set_current_prop", "movetype", 12);
		ClientEffect("frameent", "set_current_prop", "body", L_ATTACH_BODY);
		ClientEffect("frameent", "set_current_prop", "scale", 0.5);
		CUR_FRAME += 1;
		if (CUR_FRAME == 23)
		{
			CUR_FRAME = 0;
		}
		ClientEffect("frameent", "set_current_prop", "frame", CUR_FRAME);
	}

}

}
