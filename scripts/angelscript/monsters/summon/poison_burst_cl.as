#pragma context client

namespace MS
{

class PoisonBurstCl : CGameScript
{
	string CL_RADIUS;
	int CYCLE_ANGLE;
	string OWNER_POS;

	void client_activate()
	{
		const string FIRE_SPRITE = "poison_cloud.spr";
		const int TOTAL_OFS = 10;
		CYCLE_ANGLE = 0;
		OWNER_POS = param1;
		CL_RADIUS = param2;
		for (int i = 0; i < 17; i++)
		{
			create_flames();
		}
		ScheduleDelayedEvent(2.9, "remove_me_cl");
	}

	void remove_me_cl()
	{
		RemoveScript();
	}

	void create_flames()
	{
		string FLAME_POS = OWNER_POS;
		FLAME_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, TOTAL_OFS, 0));
		ClientEffect("tempent", "sprite", FIRE_SPRITE, FLAME_POS, "setup_flame");
		CYCLE_ANGLE += 20;
	}

	void setup_flame()
	{
		float FADE_DEL = 1.0;
		if (CL_RADIUS > 128)
		{
			float FADE_DEL = 2.0;
		}
		int SPRITE_SPEED = 100;
		if (CL_RADIUS > 128)
		{
			int SPRITE_SPEED = 400;
		}
		ClientEffect("tempent", "set_current_prop", "death_delay", FADE_DEL);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "scale", 1.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string FLAME_TURN = /* TODO: $relvel */ $relvel(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, SPRITE_SPEED, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", FLAME_TURN);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
	}

}

}
