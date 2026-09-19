#pragma context server

#include "tundra/base_firepit.as"

namespace MS
{

class Firepit3 : CGameScript
{
	void gave_torch()
	{
		UseTrigger("fire3");
	}

}

}
