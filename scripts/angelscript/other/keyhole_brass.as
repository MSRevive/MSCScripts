#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeBrass : CGameScript
{
	int RETURN_KEY;

	KeyholeBrass()
	{
		const string KEY_NAME = "key_brass";
		const string KEYHOLE_NAME = "Brass Keyhole";
		const string KEYHOLE_TITLE = "Use the brass key";
		RETURN_KEY = 0;
	}

}

}
