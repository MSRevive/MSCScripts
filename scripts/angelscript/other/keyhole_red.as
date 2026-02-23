#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeRed : CGameScript
{
	int RETURN_KEY;

	KeyholeRed()
	{
		const string KEY_NAME = "key_red";
		const string KEYHOLE_NAME = "Blood Stained Keyhole";
		const string KEYHOLE_TITLE = "Use the crimson key";
		RETURN_KEY = 0;
	}

}

}
