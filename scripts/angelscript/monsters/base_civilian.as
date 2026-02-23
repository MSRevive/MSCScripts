#pragma context server

namespace MS
{

class BaseCivilian : CGameScript
{
	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		call_for_help(GetEntityIndex(m_hLastStruck));
	}

	void call_for_help()
	{
		SetSayTextRange(1024);
		string RAND_SCREAM = RandomInt(1, 4);
		if (RAND_SCREAM == 1)
		{
			SayText("Help! Help!");
		}
		if (RAND_SCREAM == 2)
		{
			SayText("Guards! Call the guards!");
		}
		if (RAND_SCREAM == 3)
		{
			SayText("Save me!");
		}
		if (RAND_SCREAM == 4)
		{
			SayText("Help! Help! I m being repressed!");
		}
		CallExternal("all", "civilian_attacked", param1, IsValidPlayer(param1));
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal("all", "civilian_attacked", GetEntityIndex(m_hLastStruck), IsValidPlayer(m_hLastStruck));
	}

}

}
