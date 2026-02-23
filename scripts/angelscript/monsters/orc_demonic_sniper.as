#pragma context server

#include "monsters/orc_sniper.as"

namespace MS
{

class OrcDemonicSniper : CGameScript
{
	string ARROW_ORG;
	int DROPS_CONTAINER;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int IS_UNHOLY;

	OrcDemonicSniper()
	{
		const string ARROW_TYPE = "proj_arrow_npc_dyn";
		const string DMG_SMASH = "$rand(50,100)";
		const string DMG_SWIPE = "$rand(20,50)";
		const string DMG_KICK = "$rand(20,50)";
		const string DMG_BOW = RandomInt(100, 200);
		const int DMG_AOE = 400;
		const int DOT_DMG = 30;
		const string DROP_ITEM_BASE1 = "none";
		DROPS_CONTAINER = 1;
		const string CONTAINER_BASE = "chests/quiver_of_fire";
		const int FIN_EXP = 200;
	}

	void orc_spawn()
	{
		SetName("Demonic Blackhand Archer");
		SetProp(GetOwner(), "skin", 2);
		SetWidth(32);
		SetHeight(60);
		SetHealth(400);
		SetHearingSensitivity(2);
		SetStat("parry", 30);
		SetDamageResistance("all", ".8");
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("holy", 0.5);
		IS_UNHOLY = 1;
		SetModelBody(0, 3);
		SetModelBody(1, 3);
		SetModelBody(2, 3);
		ScheduleDelayedEvent(1.0, "reset_range");
		ScheduleDelayedEvent(2.0, "finalize_npc");
	}

	void finalize_npc()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(100, 200);
		DROP_ITEM1 = DROP_ITEM_BASE1;
		DROP_ITEM1_CHANCE = 0.0;
	}

	void ext_arrow_landed()
	{
		ARROW_ORG = param1;
		ClientEvent("new", "all", "effects/sfx_fire_burst", ARROW_ORG, 128, 1, Vector3(255, 0, 0));
		XDoDamage(ARROW_ORG, 128, DMG_AOE, 0, GetOwner(), GetOwner(), "none", "fire_effect", "dmgevent:fireburst");
	}

	void ext_arrow_hit()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 600, 110));
	}

	void fireburst_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_DMG);
		string TARG_ORG = GetEntityOrigin(param2);
		string MY_ORG = ARROW_ORG;
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 500, 110)));
	}

}

}
