#pragma context server

#include "tundra/base_firepit.as"

namespace MS
{

class Firepit4 : CGameScript
{
	void gave_torch()
	{
		UseTrigger("fire4");
	}

}

}
