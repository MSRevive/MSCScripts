#pragma context server

namespace MS
{

class TriggerDamaged : CGameScript
{
	void OnDamage(int damage) override
	{
		LogDebug("game_damaged PARAM1 PARAM2 PARAM3 PARAM4");
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		LogDebug("game_takedamage PARAM1 PARAM2 PARAM3 PARAM4");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		LogDebug("game_struck PARAM1 PARAM2 PARAM3 PARAM4");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		LogDebug("game_death PARAM1 PARAM2 PARAM3 PARAM4");
	}

	void ext_test()
	{
		LogDebug("ext_test PARAM1 PARAM2 PARAM3 PARAM4");
	}

	void ext_report()
	{
		LogDebug("game.monster.origin");
	}

	void ext_follow()
	{
		SetFollow(param1);
	}

}

}
