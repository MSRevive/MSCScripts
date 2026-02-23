#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjStaffFireBomb : CGameScript
{
	ProjStaffFireBomb()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 41;
		const string PROJ_ANIM_IDLE = "axis_spin";
		const string ITEM_NAME = "firemana";
		const string PROJ_DAMAGE_TYPE = "fire";
		const int PROJ_DAMAGE = 100;
		const int CLFX_ARROW_NOSTICK = 1;
		const int PROJ_STICK_ON_NPC = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_STICK_ON_WALL_NEW = 0;
		const int PROJ_AOE_RANGE = 200;
		const float PROJ_AOE_FALLOFF = 0.01;
		const int PROJ_IGNORENPC = 0;
		const int ARROW_BODY_OFS = 41;
		const string SPRITE_ARROW_TRADE = "silverarrow";
	}

	void projectile_spawn()
	{
		SetName("Meteor");
		SetGravity(0.4);
		SetProp(GetOwner(), "scale", 0.5);
	}

	void game_tossprojectile()
	{
		LogDebug("game_tossprojectile");
		PlayAnim("critical", PROJ_ANIM_IDLE);
		EmitSound(GetOwner(), 2, "ambience/alienflyby1.wav", 10);
	}

	void projectile_landed()
	{
		LogDebug("projectile_landed");
		EmitSound(GetOwner(), 0, "weapons/mortarhit.wav", 10);
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 100, 5, 3, 500);
		string SPLOOSH_POINT = GetEntityOrigin(GetOwner());
		ClientEvent("new", "all", "items/proj_arrow_phx_cl", SPLOOSH_POINT, 256);
		CallExternal("ent_expowner", "ext_fire_bomb", GetEntityOrigin(GetOwner()));
	}

}

}
