#pragma context server

namespace MS
{

class LightedCl : CGameScript
{
	string GLOW_COLOR;
	string GLOW_RAD;
	string SKEL_ID;
	string SKEL_LIGHT_ID;

	void client_activate()
	{
		SKEL_ID = param1;
		GLOW_COLOR = param2;
		GLOW_RAD = param3;
		if (!(SKEL_LIGHT_ID == "SKEL_LIGHT_ID")) return;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 1.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		SetCallback("render", "enable");
	}

	void game_prerender()
	{
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 0.5);
	}

	void remove_me()
	{
		RemoveScript();
	}

}

}
