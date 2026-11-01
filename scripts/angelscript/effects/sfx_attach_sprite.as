#pragma context client

namespace MS
{

class SfxAttachSprite : CGameScript
{
	string ATTACH_IDX;
	string DO_GLOW;
	int FX_ACTIVE;
	string FX_DURATION;
	string GLOW_COLOR;
	string GLOW_RAD;
	string MY_OWNER;
	string RENDER_PROPS;
	string SKEL_LIGHT_ID;
	string SPRITE_NAME;
	string SPRITE_POS;

	void client_activate()
	{
		RENDER_PROPS = param1;
		MY_OWNER = param2;
		ATTACH_IDX = param3;
		FX_DURATION = param4;
		SPRITE_NAME = param5;
		DO_GLOW = param6;
		GLOW_COLOR = param7;
		GLOW_RAD = param8;
		SetCallback("render", "enable");
		if (ATTACH_IDX == 0)
		{
			SPRITE_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0");
		}
		if (ATTACH_IDX == 1)
		{
			SPRITE_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment1");
		}
		if (ATTACH_IDX == 2)
		{
			SPRITE_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment2");
		}
		if (ATTACH_IDX == 3)
		{
			SPRITE_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment3");
		}
		LogDebug("**** mdl MY_OWNER attch ATTACH_IDX /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0") /* TODO: $getcl */ $getcl(MY_OWNER, "attachment1") /* TODO: $getcl */ $getcl(MY_OWNER, "attachment2") /* TODO: $getcl */ $getcl(MY_OWNER, "attachment3") [ SPRITE_POS ]");
		if ((DO_GLOW))
		{
			ClientEffect("light", "new", SPRITE_POS, GLOW_RAD, GLOW_COLOR, FX_DURATION);
			SKEL_LIGHT_ID = "game.script.last_light_id";
		}
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_POS, "setup_attach_sprite", "update_attach_sprite");
		FX_DURATION("end_fx");
		FX_ACTIVE = 1;
		keep_sprite_pos();
	}

	void keep_sprite_pos()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.01, "keep_sprite_pos");
		if (ATTACH_IDX == 0)
		{
			SPRITE_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0");
		}
		if (ATTACH_IDX == 1)
		{
			SPRITE_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment1");
		}
		if (ATTACH_IDX == 2)
		{
			SPRITE_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment2");
		}
		if (ATTACH_IDX == 3)
		{
			SPRITE_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment3");
		}
	}

	void end_fx()
	{
		LogDebug("**** END FX");
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void game_prerender()
	{
		if ((DO_GLOW))
		{
			string L_POS = /* TODO: $getcl */ $getcl(SKEL_ID, "origin");
			ClientEffect("light", SKEL_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
		}
	}

	void update_attach_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "origin", SPRITE_POS);
	}

	void setup_attach_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		if (GetToken(RENDER_PROPS, 0, ";") == 1)
		{
			ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		}
		ClientEffect("tempent", "set_current_prop", "scale", GetToken(RENDER_PROPS, 1, ";"));
		ClientEffect("tempent", "set_current_prop", "renderamt", GetToken(RENDER_PROPS, 2, ";"));
		ClientEffect("tempent", "set_current_prop", "rendermode", GetToken(RENDER_PROPS, 3, ";"));
		ClientEffect("tempent", "set_current_prop", "rendercolor", GetToken(RENDER_PROPS, 4, ";"));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", GetToken(RENDER_PROPS, 5, ";"));
		ClientEffect("tempent", "set_current_prop", "frames", GetToken(RENDER_PROPS, 6, ";"));
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

}

}
