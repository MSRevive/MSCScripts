#pragma context client

namespace MS
{

class BoarLavaCl : CGameScript
{
	string FB_OFS;
	int FLIP_SPRITE;
	int FX_ACTIVE;
	string FX_OWNER;
	string OWNER_YAW;
	string RL_OFS;
	string START_SCALE;

	BoarLavaCl()
	{
		const string SPRITE_NAME = "fire1_fixed2.spr";
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_ACTIVE = 1;
		string BOAR_SIZE = param2;
		if (BOAR_SIZE == 1)
		{
			FB_OFS = -25;
			RL_OFS = 10;
			START_SCALE = 0.5;
		}
		if (BOAR_SIZE == 2)
		{
			FB_OFS = -35;
			RL_OFS = 20;
			START_SCALE = 1.0;
		}
		if (BOAR_SIZE == 3)
		{
			FB_OFS = -45;
			RL_OFS = 30;
			START_SCALE = 2.0;
		}
		LogDebug("boar_lava_cl:client_activate FX_OWNER BOAR_SIZE");
		fx_loop();
		ScheduleDelayedEvent(10.0, "remove_fx");
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "fx_loop");
		OWNER_YAW = /* TODO: $getcl */ $getcl(FX_OWNER, "angles.yaw");
		FLIP_SPRITE = 0;
		string SPRITE_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SPRITE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(RL_OFS, FB_OFS, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_ORG, "setup_hoof_sprite", "update_hoof_sprite");
		string SPRITE_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		string NEG_RL_OFS = /* TODO: $neg */ $neg(RL_OFS);
		SPRITE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(NEG_RL_OFS, FB_OFS, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_ORG, "setup_hoof_sprite", "update_hoof_sprite");
		FLIP_SPRITE = 1;
		string SPRITE_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SPRITE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(RL_OFS, FB_OFS, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_ORG, "setup_hoof_sprite", "update_hoof_sprite");
		string SPRITE_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		string NEG_RL_OFS = /* TODO: $neg */ $neg(RL_OFS);
		SPRITE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(NEG_RL_OFS, FB_OFS, 0));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_ORG, "setup_hoof_sprite", "update_hoof_sprite");
	}

	void remove_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(4.0, "remove_fx2");
	}

	void remove_fx2()
	{
		RemoveScript();
	}

	void update_hoof_sprite()
	{
		string CUR_SIZE = "game.tempent.fuser1";
		CUR_SIZE -= 0.01;
		if (!(CUR_SIZE > 0)) return;
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SIZE);
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SIZE);
	}

	void setup_hoof_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "fadeout", 2.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		string L_YAW = OWNER_YAW;
		L_YAW += 90;
		if (L_YAW > 359.99)
		{
			L_YAW -= 359.99;
		}
		if ((FLIP_SPRITE))
		{
			L_YAW += 180;
			if (L_YAW > 359.99)
			{
				L_YAW -= 359.99;
			}
		}
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, L_YAW, 0));
		ClientEffect("tempent", "set_current_prop", "scale", START_SCALE);
		ClientEffect("tempent", "set_current_prop", "fuser1", START_SCALE);
	}

}

}
