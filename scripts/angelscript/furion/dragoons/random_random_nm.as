#pragma context server

#include "furion/dragoons/dragoon.as"

namespace MS
{

class RandomRandomNm : CGameScript
{
	string WEAPON;

	RandomRandomNm()
	{
		WEAPON = RandomInt(0, 5);
	}

}

}
