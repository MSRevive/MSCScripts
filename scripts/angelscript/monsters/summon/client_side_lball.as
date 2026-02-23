#pragma context client

namespace MS
{

class ClientSideLball : CGameScript
{
	string BALL_DURATION;
	int CYCLE_ANGLE;
	string FB_ORG;
	int IS_ACTIVE;
	string IS_DESTROYED;
	string START_ANG;
	string VEL_ANGLES;

	ClientSideLball()
	{
		const int BALL_SPEED = 120;
		const string BALL_MODEL = "weapons/projectiles.mdl";
		const int BALL_MODEL_OFS = 18;
		const string SOUND_KABOOM = "weapons/explode3.wav";
		const string SOUND_LOOP = "items/torch1.wav";
		const float FREQ_LOOP_SOUND = 6.1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_LOOP_SOUND);
		EmitSound3D(SOUND_LOOP, 10, FB_ORG);
	}

	void client_activate()
	{
		LogDebug("**** PARAM1 PARAM2");
		string MY_ORG = param1;
		START_ANG = param2;
		VEL_ANGLES = START_ANG;
		BALL_DURATION = param3;
		IS_ACTIVE = 1;
		ClientEffect("tempent", "model", BALL_MODEL, MY_ORG, "setup_ball", "update_ball");
		EmitSound3D(SOUND_LOOP, 10, MY_ORG);
		string L_BALL_DURATION = BALL_DURATION;
		L_BALL_DURATION += 1.0;
		L_BALL_DURATION("ball_end");
	}

	void update_ball()
	{
		if (!(IS_ACTIVE))
		{
			if (!(IS_DESTROYED))
			{
			}
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.1);
			IS_DESTROYED = 1;
		}
		if (!(IS_ACTIVE)) return;
		FB_ORG = "game.tempent.origin";
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(VEL_ANGLES, Vector3(0, BALL_SPEED, 0)));
	}

	void setup_ball()
	{
		ClientEffect("tempent", "set_current_prop", "body", 17);
		ClientEffect("tempent", "set_current_prop", "death_delay", BALL_DURATION);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(START_ANG, Vector3(0, BALL_SPEED, 0)));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "sequence", 6);
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void ball_explode()
	{
		IS_ACTIVE = 0;
		CYCLE_ANGLE = 0;
		for (int i = 0; i < 18; i++)
		{
			splodie_beams();
		}
		ball_end();
		EmitSound3D(SOUND_KABOOM, 10, FB_ORG);
	}

	void splodie_beams()
	{
		string BEAM_START = FB_ORG;
		string BEAM_END = BEAM_START;
		string RND_UD = Random(-64.0, 64.0);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, 128, RND_UD));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 1.5, 2.5, 1.5, 255, 50, 30, Vector3(255, 255, 0));
		CYCLE_ANGLE += 20;
	}

	void svr_update_vec()
	{
		VEL_ANGLES = param1;
	}

	void ball_end()
	{
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "end_effect");
	}

	void end_effect()
	{
		RemoveScript();
	}

}

}
