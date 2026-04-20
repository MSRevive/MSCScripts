#pragma context server

#include "deralia/guard.as"

namespace MS
{

class GuardWarehouse : CGameScript
{
	int DERALIA_CHATTER;

	GuardWarehouse()
	{
		DERALIA_CHATTER = 0;
	}

	void OnSpawn() override
	{
		SetName("Warehouse Guard");
		CatchSpeech("say_hi", "hi");
	}

	void say_hi()
	{
		int L_GREETING = RandomInt(0, 2);
		if (L_GREETING == 0)
		{
			SayText("We were expecting a shipment from Ara- should have been in weeks ago...");
		}
		else
		{
			if (L_GREETING == 1)
			{
				SayText("The man with the strange hat keeps trying to talk to me. I try to ignore him.");
			}
			else
			{
				if (L_GREETING == 2)
				{
					SayText("Shipments from all around Daragoth come through here.");
				}
			}
		}
	}

}

}
