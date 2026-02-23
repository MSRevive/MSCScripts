#pragma context client

namespace MS
{

class SfxBeamSparks : CGameScript
{
	string ATTACH_LOC;
	string ATTACH_NAME;
	int FX_ACTIVE;
	string FX_COLOR;
	string FX_DURATION;
	string FX_OWNER;
	string FX_TARGET;

	SfxBeamSparks()
	{
		const string SPRITE_NAME = "3dmflaora.spr";
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_TARGET = param2;
		ATTACH_NAME = "attachment";
		ATTACH_NAME += param3;
		FX_COLOR = param4;
		FX_DURATION = param5;
		FX_ACTIVE = 1;
		track_attach();
		ClientEffect("tempent", "sprite", SPRITE_NAME, ATTACH_LOC, "setup_attach_sprite", "update_attach_sprite");
		target_sprites();
		FX_DURATION("end_fx");
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

	void target_sprites()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.25, "target_sprites");
		string TARG_ORG = /* TODO: $getcl */ $getcl(FX_TARGET, "origin");
		if (!(IsValidPlayer(TARG_ORG)))
		{
			TARG_ORG += "z";
		}
		ClientEffect("tempent", "sprite", SPRITE_NAME, TARG_ORG, "setup_target_sprite");
		ClientEffect("tempent", "sprite", SPRITE_NAME, TARG_ORG, "setup_target_sprite");
		ClientEffect("tempent", "sprite", SPRITE_NAME, TARG_ORG, "setup_target_sprite");
	}

	void track_attach()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.01, "track_attach");
		ATTACH_LOC = /* TODO: $getcl */ $getcl(FX_OWNER, ATTACH_NAME);
	}

	void update_attach_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "origin", ATTACH_LOC);
	}

	void setup_attach_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", FX_COLOR);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void setup_target_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.25);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", FX_COLOR);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		string RND_ANG = Random(0, 359);
		string RND_SPEED = Random(200, 500);
		string RND_V = Random(0, 300);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, RND_ANG, 0), Vector3(0, RND_SPEED, RND_V)));
	}

}

}
