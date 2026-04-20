#pragma context client

namespace MS
{

class SfxBeamCage : CGameScript
{
	string COIL_DURATION;
	string COIL_HEIGHT;
	string COIL_POS;
	string COIL_START_TIME;
	string COIL_WIDTH;
	string COIL_WIDTH_MAX;
	string COIL_WIDTH_MIN;
	string COIL_Z_MAX;
	string COIL_Z_START;
	float ROCK_CLIMB_STEP;
	int ROT_COUNT;

	SfxBeamCage()
	{
		ROCK_CLIMB_STEP = 1.0;
	}

	void client_activate()
	{
		string L_WIDTH = /* TODO: $getcl */ $getcl(param1, "width");
		string L_HEIGHT = /* TODO: $getcl */ $getcl(param1, "height");
		COIL_POS = /* TODO: $getcl */ $getcl(param1, "origin");
		if ((/* TODO: $getcl */ $getcl(param1, "isplayer")))
		{
			COIL_POS += "z";
		}
		COIL_DURATION = param2;
		ROT_COUNT = 0;
		COIL_WIDTH = (L_WIDTH * 0.75);
		COIL_WIDTH_MIN = (L_WIDTH * 0.4);
		COIL_WIDTH_MAX = COIL_WIDTH;
		COIL_HEIGHT = L_HEIGHT;
		COIL_Z_START = (COIL_POS).z;
		COIL_Z_MAX = COIL_Z_START;
		COIL_Z_MAX += COIL_HEIGHT;
		LogDebug("*** $currentscript client_activate COIL_POS w COIL_WIDTH h COIL_HEIGHT zm COIL_Z_MAX");
		if (COIL_HEIGHT > 96)
		{
			if (COIL_HEIGHT > 200)
			{
				COIL_HEIGHT = 200;
			}
			string L_MAX_HEIGHT_RATIO = (COIL_HEIGHT / 200);
			ROCK_CLIMB_STEP += /* TODO: $ratio */ $ratio(L_MAX_HEIGHT_RATIO, 0.2, 2.0);
		}
		COIL_START_TIME = GetGameTime();
		for (int i = 0; i < 100; i++)
		{
			draw_coil_loop();
		}
		COIL_DURATION("end_fx");
	}

	void draw_coil_loop()
	{
		string L_COIL_CUR_Z = (COIL_POS).z;
		if (!(L_COIL_CUR_Z < COIL_Z_MAX)) return;
		string L_COMP_RATIO_MAX = (COIL_Z_MAX - COIL_Z_START);
		string L_COMP_RATIO_CUR = (COIL_Z_MAX - L_COIL_CUR_Z);
		string L_COMP_RATIO = (L_COMP_RATIO_CUR / L_COMP_RATIO_MAX);
		COIL_WIDTH = /* TODO: $ratio */ $ratio(L_COMP_RATIO, COIL_WIDTH_MIN, COIL_WIDTH_MAX);
		string BEAM_START = COIL_POS;
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, ROT_COUNT, 0), Vector3(0, COIL_WIDTH, 0));
		COIL_POS += "z";
		ROT_COUNT += 20;
		if (ROT_COUNT > 359)
		{
			ROT_COUNT -= 359;
		}
		string BEAM_END = COIL_POS;
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, ROT_COUNT, 0), Vector3(0, COIL_WIDTH, 0));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", COIL_DURATION, 2, 0.1, 0.9, 0.1, 30, Vector3(255, 255, 255));
	}

	void end_fx()
	{
		ScheduleDelayedEvent(5.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

}

}
