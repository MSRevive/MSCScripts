#pragma context server

#include "other/hp_trigger_base.as"

namespace MS
{

class HpTrigger1000 : CGameScript
{
	HpTrigger1000()
	{
		const int TRIGGER_RANGE = 512;
		const int TRIGGER_REQ = 1000;
		const string EVENT_NAME = "found_1000";
	}

}

}
