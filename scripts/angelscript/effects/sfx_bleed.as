#pragma context client

namespace MS
{

class SfxBleed : CGameScript
{
	string BLOOD_COL;
	string BONE_AMT;
	int BONE_IDX;
	string RENDER_PROPS;
	string SFX_OWNER;
	int SPRITE_DURATION;
	string SPRITE_NAME;

	void client_activate()
	{
		if (param2 == "green")
		{
			BLOOD_COL = "(225,225,0)";
		}
		else
		{
			BLOOD_COL = "(200,0,0)";
		}
		SFX_OWNER = param1;
		SPRITE_NAME = "bloodspray.spr";
		RENDER_PROPS = "0;0.15;255;alpha;";
		RENDER_PROPS += BLOOD_COL;
		RENDER_PROPS += ";10;10";
		SPRITE_DURATION = 5;
		BONE_AMT = (/* TODO: $getcl */ $getcl(SFX_OWNER, "bonecount") - 1);
		BONE_IDX = RandomInt(1, BONE_AMT);
		ScheduleDelayedEvent(0.01, "spurt_blood");
		SPRITE_DURATION("remove_me");
	}

	void spurt_blood()
	{
		if (BONE_AMT > 0)
		{
			string L_POS = /* TODO: $getcl */ $getcl(SFX_OWNER, "bonepos", BONE_IDX);
		}
		else
		{
			string L_POS = /* TODO: $getcl */ $getcl(SFX_OWNER, "center");
		}
		ClientEffect("tempent", "sprite", SPRITE_NAME, L_POS, "setup_temp_sprite");
		ScheduleDelayedEvent(0.1, "spurt_blood");
	}

	void setup_temp_sprite()
	{
		string L_SPURT_ANG = /* TODO: $angles */ $angles(/* TODO: $getcl */ $getcl(SFX_OWNER, "origin"), /* TODO: $getcl */ $getcl(SFX_OWNER, "bonepos", BONE_IDX));
		Vector3 L_ANG = Vector3(0, L_SPURT_ANG, 0);
		Vector3 L_VEL1 = Vector3(0, 40, 20);
		string L_VEL2 = /* TODO: $relvel */ $relvel(L_ANG, L_VEL1);
		string L_VEL3 = /* TODO: $getcl */ $getcl(SFX_OWNER, "velocity");
		L_VEL3 *= 0.05;
		L_VEL2 += L_VEL3;
		ClientEffect("tempent", "set_current_prop", "death_delay", 1);
		if (GetToken(RENDER_PROPS, 0, ";") == 1)
		{
			ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		}
		ClientEffect("tempent", "set_current_prop", "scale", GetToken(RENDER_PROPS, 1, ";"));
		ClientEffect("tempent", "set_current_prop", "renderamt", GetToken(RENDER_PROPS, 2, ";"));
		ClientEffect("tempent", "set_current_prop", "rendermode", GetToken(RENDER_PROPS, 3, ";"));
		ClientEffect("tempent", "set_current_prop", "rendercolor", GetToken(RENDER_PROPS, 4, ";"));
		ClientEffect("tempent", "set_current_prop", "framerate", GetToken(RENDER_PROPS, 5, ";"));
		ClientEffect("tempent", "set_current_prop", "frames", GetToken(RENDER_PROPS, 6, ";"));
		ClientEffect("tempent", "set_current_prop", "velocity", L_VEL2);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.6);
		ClientEffect("tempent", "set_current_prop", "collide", "world;die");
		ClientEffect("tempent", "set_current_prop", "update", 1);
	}

	void remove_me()
	{
		RemoveScript();
	}

}

}
