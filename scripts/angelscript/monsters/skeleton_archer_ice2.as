#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcherIce2 : CGameScript
{
	string ARROW_CL_SCRIPT;
	int C_SKELE_ARROW_KNOCKBACK;
	int C_SKELE_PUSH_STRENGTH;
	int DMG_AOE;
	int DMG_ARROW;
	int DMG_SWIPE;
	float FREEZE_DUR;
	int NPC_GIVE_EXP;
	int SKELE_ARROW_AOE;
	int SKELE_ARROW_ARC;
	string SKELE_ARROW_EFFECT;
	int SKELE_ARROW_EFFECT_HANDLED;
	int SKELE_ARROW_GLOW;
	string SKELE_ARROW_GLOW_COLOR;
	string SKELE_ARROW_SCRIPT;
	int SKELE_ARROW_SPEED;
	string SKELE_CONTAINER_SCRIPT;
	int SKELE_DOT_DMG;
	float SKELE_DOT_DUR;
	int SKELE_DROPS_CONTAINER;
	float SKELE_DROPS_CONTAINER_CHANCE;
	int SKELE_GOLD;
	int SKELE_START_LIVES;

	SkeletonArcherIce2()
	{
		NPC_GIVE_EXP = 800;
		DMG_ARROW = 400;
		DMG_SWIPE = 80;
		C_SKELE_PUSH_STRENGTH = 600;
		SKELE_GOLD = 100;
		SKELE_ARROW_EFFECT = "effects/dot_cold";
		SKELE_ARROW_EFFECT_HANDLED = 1;
		SKELE_ARROW_AOE = 128;
		SKELE_DOT_DMG = 50;
		SKELE_DOT_DUR = 5.0;
		SKELE_ARROW_GLOW = 1;
		SKELE_ARROW_GLOW_COLOR = Vector3(128, 128, 255);
		SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		C_SKELE_ARROW_KNOCKBACK = 800;
		SKELE_DROPS_CONTAINER = 1;
		SKELE_CONTAINER_SCRIPT = "chests/quiver_of_frost";
		SKELE_DROPS_CONTAINER_CHANCE = 1.0;
		SKELE_START_LIVES = 1;
		SKELE_ARROW_ARC = 1;
		SKELE_ARROW_SPEED = 500;
		ARROW_CL_SCRIPT = "effects/sfx_ice_burst";
		DMG_AOE = 200;
		FREEZE_DUR = 8.0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(15.1);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(128, 128, 255), 128, 15.0);
	}

	void skele_spawn()
	{
		SetName("Ancient Frozen Archer");
		SetHealth(3000);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("holy", 1.25);
		SetHeight(80);
		SetWidth(30);
		SetModelBody(0, 5);
		SetModelBody(1, 10);
		SetModelBody(2, 0);
	}

	void skele_arrow_fx()
	{
		string ARROW_ORG = param1;
		ClientEvent("new", "all", ARROW_CL_SCRIPT, ARROW_ORG, 128, 1, Vector3(0, 0, 255));
		XDoDamage(ARROW_ORG, SKELE_ARROW_AOE, DMG_AOE, 0, GetOwner(), GetOwner(), "none", "cold_effect");
	}

	void skele_handle_effect()
	{
		ApplyEffect(param1, "effects/dot_cold_freeze", FREEZE_DUR, GetEntityIndex(GetOwner()), SKELE_DOT_DMG);
	}

	void OnPostSpawn() override
	{
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(128, 128, 255), 128, 15.0);
	}

}

}
