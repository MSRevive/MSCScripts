#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeRusty : CGameScript
{
	int RETURN_KEY;

	KeyholeRusty()
	{
		const string KEY_NAME = "item_key_rusty";
		const string KEYHOLE_NAME = "Rusty Keyhole";
		const string KEYHOLE_TITLE = "Use the rusty key";
		RETURN_KEY = 0;
	}

}

}
