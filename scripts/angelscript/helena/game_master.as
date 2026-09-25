#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	void OnSpawn() override
	{
		if ((G_OLDHELENA_AXE_PICKED))
		{
			UseTrigger("SwitchAxes");
		}
	}

	void helena_bandit_chest()
	{
		string OUT_POS = param1;
		gm_createnpc(10.0, "helena/bandit_boss_chest", OUT_POS);
	}

}

}
