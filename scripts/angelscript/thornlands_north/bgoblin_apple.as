#pragma context server

#include "m2_quest/bgoblin_weak.as"

namespace MS
{

class BgoblinApple : CGameScript
{
	void OnSpawn() override
	{
		ScheduleDelayedEvent(2.0, "start_apple_chatter");
		SetSayTextRange(900);
	}

	void start_apple_chatter()
	{
		if (!(APPLE_CHATTER))
		{
			SetName("Blood Goblin");
			SayText("You took an apple?? Apple is worthless!");
			EmitSound(GetOwner(), 0, "voices/thornlands_north/gobapple1.wav", 10);
			ScheduleDelayedEvent(4, "start_apple_chatter");
		}
		else
		{
			if (APPLE_CHATTER == 1)
			{
				SetName("Goblin Needler");
				SayText("A human had this apple, it must be valuable.");
				EmitSound(GetOwner(), 0, "voices/thornlands_north/gobapple2.wav", 10);
				ScheduleDelayedEvent(4, "start_apple_chatter");
			}
			else
			{
				if (APPLE_CHATTER == 2)
				{
					SetName("Blood Goblin");
					SayText("A human picked this apple from a TREE!");
					EmitSound(GetOwner(), 0, "voices/thornlands_north/gobapple3.wav", 10);
					ScheduleDelayedEvent(3, "start_apple_chatter");
				}
				else
				{
					if (APPLE_CHATTER == 3)
					{
						SetName("Goblin Needler");
						SayText("Show me trees with apples. I've seen none!");
						EmitSound(GetOwner(), 0, "voices/thornlands_north/gobapple4.wav", 10);
						ScheduleDelayedEvent(4, "start_apple_chatter");
					}
					else
					{
						if (APPLE_CHATTER == 4)
						{
							SetName("Blood Goblin");
							UseTrigger("gobwall2stop");
						}
					}
				}
			}
		}
		APPLE_CHATTER += 1;
	}

}

}
