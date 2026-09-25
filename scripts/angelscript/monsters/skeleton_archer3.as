#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcher3 : CGameScript
{
	int C_SKELE_ARROW_KNOCKBACK;
	int C_SKELE_PUSH_STRENGTH;
	int DMG_ARROW;
	int DMG_SWIPE;
	int NPC_GIVE_EXP;
	string SKELE_ARROW_SCRIPT;
	string SKELE_CONTAINER_SCRIPT;
	int SKELE_DROPS_CONTAINER;
	float SKELE_DROPS_CONTAINER_CHANCE;
	int SKELE_GOLD;
	int SKELE_START_LIVES;

	SkeletonArcher3()
	{
		NPC_GIVE_EXP = 400;
		DMG_ARROW = 200;
		DMG_SWIPE = 30;
		C_SKELE_PUSH_STRENGTH = 400;
		SKELE_GOLD = 50;
		SKELE_DROPS_CONTAINER = 1;
		SKELE_CONTAINER_SCRIPT = "chests/quiver_of_jagged";
		SKELE_DROPS_CONTAINER_CHANCE = 0.3;
		SKELE_START_LIVES = 1;
		SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		C_SKELE_ARROW_KNOCKBACK = 200;
	}

	void skele_spawn()
	{
		SetName("Guardian Archer");
		SetHealth(1000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("stun", 0.5);
		SetModel("monsters/skeleton_boss1.mdl");
		SetWidth(32);
		SetHeight(80);
		SetModelBody(0, 10);
		SetModelBody(1, 10);
		SetModelBody(2, 0);
	}

}

}
