#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeGreen : CGameScript
{
	int RETURN_KEY;

	KeyholeGreen()
	{
		const string KEY_NAME = "key_green";
		const string KEYHOLE_NAME = "Jade Keyhole";
		const string KEYHOLE_TITLE = "Use the jade key";
		RETURN_KEY = 0;
	}

}

}
