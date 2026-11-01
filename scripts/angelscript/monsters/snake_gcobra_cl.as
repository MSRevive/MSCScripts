#pragma context client

namespace MS
{

class SnakeGcobraCl : CGameScript
{
	string BREATH_SPRITE;
	string CLOUD_ANG;
	int FX_ACTIVE;
	string FX_OWNER;
	int N_FRAMES;

	SnakeGcobraCl()
	{
		BREATH_SPRITE = "poison_cloud.spr";
		N_FRAMES = 17;
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_ACTIVE = 1;
		make_clouds();
		ScheduleDelayedEvent(15.0, "end_fx");
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

	void make_clouds()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "make_clouds");
		string CLOUD_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
		CLOUD_ANG = /* TODO: $getcl */ $getcl(FX_OWNER, "angles.yaw");
		ClientEffect("tempent", "sprite", BREATH_SPRITE, CLOUD_ORG, "setup_cloud");
		ClientEffect("tempent", "sprite", BREATH_SPRITE, CLOUD_ORG, "setup_cloud");
		ClientEffect("tempent", "sprite", BREATH_SPRITE, CLOUD_ORG, "setup_cloud");
	}

	void setup_cloud()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "framerate", 10);
		ClientEffect("tempent", "set_current_prop", "frames", N_FRAMES);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0);
		ClientEffect("tempent", "set_current_prop", "scale", Random(0.5, 1.0));
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 200);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", ".005");
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		float RND_RL = Random(-10, 10);
		float RND_UD = Random(-30, 30);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(0, CLOUD_ANG, 0), Vector3(RND_RL, 400, RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

}

}
