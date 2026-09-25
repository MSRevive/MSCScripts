#pragma context server

namespace MS
{

class ProjGuidedBase : CGameScript
{
	int GPROJ_ACTIVE;
	string GPROJ_TARGET;
	string GPROJ_TARG_HALF_HEIGHT;

	void game_tossprojectile()
	{
		if (!(GetEntityProperty("ent_expowner", "scriptvar"))) return;
		if (!(IsValidPlayer("ent_expowner")))
		{
			GPROJ_TARGET = GetEntityProperty("ent_expowner", "scriptvar");
		}
		else
		{
			GPROJ_TARGET = GetEntityProperty("ent_expowner", "scriptvar");
		}
		if (!(IsValidPlayer(GPROJ_TARGET)))
		{
			GPROJ_TARG_HALF_HEIGHT = GetEntityHeight(GPROJ_TARGET);
			GPROJ_TARG_HALF_HEIGHT *= 0.5;
		}
		else
		{
			GPROJ_TARG_HALF_HEIGHT = 0;
		}
		GPROJ_ACTIVE = 1;
		ScheduleDelayedEvent(0.1, "gproj_home");
	}

	void gproj_home()
	{
		if (!(GPROJ_ACTIVE)) return;
		if (!(IsEntityAlive(GPROJ_TARGET))) return;
		ScheduleDelayedEvent(0.25, "gproj_home");
		string L_TARG_ORG = GetEntityOrigin(GPROJ_TARGET);
		L_TARG_ORG += "z";
		string L_MY_ORG = GetEntityOrigin(GetOwner());
		string L_ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(L_MY_ORG, L_TARG_ORG);
		L_ANG_TO_TARG = "x";
		SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(L_ANG_TO_TARG, Vector3(0, 300, 0)));
		SetProp(GetOwner(), "movedir", L_ANG_TO_TARG);
	}

	void projectile_landed()
	{
		GPROJ_ACTIVE = 0;
	}

}

}
