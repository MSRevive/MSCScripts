#pragma context server

#include "chests/bag_o_gold_base.as"

namespace MS
{

class BagOGold10 : CGameScript
{
	string GOLD_AMT;

	BagOGold10()
	{
		GOLD_AMT = RandomInt(7, 10);
	}

}

}
