#pragma context client

namespace MS
{

class SfxGibBurst : CGameScript
{
	string FX_AMT;
	string FX_DURATION;
	string FX_FORCE;
	string FX_MODELS;
	string FX_ORIGIN;
	string FX_RENDER_PROPS;
	string FX_SUBMODELS;

	SfxGibBurst()
	{
		const float GIB_BOUNCE_FACTOR = 1.3;
		const float GIB_GRAV = 0.7;
		const string GIB_COLLISION = "world";
		const int GIB_DIE_ON_COLLIDE = 0;
		const string GIB_RENDER_FX = "normal";
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_MODELS = param2;
		FX_SUBMODELS = param3;
		FX_RENDER_PROPS = param4;
		FX_AMT = param5;
		FX_FORCE = param6;
		FX_DURATION = param7;
		ScheduleDelayedEvent(0.01, "start_gibs");
		FX_DURATION("remove_me");
	}

	void start_gibs()
	{
		for (int i = 0; i < FX_AMT; i++)
		{
			create_gibs();
		}
	}

	void create_gibs()
	{
		ClientEffect("tempent", "model", GetRandomToken(FX_MODELS, ";"), FX_ORIGIN, "setup_gib", "update_gib");
	}

	void setup_gib()
	{
		string L_PITCH = RandomInt(0, 359);
		string L_YAW = RandomInt(0, 359);
		string L_ROLL = RandomInt(0, 359);
		Vector3 L_ANG = Vector3(L_PITCH, L_YAW, 0);
		ClientEffect("tempent", "set_current_prop", "body", GetRandomToken(FX_SUBMODELS, ";"));
		ClientEffect("tempent", "set_current_prop", "death_delay", FX_DURATION);
		if (GetToken(FX_RENDER_PROPS, 0, ";") == 1)
		{
			ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		}
		ClientEffect("tempent", "set_current_prop", "scale", GetToken(FX_RENDER_PROPS, 1, ";"));
		ClientEffect("tempent", "set_current_prop", "renderamt", GetToken(FX_RENDER_PROPS, 2, ";"));
		ClientEffect("tempent", "set_current_prop", "rendermode", GetToken(FX_RENDER_PROPS, 3, ";"));
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(RandomInt(0, 359), RandomInt(0, 90), 0), FX_FORCE));
		ClientEffect("tempent", "set_current_prop", "bouncefactor", GIB_BOUNCE_FACTOR);
		ClientEffect("tempent", "set_current_prop", "gravity", GIB_GRAV);
		ClientEffect("tempent", "set_current_prop", "renderfx", GIB_RENDER_FX);
		ClientEffect("tempent", "set_current_prop", "collide", GIB_COLLISION);
		if ((GIB_DIE_ON_COLLIDE))
		{
			ClientEffect("tempent", "set_current_prop", "collide", "die");
		}
		ClientEffect("tempent", "set_current_prop", "angles", L_ANG);
	}

	void update_gib()
	{
	}

	void remove_me()
	{
		RemoveScript();
	}

}

}
