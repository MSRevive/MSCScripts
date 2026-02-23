#pragma context server

namespace MS
{

class DragonIceStormCl : CGameScript
{
	int FX_ACTIVE;
	string FX_GROUND;
	string FX_ORIGIN;
	string SHARD_ORIGIN;

	DragonIceStormCl()
	{
		const int STORM_RAD = 768;
		const float MIN_SCALE = 2.0;
		const float MAX_SCALE = 3.0;
		const string SOUND_BREAK1 = "debris/glass1.wav";
		const string SOUND_BREAK2 = "debris/glass2.wav";
	}

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_ACTIVE = 1;
		FX_GROUND = FX_ORIGIN;
		FX_GROUND = "z";
		fx_loop();
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		Random(0_2, 0_5)("fx_loop");
		string L_POS = FX_ORIGIN;
		string RND_ANG = Random(0, 359.99);
		string RND_DIST = Random(0, STORM_RAD);
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, RND_DIST, 0));
		ClientEffect("tempent", "model", "glassgibs.mdl", L_POS, "setup_ice_spike");
	}

	void shard_land()
	{
		SHARD_ORIGIN = "game.tempent.origin";
		string SHARD_SIZE = "game.tempent.fuser1";
		int SHARD_VOLUME = 5;
		string RND_SOUND = RandomInt(1, 2);
		if (RND_SOUND == 1)
		{
			EmitSound3D(SOUND_BREAK1, SHARD_VOLUME, SHARD_ORIGIN);
		}
		else
		{
			if (RND_SOUND == 2)
			{
				EmitSound3D(SOUND_BREAK2, SHARD_VOLUME, SHARD_ORIGIN);
			}
		}
	}

	void setup_ice_spike()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3.0);
		ClientEffect("tempent", "set_current_prop", "body", 0);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "gravity", 1);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "cb_collide", "shard_land");
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		string RND_SCALE = Random(MIN_SCALE, MAX_SCALE);
		ClientEffect("tempent", "set_current_prop", "scale", RND_SCALE);
		ClientEffect("tempent", "set_current_prop", "fuser1", RND_SCALE);
		ClientEffect("tempent", "set_current_prop", "gravity", Random(1.0, 2.0));
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(90, 0, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(-10, -10, -200));
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(3.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

}

}
