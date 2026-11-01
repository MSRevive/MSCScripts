#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	void gm_phobia_tele_bandits()
	{
		string BANDIT_ID = FindEntityByName("bandit_ralion");
		if ((IsEntityAlive(BANDIT_ID)))
		{
			SetEntityOrigin(BANDIT_ID, Vector3(328, 2432, -272));
		}
		string BANDIT_ID = FindEntityByName("bandit_betor");
		if ((IsEntityAlive(BANDIT_ID)))
		{
			SetEntityOrigin(BANDIT_ID, Vector3(448, 2560, -272));
		}
		string BANDIT_ID = FindEntityByName("bandit_skelr");
		if ((IsEntityAlive(BANDIT_ID)))
		{
			SetEntityOrigin(BANDIT_ID, Vector3(208, 2560, -272));
		}
	}

	void gm_phobia_bandit_lights()
	{
		CallExternal("all", "bandit_ally_lights");
	}

}

}
