#pragma context server

#include "monsters/bandit_boss.as"

namespace MS
{

class BanditBossNova : CGameScript
{
	int BOSS_TYPE;
	int BOSS_TYPE_OVERRIDE;

	BanditBossNova()
	{
		BOSS_TYPE = 6;
		BOSS_TYPE_OVERRIDE = 1;
	}

}

}
