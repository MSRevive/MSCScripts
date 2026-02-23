#pragma context client

namespace MS
{

class GuardianIronCl : CGameScript
{
	string BURST_TYPE;
	int CHARGER_ON;
	int CYCLE_ANGLE;
	int FLICKER_COUNT;
	int FX_ACTIVE;
	string FX_CHARGER_ORG;
	string FX_OWNER;
	string FX_REINIT;
	string FX_SWORD_STATE;
	int GRAB_SPRITE_ON;
	string GRAB_TARG;
	string GRAB_TARG_ORG;
	string LHAND_ORG;
	string PASSIVE_LIGHT_ID;
	string RHAND_ORG;
	float SPIT_SPRITE_DEATH_DELAY;
	string STOMP_ORG;
	string SWORD_LIGHT_ID;
	int SWORD_ON;
	string SWORD_ORG;

	GuardianIronCl()
	{
		const Vector3 PASSIVE_GLOW_COLOR = Vector3(128, 128, 128);
		const int PASSIVE_GLOW_RAD = 64;
		const int SWORD_GLOW_RAD = 128;
		const Vector3 SWORD_GLOW_COLOR = Vector3(128, 128, 255);
		const int CHARGER_GLOW_RAD = 640;
		const Vector3 CHARGER_GLOW_COLOR = Vector3(196, 196, 255);
		const string CHARGER_SPRITE = "c-tele1.spr";
		const int CHARGER_SPRITE_NFRAMES = 25;
		const string SWORD_SPRITE = "flare1.spr";
		const string SWORD_HILT_INDEX = "attachment0";
		const string SWORD_TIP_INDEX = "attachment1";
		const string RHAND_INDEX = "attachment2";
		const string LHAND_INDEX = "attachment3";
		const string SOUND_CHARGER = "magic/blackhole.wav";
		const string SOUND_ZAP = "magic/bolt_end.wav";
		const string SOUND_STOMP = "magic/boom.wav";
		const string STOMP_SPRITE = "fire1_fixed.spr";
		Precache(CHARGER_SPRITE);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.01);
		SWORD_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, SWORD_HILT_INDEX);
		RHAND_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, RHAND_INDEX);
		LHAND_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, LHAND_INDEX);
		if ((GRAB_SPRITE_ON))
		{
		}
		GRAB_TARG_ORG = /* TODO: $getcl */ $getcl(GRAB_TARG, "origin");
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_REINIT = param2;
		FX_SWORD_STATE = param3;
		SetCallback("render", "enable");
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), PASSIVE_GLOW_RAD, PASSIVE_GLOW_COLOR, 1.0);
		PASSIVE_LIGHT_ID = "game.script.last_light_id";
		if (!(FX_REINIT)) return;
		if (!(FX_SWORD_STATE)) return;
		sword_on();
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void game_prerender()
	{
		if (!(/* TODO: $getcl */ $getcl(FX_OWNER, "exists")))
		{
			remove_fx();
		}
		else
		{
			ClientEffect("light", PASSIVE_LIGHT_ID, /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), PASSIVE_GLOW_RAD, PASSIVE_GLOW_COLOR, 1.0);
			if ((SWORD_ON))
			{
			}
			ClientEffect("light", SWORD_LIGHT_ID, SWORD_ORG, SWORD_GLOW_RAD, SWORD_GLOW_COLOR, 0.5);
			if ((GRAB_SPRITE_ON))
			{
			}
			string BEAM_START = /* TODO: $getcl */ $getcl(FX_OWNER, LHAND_INDEX);
			string RND_BONE = RandomInt(0, 15);
			string BEAM_END = /* TODO: $getcl */ $getcl(GRAB_TARG, "origin");
			ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.1, 5.0, 1.5, 255, 50, 30, Vector3(255, 255, 255));
		}
	}

	void sword_on()
	{
		SWORD_ON = 1;
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(FX_OWNER, SWORD_HILT_INDEX), SWORD_GLOW_RAD, SWORD_GLOW_COLOR, 1.0);
		SWORD_LIGHT_ID = "game.script.last_light_id";
		if (!(param1)) return;
		ClientEffect("tempent", "sprite", SWORD_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, SWORD_HILT_INDEX), "setup_sword_sprite");
		ClientEffect("tempent", "sprite", SWORD_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, SWORD_HILT_INDEX), "setup_sword_sprite");
		ClientEffect("tempent", "sprite", SWORD_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, SWORD_HILT_INDEX), "setup_sword_sprite");
		ClientEffect("tempent", "sprite", SWORD_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, SWORD_HILT_INDEX), "setup_sword_sprite");
		ClientEffect("tempent", "sprite", SWORD_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, SWORD_TIP_INDEX), "setup_sword_sprite");
		ClientEffect("tempent", "sprite", SWORD_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, SWORD_TIP_INDEX), "setup_sword_sprite");
		ClientEffect("tempent", "sprite", SWORD_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, SWORD_TIP_INDEX), "setup_sword_sprite");
	}

	void sword_flicker_out()
	{
		FLICKER_COUNT = 10;
		sword_flicker_loop();
	}

	void sword_flicker_loop()
	{
		FLICKER_COUNT -= 1;
		if (FLICKER_COUNT == 1)
		{
			SWORD_ON = 0;
		}
		if (!(FLICKER_COUNT > 1)) return;
		ScheduleDelayedEvent(0.1, "sword_flicker_loop");
		SWORD_ON = RandomInt(0, 1);
	}

	void recharge_fx()
	{
		FX_CHARGER_ORG = param1;
		ClientEffect("tempent", "sprite", CHARGER_SPRITE, FX_CHARGER_ORG, "setup_charger_sprite");
		ClientEffect("tempent", "sprite", CHARGER_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, RHAND_INDEX), "setup_charger_lhand_sprite", "update_lhand_sprite");
		ClientEffect("tempent", "sprite", CHARGER_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, LHAND_INDEX), "setup_charger_rhand_sprite", "update_rhand_sprite");
		EmitSound3D(SOUND_CHARGER, 10, FX_CHARGER_ORG);
		CHARGER_ON = 1;
		ClientEffect("light", "new", FX_CHARGER_ORG, CHARGER_GLOW_RAD, CHARGER_GLOW_COLOR, 8.0);
		ScheduleDelayedEvent(8.0, "end_charger_fx");
		SPIT_SPRITE_DEATH_DELAY = 10.0;
		ScheduleDelayedEvent(1.0, "recharge_fx_spit_sprite");
		SPIT_SPRITE_DEATH_DELAY -= 1.0;
		ScheduleDelayedEvent(2.0, "recharge_fx_spit_sprite");
		SPIT_SPRITE_DEATH_DELAY -= 1.0;
		ScheduleDelayedEvent(3.0, "recharge_fx_spit_sprite");
		SPIT_SPRITE_DEATH_DELAY -= 1.0;
		ScheduleDelayedEvent(4.0, "recharge_fx_spit_sprite");
		SPIT_SPRITE_DEATH_DELAY -= 1.0;
		ScheduleDelayedEvent(5.0, "recharge_fx_spit_sprite");
		charger_fx_loop();
	}

	void end_charger_fx()
	{
		CHARGER_ON = 0;
	}

	void charger_fx_loop()
	{
		if (!(CHARGER_ON)) return;
		ScheduleDelayedEvent(0.1, "charger_fx_loop");
		string BEAM_START = FX_CHARGER_ORG;
		string BEAM_END = /* TODO: $getcl */ $getcl(FX_OWNER, RHAND_INDEX);
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.1, 10.0, 0.5, 255, 50, 30, Vector3(60, 60, 255));
		string BEAM_START = FX_CHARGER_ORG;
		string BEAM_END = /* TODO: $getcl */ $getcl(FX_OWNER, LHAND_INDEX);
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.1, 10.0, 0.5, 255, 50, 30, Vector3(60, 60, 255));
	}

	void recharge_fx_spit_sprite()
	{
		EmitSound3D(SOUND_CHARGER, 10, FX_CHARGER_ORG);
		ClientEffect("tempent", "sprite", CHARGER_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), "setup_spit_sprite", "update_spit_sprite");
	}

	void grab_sprite_on()
	{
		ClientEffect("tempent", "sprite", CHARGER_SPRITE, /* TODO: $getcl */ $getcl(FX_OWNER, LHAND_INDEX), "setup_grab_sprite", "update_grab_sprite");
	}

	void grab_fx()
	{
		GRAB_SPRITE_ON = 1;
		GRAB_TARG = param1;
		EmitSound3D(SOUND_ZAP, 10, /* TODO: $getcl */ $getcl(GRAB_TARG, "origin"));
		ClientEffect("tempent", "sprite", SWORD_SPRITE, /* TODO: $getcl */ $getcl(GRAB_TARG, "origin"), "setup_grab_targ_sprite", "update_grab_targ_sprite");
		ScheduleDelayedEvent(1.0, "grab_fx_off");
	}

	void grab_fx_off()
	{
		GRAB_SPRITE_ON = 0;
	}

	void stomp_fx()
	{
		STOMP_ORG = param1;
		CYCLE_ANGLE = 0;
		BURST_TYPE = "stomp";
		EmitSound3D(SOUND_STOMP, 10, STOMP_ORG);
		for (int i = 0; i < 17; i++)
		{
			make_stomp_flames();
		}
	}

	void smash_fx()
	{
		STOMP_ORG = param1;
		CYCLE_ANGLE = 0;
		BURST_TYPE = "smash";
		EmitSound3D(SOUND_STOMP, 10, STOMP_ORG);
		for (int i = 0; i < 17; i++)
		{
			make_stomp_flames();
		}
		LogDebug("*** smash_fx STOMP_ORG");
	}

	void make_stomp_flames()
	{
		string FLAME_POS = STOMP_ORG;
		FLAME_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, 10, 0));
		ClientEffect("tempent", "sprite", STOMP_SPRITE, FLAME_POS, "setup_stomp_sprite");
		CYCLE_ANGLE += 20;
	}

	void update_grab_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "origin", LHAND_ORG);
	}

	void update_grab_targ_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "origin", GRAB_TARG_ORG);
	}

	void update_spit_sprite()
	{
		string ROTATE_CYCLE = "game.tempent.fuser1";
		string RAISE_CYCLE = "game.tempent.fuser2";
		ROTATE_CYCLE += 5;
		if (ROTATE_CYCLE > 359.99)
		{
			int ROTATE_CYCLE = 0;
		}
		RAISE_CYCLE += 0.5;
		string SPRITE_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		SPRITE_ORG += /* TODO: $relpos */ $relpos(Vector3(0, ROTATE_CYCLE, 0), Vector3(0, 50, RAISE_CYCLE));
		ClientEffect("tempent", "set_current_prop", "origin", SPRITE_ORG);
		ClientEffect("tempent", "set_current_prop", "fuser1", ROTATE_CYCLE);
		ClientEffect("tempent", "set_current_prop", "fuser2", RAISE_CYCLE);
		if (!(CHARGER_ON)) return;
		if (!(RandomInt(1, 20) == 1)) return;
		string BEAM_START = FX_CHARGER_ORG;
		string BEAM_END = SPRITE_ORG;
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.1, 2.0, 2.0, 255, 50, 30, Vector3(60, 60, 255));
	}

	void update_rhand_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "origin", RHAND_ORG);
	}

	void update_lhand_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "origin", LHAND_ORG);
	}

	void setup_stomp_sprite()
	{
		if (BURST_TYPE == "stomp")
		{
			float FADE_DEL = 1.5;
			int SPRITE_SPEED = 150;
		}
		else
		{
			float FADE_DEL = 1.0;
			int SPRITE_SPEED = 100;
		}
		ClientEffect("tempent", "set_current_prop", "death_delay", FADE_DEL);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string FLAME_TURN = /* TODO: $relvel */ $relvel(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, SPRITE_SPEED, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", FLAME_TURN);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

	void setup_grab_targ_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 128, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 3.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
	}

	void setup_charger_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 8.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 128, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", CHARGER_SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
	}

	void setup_grab_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 4.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", CHARGER_SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
	}

	void setup_charger_lhand_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 8.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 128, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", CHARGER_SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
	}

	void setup_charger_rhand_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 8.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 128, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", CHARGER_SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
	}

	void setup_spit_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", SPIT_SPRITE_DEATH_DELAY);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(64, 64, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", CHARGER_SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", 0.3);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "fuser1", 0);
		ClientEffect("tempent", "set_current_prop", "fuser2", 0);
	}

	void setup_sword_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 128, 255));
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		string RND_ANG = Random(0, 359);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, RND_ANG, 0), Vector3(0, 30, -50)));
		ClientEffect("tempent", "set_current_prop", "collide", "world");
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 1);
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

}

}
