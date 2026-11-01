#pragma context server

namespace MS
{

class SfxZapAura : CGameScript
{
	int FX_ACTIVE;
	string FX_DURATION;
	string FX_OWNER;
	string FX_RADIUS;

	void client_activate()
	{
		FX_OWNER = param1;
		FX_RADIUS = param2;
		FX_DURATION = param3;
		FX_ACTIVE = 1;
		FX_DURATION("end_fx");
		fx_loop();
	}

	void fx_loop()
	{
		if (!(FX_ACTIVE)) return;
		ScheduleDelayedEvent(0.25, "fx_loop");
		string BEAM_START = /* TODO: $getcl */ $getcl(FX_OWNER, "origin");
		if (!(/* TODO: $getcl */ $getcl(FX_OWNER, "isplayer")))
		{
			BEAM_START += "z";
		}
		string BEAM_END = BEAM_START;
		float RND_ANG = Random(0, 359.99);
		float V_ADJ = Random(-24.0, 24.0);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, FX_RADIUS, V_ADJ));
		string L_BEAM_START = BEAM_START;
		L_BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, 16, 0));
		ClientEffect("beam_points", L_BEAM_START, BEAM_END, "lgtning.spr", 1.0, 1, 1, 255, 255, 30, Vector3(255, 64, 0));
		string BEAM_END = BEAM_START;
		float RND_ANG = Random(0, 359.99);
		float V_ADJ = Random(-24.0, 24.0);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, FX_RADIUS, V_ADJ));
		string L_BEAM_START = BEAM_START;
		L_BEAM_START += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, 16, 0));
		ClientEffect("beam_points", L_BEAM_START, BEAM_END, "lgtning.spr", 1.0, 1, 1, 255, 255, 30, Vector3(255, 64, 0));
	}

	void end_fx()
	{
		if (!(FX_ACTIVE)) return;
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.1, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

}

}
