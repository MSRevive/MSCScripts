#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjStaffFireBomb : CGameScript
{
	int ARROW_BODY_OFS;
	int CLFX_ARROW_NOSTICK;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	float PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_IGNORENPC;
	int PROJ_MOTIONBLUR;
	int PROJ_STICK_DURATION;
	int PROJ_STICK_ON_NPC;
	int PROJ_STICK_ON_WALL_NEW;
	string SPRITE_ARROW_TRADE;

	ProjStaffFireBomb()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 41;
		PROJ_ANIM_IDLE = "axis_spin";
		ITEM_NAME = "firemana";
		PROJ_DAMAGE_TYPE = "fire";
		PROJ_DAMAGE = 100;
		CLFX_ARROW_NOSTICK = 1;
		PROJ_STICK_ON_NPC = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_MOTIONBLUR = 0;
		PROJ_STICK_ON_WALL_NEW = 0;
		PROJ_AOE_RANGE = 200;
		PROJ_AOE_FALLOFF = 0.01;
		PROJ_IGNORENPC = 0;
		ARROW_BODY_OFS = 41;
		SPRITE_ARROW_TRADE = "silverarrow";
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
