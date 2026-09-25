#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class MonsterLure : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(1);
		SetRoam(false);
		SetName("Structure");
		SetRace("human");
		SetBloodType("none");
		SetSkillLevel(0);
		Precache("woodgibs.mdl");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		UseTrigger("tower_fall");
		ScheduleDelayedEvent(0.1, "remove_me");
		Effect("tempent", "gibs", "woodgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1, 5, 15, 20, 5);
	}

	void remove_me()
	{
		DeleteEntity("me");
	}

}

}
