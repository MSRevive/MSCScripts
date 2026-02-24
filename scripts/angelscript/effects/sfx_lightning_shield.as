#pragma context client

namespace MS
{

class SfxLightningShield : CGameScript
{
	string L_SHIELD_RADIUS;
	string SHIELD_DURATION;
	string SHIELD_IS_CONSTANT;
	string SHIELD_OWNER;
	string SHIELD_RADIUS;
	string SHIELD_VADJ;
	string ZAP_FX_NERF;
	int ZAP_ON;

	void client_activate()
	{
		SHIELD_OWNER = param1;
		SHIELD_RADIUS = param2;
		SHIELD_DURATION = param3;
		SHIELD_VADJ = param4;
		SHIELD_IS_CONSTANT = param5;
		const Vector3 SHIELD_COLOR = Vector3(2, 1.5, 0.25);
		SHIELD_DURATION("remove_effect");
		if ((SHIELD_IS_CONSTANT)) return;
		lshield_on();
	}

	void lshield_on()
	{
		ZAP_ON = 1;
		lshield_loop();
		ZAP_FX_NERF = GetGameTime();
		ZAP_FX_NERF += 1.0;
		PARAM1("lshield_off");
	}

	void lshield_loop()
	{
		if (!(ZAP_ON)) return;
		ScheduleDelayedEvent(0.1, "lshield_loop");
		if (GetGameTime() > ZAP_FX_NERF)
		{
			int EXIT_SUB = RandomInt(0, 1);
		}
		if ((EXIT_SUB)) return;
		string BEAM_START = /* TODO: $getcl */ $getcl(SHIELD_OWNER, "origin");
		string BEAM_END = /* TODO: $getcl */ $getcl(SHIELD_OWNER, "origin");
		BEAM_START += "z";
		float RND_PITCH = Random(0, 359);
		float RND_YAW = Random(0, 359);
		L_SHIELD_RADIUS = SHIELD_RADIUS;
		L_SHIELD_RADIUS *= 0.5;
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(RND_PITCH, RND_YAW, 0), Vector3(0, L_SHIELD_RADIUS, 0));
		float RND_PITCH = Random(0, 359);
		float RND_YAW = Random(0, 359);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(RND_PITCH, RND_YAW, 0), Vector3(0, L_SHIELD_RADIUS, 0));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.2, 2, 9, 0.3, 0.1, 30, SHIELD_COLOR);
		if (!(SHIELD_RADIUS > 128)) return;
		string BEAM_START = /* TODO: $getcl */ $getcl(SHIELD_OWNER, "origin");
		string BEAM_END = /* TODO: $getcl */ $getcl(SHIELD_OWNER, "origin");
		BEAM_START += /* TODO: $relpos */ $relpos(Vector3(RND_PITCH, RND_YAW, 0), Vector3(0, L_SHIELD_RADIUS, 0));
		float RND_PITCH = Random(0, 359);
		float RND_YAW = Random(0, 359);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(RND_PITCH, RND_YAW, 0), Vector3(0, L_SHIELD_RADIUS, 0));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.2, 2, 9, 0.3, 0.1, 30, SHIELD_COLOR);
	}

	void lshield_off()
	{
		ZAP_ON = 0;
	}

	void remove_effect()
	{
		RemoveScript();
	}

}

}
