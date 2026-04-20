#pragma context server

namespace MS
{

class AxesCCl : CGameScript
{
	string CAXE_SPRITE_COLOR;
	string EFFECT_COLORS;
	string EFFECT_ELEMENTS;
	string PREV_POS;
	int SPRITE_ACTIVE;

	AxesCCl()
	{
		EFFECT_ELEMENTS = "acid;fire;cold;poison;dark;lightning;holy";
		EFFECT_COLORS = "(64,255,64);(255,64,0);(128,128,255);(0,255,0);(255,0,255);(255,255,0);(255,255,255)";
	}

	void client_activate()
	{
		SetCallback("render", "enable");
	}

	void update_caxe_sprite()
	{
		string L_IDX = FindToken(EFFECT_ELEMENTS, param1, ";");
		CAXE_SPRITE_COLOR = GetToken(EFFECT_COLORS, L_IDX, ";");
		SPRITE_ACTIVE = 1;
		LogDebug("update_caxe_sprite CAXE_SPRITE_COLOR");
	}

	void game_prerender()
	{
		if (!(SPRITE_ACTIVE)) return;
		if (("game.localplayer.thirdperson")) return;
		string L_WEP_IDX = "game.localplayer.viewmodel.active.id";
		string L_POS = /* TODO: $getcl */ $getcl(L_WEP_IDX, "attachment0");
		ClientEffect("frameent", "sprite", "3dmflagry.spr", L_POS, "setup_caxe_sprite");
		ClientEffect("beam_points", L_POS, PREV_POS, "3dmflagry.spr", 0.25, 0.5, 0.2, 1, 30, 30, /* TODO: $clcol */ $clcol(CAXE_SPRITE_COLOR));
		PREV_POS = L_POS;
	}

	void end_fx()
	{
		SPRITE_ACTIVE = 0;
		ScheduleDelayedEvent(0.1, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_caxe_sprite()
	{
		ClientEffect("frameent", "set_current_prop", "renderamt", 200);
		ClientEffect("frameent", "set_current_prop", "rendermode", "glow");
		ClientEffect("frameent", "set_current_prop", "rendercolor", CAXE_SPRITE_COLOR);
		ClientEffect("frameent", "set_current_prop", "scale", 0.5);
		ClientEffect("frameent", "set_current_prop", "frame", 0);
	}

}

}
