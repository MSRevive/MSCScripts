#pragma context server

#include "monsters/wolf_base.as"

namespace MS
{

class WolfAlpha : CGameScript
{
	int AM_ALPHA;
	int NPC_GIVE_EXP;

	WolfAlpha()
	{
		AM_ALPHA = 1;
		NPC_GIVE_EXP = 35;
	}

}

}
