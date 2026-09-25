#pragma context server

#include "furion/dragoons/dragoon.as"

namespace MS
{

class FireRandomNm : CGameScript
{
	int ELEMENT;
	int WEAPON;

	FireRandomNm()
	{
		WEAPON = RandomInt(0, 5);
		ELEMENT = 2;
	}

}

}
