#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjAcidBomb : CGameScript
{
	ProjAcidBomb()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 68;
		const string PROJ_ANIM_IDLE = "spin_vertical_slow";
		const string ITEM_NAME = "firemana";
		const string PROJ_DAMAGE_TYPE = "acid";
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
