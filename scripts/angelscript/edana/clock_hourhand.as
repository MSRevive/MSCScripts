#pragma context server

#include "worlditems/clock_base.as"

namespace MS
{

class ClockHourhand : CGameScript
{
	int local.updatehourhand;

	ClockHourhand()
	{
		local.updatehourhand = 1;
	}

}

}
