#pragma context server

#include "monsters/orcflayer.as"

namespace MS
{

class Orcboss : CGameScript
{
	void OnSpawn() override
	{
		ScheduleDelayedEvent(0.1, "thorny");
		SetSayTextRange(1000);
	}

	void thorny()
	{
		SetName("|Vakgar the Guardian");
		SayText("What's going on here? Humans!? Destroy them!");
		EmitSound(GetOwner(), 0, "voices/thornlands_north/orcforboss.wav", 10);
	}

}

}
