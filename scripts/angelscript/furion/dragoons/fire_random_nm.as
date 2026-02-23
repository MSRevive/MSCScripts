#pragma context server

#include "furion/dragoons/dragoon.as"

namespace MS
{

class FireRandomNm : CGameScript
{
	string WEAPON;

	FireRandomNm()
	{
		WEAPON = RandomInt(0, 5);
		const int ELEMENT = 2;
	}

}

}
