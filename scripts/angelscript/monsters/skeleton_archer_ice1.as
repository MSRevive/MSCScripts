#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcherIce1 : CGameScript
{
	int NPC_GIVE_EXP;

	SkeletonArcherIce1()
	{
		NPC_GIVE_EXP = 500;
		const int DMG_ARROW = 200;
		const int DMG_SWIPE = 30;
		const int C_SKELE_PUSH_STRENGTH = 200;
		const int SKELE_GOLD = 50;
		const string SKELE_ARROW_EFFECT = "effects/dot_cold";
		const int SKELE_ARROW_AOE = 0;
		const int SKELE_DOT_DMG = 25;
		const float SKELE_DOT_DUR = 8.0;
		const int SKELE_ARROW_GLOW = 1;
		const Vector3 SKELE_ARROW_GLOW_COLOR = Vector3(128, 128, 255);
		const string SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		const int C_SKELE_ARROW_KNOCKBACK = 400;
		const int SKELE_DROPS_CONTAINER = 1;
		const string SKELE_CONTAINER_SCRIPT = "chests/quiver_of_frost";
		const float SKELE_DROPS_CONTAINER_CHANCE = 0.2;
		const int SKELE_START_LIVES = 1;
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
