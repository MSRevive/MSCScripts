#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcherLightning1 : CGameScript
{
	int NPC_GIVE_EXP;

	SkeletonArcherLightning1()
	{
		NPC_GIVE_EXP = 450;
		const int DMG_ARROW = 200;
		const int DMG_SWIPE = 30;
		const int C_SKELE_PUSH_STRENGTH = 400;
		const int SKELE_GOLD = 50;
		const string SKELE_ARROW_EFFECT = "effects/dot_lightning";
		const int SKELE_ARROW_AOE = 0;
		const int SKELE_DOT_DMG = 30;
		const float SKELE_DOT_DUR = 5.0;
		const int SKELE_ARROW_GLOW = 1;
		const Vector3 SKELE_ARROW_GLOW_COLOR = Vector3(255, 255, 0);
		const string SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		const int C_SKELE_ARROW_KNOCKBACK = 400;
		const int SKELE_DROPS_CONTAINER = 1;
		const string SKELE_CONTAINER_SCRIPT = "chests/quiver_of_lightning";
		const float SKELE_DROPS_CONTAINER_CHANCE = 0.5;
		const int SKELE_START_LIVES = 1;
	}

	void skele_spawn()
	{
		SetName("Thunder Archer");
		SetHealth(1000);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("holy", 1.25);
		SetModel("monsters/skeleton_boss1.mdl");
		SetWidth(32);
		SetHeight(80);
		SetModelBody(0, 6);
		SetModelBody(1, 10);
		SetModelBody(2, 0);
	}

}

}
