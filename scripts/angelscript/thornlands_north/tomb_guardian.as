#pragma context server

#include "calruin/corpse_once.as"

namespace MS
{

class TombGuardian : CGameScript
{
	void OnSpawn() override
	{
		ScheduleDelayedEvent(0.1, "thorny");
		SetSayTextRange(1000);
	}

	void thorny()
	{
		SetName("Guardian of the Tomb");
		SayText("We protect our Master with our unlives, you shall not disturb his torpor.");
		EmitSound(GetOwner(), 0, "voices/thornlands_north/wwprotector.wav", 10);
	}

}

}
