#pragma context server

#include "chests/bag_o_gold_base.as"

namespace MS
{

class BagOGold50 : CGameScript
{
	int GOLD_AMT;

	BagOGold50()
	{
		GOLD_AMT = RandomInt(40, 50);
	}

}

}
