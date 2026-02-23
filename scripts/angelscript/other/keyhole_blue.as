#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeBlue : CGameScript
{
	int RETURN_KEY;

	KeyholeBlue()
	{
		const string KEY_NAME = "key_blue";
		const string KEYHOLE_NAME = "Blue Keyhole";
		const string KEYHOLE_TITLE = "Use the sapphire key";
		RETURN_KEY = 0;
	}

	void key_used()
	{
		UseTrigger("ustart");
	}

}

}
