#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeStorageroomkey : CGameScript
{
	int RETURN_KEY;

	KeyholeStorageroomkey()
	{
		const string KEY_NAME = "item_storageroomkey";
		const string KEYHOLE_NAME = "Storageroom Keyhole";
		const string KEYHOLE_TITLE = "Use the Storageroom key";
		RETURN_KEY = 0;
	}

}

}
