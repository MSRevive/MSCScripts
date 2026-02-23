#pragma context server

#include "calruin/base_riddler.as"

namespace MS
{

class Riddler1 : CGameScript
{
	Riddler1()
	{
		const string FAILED_MSG = "...And here I thought *MY* death was disturbing.";
		const string RIDDLE_ANSWER = "dark";
	}

	void riddle_question()
	{
		SayText("It cannot be seen, cannot be heard, cannot be felt, cannot be smelt...");
		ScheduleDelayedEvent(1, "riddle_question2");
	}

	void riddle_question2()
	{
		SayText("It lies behind stars and under hills and empty holes it fills...");
		ScheduleDelayedEvent(1, "riddle_question3");
	}

	void riddle_question3()
	{
		SayText("It comes first and follows after. It ends life, kills laughter.");
	}

	void riddle_correct()
	{
		SayText("You may pass...");
		UseTrigger("spikedoor1");
	}

}

}
