#pragma context server

namespace MS
{

class Woodenwall : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(300);
		SetRoam(false);
		SetName("Wooden Wall");
		SetBloodType("none");
		SetSkillLevel(0);
		SetDamageResistance("fire", 2.0);
		Precache("woodgibs.mdl");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		DeleteEntity(GetOwner());
		Effect("tempent", "gibs", "woodgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1, 5, 15, 20, 5);
	}

	void hit_by_siege()
	{
		game_death();
	}

}

}
