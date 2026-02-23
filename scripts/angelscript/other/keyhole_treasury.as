#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeTreasury : CGameScript
{
	int RETURN_KEY;

	KeyholeTreasury()
	{
		const string KEY_NAME = "key_treasury";
		const string KEYHOLE_NAME = "Keyhole for the Treasury";
		const string KEYHOLE_TITLE = "Use the treasury key";
		RETURN_KEY = 0;
	}

}

}
