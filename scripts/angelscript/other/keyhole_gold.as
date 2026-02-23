#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeGold : CGameScript
{
	int RETURN_KEY;

	KeyholeGold()
	{
		const string KEY_NAME = "key_gold";
		const string KEYHOLE_NAME = "Golden Keyhole";
		const string KEYHOLE_TITLE = "Use the gold key";
		RETURN_KEY = 0;
	}

}

}
