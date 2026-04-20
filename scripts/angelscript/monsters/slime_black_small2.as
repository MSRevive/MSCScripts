#pragma context server

#include "monsters/slime_black_small.as"

namespace MS
{

class SlimeBlackSmall2 : CGameScript
{
	void OnSpawn() override
	{
		SetRace("demon");
	}

}

}
