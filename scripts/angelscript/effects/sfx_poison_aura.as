#pragma context client

namespace MS
{

class SfxPoisonAura : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_RAD;
	string FX_RAD_NEG;
	string GLOW_COLOR;
	string GLOW_RAD;
	string LIGHT_ID;
	string MY_OWNER;

	SfxPoisonAura()
	{
		GLOW_COLOR = Vector3(0, 255, 0);
	}

	void client_activate()
	{
		MY_OWNER = param1;
		FX_RAD = param2;
		FX_RAD_NEG = /* TODO: $neg */ $neg(FX_RAD);
		FX_DURATION = param3;
		GLOW_RAD = FX_RAD;
		if ((/* TODO: $getcl */ $getcl(MY_OWNER, "isplayer")))
		{
			GLOW_RAD *= 2.5;
		}
		else
		{
			GLOW_RAD *= 1.5;
		}
		SetCallback("render", "enable");
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), GLOW_RAD, GLOW_COLOR, 1.0);
		LIGHT_ID = "game.script.last_light_id";
		FX_ACTIVE = 1;
		FX_DURATION("end_fx");
		fx_loop();
	}

	void game_prerender()
	{
		if (!(/* TODO: $getcl */ $getcl(MY_OWNER, "exists"))) return;
		string L_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		if ((/* TODO: $getcl */ $getcl(MY_OWNER, "isplayer")))
		{
			L_POS += "z";
		}
		ClientEffect("light", LIGHT_ID, L_POS, GLOW_RAD, GLOW_COLOR, 1.0);
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.25, "fx_loop");
		string C_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "origin");
		if ((/* TODO: $getcl */ $getcl(MY_OWNER, "isplayer")))
		{
			C_POS += "z";
		}
		string L_POS = C_POS;
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359), 0), Vector3(0, Random(FX_RAD_NEG, FX_RAD), 0));
		ClientEffect("tempent", "sprite", "poison_cloud.spr", L_POS, "setup_smokes");
		string L_POS = C_POS;
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359), 0), Vector3(0, Random(FX_RAD_NEG, FX_RAD), 0));
		ClientEffect("tempent", "sprite", "poison_cloud.spr", L_POS, "setup_smokes");
		string L_POS = C_POS;
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359), 0), Vector3(0, Random(FX_RAD_NEG, FX_RAD), 0));
		ClientEffect("tempent", "sprite", "poison_cloud.spr", L_POS, "setup_smokes");
	}

	void setup_smokes()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "world");
	}

}

}
