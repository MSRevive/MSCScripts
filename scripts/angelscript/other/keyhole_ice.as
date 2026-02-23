#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeIce : CGameScript
{
	int RETURN_KEY;

	KeyholeIce()
	{
		const string KEY_NAME = "key_blue";
		const string KEYHOLE_NAME = "Ice Encrusted Keyhole";
		const string KEYHOLE_TITLE = "Use the Ice key";
		RETURN_KEY = 0;
	}

}

}
