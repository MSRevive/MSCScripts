#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcherIce1 : CGameScript
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

	SkeletonArcherIce1()
	{
		NPC_GIVE_EXP = 500;
		DMG_ARROW = 200;
		DMG_SWIPE = 30;
		C_SKELE_PUSH_STRENGTH = 200;
		SKELE_GOLD = 50;
		SKELE_ARROW_EFFECT = "effects/dot_cold";
		SKELE_ARROW_AOE = 0;
		SKELE_DOT_DMG = 25;
		SKELE_DOT_DUR = 8.0;
		SKELE_ARROW_GLOW = 1;
		SKELE_ARROW_GLOW_COLOR = Vector3(128, 128, 255);
		SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		C_SKELE_ARROW_KNOCKBACK = 400;
		SKELE_DROPS_CONTAINER = 1;
		SKELE_CONTAINER_SCRIPT = "chests/quiver_of_frost";
		SKELE_DROPS_CONTAINER_CHANCE = 0.2;
		SKELE_START_LIVES = 1;
	}

	void skele_spawn()
	{
		SetName("Frozen Archer");
		SetHealth(1000);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("holy", 1.25);
		SetModel("monsters/skeleton_boss1.mdl");
		SetWidth(32);
		SetHeight(80);
		SetModelBody(0, 5);
		SetModelBody(1, 10);
		SetModelBody(2, 0);
	}

}

}
