#pragma context client

namespace MS
{

class BowsFrostCl : CGameScript
{
	float CONTRACT_RATE;
	string CUR_VOF;
	int CYCLE_ANGLE;
	string FX_OWNER;
	int FX_RADIUS;
	float RISE_RATE;
	string SPRITE_MODE;
	string SPRITE_NAME;
	int VOF_START;

	BowsFrostCl()
	{
		VOF_START = -24;
		SPRITE_NAME = "char_breath.spr";
		RISE_RATE = 0.06;
		CONTRACT_RATE = 0.015;
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_RADIUS = 64;
		CYCLE_ANGLE = 0;
		CUR_VOF = VOF_START;
		SPRITE_MODE = "rise";
		for (int i = 0; i < 9; i++)
		{
			make_sprites();
		}
		ScheduleDelayedEvent(3.0, "rotate_mode");
		ScheduleDelayedEvent(6.0, "contract_mode");
		ScheduleDelayedEvent(10.0, "remove_sprites");
	}

	void rotate_mode()
	{
		SPRITE_MODE = "rotate";
	}

	void contract_mode()
	{
		SPRITE_MODE = "contract";
	}

	void remove_sprites()
	{
		SPRITE_MODE = "remove";
		ScheduleDelayedEvent(2.0, "remove_me");
	}

	void remove_me()
	{
		LogDebug("*** bows_frost_cl_removescript");
		RemoveScript();
	}

	void make_sprites()
	{
		string SPRITE_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SPRITE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, FX_RADIUS, CUR_VOF));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_ORG, "setup_sprite", "update_sprite");
		CYCLE_ANGLE += 40;
	}

	void update_sprite()
	{
		if (SPRITE_MODE == "remove")
		{
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
		}
		if (!(SPRITE_MODE != "remove")) return;
		string SPRITE_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		string MY_ANGLE = "game.tempent.fuser1";
		if (SPRITE_MODE == "rise")
		{
			SPRITE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, MY_ANGLE, 0), Vector3(0, FX_RADIUS, CUR_VOF));
			if (MY_ANGLE == 0)
			{
				CUR_VOF += RISE_RATE;
			}
		}
		if (SPRITE_MODE == "rotate")
		{
			MY_ANGLE += 1;
			if (MY_ANGLE > 359)
			{
				int MY_ANGLE = 0;
			}
			ClientEffect("tempent", "set_current_prop", "fuser1", MY_ANGLE);
			SPRITE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, MY_ANGLE, 0), Vector3(0, FX_RADIUS, CUR_VOF));
		}
		if (SPRITE_MODE == "contract")
		{
			MY_ANGLE += 1;
			if (MY_ANGLE > 359)
			{
				int MY_ANGLE = 0;
			}
			ClientEffect("tempent", "set_current_prop", "fuser1", MY_ANGLE);
			FX_RADIUS -= CONTRACT_RATE;
			SPRITE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, MY_ANGLE, 0), Vector3(0, FX_RADIUS, CUR_VOF));
		}
		ClientEffect("tempent", "set_current_prop", "origin", SPRITE_ORG);
	}

	void setup_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 10.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 3.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", CYCLE_ANGLE);
	}

}

}
