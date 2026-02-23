#pragma context client

namespace MS
{

class SfxIcecage : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_OWNER;

	void client_activate()
	{
		FX_OWNER = param1;
		FX_DURATION = param2;
		FX_ACTIVE = 1;
		LogDebug("**** sfx_icecage FX_OWNER FX_DURATION");
		ClientEffect("tempent", "sprite", "misc/treasure.mdl", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), "setup_icecage", "update_icecage");
		FX_DURATION("end_cage_fx");
	}

	void end_cage_fx()
	{
		LogDebug("**** end_fx");
		EmitSound3D("debris/bustglass2.wav", 5, /* TODO: $getcl */ $getcl(FX_OWNER, "origin"));
		for (int i = 0; i < RandomInt(8, 10); i++)
		{
			do_gibs();
		}
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.1, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void do_gibs()
	{
		string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		if (!(/* TODO: $getcl */ $getcl(FX_OWNER, "isplayer")))
		{
			SPR_POS += "z";
		}
		ClientEffect("tempent", "sprite", "glassgibs.mdl", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), "setup_gibs");
	}

	void update_icecage()
	{
		if ((FX_ACTIVE))
		{
			string CAGE_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
			if ((/* TODO: $getcl */ $getcl(FX_OWNER, "isplayer")))
			{
				CAGE_ORG += "z";
			}
			if (/* TODO: $get_contents */ $get_contents(CAGE_ORG) != "empty")
			{
				CAGE_ORG += "z";
			}
			ClientEffect("tempent", "set_current_prop", "origin", CAGE_ORG);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "rendermode", 5);
			ClientEffect("tempent", "set_current_prop", "renderamt", 0);
			ClientEffect("tempent", "set_current_prop", "death_delay", /* TODO: $neg */ $neg(FX_DURATION));
			ClientEffect("tempent", "set_current_prop", "fadeout", 0);
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(10000, 10000, 10000));
		}
	}

	void setup_icecage()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "body", 4);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "scale", 1);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		string FADE_TIME = FX_DURATION;
		FADE_TIME += 5.0;
		ClientEffect("tempent", "set_current_prop", "fadeout", FADE_TIME);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, 90, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "movetype", 0);
	}

	void setup_gibs()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "body", RandomInt(0, 6));
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.75, 1.25));
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 1);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(RandomInt(0, 359), RandomInt(0, 359), 0));
		string RND_ANG = Random(0, 359.99);
		string RND_SPRING = Random(150, 350);
		string RND_SWING = Random(-100, 100);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, RND_ANG, 0), Vector3(RND_SWING, 0, RND_SPRING)));
	}

}

}
