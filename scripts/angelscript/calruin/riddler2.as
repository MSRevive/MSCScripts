#pragma context server

#include "calruin/base_riddler.as"

namespace MS
{

class Riddler2 : CGameScript
{
	Riddler2()
	{
		const string FAILED_MSG = "So very disapointing...";
		const string RIDDLE_ANSWER = "river";
	}

	void riddle_question()
	{
		SayText("What can run, yet never walks, has a mouth, yet never talks...");
		ScheduleDelayedEvent(1, "riddle_question2");
	}

	void riddle_question2()
	{
		SayText("...has a head, but never weeps, has a bed, but never sleeps?");
	}

	void riddle_correct()
	{
		SayText("Smarter than I had thought. Or are you...?");
		UseTrigger("spikedoor2");
	}

}

}
