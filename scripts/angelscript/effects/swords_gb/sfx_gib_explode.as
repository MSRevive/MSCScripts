#pragma context client

namespace MS
{

class SfxGibExplode : CGameScript
{
	string FX_RENDER_PROPS;

	SfxGibExplode()
	{
		const string SPR_SPRITE = "char_breath.spr";
		const float SPR_DEATH_DELAY = 0.5;
		const string SPR_RENDER_PROPS = FX_RENDER_PROPS;
		const int SPR_SCALE = 3;
	}

	void client_activate()
	{
		string L_POS = param1;
		string L_BLOOD_COL = param2;
		if (L_BLOOD_COL == "green")
		{
			FX_RENDER_PROPS = "0;1;255;add;(225,225,0);58;30";
		}
		else
		{
			FX_RENDER_PROPS = "0;1;255;add;(200,0,0);58;30";
		}
		ClientEffect("tempent", "sprite", SPR_SPRITE, L_POS, "setup_sprite");
		RemoveScript();
	}

	void setup_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", SPR_DEATH_DELAY);
		if (GetToken(SPR_RENDER_PROPS, 0, ";") == 1)
		{
			ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		}
		ClientEffect("tempent", "set_current_prop", "scale", SPR_SCALE);
		ClientEffect("tempent", "set_current_prop", "renderamt", GetToken(SPR_RENDER_PROPS, 2, ";"));
		ClientEffect("tempent", "set_current_prop", "rendermode", GetToken(SPR_RENDER_PROPS, 3, ";"));
		ClientEffect("tempent", "set_current_prop", "rendercolor", GetToken(SPR_RENDER_PROPS, 4, ";"));
		ClientEffect("tempent", "set_current_prop", "framerate", GetToken(SPR_RENDER_PROPS, 5, ";"));
		ClientEffect("tempent", "set_current_prop", "frames", GetToken(SPR_RENDER_PROPS, 6, ";"));
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
