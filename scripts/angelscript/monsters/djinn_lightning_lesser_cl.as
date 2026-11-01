#pragma context client

namespace MS
{

class DjinnLightningLesserCl : CGameScript
{
	string ASPRITE_ANG;
	string FX_DURATION;
	string GLOW_COLOR;
	int GLOW_RAD;
	int HAND_POWERUP;
	string HAND_POWER_IDX;
	float HAND_SCALE;
	int IS_ACTIVE;
	string LEFT_HAND_POS;
	string MY_LIGHT_ID;
	string MY_OWNER;
	string RIGHT_HAND_POS;

	DjinnLightningLesserCl()
	{
		GLOW_RAD = 128;
		GLOW_COLOR = Vector3(255, 255, 0);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.01);
		RIGHT_HAND_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0");
		LEFT_HAND_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment1");
	}

	void client_activate()
	{
		MY_OWNER = param1;
		FX_DURATION = param2;
		SetCallback("render", "enable");
		IS_ACTIVE = 1;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), GLOW_RAD, GLOW_COLOR, 5.0);
		MY_LIGHT_ID = "game.script.last_light_id";
		RIGHT_HAND_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0");
		LEFT_HAND_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment1");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", RIGHT_HAND_POS, "setup_hand_sprite", "update_rhand_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", LEFT_HAND_POS, "setup_hand_sprite", "update_lhand_sprite");
		FX_DURATION("remove_fx");
	}

	void game_prerender()
	{
		if (!(IS_ACTIVE)) return;
		string L_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		ClientEffect("light", MY_LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void remove_fx()
	{
		if (!(IS_ACTIVE)) return;
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void hand_sprite()
	{
		LogDebug("**** hand_sprite PARAM1 PARAM2");
		ASPRITE_ANG = param1;
		if (param2 == 0)
		{
			string SPRITE_POS = RIGHT_HAND_POS;
		}
		if (param2 == 1)
		{
			string SPRITE_POS = LEFT_HAND_POS;
		}
		ClientEffect("tempent", "sprite", "3dmflaora.spr", SPRITE_POS, "setup_attack_sprite");
	}

	void hand_powerup()
	{
		HAND_POWERUP = 1;
		HAND_POWER_IDX = param1;
		HAND_SCALE = 0.3;
		ScheduleDelayedEvent(3.0, "end_hand_powerup");
	}

	void end_hand_powerup()
	{
		HAND_POWERUP = 2;
	}

	void update_rhand_sprite()
	{
		if ((IS_ACTIVE))
		{
			ClientEffect("tempent", "set_current_prop", "origin", RIGHT_HAND_POS);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 20000));
		}
		if (HAND_POWERUP == 1)
		{
			if (HAND_POWER_IDX == 0)
			{
			}
			HAND_SCALE += 0.01;
			ClientEffect("tempent", "set_current_prop", "scale", HAND_SCALE);
		}
		if (HAND_POWERUP == 2)
		{
			if (HAND_POWER_IDX == 0)
			{
			}
			ClientEffect("tempent", "set_current_prop", "scale", 0.3);
			HAND_POWERUP = 0;
		}
	}

	void update_lhand_sprite()
	{
		if ((IS_ACTIVE))
		{
			ClientEffect("tempent", "set_current_prop", "origin", LEFT_HAND_POS);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 20000));
		}
		if (HAND_POWERUP == 1)
		{
			if (HAND_POWER_IDX == 1)
			{
			}
			HAND_SCALE += 0.01;
			ClientEffect("tempent", "set_current_prop", "scale", HAND_SCALE);
		}
		if (HAND_POWERUP == 2)
		{
			if (HAND_POWER_IDX == 1)
			{
			}
			ClientEffect("tempent", "set_current_prop", "scale", 0.3);
			HAND_POWERUP = 0;
		}
	}

	void setup_attack_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(254, 254, 1));
		ClientEffect("tempent", "set_current_prop", "scale", 0.3);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(ASPRITE_ANG, Vector3(0, 300, 0)));
	}

	void setup_hand_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(254, 254, 1));
		ClientEffect("tempent", "set_current_prop", "scale", 0.3);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

}

}
