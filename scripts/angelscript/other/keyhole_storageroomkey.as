#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class KeyholeStorageroomkey : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	KeyholeStorageroomkey()
	{
		KEY_NAME = "item_storageroomkey";
		KEYHOLE_NAME = "Storageroom Keyhole";
		KEYHOLE_TITLE = "Use the Storageroom key";
		RETURN_KEY = 0;
	}

}

}
