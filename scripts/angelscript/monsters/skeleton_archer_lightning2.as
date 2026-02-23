#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcherLightning2 : CGameScript
{
	int NPC_GIVE_EXP;

	SkeletonArcherLightning2()
	{
		NPC_GIVE_EXP = 800;
		const int DMG_ARROW = 400;
		const int DMG_SWIPE = 80;
		const int C_SKELE_PUSH_STRENGTH = 400;
		const int SKELE_GOLD = 100;
		const string SKELE_ARROW_EFFECT = "effects/dot_lightning";
		const int SKELE_ARROW_AOE = 128;
		const int SKELE_DOT_DMG = 75;
		const float SKELE_DOT_DUR = 5.0;
		const int SKELE_ARROW_GLOW = 1;
		const Vector3 SKELE_ARROW_GLOW_COLOR = Vector3(255, 255, 0);
		const string SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		const int C_SKELE_ARROW_KNOCKBACK = 800;
		const int SKELE_DROPS_CONTAINER = 1;
		const string SKELE_CONTAINER_SCRIPT = "chests/quiver_of_lightning";
		const float SKELE_DROPS_CONTAINER_CHANCE = 1.0;
		const int SKELE_START_LIVES = 1;
		const int SKELE_ARROW_ARC = 1;
		const int SKELE_ARROW_SPEED = 500;
		const string ARROW_CL_SCRIPT = "effects/sfx_shock_burst";
		const int DMG_AOE = 500;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(15.1);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 255, 0), 128, 15.0);
	}

	void skele_spawn()
	{
		SetName("Lightning Archer");
		SetHealth(3000);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("holy", 1.25);
		SetModel("monsters/skeleton_boss1.mdl");
		SetWidth(32);
		SetHeight(80);
		SetModelBody(0, 6);
		SetModelBody(1, 10);
		SetModelBody(2, 0);
	}

	void skele_arrow_fx()
	{
		string ARROW_ORG = param1;
		ClientEvent("new", "all", ARROW_CL_SCRIPT, ARROW_ORG, 128, 1, Vector3(255, 255, 0));
		XDoDamage(ARROW_ORG, SKELE_ARROW_AOE, DMG_AOE, 0, GetOwner(), GetOwner(), "none", "lightning_effect");
	}

	void OnPostSpawn() override
	{
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 255, 0), 128, 15.0);
	}

}

}
