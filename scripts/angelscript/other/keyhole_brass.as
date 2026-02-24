#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeBrass : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeBrass()
	{
		KEY_NAME = "key_brass";
		KEYHOLE_NAME = "Brass Keyhole";
		KEYHOLE_TITLE = "Use the brass key";
		RETURN_KEY = 0;
	}

}

}
