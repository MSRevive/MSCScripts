#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcherPoison2 : CGameScript
{
	string ARROW_CL_SCRIPT;
	int C_SKELE_ARROW_KNOCKBACK;
	int C_SKELE_PUSH_STRENGTH;
	int DMG_AOE;
	int DMG_ARROW;
	int DMG_SWIPE;
	int NPC_GIVE_EXP;
	int SKELE_ARROW_AOE;
	int SKELE_ARROW_ARC;
	string SKELE_ARROW_EFFECT;
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

	SkeletonArcherPoison2()
	{
		NPC_GIVE_EXP = 1500;
		DMG_ARROW = 400;
		DMG_SWIPE = 80;
		C_SKELE_PUSH_STRENGTH = 400;
		SKELE_GOLD = 100;
		SKELE_ARROW_EFFECT = "effects/dot_poison";
		SKELE_ARROW_AOE = 128;
		SKELE_DOT_DMG = 50;
		SKELE_DOT_DUR = 10.0;
		SKELE_ARROW_GLOW = 1;
		SKELE_ARROW_GLOW_COLOR = Vector3(0, 255, 0);
		SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		C_SKELE_ARROW_KNOCKBACK = 800;
		SKELE_DROPS_CONTAINER = 1;
		SKELE_CONTAINER_SCRIPT = "chests/quiver_of_gpoison";
		SKELE_DROPS_CONTAINER_CHANCE = 1.0;
		SKELE_START_LIVES = 1;
		SKELE_ARROW_ARC = 1;
		SKELE_ARROW_SPEED = 500;
		ARROW_CL_SCRIPT = "effects/sfx_poison_burst";
		DMG_AOE = 150;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(15.1);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(0, 255, 0), 128, 15.0);
	}

	void skele_spawn()
	{
		SetName("Vile Archer");
		SetHealth(3000);
		SetDamageResistance("acid", 0.25);
		SetDamageResistance("holy", 1.25);
		SetModel("monsters/skeleton_boss1.mdl");
		SetWidth(32);
		SetHeight(80);
		SetModelBody(0, 2);
		SetModelBody(1, 10);
		SetModelBody(2, 0);
	}

	void skele_arrow_fx()
	{
		string ARROW_ORG = param1;
		ClientEvent("new", "all", ARROW_CL_SCRIPT, ARROW_ORG, 128, 1, Vector3(0, 255, 0));
		XDoDamage(ARROW_ORG, SKELE_ARROW_AOE, DMG_AOE, 0, GetOwner(), GetOwner(), "none", "poison_effect");
	}

	void OnPostSpawn() override
	{
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(0, 255, 0), 128, 15.0);
	}

}

}
