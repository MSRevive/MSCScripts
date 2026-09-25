#pragma context server

namespace MS
{

class SfxPulseSphere : CGameScript
{
	string BLUR_ANG;
	string BLUR_VEL;
	int FX_ACTIVE;
	string FX_ANIM;
	string FX_MAX_SCALE;
	string FX_ORIGIN;
	string FX_OWNER;
	string FX_SKIN;
	string NO_BLUR;
	int VEL_X;

	void client_activate()
	{
		FX_ORIGIN = param1;
		FX_MAX_SCALE = param2;
		FX_OWNER = param3;
		FX_SKIN = param4;
		FX_ANIM = param5;
		if ((FX_OWNER).findFirst(PARAM) == 0)
		{
			NO_BLUR = 1;
		}
		FX_ACTIVE = 1;
		ScheduleDelayedEvent(5.0, "end_fx");
		EmitSound3D("magic/sff_explsonic.wav", 10, FX_ORIGIN);
		if ((param6).findFirst(PARAM) == 0)
		{
			string SPR_POS = FX_ORIGIN;
		}
		else
		{
			if (param6 == 0)
			{
				string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment0");
			}
			if (param6 == 1)
			{
				string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment1");
			}
			if (param6 == 2)
			{
				string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment2");
			}
			if (param6 == 3)
			{
				string SPR_POS = /* TODO: $getcl */ $getcl(FX_OWNER, "attachment3");
			}
			LogDebug("*** SPR_POS");
		}
		ClientEffect("tempent", "model", "monsters/zubat_sphere.mdl", /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), "setup_sphere", "update_sphere");
		if ((NO_BLUR)) return;
		VEL_X = 0;
		for (int i = 0; i < 8; i++)
		{
			blur_loop();
		}
	}

	void end_fx()
	{
		FX_ACTIVE = 0;
		ScheduleDelayedEvent(1.0, "remove_fx");
	}

	void remove_fx()
	{
		RemoveScript();
	}

	void blur_loop()
	{
		VEL_R += 20;
		BLUR_ANG = /* TODO: $getcl */ $getcl(FX_OWNER, "angles");
		BLUR_VEL = /* TODO: $relvel */ $relvel(BLUR_ANG, Vector3(/* TODO: $neg */ $neg(VEL_R), 0, 0));
		ClientEffect("tempent", "model", /* TODO: $getcl */ $getcl(FX_OWNER, "model"), /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), "setup_blur");
		BLUR_VEL = /* TODO: $relvel */ $relvel(BLUR_ANG, Vector3(VEL_R, 0, 0));
		ClientEffect("tempent", "model", /* TODO: $getcl */ $getcl(FX_OWNER, "model"), /* TODO: $getcl */ $getcl(FX_OWNER, "origin"), "setup_blur");
	}

	void setup_blur()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "scale", 2.0);
		ClientEffect("tempent", "set_current_prop", "angles", BLUR_ANG);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "rendermode", "alpha");
		ClientEffect("tempent", "set_current_prop", "renderamt", 50);
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "skin", FX_SKIN);
		ClientEffect("tempent", "set_current_prop", "velocity", BLUR_VEL);
		ClientEffect("tempent", "set_current_prop", "sequence", FX_ANIM);
	}

	void setup_sphere()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 4.0);
		ClientEffect("tempent", "set_current_prop", "fadeout", 2.0);
		ClientEffect("tempent", "set_current_prop", "scale", 0.25);
		ClientEffect("tempent", "set_current_prop", "gravity", 0);
		ClientEffect("tempent", "set_current_prop", "sequence", 0);
		ClientEffect("tempent", "set_current_prop", "framerate", 1.0);
		ClientEffect("tempent", "set_current_prop", "frames", 999);
		ClientEffect("tempent", "set_current_prop", "rendermode", "add");
		ClientEffect("tempent", "set_current_prop", "renderamt", 255);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(64, 64, 255));
		ClientEffect("tempent", "set_current_prop", "color", Vector3(64, 64, 255));
		ClientEffect("tempent", "set_current_prop", "collide", "none");
		ClientEffect("tempent", "set_current_prop", "fuser1", 0.25);
	}

	void update_sphere()
	{
		if ((FX_ACTIVE))
		{
			string CUR_SCALE = "game.tempent.fuser1";
			if (CUR_SCALE < FX_MAX_SCALE)
			{
			}
			CUR_SCALE += 0.05;
			ClientEffect("tempent", "set_current_prop", "scale", CUR_SCALE);
			ClientEffect("tempent", "set_current_prop", "fuser1", CUR_SCALE);
		}
		else
		{
			ClientEffect("tempent", "set_current_prop", "origin", Vector3(20000, 20000, 2000));
		}
	}

}

}
