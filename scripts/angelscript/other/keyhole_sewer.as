#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeSewer : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeSewer()
	{
		KEY_NAME = "item_key_sewer";
		KEYHOLE_NAME = "Sewer Maintenance Keyhole";
		KEYHOLE_TITLE = "Use the maintenance key";
		RETURN_KEY = 0;
	}

	void key_used()
	{
		UseTrigger("ustart");
	}

}

}
