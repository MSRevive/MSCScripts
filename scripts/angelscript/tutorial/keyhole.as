#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class Keyhole : CGameScript
{
	string KEYHOLE_NAME;
	string KEYHOLE_TITLE;
	string KEY_NAME;
	int RETURN_KEY;

	Keyhole()
	{
		KEY_NAME = "tutorial_key";
		KEYHOLE_NAME = "keyhole";
		KEYHOLE_TITLE = "Use Key";
		RETURN_KEY = 0;
	}

	void OnSpawn() override
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
	}

}

}
