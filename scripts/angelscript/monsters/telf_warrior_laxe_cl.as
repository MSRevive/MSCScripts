#pragma context client

namespace MS
{

class TelfWarriorLaxeCl : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string MY_OWNER;
	string WEAPON_POS;

	void client_activate()
	{
		MY_OWNER = param1;
		FX_DURATION = param2;
		FX_ACTIVE = 1;
		ClientEffect("tempent", "sprite", "3dmflaora.spr", /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0"), "setup_weapon_sprite", "update_weapon_sprite");
		FX_DURATION("end_fx");
		fx_loop();
		ClientEffect("light", "new", /* TODO: $getcl */ $getcl(MY_OWNER, "origin"), 128, Vector3(255, 255, 0), FX_DURATION);
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.05, "fx_loop");
		WEAPON_POS = /* TODO: $getcl */ $getcl(MY_OWNER, "attachment0");
		string BEAM_START = WEAPON_POS;
		string BEAM_END = BEAM_START;
		float RND_ANG = Random(0.0, 359.99);
		float RND_UD = Random(-20.0, 20.0);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, 128, RND_UD));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.1, 2, 0.1, 0.3, 0.1, 30, Vector3(2, 1.5, 0.25));
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

	void update_weapon_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "origin", WEAPON_POS);
	}

	void setup_weapon_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(254, 254, 1));
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

}

}
