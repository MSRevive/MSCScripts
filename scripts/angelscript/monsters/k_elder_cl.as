#pragma context server

namespace MS
{

class KElderCl : CGameScript
{
	string KE_BEAM_ON;
	int KE_END_KNIFE_SPRITE;
	string KE_OWNER_SKEL;
	string KE_RENDER_ON;
	string KE_SPRITE_TARGET;
	string KE_TARG_HALF_HEIGHT;
	string OWNER_TYPE;

	KElderCl()
	{
		const string KE_GLOW_SPRITE = "3dmflaora.spr";
		const float KE_GLOW_SPRITE_LARGE = 0.5;
		const float KE_GLOW_SPRITE_SMALL = 0.1;
		Precache(KE_GLOW_SPRITE);
	}

	void client_activate()
	{
		LogDebug("***** ke_setup PARAM1 PARAM2 PARAM3 PARAM4 PARAM5");
		KE_OWNER_SKEL = param1;
		OWNER_TYPE = param2;
		if (!(OWNER_TYPE == "lightning")) return;
		string KNIFE_SPR_ORG = /* TODO: $getcl */ $getcl(KE_OWNER_SKEL, "bonepos", 26);
		KE_RENDER_ON = param3;
		KE_BEAM_ON = param4;
		KE_SPRITE_TARGET = param5;
		ClientEffect("tempent", "sprite", KE_GLOW_SPRITE, KNIFE_SPR_ORG, "ke_setup_knife_sprite", "ke_update_knife_sprite");
		ScheduleDelayedEvent(5.0, "ke_maintain_script");
	}

	void ke_maintain_script()
	{
		if ((KE_END_KNIFE_SPRITE)) return;
		string KNIFE_SPR_ORG = /* TODO: $getcl */ $getcl(KE_OWNER_SKEL, "bonepos", 26);
		ClientEffect("tempent", "sprite", KE_GLOW_SPRITE, KNIFE_SPR_ORG, "ke_setup_knife_sprite", "ke_update_knife_sprite");
		ScheduleDelayedEvent(5.0, "ke_maintain_script");
	}

	void ke_update_knife_sprite()
	{
		if ((KE_END_KNIFE_SPRITE))
		{
			ClientEffect("tempent", "set_current_prop", "death_delay", 0.01);
			ClientEffect("tempent", "set_current_prop", "renderamt", 0);
			ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		}
		if ((KE_END_KNIFE_SPRITE)) return;
		if ((KE_RENDER_ON))
		{
			string KNIFE_SPR_ORG = /* TODO: $getcl */ $getcl(KE_OWNER_SKEL, "bonepos", 26);
			ClientEffect("tempent", "set_current_prop", "origin", KNIFE_SPR_ORG);
			ClientEffect("tempent", "set_current_prop", "renderamt", 255);
			ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		}
	}

	void ke_beam_loop()
	{
		if (!(KE_BEAM_ON)) return;
		ScheduleDelayedEvent(0.01, "ke_beam_loop");
		string SPARK_ORG = /* TODO: $getcl */ $getcl(KE_SPRITE_TARGET, "origin");
		SPARK_ORG += /* TODO: $relpos */ $relpos(Vector3(0, Random(0, 359), 0), Vector3(0, 32, KE_TARG_HALF_HEIGHT));
		ClientEffect("tempent", "sprite", KE_GLOW_SPRITE, SPARK_ORG, "ke_spit_sparks");
		string BEAM_START = /* TODO: $getcl */ $getcl(KE_OWNER_SKEL, "bonepos", 26);
		string BEAM_END = /* TODO: $getcl */ $getcl(KE_SPRITE_TARGET, "origin");
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(Random(-32, 32), 0, Random(/* TODO: $neg */ $neg(KE_TARG_HALF_HEIGHT), KE_TARG_HALF_HEIGHT)));
		ClientEffect("beam_points", BEAM_START, BEAM_END, "lgtning.spr", 0.1, 2, 0.1, 0.3, 0.1, 30, Vector3(2, 1.5, 0.25));
	}

	void ke_beam_on()
	{
		LogDebug("***** KE_BEAM_ON PARAM1 PARAM2");
		KE_SPRITE_TARGET = param1;
		KE_TARG_HALF_HEIGHT = param2;
		KE_BEAM_ON = 1;
		ke_beam_loop();
	}

	void ke_beam_off()
	{
		KE_BEAM_ON = 0;
	}

	void ke_knife_sprite_on()
	{
		LogDebug("***** knife_sprite_on");
		KE_RENDER_ON = 1;
	}

	void ke_setup_knife_sprite()
	{
		LogDebug("**** ke_setup_knife_sprite");
		ClientEffect("tempent", "set_current_prop", "death_delay", 5.0);
		ClientEffect("tempent", "set_current_prop", "renderamt", 0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "velocity", /* TODO: $relvel */ $relvel(Vector3(0, RandomInt(0, 359), 0), Vector3(0, 110, 0)));
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(254, 254, 1));
		ClientEffect("tempent", "set_current_prop", "scale", KE_GLOW_SPRITE_LARGE);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void ke_spit_sparks()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 0.5);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 5);
		ClientEffect("tempent", "set_current_prop", "scale", KE_GLOW_SPRITE_SMALL);
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 128));
		ClientEffect("tempent", "set_current_prop", "gravity", 1.0);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "framerate", 30);
		ClientEffect("tempent", "set_current_prop", "frames", 1);
	}

	void ke_end_effect()
	{
		LogDebug("***** Ending Effect");
		KE_END_KNIFE_SPRITE = 1;
		ScheduleDelayedEvent(1.0, "ke_remove_me");
	}

	void ke_remove_me()
	{
		RemoveScript();
	}

}

}
