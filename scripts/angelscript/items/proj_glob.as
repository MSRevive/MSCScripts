#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjGlob : CGameScript
{
	string EFFECT_DOT;
	string EFFECT_DUR;
	string EFFECT_TYPE;

	ProjGlob()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 68;
		const string PROJ_ANIM_IDLE = "spin_vertical_fast";
		const string ITEM_NAME = "firemana";
		const string PROJ_DAMAGE_TYPE = "acid_effect";
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_DAMAGE = 100;
		const int PROJ_AOE_RANGE = 64;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const int PROJ_IGNORENPC = 0;
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
