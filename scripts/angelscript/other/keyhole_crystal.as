#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeCrystal : CGameScript
{
	int RETURN_KEY;

	KeyholeCrystal()
	{
		const string KEY_NAME = "key_crystal";
		const string KEYHOLE_NAME = "Crystal Keyhole.";
		const string KEYHOLE_TITLE = "Use the crystal key.";
		RETURN_KEY = 1;
	}

}

}
