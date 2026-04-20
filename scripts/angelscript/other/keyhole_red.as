#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeRed : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeRed()
	{
		KEY_NAME = "key_red";
		KEYHOLE_NAME = "Blood Stained Keyhole";
		KEYHOLE_TITLE = "Use the crimson key";
		RETURN_KEY = 0;
	}

}

}
