#pragma context server

namespace MS
{

class OrcSummonerSlaughterCl : CGameScript
{
	string ATTACH_POS;
	string FINAL_ORG;
	int FINAL_ORG_SET;
	string FLING_VEL;
	int FX_ACTIVE;
	string FX_OWNER;
	int FX_STAGE;
	string MAX_Z;

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.1);
		ATTACH_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		if ((ATTACH_POS).z < MAX_Z)
		{
			ATTACH_POS = "z";
		}
		if (FX_STAGE == 1)
		{
			string BLOOD_POS = ATTACH_POS;
			BLOOD_POS += "z";
			ClientEffect("tempent", "sprite", "bloodspray.spr", BLOOD_POS, "setup_blood_spray");
		}
	}

	void client_activate()
	{
		FX_OWNER = param1;
		MAX_Z = /* TODO: $getcl */ $getcl(param1, "origin");
		MAX_Z = (MAX_Z).z;
		FX_ACTIVE = 1;
		FX_STAGE = 1;
		ATTACH_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		if ((ATTACH_POS).z < MAX_Z)
		{
			ATTACH_POS = "z";
		}
		ClientEffect("tempent", "model", "monsters/Orc.mdl", ATTACH_POS, "setup_orc_corpse", "update_orc_corpse");
		SetCallback("render", "enable");
	}

	void update_orc_corpse()
	{
		if (!(FX_ACTIVE)) return;
		if (FX_STAGE == 1)
		{
			ClientEffect("tempent", "set_current_prop", "origin", ATTACH_POS);
		}
		if (FX_STAGE == 2)
		{
			ClientEffect("tempent", "set_current_prop", "collide", "world");
			ClientEffect("tempent", "set_current_prop", "cb_collide", "collide_corpse");
			ClientEffect("tempent", "set_current_prop", "velocity", FLING_VEL);
			FX_STAGE = 3;
		}
		if (!(FINAL_ORG_SET)) return;
		ClientEffect("tempent", "set_current_prop", "origin", FINAL_ORG);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
	}

	void collide_corpse()
	{
		LogDebug("***** collide_corpse game.tempent.origin");
		if ((FINAL_ORG_SET)) return;
		FINAL_ORG = "game.tempent.origin";
		FINAL_ORG += "z";
		FINAL_ORG_SET = 1;
		ClientEffect("tempent", "set_current_prop", "origin", FINAL_ORG);
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
	}

	void do_fling()
	{
		FX_STAGE = 2;
		FLING_VEL = param1;
		ScheduleDelayedEvent(10.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_orc_corpse()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 30.0);
		ClientEffect("tempent", "set_current_prop", "body", 16);
		ClientEffect("tempent", "set_current_prop", "skin", 2);
		ClientEffect("tempent", "set_current_prop", "framerate", 1);
		ClientEffect("tempent", "set_current_prop", "frames", 44);
		ClientEffect("tempent", "set_current_prop", "sequence", 6);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", -20);
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "scale", 1);
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void setup_blood_spray()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", Random(1, 2));
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 10);
		ClientEffect("tempent", "set_current_prop", "rendermode", "alpha");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.1, 1.0));
		float RND_UP = Random(50, 100);
		float RND_ANG = Random(0, 359.99);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, 0, RND_UP)));
	}

}

}
