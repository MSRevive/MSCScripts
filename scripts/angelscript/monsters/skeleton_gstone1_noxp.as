#pragma context server

#include "monsters/skeleton_gstone1.as"

namespace MS
{

class SkeletonGstone1Noxp : CGameScript
{
	int DROP_GOLD;
	int NPC_GIVE_EXP;

	SkeletonGstone1Noxp()
	{
		NPC_GIVE_EXP = 0;
		DROP_GOLD = 0;
	}

}

}
