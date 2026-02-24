#pragma context client

namespace MS
{

class AxesDragonCl : CGameScript
{
	string CLOUD_ANG;
	string FLAME_SPRITE;
	int N_FRAMES;

	AxesDragonCl()
	{
		FLAME_SPRITE = "explode1.spr";
		N_FRAMES = 9;
	}

	void client_activate()
	{
	}

	void make_clouds()
	{
		string CLOUD_ORG = param1;
		CLOUD_ANG = param2;
		ClientEffect("tempent", "sprite", FLAME_SPRITE, CLOUD_ORG, "setup_cloud");
		ClientEffect("tempent", "sprite", FLAME_SPRITE, CLOUD_ORG, "setup_cloud");
		ClientEffect("tempent", "sprite", FLAME_SPRITE, CLOUD_ORG, "setup_cloud");
	}

	void setup_cloud()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", N_FRAME);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.5, 1.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "all;die");
		float RND_RL = Random(-20, 20);
		float RND_UD = Random(-20, 20);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(CLOUD_ANG, Vector3(RND_RL, Random(300, 400), RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

	void end_fx()
	{
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

}

}
