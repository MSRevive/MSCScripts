#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	int BGOBLIN_CHIEF_SLAIN;
	int VGOBLIN_CHIEF_SLAIN;

	void bgoblin_chief_died()
	{
		string CHIEF_ORG = param1;
		gold_spew(500, 2, 96, 4, 8, CHIEF_ORG);
		BGOBLIN_CHIEF_SLAIN = 1;
	}

	void vgoblin_chief_died()
	{
		string CHIEF_ORG = param1;
		gold_spew(500, 2, 96, 4, 8, CHIEF_ORG);
		VGOBLIN_CHIEF_SLAIN = 1;
	}

}

}
