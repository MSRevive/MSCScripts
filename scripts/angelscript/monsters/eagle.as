#pragma context server

#include "monsters/eagle_base.as"

namespace MS
{

class Eagle : CGameScript
{
	int NO_DIVE;
	int NPC_GIVE_EXP;

	Eagle()
	{
		NO_DIVE = 1;
		NPC_GIVE_EXP = 100;
	}

}

}
