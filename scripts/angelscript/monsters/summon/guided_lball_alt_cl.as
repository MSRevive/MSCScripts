#pragma context client

namespace MS
{

class GuidedLballAltCl : CGameScript
{
	int CYCLE_ANGLE;
	string MY_ORG;
	string MY_RADIUS;

	GuidedLballAltCl()
	{
		const string SOUND_KABOOM = "weapons/explode3.wav";
	}

	void client_activate()
	{
		MY_ORG = param1;
		MY_RADIUS = param2;
		MY_RADIUS /= 2;
		CYCLE_ANGLE = 0;
		for (int i = 0; i < 18; i++)
		{
			splodie_beams();
		}
		ball_end();
		EmitSound3D(SOUND_KABOOM, 10, MY_ORG);
		ScheduleDelayedEvent(2.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void splodie_beams()
	{
		string BEAM_START = MY_ORG;
		string BEAM_END = BEAM_START;
		string RND_UD = Random(-64.0, 64.0);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, CYCLE_ANGLE, 0), Vector3(0, MY_RADIUS, RND_UD));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 1.5, 2.5, 1.5, 255, 50, 30, Vector3(255, 255, 0));
		CYCLE_ANGLE += 20;
	}

}

}
