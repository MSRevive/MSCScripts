#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcher3 : CGameScript
{
	int NPC_GIVE_EXP;

	SkeletonArcher3()
	{
		NPC_GIVE_EXP = 400;
		const int DMG_ARROW = 200;
		const int DMG_SWIPE = 30;
		const int C_SKELE_PUSH_STRENGTH = 400;
		const int SKELE_GOLD = 50;
		const int SKELE_DROPS_CONTAINER = 1;
		const string SKELE_CONTAINER_SCRIPT = "chests/quiver_of_jagged";
		const float SKELE_DROPS_CONTAINER_CHANCE = 0.3;
		const int SKELE_START_LIVES = 1;
		const string SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		const int C_SKELE_ARROW_KNOCKBACK = 200;
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
