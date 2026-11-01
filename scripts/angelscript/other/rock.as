#pragma context server

namespace MS
{

class Rock : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(150);
		SetWidth(128);
		SetHeight(64);
		SetRoam(false);
		SetRace("nothing");
		SetName("large rock");
		SetBloodType("none");
		SetIdleAnim("seq-name");
		SetModel("props/rock1.mdl");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		Effect("tempent", "gibs", "rockgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1.0, /* TODO: $relvel */ $relvel(0, 0, 10), 20, 10, 1);
		SetEntityOrigin(GetOwner(), Vector3(20000, 20000, 20000));
	}

}

}
