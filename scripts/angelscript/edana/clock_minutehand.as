#pragma context server

#include "worlditems/clock_base.as"

namespace MS
{

class ClockMinutehand : CGameScript
{
	int local.updateminutehand;

	ClockMinutehand()
	{
		local.updateminutehand = 1;
	}

}

}
