#pragma context client

namespace MS
{

class SnakeCobraBossCl : CGameScript
{
	string CLOUD_ANG;

	void client_activate()
	{
	}

	void make_cloud()
	{
		string CLOUD_ORG = param1;
		CLOUD_ANG = param2;
		ClientEffect("tempent", "sprite", "poison_cloud.spr", CLOUD_ORG, "setup_cloud");
		ClientEffect("tempent", "sprite", "poison_cloud.spr", CLOUD_ORG, "setup_cloud");
		ClientEffect("tempent", "sprite", "poison_cloud.spr", CLOUD_ORG, "setup_cloud");
	}

	void setup_cloud()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", 17);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		float RND_RL = Random(-10, 10);
		float RND_UD = Random(-220, -180);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(0, CLOUD_ANG, 0), Vector3(RND_RL, 400, RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

}

}
