#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeBlue : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeBlue()
	{
		KEY_NAME = "key_blue";
		KEYHOLE_NAME = "Blue Keyhole";
		KEYHOLE_TITLE = "Use the sapphire key";
		RETURN_KEY = 0;
	}

	void key_used()
	{
		UseTrigger("ustart");
	}

}

}
