#pragma context server

#include "other/base_keyhole.as"

namespace MS
{

class Keyhole : CGameScript
{
	int RETURN_KEY;

	Keyhole()
	{
		const string KEY_NAME = "tutorial_key";
		const string KEYHOLE_NAME = "keyhole";
		const string KEYHOLE_TITLE = "Use Key";
		RETURN_KEY = 0;
	}

	void OnSpawn() override
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
	}

}

}
