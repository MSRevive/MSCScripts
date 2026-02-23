#pragma context server

#include "other/hp_trigger_base.as"

namespace MS
{

class HpTrigger300 : CGameScript
{
	HpTrigger300()
	{
		const int TRIGGER_RANGE = 256;
		const int TRIGGER_REQ = 300;
		const string EVENT_NAME = "found_300";
	}

}

}
