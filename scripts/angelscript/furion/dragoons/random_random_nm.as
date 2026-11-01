#pragma context server

#include "furion/dragoons/dragoon.as"

namespace MS
{

class RandomRandomNm : CGameScript
{
	int WEAPON;

	RandomRandomNm()
	{
		WEAPON = RandomInt(0, 5);
	}

}

}
