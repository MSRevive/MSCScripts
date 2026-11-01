#pragma context server

#include "monsters/zombie_decayed.as"

namespace MS
{

class ZombieDecayedNr : CGameScript
{
	int ME_NO_WANDER;

	ZombieDecayedNr()
	{
		ME_NO_WANDER = 1;
	}

}

}
