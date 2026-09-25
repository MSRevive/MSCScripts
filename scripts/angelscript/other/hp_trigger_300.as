#pragma context server

#include "other/hp_trigger_base.as"

namespace MS
{

class HpTrigger300 : CGameScript
{
	string EVENT_NAME;
	int TRIGGER_RANGE;
	int TRIGGER_REQ;

	HpTrigger300()
	{
		TRIGGER_RANGE = 256;
		TRIGGER_REQ = 300;
		EVENT_NAME = "found_300";
	}

}

}
