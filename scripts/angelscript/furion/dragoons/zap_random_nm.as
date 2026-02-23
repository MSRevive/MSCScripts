#pragma context server

#include "furion/dragoons/dragoon.as"

namespace MS
{

class ZapRandomNm : CGameScript
{
	ZapRandomNm()
	{
		const string WEAPON = RandomInt(0, 5);
		const int ELEMENT = 3;
	}

}

}
