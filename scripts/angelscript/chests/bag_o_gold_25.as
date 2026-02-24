#pragma context server

#include "chests/bag_o_gold_base.as"

namespace MS
{

class BagOGold25 : CGameScript
{
	int GOLD_AMT;

	BagOGold25()
	{
		GOLD_AMT = RandomInt(20, 25);
	}

}

}
