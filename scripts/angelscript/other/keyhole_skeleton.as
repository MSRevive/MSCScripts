#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeSkeleton : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeSkeleton()
	{
		KEY_NAME = "key_skeleton";
		KEYHOLE_NAME = "Keyhole carved from bones";
		KEYHOLE_TITLE = "Use the skeleton key";
		RETURN_KEY = 0;
	}

}

}
