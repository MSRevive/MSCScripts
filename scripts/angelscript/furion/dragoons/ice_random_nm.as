#pragma context server

#include "furion/dragoons/dragoon.as"

namespace MS
{

class IceRandomNm : CGameScript
{
	string WEAPON;

	IceRandomNm()
	{
		WEAPON = RandomInt(0, 5);
		const int ELEMENT = 0;
	}

}

}
