#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcherStone1 : CGameScript
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
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	int STONE_SKELETON;

	SkeletonArcherStone1()
	{
		NPC_GIVE_EXP = 500;
		DMG_ARROW = 500;
		DMG_SWIPE = 80;
		C_SKELE_PUSH_STRENGTH = 200;
		SKELE_GOLD = 50;
		SKELE_DROPS_CONTAINER = 1;
		SKELE_CONTAINER_SCRIPT = "chests/quiver_of_jagged";
		SKELE_DROPS_CONTAINER_CHANCE = 0.5;
		SKELE_START_LIVES = 1;
		SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		C_SKELE_ARROW_KNOCKBACK = 400;
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STRUCK3 = "debris/concrete1.wav";
		STONE_SKELETON = 1;
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
