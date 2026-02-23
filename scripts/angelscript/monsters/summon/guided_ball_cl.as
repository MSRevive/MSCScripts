#pragma context client

namespace MS
{

class GuidedBallCl : CGameScript
{
	string GLOW_COLOR;
	string SKEL_ID;
	string SKEL_LIGHT_ID;

	GuidedBallCl()
	{
		const int GLOW_RAD = 128;
	}

	void client_activate()
	{
		SKEL_ID = param1;
		GLOW_COLOR = param2;
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

}

}
