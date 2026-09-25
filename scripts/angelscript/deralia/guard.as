#pragma context server

#include "NPCs/human_guard.as"
#include "monsters/base_chat.as"

namespace MS
{

class Guard : CGameScript
{
	int DERALIA_CHATTER;
	int NO_JOB;
	int NO_RUMOR;

	Guard()
	{
		NO_RUMOR = 1;
		NO_JOB = 1;
		DERALIA_CHATTER = 1;
	}

	void OnSpawn() override
	{
		SetGold(10);
		CatchSpeech("say_hi", "hi");
	}

	void say_hi()
	{
		if ((DERALIA_CHATTER))
		{
			int L_GREETING = RandomInt(0, 3);
			if (L_GREETING == 0)
			{
				SayText("Thordac's shop produces most of the weapons here.");
			}
			else
			{
				if (L_GREETING == 1)
				{
					SayText("I should've joined the army.");
				}
				else
				{
					if (L_GREETING == 2)
					{
						SayText("Brawls of opposing worshippers often break out near the temples.");
					}
					else
					{
						if (L_GREETING == 3)
						{
							SayText("If you're looking for work, I heard Gerald needed help with something.");
						}
					}
				}
			}
		}
	}

}

}
