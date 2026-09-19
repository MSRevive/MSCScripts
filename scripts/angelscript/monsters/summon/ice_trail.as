#pragma context server

namespace MS
{

class IceTrail : CGameScript
{
	string DMG_FREEZE;
	string DUR_FREEZE;
	string MY_OWNER;

	IceTrail()
	{
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		DUR_FREEZE = param2;
		DMG_FREEZE = param3;
	}

}

}
