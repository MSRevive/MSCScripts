#pragma context server

#include "items/proj_arrow_base.as"

namespace MS
{

class ProjTrollLightning : CGameScript
{
	string SHOCK_TARGETS;

	ProjTrollLightning()
	{
		const string MODEL_WORLD = "weapons/projectiles.mdl";
		const int ARROW_BODY_OFS = 20;
		const int MODEL_BODY_OFS = 20;
		const string PROJ_ANIM_IDLE = "idle_standard";
		const int PROJ_STICK_DURATION = 0;
		const int ARROW_SOLIDIFY_ON_WALL = 0;
		const float ARROW_BREAK_CHANCE = 1.0;
		const int PROJ_MOTIONBLUR = 0;
		const string PROJ_DAMAGE_TYPE = "lightning";
		const string PROJ_DAMAGE = RandomInt(200, 300);
		const int PROJ_AOE_RANGE = 200;
		const int PROJ_AOE_FALLOFF = 0;
		const int PROJ_IGNORENPC = 1;
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
