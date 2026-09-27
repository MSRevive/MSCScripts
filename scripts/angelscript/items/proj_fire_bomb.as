#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjFireBomb : CGameScript
{
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_IGNORENPC;
	int PROJ_MOTIONBLUR;
	int PROJ_SOLIDIFY_ON_WALL;
	int PROJ_STICK_DURATION;

	ProjFireBomb()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 41;
		PROJ_ANIM_IDLE = "axis_spin";
		ITEM_NAME = "firemana";
		PROJ_DAMAGE_TYPE = "fire";
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 100;
		PROJ_AOE_RANGE = 200;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_SOLIDIFY_ON_WALL = 0;
		PROJ_IGNORENPC = 1;
	}

	void projectile_spawn()
	{
		SetName("Meteor");
		SetWeight(500);
		SetSize(10);
		SetValue(5);
		SetGravity(0.4);
		SetGroupable(25);
		SetProp(GetOwner(), "scale", 0.5);
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
		// svplaysound: svplaysound 2 10 ambience/alienflyby1.wav
		EmitSound(2, 10, "ambience/alienflyby1.wav");
	}

	void projectile_landed()
	{
		EmitSound(GetOwner(), 0, "weapons/mortarhit.wav", 10);
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
