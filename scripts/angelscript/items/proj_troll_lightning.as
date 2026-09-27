#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjTrollLightning : CGameScript
{
	int ARROW_BODY_OFS;
	float ARROW_BREAK_CHANCE;
	int ARROW_SOLIDIFY_ON_WALL;
	int MODEL_BODY_OFS;
	string MODEL_WORLD;
	string PROJ_ANIM_IDLE;
	int PROJ_AOE_FALLOFF;
	int PROJ_AOE_RANGE;
	int PROJ_DAMAGE;
	string PROJ_DAMAGE_TYPE;
	int PROJ_IGNORENPC;
	int PROJ_MOTIONBLUR;
	int PROJ_STICK_DURATION;
	string SHOCK_TARGETS;

	ProjTrollLightning()
	{
		MODEL_WORLD = "weapons/projectiles.mdl";
		ARROW_BODY_OFS = 20;
		MODEL_BODY_OFS = 20;
		PROJ_ANIM_IDLE = "idle_standard";
		PROJ_STICK_DURATION = 0;
		ARROW_SOLIDIFY_ON_WALL = 0;
		ARROW_BREAK_CHANCE = 1.0;
		PROJ_MOTIONBLUR = 0;
		PROJ_DAMAGE_TYPE = "lightning";
		PROJ_DAMAGE = RandomInt(200, 300);
		PROJ_AOE_RANGE = 200;
		PROJ_AOE_FALLOFF = 0;
		PROJ_IGNORENPC = 1;
	}

	void game_precache()
	{
		Precache("effects/sfx_shock_burst");
	}

	void arrow_spawn()
	{
		SetName("Big Ball o Lightning");
		SetDescription("Big zappy thang");
		SetWeight(0.1);
		SetSize(1);
		SetValue(0);
		SetGravity(0.4);
		SetGroupable(25);
	}

	void game_projectile_hitwall()
	{
		string MY_ORG = GetEntityOrigin(GetOwner());
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 100, 5, 3, 500);
		ClientEvent("new", "all", "effects/sfx_shock_burst", MY_ORG, 256, 1, Vector3(255, 255, 0));
		string MY_DMG = GetEntityProperty("ent_expowner", "scriptvar");
		XDoDamage(MY_ORG, 256, MY_DMG, 0, "ent_expowner", "ent_expowner", "none", "lightning");
		SHOCK_TARGETS = FindEntitiesInSphere("any", 256);
		LogDebug("game_projectile_hitwall MY_DMG SHOCK_TARGETS");
		if (!(SHOCK_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(SHOCK_TARGETS, ";"); i++)
		{
			apply_effect();
		}
	}

	void apply_effect()
	{
		string CUR_TARG = GetToken(SHOCK_TARGETS, i, ";");
		if (!(GetRelationship("ent_expowner") == "enemy")) return;
		ApplyEffect(CUR_TARG, "effects/dot_lightning", 8.0, GetEntityIndex("ent_expowner"), GetEntityProperty("ent_expowner", "scriptvar"));
	}

}

}
