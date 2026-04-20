#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjGdragonSpit : CGameScript
{
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_WORLD;
	string NEXT_DAMAGE;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_IGNORENPC;
	int PROJ_MOTIONBLUR;
	int PROJ_SOLIDIFY_ON_WALL;
	int PROJ_STICK_DURATION;

	ProjGdragonSpit()
	{
		MODEL_HANDS = "none";
		MODEL_WORLD = "weapons/projectiles.mdl";
		MODEL_BODY_OFS = 68;
		PROJ_ANIM_IDLE = "spin_vertical_fast";
		ITEM_NAME = "firemana";
		PROJ_DAMAGE_TYPE = "acid_effect";
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE = 100;
		PROJ_AOE_RANGE = 256;
		PROJ_AOE_FALLOFF = 0;
		PROJ_STICK_DURATION = 0;
		PROJ_SOLIDIFY_ON_WALL = 0;
		PROJ_IGNORENPC = 1;
	}

	void projectile_spawn()
	{
		SetName("Acid Glob");
		SetWeight(500);
		SetSize(10);
		SetValue(0);
		SetGravity(0);
		SetGroupable(25);
		PlayAnim("once", "spin_vertical_fast");
		SetIdleAnim("spin_vertical_fast");
		SetHUDSprite("hand", "arrows");
		SetHUDSprite("trade", ITEM_NAME);
		SetHand("any");
	}

	void game_tossprojectile()
	{
		// TODO: projectiletouch 1
		PlayAnim("critical", "spin_vertical_fast");
		ClientEvent("new", "all", "items/proj_slime_jet_cl", GetEntityIndex(GetOwner()), "xfireball3.spr", 5.0, 3.0);
		// svplaysound: svplaysound 2 10 ambience/alienflyby1.wav
		EmitSound(2, 10, "ambience/alienflyby1.wav");
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(GetGameTime() > NEXT_DAMAGE)) return;
		NEXT_DAMAGE = GetGameTime();
		NEXT_DAMAGE += 0.2;
		CallExternal("ent_expowner", "ext_proj_touch", GetEntityIndex(param1));
	}

	void projectile_landed()
	{
		string SPLOOSH_POINT = GetEntityOrigin(GetOwner());
		ClientEvent("new", "all", "effects/sfx_acid_splash", SPLOOSH_POINT, 128);
		CallExternal("ent_expowner", "ext_proj_landed", SPLOOSH_POINT);
	}

}

}
