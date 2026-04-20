#pragma context server

#include "tundra/base_firepit.as"

namespace MS
{

class Firepit2 : CGameScript
{
	void gave_torch()
	{
		UseTrigger("fire2");
	}

}

}
