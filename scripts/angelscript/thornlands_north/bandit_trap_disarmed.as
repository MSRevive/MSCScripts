#pragma context server

#include "monsters/bandit_hard_random.as"

namespace MS
{

class BanditTrapDisarmed : CGameScript
{
	void OnSpawn() override
	{
		ScheduleDelayedEvent(0.1, "thorny");
		SetSayTextRange(500);
	}

	void thorny()
	{
		SetName("Thornlands Bandit");
		SayText("The traps been disarmed? How?!");
		EmitSound(GetOwner(), 0, "voices/thornlands_north/shifty4.wav", 10);
	}

}

}
