#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class MonsHateMe : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(1);
		SetRoam(false);
		SetWidth(128);
		SetHeight(128);
		SetModel("none");
		SetName("Structure");
		SetRace("hated");
		SetBloodType("none");
		SetSkillLevel(0);
		Precache("woodgibs.mdl");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		UseTrigger("tower_fall");
		Effect("tempent", "gibs", "woodgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1, 5, 15, 20, 5);
	}

}

}
