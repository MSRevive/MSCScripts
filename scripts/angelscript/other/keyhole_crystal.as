#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeCrystal : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeCrystal()
	{
		KEY_NAME = "key_crystal";
		KEYHOLE_NAME = "Crystal Keyhole.";
		KEYHOLE_TITLE = "Use the crystal key.";
		RETURN_KEY = 1;
	}

}

}
