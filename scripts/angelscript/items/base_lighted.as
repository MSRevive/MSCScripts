#pragma context server

namespace MS
{

class BaseLighted : CGameScript
{
	int LIGHT_RADIUS;
	int L_ATTACH_BODY;
	string L_ATTACH_MDL_ID;
	string L_POS;
	string local.body;
	string local.lightid;
	int local.local3rdp_sprite;
	int local.modelid;
	string local.scale;
	string local.sprite;

	BaseLighted()
	{
		const string SPRITE_FIRE = "fire1_fixed.spr";
		const string SPRITE_FIRE_FIXED = "fire1_fixed.spr";
		LIGHT_RADIUS = 192;
		const Vector3 LIGHT_COLOR = Vector3(255, 255, 128);
		const float LIGHT_PLAYER_SCALE = 0.3;
		const float LIGHT_DROPPED_SCALE = 0.5;
		Precache(SPRITE_FIRE);
		Precache(SPRITE_FIRE_FIXED);
		const int FRAMES = 23;
		const int FRAMERATE = 30;
		local.modelid = -1;
		local.local3rdp_sprite = 0;
		SetCallback("render", "enable");
	}

	void game_putinpack()
	{
		ClientEffect("all", LAST_TORCH_LIGHT);
		ClientEffect("remove", "all", LAST_TORCH_LIGHT);
	}

	void game_removefromowner()
	{
		ClientEffect("all", LAST_TORCH_LIGHT);
		ClientEffect("remove", "all", LAST_TORCH_LIGHT);
	}

	void game_newowner()
	{
		ClientEffect("all", LAST_TORCH_LIGHT);
		ClientEffect("remove", "all", LAST_TORCH_LIGHT);
	}

	void client_activate()
	{
		local.modelid = param1;
		local.body = param2;
		local.sprite = SPRITE_FIRE_FIXED;
		local.scale = LIGHT_DROPPED_SCALE;
		if (local.modelid == "game.localplayer.index")
		{
			local.local3rdp_sprite = 1;
		}
		if ((/* TODO: $getcl */ $getcl(local.modelid, "isplayer")))
		{
			local.sprite = SPRITE_FIRE;
			local.scale = LIGHT_PLAYER_SCALE;
		}
		create_light();
	}

	void create_light()
	{
		ClientEffect("light", "new", Vector3(0, 0, 0), LIGHT_RADIUS, LIGHT_COLOR, 5);
		SetGlobalVar("LAST_TORCH_LIGHT", "game.script.last_light_id");
		local.lightid = "game.script.last_light_id";
	}

	void game_prerender()
	{
		if (SPRITE_FIRE != "none")
		{
			ClientEffect("frameent", "sprite", local.sprite, Vector3(0, 0, 0), "setup_flame");
		}
		if (!(LIGHT_RADIUS > 0)) return;
		string L_POS = /* TODO: $getcl */ $getcl(local.modelid, "origin");
		if ((/* TODO: $getcl */ $getcl(local.modelid, "isplayer")))
		{
			L_POS = /* TODO: $relpos */ $relpos(/* TODO: $getcl */ $getcl(local.modelid, "angles"), Vector3(0, 64, 0));
			L_POS += /* TODO: $getcl */ $getcl(local.modelid, "center");
		}
		string L_RADIUS = LIGHT_RADIUS;
		L_RADIUS += Random(-8, 8);
		ClientEffect("light", local.lightid, L_POS, L_RADIUS, LIGHT_COLOR, 5);
	}

	void setup_flame()
	{
		string L_ATTACH_MDL_ID = local.modelid;
		string L_ATTACH_BODY = local.body;
		if ((local.local3rdp_sprite))
		{
			// TODO: UNCONVERTED: if( local.local3rdp_sprite ) if( !game.localplayer.thirdperson )
		}
		if (local.body == 1)
		{
			L_ATTACH_MDL_ID = "game.localplayer.viewmodel.left.id";
		}
		else
		{
			L_ATTACH_MDL_ID = "game.localplayer.viewmodel.right.id";
		}
		L_ATTACH_BODY = 1;
		if (!(L_ATTACH_MDL_ID > -1)) return;
		ClientEffect("frameent", "set_current_prop", "owner", L_ATTACH_MDL_ID);
		ClientEffect("frameent", "set_current_prop", "skin", L_ATTACH_MDL_ID);
		ClientEffect("frameent", "set_current_prop", "aiment", L_ATTACH_MDL_ID);
		ClientEffect("frameent", "set_current_prop", "movetype", 12);
		ClientEffect("frameent", "set_current_prop", "body", L_ATTACH_BODY);
		ClientEffect("frameent", "set_current_prop", "scale", local.scale);
		string l.frame = GetGameTime();
		l.frame -= START_BURNING;
		l.frame *= FRAMERATE;
		l.frame %= FRAMES;
		ClientEffect("frameent", "set_current_prop", "frame", l.frame);
	}

}

}
