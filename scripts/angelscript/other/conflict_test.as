#pragma context server

#include "monsters/externals.as"
#include "monsters/debug.as"

namespace MS
{

class ConflictTest : CGameScript
{
	int CHECK_CONFLICTS;
	int NOTICE_THIS_CONFLICT;

	ConflictTest()
	{
		CHECK_CONFLICTS = 1;
		const int NOTICE_THIS_CONFLICT = 1;
		NOTICE_THIS_CONFLICT = 2;
	}

	void OnSpawn() override
	{
		SetName("Conflict Checker");
		SetModel("monsters/skeleton.mdl");
		SetWidth(32);
		SetHeight(32);
		SetHealth(10);
		SetRace("beloved");
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		PlayAnim("once", "idle1");
	}

}

}
