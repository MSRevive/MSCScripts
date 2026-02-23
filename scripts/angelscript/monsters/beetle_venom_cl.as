#pragma context server

namespace MS
{

class BeetleVenomCl : CGameScript
{
	int FX_ACTIVE;
	string FX_OWNER;
	string SPRITE_NAME;

	BeetleVenomCl()
	{
		SPRITE_NAME = "poison_cloud.spr";
		const int SPRITE_NFRAMES = 17;
	}

	void client_activate()
	{
		FX_OWNER = param1;
		string FX_MAX_DURATION = param2;
		FX_ACTIVE = 1;
		fart_loop();
		FX_MAX_DURATION("remove_fx");
	}

	void remove_fx()
	{
		if (!(FX_ACTIVE)) return;
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(3.0, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
	}

	void fart_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.5, "fart_loop");
		string SPRITE_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		string OWNER_YAW = /* TODO: $getcl */ $getcl(FX_OWNER, "angles.yaw");
		SPRITE_POS += /* TODO: $relpos */ $relpos(Vector3(0, OWNER_YAW, 0), Vector3(0, -64, -32));
		ClientEffect("tempent", "sprite", SPRITE_NAME, SPRITE_POS, "setup_sprite");
	}

	void setup_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", SPRITE_NFRAMES);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.5);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

}

}
