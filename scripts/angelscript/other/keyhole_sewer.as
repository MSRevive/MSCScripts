#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeSewer : CGameScript
{
	int RETURN_KEY;

	KeyholeSewer()
	{
		const string KEY_NAME = "item_key_sewer";
		const string KEYHOLE_NAME = "Sewer Maintenance Keyhole";
		const string KEYHOLE_TITLE = "Use the maintenance key";
		RETURN_KEY = 0;
	}

	void key_used()
	{
		UseTrigger("ustart");
	}

}

}
