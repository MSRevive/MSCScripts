#pragma context server

namespace MS
{

class DqApplyCallbackOnDeath : CGameScript
{
	string DQ_WHERE_IS_THE_CREATOR;

	void game_activate()
	{
		DQ_WHERE_IS_THE_CREATOR = param1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(DQ_WHERE_IS_THE_CREATOR, "ext_effected_monster_killed");
	}

}

}
