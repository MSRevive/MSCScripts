#pragma context server

namespace MS
{

class Structure : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(300);
		SetInvincible(true);
		SetRoam(false);
		SetName("Stone Wall");
		SetDamageResistance("siege", 1.0);
		SetBloodType("none");
		SetSkillLevel(0);
		Precache("cindergibs.mdl");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		DeleteEntity(GetOwner());
		Effect("tempent", "gibs", "cindergibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1, 5, 15, 20, 5);
	}

	void hit_by_siege()
	{
		SetInvincible(false);
		DeleteEntity(GetOwner());
		Effect("tempent", "gibs", "cindergibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1, 5, 15, 20, 5);
	}

}

}
