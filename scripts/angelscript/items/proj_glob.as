#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjGlob : CGameScript
{
	string EFFECT_DOT;
	string EFFECT_DUR;
	string EFFECT_TYPE;
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

	ProjGlob()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 68;
		PROJ_ANIM_IDLE = "spin_vertical_fast";
		ITEM_NAME = "firemana";
		PROJ_DAMAGE_TYPE = "acid_effect";
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 100;
		PROJ_AOE_RANGE = 64;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_SOLIDIFY_ON_WALL = 0;
		PROJ_IGNORENPC = 0;
	}

	void projectile_spawn()
	{
		SetName("Acid Glob");
		SetWeight(500);
		SetSize(10);
		SetValue(0);
		SetGravity(0.4);
		SetGroupable(25);
		SetProp(GetOwner(), "scale", 0.25);
		PlayAnim("once", "spin_vertical_fast");
		SetIdleAnim("spin_vertical_fast");
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
	}

	void game_tossprojectile()
	{
		PlayAnim("critical", "spin_vertical_fast");
		ClientEvent("new", "all", "items/proj_slime_jet_cl", GetEntityIndex(GetOwner()), "xfireball3.spr");
		EFFECT_TYPE = GetEntityProperty("ent_expowner", "scriptvar");
		EFFECT_DUR = GetEntityProperty("ent_expowner", "scriptvar");
		EFFECT_DOT = GetEntityProperty("ent_expowner", "scriptvar");
	}

	void projectile_landed()
	{
		string SPLOOSH_POINT = GetEntityOrigin(GetOwner());
		ClientEvent("new", "all", "effects/sfx_acid_splash", SPLOOSH_POINT, 64);
	}

	void game_dodamage()
	{
		LogDebug("game_dodamage EFFECT_TYPE PARAM1 GetEntityName(param2) GetRelationship("ent_expowner")");
		if (!(param1)) return;
		if (!(GetRelationship("ent_expowner") == "enemy")) return;
		ApplyEffect(param2, EFFECT_TYPE, EFFECT_DUR, GetEntityIndex("ent_expowner"), EFFECT_DOT, "none");
	}

}

}
