#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjFireBombSm : CGameScript
{
	int IN_FLIGHT;
	string PROJ_LOOP_SOUND;
	string PROJ_TARGET;
	string TARG_HALF_HEIGHT;
	int WIGGLE_COUNT;
	int WIGGLE_DIR;

	ProjFireBombSm()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 41;
		const string PROJ_ANIM_IDLE = "axis_spin";
		const string ITEM_NAME = "firemana";
		const string PROJ_DAMAGE_TYPE = "fire";
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_DAMAGE = 100;
		const int PROJ_AOE_RANGE = 200;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const int PROJ_IGNORENPC = 1;
	}

	void projectile_spawn()
	{
		SetName("Meteor");
		SetWeight(500);
		SetSize(10);
		SetValue(5);
		SetGravity(0);
		SetGroupable(25);
		SetProp(GetOwner(), "scale", 0.1);
		string L_SCALE = GetEntityProperty("ent_expowner", "scriptvar");
		if (L_SCALE > 0)
		{
			SetProp(GetOwner(), "scale", L_SCALE);
		}
		PlayAnim("once", PROJ_ANIM_IDLE);
		SetIdleAnim(PROJ_ANIM_IDLE);
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
	}

	void game_tossprojectile()
	{
		string L_SCALE = GetEntityProperty("ent_expowner", "scriptvar");
		if (L_SCALE > 0)
		{
			SetProp(GetOwner(), "scale", L_SCALE);
		}
		PlayAnim("critical", PROJ_ANIM_IDLE);
		PROJ_LOOP_SOUND = GetEntityProperty("ent_expowner", "scriptvar");
		if (PROJ_LOOP_SOUND == "PROJ_LOOP_SOUND")
		{
			PROJ_LOOP_SOUND = "ambience/alienflyby1.wav";
		}
		// svplaysound: svplaysound 2 10 PROJ_LOOP_SOUND
		EmitSound(2, 10, PROJ_LOOP_SOUND);
		IN_FLIGHT = 1;
		PROJ_TARGET = GetEntityProperty("ent_expowner", "scriptvar");
		WIGGLE_DIR = 1;
		WIGGLE_COUNT = 0;
		if (!(IsValidPlayer(PROJ_TARGET)))
		{
			TARG_HALF_HEIGHT = GetEntityHeight(PROJ_TARGET);
			TARG_HALF_HEIGHT *= 0.5;
		}
		else
		{
			TARG_HALF_HEIGHT = 0;
		}
		ScheduleDelayedEvent(0.1, "wiggle_loop");
	}

	void wiggle_loop()
	{
		if (!(IN_FLIGHT)) return;
		ScheduleDelayedEvent(0.1, "wiggle_loop");
		if ((IsEntityAlive(PROJ_TARGET)))
		{
			string TARG_ORG = GetEntityOrigin(PROJ_TARGET);
			TARG_ORG = "z";
			string MY_ORG = GetEntityOrigin(GetOwner());
			string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(MY_ORG, TARG_ORG);
			ANG_TO_TARG = "x";
			SetProp(GetOwner(), "velocity", /* TODO: $relvel */ $relvel(ANG_TO_TARG, Vector3(0, 300, 0)));
			SetProp(GetOwner(), "movedir", ANG_TO_TARG);
		}
		string L_MY_ANG = GetEntityProperty(GetOwner(), "movedir");
		L_MY_ANG += "y";
		WIGGLE_COUNT += WIGGLE_DIR;
		if (WIGGLE_COUNT > 20)
		{
			WIGGLE_DIR = -1;
		}
		if (WIGGLE_COUNT < -20)
		{
			WIGGLE_DIR = 1;
		}
		SetProp(GetOwner(), "movedir", WIGGLE_DIR);
	}

	void projectile_landed()
	{
		IN_FLIGHT = 0;
		EmitSound(GetOwner(), 0, "ambience/steamburst1.wav", 10);
		// svplaysound: svplaysound 2 0 PROJ_LOOP_SOUND
		EmitSound(2, 0, PROJ_LOOP_SOUND);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 100, 5, 3, 500);
		string SPLOOSH_POINT = GetEntityOrigin(GetOwner());
		string L_AOE = GetEntityProperty("ent_expowner", "scriptvar");
		if (L_AOE == 0)
		{
			int L_AOE = 256;
		}
		ClientEvent("new", "all", "items/proj_arrow_phx_cl", SPLOOSH_POINT, L_AOE);
		CallExternal("ent_expowner", "ext_fire_bomb", GetEntityOrigin(GetOwner()));
	}

}

}
