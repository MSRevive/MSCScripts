#pragma context server

namespace MS
{

class DqMonsterExternals : CGameScript
{
	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((GetEntityProperty(GAME_MASTER, "scriptvar")))
		{
			CallExternal(GAME_MASTER, "gm_dq_add_death", GetEntityName(GetOwner()), GetEntityOrigin(GetOwner()));
		}
	}

}

}
