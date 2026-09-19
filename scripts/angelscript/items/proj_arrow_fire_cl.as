#pragma context server

namespace MS
{

class ProjArrowFireCl : CGameScript
{
	int FX_ACTIVE;
	string FX_ORIGIN;
	int FX_ORIGIN_FIXED;
	string FX_OWNER;
	int FX_SMOKES_ON;
	string LIGHT_COLOR;
	int LIGHT_RADIUS;
	int N_FRAMES;
	int OWNER_TRANSFERED;
	string SKEL_LIGHT_ID;
	string SPR_FIRE;
	string SPR_SMOKE1;

	ProjArrowFireCl()
	{
		SPR_FIRE = "fire1_fixed.spr";
		SPR_SMOKE1 = "xsmoke3.spr";
		N_FRAMES = 20;
		LIGHT_RADIUS = 256;
		LIGHT_COLOR = Vector3(255, 96, 32);
	}

	void client_activate()
	{
		FX_OWNER = param1;
		LogDebug("client_activate");
		FX_ORIGIN = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		FX_ACTIVE = 1;
		SetCallback("render", "enable");
		ClientEffect("light", "new", FX_ORIGIN, LIGHT_RADIUS, LIGHT_COLOR, 5.0);
		SKEL_LIGHT_ID = "game.script.last_light_id";
		ClientEffect("tempent", "sprite", SPR_FIRE, FX_ORIGIN, "setup_fire_sprite");
		FX_SMOKES_ON = 1;
		do_smokes();
		ScheduleDelayedEvent(10.0, "end_smoke");
		ScheduleDelayedEvent(60.0, "end_fx");
	}

	void transfer_owner()
	{
		OWNER_TRANSFERED = 1;
		FX_OWNER = param1;
		FX_ORIGIN = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		owner_update();
	}

	void owner_update()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(1.0, "owner_update");
		FX_ORIGIN = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
	}

	void game_prerender()
	{
		if (!(FX_ACTIVE)) return;
		if (!(FX_ORIGIN_FIXED))
		{
			string L_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		}
		else
		{
			string L_POS = FX_ORIGIN;
		}
		if (L_POS == Vector3(0, 0, 0))
		{
			end_fx();
		}
		ClientEffect("light", SKEL_LIGHT_ID, L_POS, LIGHT_RADIUS, LIGHT_COLOR, 1.0);
	}

	void end_smoke()
	{
		FX_SMOKES_ON = 0;
		if ((OWNER_TRANSFERED)) return;
		FX_ORIGIN = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		FX_ORIGIN_FIXED = 1;
	}

	void do_smokes()
	{
		if (!(FX_SMOKES_ON)) return;
		Random(0_25, 0_5)("do_smokes");
		if (!(FX_ORIGIN_FIXED))
		{
			string L_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		}
		else
		{
			string L_POS = FX_ORIGIN;
		}
		ClientEffect("tempent", "sprite", SPR_SMOKE1, L_POS, "setup_smoke");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void setup_smoke()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "last_frame");
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", Random(100, 200));
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(-0.2, -0.01));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-5, 5), Random(-5, 5), 0));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(32, 32, 32));
		ClientEffect("tempent", "set_current_prop", "frames", N_FRAMES);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
	}

	void setup_fire_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", "die_with_ent", FX_OWNER);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 128);
		ClientEffect("tempent", "set_current_prop", "scale", 0.3);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(128, 128, 128));
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "follow", FX_OWNER, 0);
	}

	void loop_sound()
	{
		if (!(FX_ACTIVE)) return;
		EmitSound3D("items/torch1.wav", 5, FX_ORIGIN);
		ScheduleDelayedEvent(6.0, "loop_sound");
	}

}

}
