#pragma context client

namespace MS
{

class SfxMultiLightning : CGameScript
{
	string ZAP_LIST;

	SfxMultiLightning()
	{
		const string SOUND_THUNDER = "weather/lightning.wav";
	}

	void client_activate()
	{
		ZAP_LIST = param1;
		for (int i = 0; i < GetTokenCount(ZAP_LIST, ";"); i++)
		{
			zap_target();
		}
		ScheduleDelayedEvent(5.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void zap_target()
	{
		string CUR_TARG = GetToken(ZAP_LIST, i, ";");
		string BEAM_START = /* TODO: $getcl */ $getcl(CUR_TARG, "origin");
		BEAM_START = "z";
		ClientEffect("light", "new", BEAM_START, 128, Vector3(255, 255, 0), 4.0);
		string BEAM_END = BEAM_START;
		BEAM_END += "z";
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 4.0, 20.0, 0.5, 255, 50, 30, Vector3(255, 255, 0));
		EmitSound3D(SOUND_THUNDER, 10, BEAM_START);
	}

}

}
