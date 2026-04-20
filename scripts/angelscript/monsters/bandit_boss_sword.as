#pragma context server

#include "monsters/bandit_boss.as"

namespace MS
{

class BanditBossSword : CGameScript
{
	int BOSS_TYPE;
	int BOSS_TYPE_OVERRIDE;

	BanditBossSword()
	{
		BOSS_TYPE = 4;
		BOSS_TYPE_OVERRIDE = 1;
	}

}

}
