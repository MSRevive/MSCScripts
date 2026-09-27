#pragma context server

#include "furion/dragoons/dragoon.as"

namespace MS
{

class PsnRandomNm : CGameScript
{
	int ELEMENT;
	int WEAPON;

	PsnRandomNm()
	{
		WEAPON = RandomInt(0, 5);
		ELEMENT = 1;
	}

}

}
