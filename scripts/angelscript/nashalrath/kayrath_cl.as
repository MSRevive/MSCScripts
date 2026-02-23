#pragma context client

namespace MS
{

class KayrathCl : CGameScript
{
	string ATTACH_LHAND;
	string ATTACH_RHAND;
	int FX_ACTIVE;
	string FX_DURATION;
	string MY_OWNER;
	string OWNER_ANGLES;
	string SPRAY_TYPE;

	KayrathCl()
	{
		const string POISON_SPRITE = "poison_cloud.spr";
		const string FIRE_SPRITE = "explode1.spr";
		const int FIRE_SPRITE_NFRAMES = 9;
		const int POISON_SPRITE_NFRAMES = 17;
		const string SOURCE_SPRITE = "3dmflaora.spr";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.01);
		if ((FX_ACIVE))
		{
		}
		ATTACH_RHAND = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment1");
		ATTACH_LHAND = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment2");
	}

	void client_activate()
	{
		MY_OWNER = param1;
		SPRAY_TYPE = param2;
		FX_DURATION = param3;
		FX_ACTIVE = 1;
		spray_loop();
		FX_DURATION("end_fx");
		LogDebug("**** Owner MY_OWNER type SPRAY_TYPE durat FX_DURATION");
		SetCallback("render", "enable");
		ATTACH_RHAND = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment1");
		ATTACH_LHAND = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment2");
		if (SPRAY_TYPE == 1)
		{
			ClientEffect("tempent", "sprite", SOURCE_SPRITE, ATTACH_RHAND, "setup_fire_source", "update_source_rhand");
			ClientEffect("tempent", "sprite", SOURCE_SPRITE, ATTACH_LHAND, "setup_fire_source", "update_source_lhand");
			ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), 512, Vector3(255, 128, 64), FX_DURATION);
		}
		else
		{
			ClientEffect("tempent", "sprite", SOURCE_SPRITE, ATTACH_RHAND, "setup_poison_source", "update_source_rhand");
			ClientEffect("tempent", "sprite", SOURCE_SPRITE, ATTACH_LHAND, "setup_poison_source", "update_source_lhand");
			ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), 512, Vector3(0, 255, 0), FX_DURATION);
		}
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void spray_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "spray_loop");
		OWNER_ANGLES = /* TODO: $getcl */ $getcl(MY_OWNER, "angles");
		if (SPRAY_TYPE == 1)
		{
			ClientEffect("tempent", "sprite", FIRE_SPRITE, ATTACH_RHAND, "setup_fire_sprite", "update_spray_sprite");
			ClientEffect("tempent", "sprite", FIRE_SPRITE, ATTACH_LHAND, "setup_fire_sprite", "update_spray_sprite");
		}
		else
		{
			ClientEffect("tempent", "sprite", POISON_SPRITE, ATTACH_RHAND, "setup_poison_sprite", "update_spray_sprite");
			ClientEffect("tempent", "sprite", POISON_SPRITE, ATTACH_LHAND, "setup_poison_sprite", "update_spray_sprite");
		}
	}

	void setup_poison_source()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", 5);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
	}

	void setup_fire_source()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
	}

	void update_source_rhand()
	{
		ClientEffect("tempent", "set_current_prop", "origin", ATTACH_RHAND);
		ClientEffect("tempent", "set_current_prop", "origin", ATTACH_LHAND);
	}

	void setup_poison_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3.0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.25);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", POISON_SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(OWNER_ANGLES, Vector3(0, 300, 0)));
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.25);
	}

	void setup_fire_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3.0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.3);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", FIRE_SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(OWNER_ANGLES, Vector3(0, 300, 0)));
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.3);
	}

	void update_spray_sprite()
	{
		string CUR_SCALE = "game.tempent.fuser1";
		CUR_SCALE += 0.02;
		ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
		ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
	}

}

}
