#pragma context server

#include "monsters/bandit_boss.as"

namespace MS
{

class BanditBossAxe : CGameScript
{
	int BOSS_TYPE;
	int BOSS_TYPE_OVERRIDE;

	BanditBossAxe()
	{
		BOSS_TYPE = 3;
		BOSS_TYPE_OVERRIDE = 1;
	}

}

}
