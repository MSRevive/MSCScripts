#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcherFire1 : CGameScript
{
	int C_SKELE_ARROW_KNOCKBACK;
	int C_SKELE_PUSH_STRENGTH;
	int DMG_ARROW;
	int DMG_SWIPE;
	int NPC_GIVE_EXP;
	int SKELE_ARROW_AOE;
	string SKELE_ARROW_EFFECT;
	int SKELE_ARROW_GLOW;
	string SKELE_ARROW_GLOW_COLOR;
	string SKELE_ARROW_SCRIPT;
	string SKELE_CONTAINER_SCRIPT;
	int SKELE_DOT_DMG;
	float SKELE_DOT_DUR;
	int SKELE_DROPS_CONTAINER;
	float SKELE_DROPS_CONTAINER_CHANCE;
	int SKELE_GOLD;
	int SKELE_START_LIVES;

	SkeletonArcherFire1()
	{
		NPC_GIVE_EXP = 400;
		DMG_ARROW = 200;
		DMG_SWIPE = 30;
		C_SKELE_PUSH_STRENGTH = 200;
		SKELE_GOLD = 50;
		SKELE_ARROW_EFFECT = "effects/dot_fire";
		SKELE_ARROW_AOE = 0;
		SKELE_DOT_DMG = 50;
		SKELE_DOT_DUR = 5.0;
		SKELE_ARROW_GLOW = 1;
		SKELE_ARROW_GLOW_COLOR = Vector3(255, 0, 0);
		SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		C_SKELE_ARROW_KNOCKBACK = 400;
		SKELE_DROPS_CONTAINER = 1;
		SKELE_CONTAINER_SCRIPT = "chests/quiver_of_fire";
		SKELE_DROPS_CONTAINER_CHANCE = 0.5;
		SKELE_START_LIVES = 1;
	}

	void skele_spawn()
	{
		SetName("Infernal Archer");
		SetHealth(1000);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("cold", 1.5);
		SetDamageResistance("holy", 1.25);
		SetModel("monsters/skeleton_boss1.mdl");
		SetWidth(32);
		SetHeight(80);
		SetModelBody(0, 3);
		SetModelBody(1, 10);
		SetModelBody(2, 0);
	}

}

}
