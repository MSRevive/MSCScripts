#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjGlobGuided : CGameScript
{
	int IS_ACTIVE;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string MY_CL_ID;
	string MY_TARG;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_IGNORENPC;
	int PROJ_MOTIONBLUR;
	int PROJ_SOLIDIFY_ON_WALL;
	int PROJ_STICK_DURATION;
	string TARG_HALF_HEIGHT;

	ProjGlobGuided()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 68;
		PROJ_ANIM_IDLE = "spin_vertical_fast";
		ITEM_NAME = "firemana";
		PROJ_DAMAGE_TYPE = "acid_effect";
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 0;
		PROJ_AOE_RANGE = 0;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_SOLIDIFY_ON_WALL = 0;
		PROJ_IGNORENPC = 0;
	}

	void projectile_spawn()
	{
		SetName("Acid Glob");
		SetGravity(0);
		SetProp(GetOwner(), "scale", 0.25);
		PlayAnim("once", "spin_vertical_fast");
		SetIdleAnim("spin_vertical_fast");
	}

	void game_tossprojectile()
	{
		PlayAnim("critical", "spin_vertical_fast");
		ClientEvent("new", "all", "items/proj_slime_jet_cl", GetEntityIndex(GetOwner()), "xfireball3.spr");
		MY_CL_ID = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.1, "pick_target");
	}

	void pick_target()
	{
		MY_TARG = GetEntityProperty("ent_expowner", "scriptvar");
		if (!(MY_TARG != "none")) return;
		if (!(IsValidPlayer(MY_TARG)))
		{
			TARG_HALF_HEIGHT = GetEntityHeight(MY_TARG);
			TARG_HALF_HEIGHT *= 0.5;
		}
		else
		{
			TARG_HALF_HEIGHT = 0;
		}
		IS_ACTIVE = 1;
		home_on_target();
		ScheduleDelayedEvent(10.0, "max_chase_time");
	}

	void home_on_target()
	{
		if (!(IS_ACTIVE)) return;
		if (!(IsEntityAlive(MY_TARG))) return;
		ScheduleDelayedEvent(0.25, "home_on_target");
		string TARG_ORG = GetEntityOrigin(MY_TARG);
		TARG_ORG += "z";
		string MY_ORG = GetEntityOrigin(GetOwner());
		string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(MY_ORG, TARG_ORG);
		ANG_TO_TARG = "x";
		SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(ANG_TO_TARG, Vector3(0, 300, 0)));
		SetProp(GetOwner(), "movedir", ANG_TO_TARG);
	}

	void max_chase_time()
	{
		projectile_landed();
	}

	void projectile_landed()
	{
		IS_ACTIVE = 0;
		string SPLOOSH_POINT = GetEntityOrigin(GetOwner());
		ClientEvent("new", "all", "effects/sfx_acid_splash", SPLOOSH_POINT, 64);
		CallExternal("ent_expowner", "ext_glob_landed", SPLOOSH_POINT);
		ClientEvent("update", "all", MY_CL_ID, "end_fx");
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		RemoveScript();
		DeleteEntity(GetOwner());
	}

}

}
