#pragma context client

namespace MS
{

class IceBurstCl : CGameScript
{
	int CYCLE_ANGLE;
	string OWNER_POS;

	void client_activate()
	{
		const string ICE_SPRITE = "fire1_fixed.spr";
		const int TOTAL_OFS = 10;
		CYCLE_ANGLE = 0;
		OWNER_POS = /* TODO: $getcl */ $getcl(param1, "origin");
		for (int i = 0; i < 17; i++)
		{
			create_ice();
		}
		ScheduleDelayedEvent(2.9, "remove_me_cl");
		EmitSound3D("ambience/steamburst1.wav", 10, OWNER_POS);
	}

	void remove_me_cl()
	{
		RemoveScript();
	}

	void create_ice()
	{
		string ICE_POS = OWNER_POS;
		ICE_POS += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, TOTAL_OFS, 0));
		ClientEffect("tempent", "sprite", ICE_SPRITE, ICE_POS, "setup_ice");
		CYCLE_ANGLE += 20;
	}

	void setup_ice()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 2.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 23);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		string ICE_TURN = /* TODO: $relvel */ $relvel(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, 100, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", ICE_TURN);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 255));
	}

}

}
