#pragma context server

#include "furion/dragoons/dragoon.as"

namespace MS
{

class IceRandomNm : CGameScript
{
	int ELEMENT;
	int WEAPON;

	IceRandomNm()
	{
		WEAPON = RandomInt(0, 5);
		ELEMENT = 0;
	}

}

}
