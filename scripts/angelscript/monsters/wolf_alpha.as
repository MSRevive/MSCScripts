#pragma context server

#include "monsters/wolf_base.as"

namespace MS
{

class WolfAlpha : CGameScript
{
	int NPC_GIVE_EXP;

	WolfAlpha()
	{
		const int AM_ALPHA = 1;
		NPC_GIVE_EXP = 35;
	}

}

}
