#pragma context server

#include "other/hp_trigger_base.as"

namespace MS
{

class HpTrigger1000 : CGameScript
{
	string EVENT_NAME;
	int TRIGGER_RANGE;
	int TRIGGER_REQ;

	HpTrigger1000()
	{
		TRIGGER_RANGE = 512;
		TRIGGER_REQ = 1000;
		EVENT_NAME = "found_1000";
	}

}

}
