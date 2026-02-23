#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjFireBomb : CGameScript
{
	ProjFireBomb()
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
