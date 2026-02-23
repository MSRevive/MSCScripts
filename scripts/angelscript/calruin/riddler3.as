#pragma context server

#include "calruin/base_riddler.as"

namespace MS
{

class Riddler3 : CGameScript
{
	Riddler3()
	{
		const string FAILED_MSG = "Your link, strong as the others it is not, goodbye.";
		const string RIDDLE_ANSWER = "time";
	}

	void riddle_question()
	{
		SayText("This thing, all things devours: the birds, the beasts, the trees, the flowers...");
		ScheduleDelayedEvent(1, "riddle_question2");
	}

	void riddle_question2()
	{
		SayText("It gnaws iron and bites steel. It grinds hard stones to meal...");
		ScheduleDelayedEvent(1, "riddle_question3");
	}

	void riddle_question3()
	{
		SayText("It slays kings, and ruins town, and beats high mountain down!");
	}

	void riddle_correct()
	{
		SayText("You are man... He is not man... For you he waits... For you...");
		EmitSound(GetOwner(), CHAN_VOICE, "nihilanth/nil_man_notman.wav", 10);
		UseTrigger("calriandoor");
	}

}

}
