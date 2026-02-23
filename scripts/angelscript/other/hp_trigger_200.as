#pragma context server

#include "other/hp_trigger_base.as"

namespace MS
{

class HpTrigger200 : CGameScript
{
	HpTrigger200()
	{
		const int TRIGGER_RANGE = 256;
		const int TRIGGER_REQ = 200;
		const string EVENT_NAME = "found_200";
	}

}

}
