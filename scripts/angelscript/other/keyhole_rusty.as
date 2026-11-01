#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeRusty : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeRusty()
	{
		KEY_NAME = "item_key_rusty";
		KEYHOLE_NAME = "Rusty Keyhole";
		KEYHOLE_TITLE = "Use the rusty key";
		RETURN_KEY = 0;
	}

}

}
