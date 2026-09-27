#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjAcidBomb : CGameScript
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

	ProjAcidBomb()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 68;
		PROJ_ANIM_IDLE = "spin_vertical_slow";
		ITEM_NAME = "firemana";
		PROJ_DAMAGE_TYPE = "acid";
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
		SetName("Acid Ball");
		SetWeight(500);
		SetSize(10);
		SetValue(5);
		SetGravity(0.4);
		SetGroupable(25);
		SetProp(GetOwner(), "scale", 0.75);
		PlayAnim("once", "spin_vertical_slow");
		SetIdleAnim("spin_vertical_slow");
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
	}

	void game_tossprojectile()
	{
		PlayAnim("critical", "spin_vertical_slow");
	}

	void projectile_landed()
	{
		string SPLOOSH_POINT = GetEntityOrigin(GetOwner());
		ClientEvent("new", "all", "effects/sfx_acid_splash", SPLOOSH_POINT);
		CallExternal("ent_expowner", "ext_acid_bomb", GetEntityOrigin(GetOwner()));
	}

}

}
