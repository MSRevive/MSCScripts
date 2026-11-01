#pragma context server

#include "tundra/base_firepit.as"

namespace MS
{

class Firepit1 : CGameScript
{
	void gave_torch()
	{
		UseTrigger("fire1");
	}

}

}
