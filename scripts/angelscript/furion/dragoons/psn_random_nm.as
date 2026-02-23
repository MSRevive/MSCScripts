#pragma context server

#include "furion/dragoons/dragoon.as"

namespace MS
{

class PsnRandomNm : CGameScript
{
	string WEAPON;

	PsnRandomNm()
	{
		WEAPON = RandomInt(0, 5);
		const int ELEMENT = 1;
	}

}

}
