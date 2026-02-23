#pragma context server

namespace MS
{

class ProtectMe : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(4000);
		SetRoam(false);
		SetRace("undead");
		SetName("Crystal Shield");
		SetBloodType("none");
		SetSkillLevel(0);
		SetModel("null.mdl");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		CallExternal("all", "npcatk_ally_alert", GetEntityIndex(m_hLastStruck), GetEntityIndex(GetOwner()), "crystal_hit");
	}

	void OnDamage(int damage) override
	{
		CallExternal("all", "npcatk_ally_alert", GetEntityIndex(m_hLastStruck), GetEntityIndex(GetOwner()), "crystal_hit");
	}

}

}
