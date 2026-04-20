#pragma context server

#include "monsters/bandit_boss.as"

namespace MS
{

class BanditBossMace : CGameScript
{
	int BOSS_TYPE;
	int BOSS_TYPE_OVERRIDE;

	BanditBossMace()
	{
		BOSS_TYPE = 2;
		BOSS_TYPE_OVERRIDE = 1;
	}

}

}
