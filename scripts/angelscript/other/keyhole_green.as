#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeGreen : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeGreen()
	{
		KEY_NAME = "key_green";
		KEYHOLE_NAME = "Jade Keyhole";
		KEYHOLE_TITLE = "Use the jade key";
		RETURN_KEY = 0;
	}

}

}
