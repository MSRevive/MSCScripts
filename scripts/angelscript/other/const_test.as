#pragma context server

#include "other/const_test_inc.as"

namespace MS
{

class ConstTest : CGameScript
{
	ConstTest()
	{
		const int TOP_CONST = 1;
		Precache("dwarf/male1.mdl");
	}

	void OnSpawn() override
	{
		ScheduleDelayedEvent(0.1, "say_const");
		ScheduleDelayedEvent(1.0, "ext_change_const");
	}

	void say_const()
	{
		SayText("The constants are top TOP_CONST and bottom BOTTOM_CONST");
	}

	void ext_change_const()
	{
		// TODO: UNCONVERTED: const_ovrd TOP_CONST A
		// TODO: UNCONVERTED: const_ovrd BOTTOM_CONST B
		SayText("The changed to top TOP_CONST and bottom BOTTOM_CONST");
		SayText("Scriptvar top GetEntityProperty(GetOwner(), "scriptvar") and bottom GetEntityProperty(GetOwner(), "scriptvar")");
	}

}

}
