#pragma context client

namespace MS
{

class SfxSprite : CGameScript
{
	string RENDER_PROPS;
	string SPRITE_DURATION;

	void client_activate()
	{
		string SPRITE_POS = param1;
		string SPRITE_NAME = param2;
		RENDER_PROPS = param3;
		SPRITE_DURATION = param4;
		if (SPRITE_DURATION != "once")
		{
			ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_POS, "setup_temp_sprite");
			string F_DURATION = SPRITE_DURATION;
			F_DURATION += 0.1;
			F_DURATION("remove_me");
		}
		else
		{
			ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_POS, "setup_temp_sprite", "update_temp_sprite");
			F_DURATION += 20.0;
			F_DURATION("remove_me");
			LogDebug("*** $currentscript playonce started @ game.time");
		}
	}

	void update_temp_sprite()
	{
		if (!("game.tempent.frame" >= GetToken(RENDER_PROPS, 6, ";"))) return;
		remove_me();
	}

	void remove_me()
	{
		RemoveScript();
	}

	void setup_temp_sprite()
	{
		if (SPRITE_DURATION != "once")
		{
			ClientEffect("tempent", "set_current_prop", "death_delay", SPRITE_DURATION);
		}
		if (GetToken(RENDER_PROPS, 0, ";") == 1)
		{
			ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		}
		ClientEffect("tempent", "set_current_prop", "scale", GetToken(RENDER_PROPS, 1, ";"));
		ClientEffect("tempent", "set_current_prop", "renderamt", GetToken(RENDER_PROPS, 2, ";"));
		ClientEffect("tempent", "set_current_prop", "rendermode", GetToken(RENDER_PROPS, 3, ";"));
		ClientEffect("tempent", "set_current_prop", "rendercolor", GetToken(RENDER_PROPS, 4, ";"));
		ClientEffect("tempent", "set_current_prop", "framerate", GetToken(RENDER_PROPS, 5, ";"));
		ClientEffect("tempent", "set_current_prop", "frames", GetToken(RENDER_PROPS, 6, ";"));
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
	}

}

}
