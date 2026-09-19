#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeIce : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeIce()
	{
		KEY_NAME = "key_blue";
		KEYHOLE_NAME = "Ice Encrusted Keyhole";
		KEYHOLE_TITLE = "Use the Ice key";
		RETURN_KEY = 0;
	}

}

}
