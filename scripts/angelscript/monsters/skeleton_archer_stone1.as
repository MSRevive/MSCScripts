#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcherStone1 : CGameScript
{
	int NPC_GIVE_EXP;

	SkeletonArcherStone1()
	{
		NPC_GIVE_EXP = 500;
		const int DMG_ARROW = 500;
		const int DMG_SWIPE = 80;
		const int C_SKELE_PUSH_STRENGTH = 200;
		const int SKELE_GOLD = 50;
		const int SKELE_DROPS_CONTAINER = 1;
		const string SKELE_CONTAINER_SCRIPT = "chests/quiver_of_jagged";
		const float SKELE_DROPS_CONTAINER_CHANCE = 0.5;
		const int SKELE_START_LIVES = 1;
		const string SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		const int C_SKELE_ARROW_KNOCKBACK = 400;
		const string SOUND_STRUCK1 = "weapons/axemetal1.wav";
		const string SOUND_STRUCK2 = "weapons/axemetal2.wav";
		const string SOUND_STRUCK3 = "debris/concrete1.wav";
		const int STONE_SKELETON = 1;
	}

	void skele_spawn()
	{
		SetName("Stone Archer");
		SetHealth(2000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("fire", 1.0);
		SetDamageResistance("stun", 0.25);
		SetModel("monsters/skeleton_boss1.mdl");
		SetWidth(32);
		SetHeight(80);
		SetModelBody(0, 7);
		SetModelBody(1, 10);
		SetModelBody(2, 0);
	}

}

}
