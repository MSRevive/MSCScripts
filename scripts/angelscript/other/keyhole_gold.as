#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeGold : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeGold()
	{
		KEY_NAME = "key_gold";
		KEYHOLE_NAME = "Golden Keyhole";
		KEYHOLE_TITLE = "Use the gold key";
		RETURN_KEY = 0;
	}

}

}
