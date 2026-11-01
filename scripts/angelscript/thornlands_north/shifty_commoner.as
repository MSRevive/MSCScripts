#pragma context server

#include "deralia/commoner.as"

namespace MS
{

class ShiftyCommoner : CGameScript
{
	void OnSpawn() override
	{
		ScheduleDelayedEvent(2.0, "start_shifty");
		SetSayTextRange(900);
	}

	void start_shifty()
	{
		SetRoam(false);
		if (!(CHATTER))
		{
			SayText("Hey, you look like an adventurer. Come here.");
			EmitSound(GetOwner(), 0, "voices/thornlands_north/shifty1.wav", 10);
			ScheduleDelayedEvent(4.5, "start_shifty");
		}
		else
		{
			if (CHATTER == 1)
			{
				SayText("I left some... valuable... items in a secret cave near those bears.");
				EmitSound(GetOwner(), 0, "voices/thornlands_north/shifty2.wav", 10);
				ScheduleDelayedEvent(5.7, "start_shifty");
			}
			else
			{
				if (CHATTER == 2)
				{
					SayText("You NEED to help me get them back. You will be... well rewarded.");
					EmitSound(GetOwner(), 0, "voices/thornlands_north/shifty3.wav", 10);
					ScheduleDelayedEvent(8, "start_shifty");
				}
				else
				{
					if (CHATTER == 3)
					{
						UseTrigger("WallBlock11");
					}
				}
			}
		}
		CHATTER += 1;
	}

}

}
