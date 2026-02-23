#pragma context server

#include "items/proj_base.as"

namespace MS
{

class ProjGdragonSpit : CGameScript
{
	string NEXT_DAMAGE;

	ProjGdragonSpit()
	{
		const string MODEL_HANDS = "none";
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int MODEL_BODY_OFS = 68;
		const string PROJ_ANIM_IDLE = "spin_vertical_fast";
		const string ITEM_NAME = "firemana";
		const string PROJ_DAMAGE_TYPE = "acid_effect";
		const int PROJ_MOTIONBLUR = 0;
		const int PROJ_DAMAGE = 100;
		const int PROJ_AOE_RANGE = 256;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_STICK_DURATION = 0;
		const int PROJ_SOLIDIFY_ON_WALL = 0;
		const int PROJ_IGNORENPC = 1;
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
		// TODO: UNCONVERTED: projectiletouch 1
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
