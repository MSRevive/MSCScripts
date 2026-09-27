#pragma context server

#include "furion/dragoons/dragoon.as"

namespace MS
{

class ZapRandomNm : CGameScript
{
	int ELEMENT;
	int WEAPON;

	ZapRandomNm()
	{
		WEAPON = RandomInt(0, 5);
		ELEMENT = 3;
	}

}

}
