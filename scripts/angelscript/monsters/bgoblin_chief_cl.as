#pragma context client

namespace MS
{

class BgoblinChiefCl : CGameScript
{
	string CLOUD_ANG;
	string FLAME_SPRITE;
	int FX_ACTIVE;
	string FX_OWNER;
	int N_FRAMES;

	BgoblinChiefCl()
	{
		FLAME_SPRITE = "explode1.spr";
		N_FRAMES = 9;
	}

	void client_activate()
	{
		FX_OWNER = param1;
		FX_ACTIVE = 1;
		breath_loop();
		ScheduleDelayedEvent(20.0, "end_fx");
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void breath_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "breath_loop");
		string CLOUD_ORG = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment2");
		CLOUD_ANG = /* TODO: $getcl */ $getcl(FX_OWNER, "angles.yaw");
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
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		float RND_RL = Random(-20, 20);
		float RND_UD = Random(-20, 20);
		string CLOUD_VEL = /* TODO: $relvel */ $relvel(Vector3(0, CLOUD_ANG, 0), Vector3(RND_RL, Random(300, 400), RND_UD));
		ClientEffect("tempent", "set_current_prop", "velocity", CLOUD_VEL);
	}

}

}
