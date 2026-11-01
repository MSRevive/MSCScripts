#pragma context server

#include "other/hp_trigger_base.as"

namespace MS
{

class HpTrigger200 : CGameScript
{
	string EVENT_NAME;
	int TRIGGER_RANGE;
	int TRIGGER_REQ;

	HpTrigger200()
	{
		TRIGGER_RANGE = 256;
		TRIGGER_REQ = 200;
		EVENT_NAME = "found_200";
	}

}

}
