#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeSkeleton : CGameScript
{
	int RETURN_KEY;

	KeyholeSkeleton()
	{
		const string KEY_NAME = "key_skeleton";
		const string KEYHOLE_NAME = "Keyhole carved from bones";
		const string KEYHOLE_TITLE = "Use the skeleton key";
		RETURN_KEY = 0;
	}

}

}
