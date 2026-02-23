#pragma context server

#include "deralia/guard.as"

namespace MS
{

class Bob : CGameScript
{
	Bob()
	{
		const int DERALIA_CHATTER = 0;
	}

	void OnSpawn() override
	{
		SetName("Bob , the Bouncer");
		CatchSpeech("say_hi", "hi");
	}

	void say_hi()
	{
		string L_GREETING = RandomInt(0, 2);
		if (L_GREETING == 0)
		{
			SayText("Gerald wants me to take care of his rat problem. That's not what I get paid for.");
		}
		else
		{
			if (L_GREETING == 1)
			{
				SayText("Don't make any trouble.");
			}
			else
			{
				if (L_GREETING == 2)
				{
					SayText("I drink elsewhere because of the rats here.");
				}
			}
		}
	}

}

}
