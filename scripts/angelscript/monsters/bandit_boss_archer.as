#pragma context server

#include "monsters/bandit_boss.as"

namespace MS
{

class BanditBossArcher : CGameScript
{
	int BOSS_TYPE;
	int BOSS_TYPE_OVERRIDE;

	BanditBossArcher()
	{
		BOSS_TYPE = 5;
		BOSS_TYPE_OVERRIDE = 1;
	}

}

}
