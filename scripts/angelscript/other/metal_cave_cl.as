#pragma context client

namespace MS
{

class MetalCaveCl : CGameScript
{
	int B_CYCLE;
	float B_CYCLE_PM;
	string GLOW_COLOR;
	string GLOW_RAD;
	int G_CYCLE;
	float G_CYCLE_PM;
	int R_CYCLE;
	float R_CYCLE_PM;
	string SKEL_ID;
	string SKEL_LIGHT_ID;

	void client_activate()
	{
		SKEL_ID = param1;
		GLOW_COLOR = param2;
		GLOW_RAD = param3;
		if (!(SKEL_LIGHT_ID == "SKEL_LIGHT_ID")) return;
		R_CYCLE = RandomInt(0, 255);
		G_CYCLE = RandomInt(0, 255);
		B_CYCLE = RandomInt(0, 255);
		R_CYCLE_PM = 0.01;
		G_CYCLE_PM = -0.01;
		B_CYCLE_PM = 0.01;
		SetCallback("render", "enable");
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(SKEL_ID, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		PARAM4("remove_light");
	}

	void game_prerender()
	{
		string L_CYCLE = R_CYCLE_PM;
		L_CYCLE *= Random(1, 2);
		R_CYCLE += L_CYCLE;
		if (R_CYCLE < 0)
		{
			R_CYCLE_PM *= -1;
			R_CYCLE = 0;
		}
		if (R_CYCLE > 255)
		{
			R_CYCLE_PM *= -1;
			R_CYCLE = 255;
		}
		string L_CYCLE = G_CYCLE_PM;
		L_CYCLE *= Random(1, 2);
		G_CYCLE += L_CYCLE;
		if (G_CYCLE < 0)
		{
			G_CYCLE_PM *= -1;
			G_CYCLE = 0;
		}
		if (G_CYCLE > 255)
		{
			G_CYCLE_PM *= -1;
			G_CYCLE = 255;
		}
		string L_CYCLE = B_CYCLE_PM;
		L_CYCLE *= Random(1, 2);
		B_CYCLE += L_CYCLE;
		if (B_CYCLE < 0)
		{
			B_CYCLE_PM *= -1;
			B_CYCLE = 0;
		}
		if (B_CYCLE > 255)
		{
			B_CYCLE_PM *= -1;
			B_CYCLE = 255;
		}
		Vector3 L_COLOR = Vector3(int(R_CYCLE), int(G_CYCLE), int(B_CYCLE));
		string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, L_COLOR, 1.0);
	}

	void remove_light()
	{
		RemoveScript();
	}

}

}
