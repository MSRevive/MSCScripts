#pragma context server

#include "monsters/skeleton_archer_base.as"

namespace MS
{

class SkeletonArcherFire2 : CGameScript
{
	string DMG_AOE;
	int NPC_GIVE_EXP;

	SkeletonArcherFire2()
	{
		NPC_GIVE_EXP = 650;
		const int DMG_ARROW = 400;
		const int DMG_SWIPE = 80;
		const int C_SKELE_PUSH_STRENGTH = 400;
		const int SKELE_GOLD = 100;
		const string SKELE_ARROW_EFFECT = "effects/dot_fire";
		const int SKELE_ARROW_AOE = 128;
		const int SKELE_DOT_DMG = 75;
		const float SKELE_DOT_DUR = 5.0;
		const int SKELE_ARROW_GLOW = 1;
		const Vector3 SKELE_ARROW_GLOW_COLOR = Vector3(255, 255, 128);
		const string SKELE_ARROW_SCRIPT = "proj_arrow_npc_dyn";
		const int SKELE_ARROW_KNOCKBACK = 800;
		const int SKELE_DROPS_CONTAINER = 1;
		const string SKELE_CONTAINER_SCRIPT = "chests/quiver_of_fire";
		const float SKELE_DROPS_CONTAINER_CHANCE = 1.0;
		const int SKELE_START_LIVES = 1;
		const int SKELE_ARROW_ARC = 1;
		const int SKELE_ARROW_SPEED = 500;
		const string ARROW_CL_SCRIPT = "effects/sfx_fire_burst";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(15.1);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 0, 0), 128, 15.0);
	}

	void skele_spawn()
	{
		SetName("Demonic Archer");
		SetHealth(3000);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("cold", 1.5);
		SetDamageResistance("holy", 0.75);
		SetModel("monsters/skeleton_boss1.mdl");
		SetWidth(32);
		SetHeight(80);
		SetModelBody(0, 9);
		SetModelBody(1, 10);
		SetModelBody(2, 0);
		ScheduleDelayedEvent(2.0, "final_adj");
	}

	void skele_arrow_fx()
	{
		string ARROW_ORG = param1;
		ClientEvent("new", "all", ARROW_CL_SCRIPT, ARROW_ORG, 128, 1, Vector3(255, 0, 0));
		XDoDamage(ARROW_ORG, SKELE_ARROW_AOE, DMG_AOE, 0, GetOwner(), GetOwner(), "none", "fire_effect");
	}

	void OnPostSpawn() override
	{
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 0, 0), 128, 15.0);
	}

	void final_adj()
	{
		if (NPC_ADJ_LEVEL < 2)
		{
			DMG_AOE = 100;
		}
		else
		{
			DMG_AOE = 400;
		}
	}

}

}
