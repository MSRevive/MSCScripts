#pragma context server

#include "monsters/bandit_boss.as"

namespace MS
{

class BanditBossDagger : CGameScript
{
	int BOSS_TYPE;
	int BOSS_TYPE_OVERRIDE;

	BanditBossDagger()
	{
		BOSS_TYPE = 1;
		BOSS_TYPE_OVERRIDE = 1;
	}

}

}
