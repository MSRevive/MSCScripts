#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeTreasury : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeTreasury()
	{
		KEY_NAME = "key_treasury";
		KEYHOLE_NAME = "Keyhole for the Treasury";
		KEYHOLE_TITLE = "Use the treasury key";
		RETURN_KEY = 0;
	}

}

}
