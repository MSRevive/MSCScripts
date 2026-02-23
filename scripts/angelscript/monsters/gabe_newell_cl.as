#pragma context server

namespace MS
{

class GabeNewellCl : CGameScript
{
	string FX_DURATION;
	string FX_OWNER;
	string SKEL_LIGHT_ID;

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = param2;
		FX_DURATION("end_fx");
		SetCallback("render", "enable");
		string RND_R = RandomInt(32, 255);
		string RND_G = RandomInt(32, 255);
		string RND_B = RandomInt(32, 255);
		Vector3 RND_COLOR = Vector3(RND_R, RND_G, RND_B);
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), 256, RND_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
	}

	void end_fx()
	{
		RemoveScript();
	}

	void game_prerender()
	{
		string RND_R = RandomInt(32, 255);
		string RND_G = RandomInt(32, 255);
		string RND_B = RandomInt(32, 255);
		Vector3 RND_COLOR = Vector3(RND_R, RND_G, RND_B);
		ClientEffect("light", SKEL_LIGHT_ID, /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), 256, RND_COLOR, 1.0);
	}

}

}
