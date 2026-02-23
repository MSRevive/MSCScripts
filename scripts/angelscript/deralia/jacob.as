#pragma context server

#include "deralia/guard.as"

namespace MS
{

class Jacob : CGameScript
{
	Jacob()
	{
		const int DERALIA_CHATTER = 0;
	}

	void OnSpawn() override
	{
		SetName("Bouncer Jacob");
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_hayy", "hayy");
	}

	void say_hi()
	{
		if (param1 != "PARAM1")
		{
			string L_GENDER = GetGender(param1);
		}
		else
		{
			string L_GENDER = GetGender("ent_lastspoke");
		}
		if (L_GENDER == "male")
		{
			SayText("I don't recognize you. You'll have to talk to my boss before I let you in.");
		}
		else
		{
			PlayAnim("once", "lean");
			SayText("If you're looking for work, I may have something for you. You've certainly got the looks, but it also requires some skills.");
		}
	}

	void say_hayy()
	{
		if (GetGender("ent_lastspoke") == "male")
		{
			SayText("Hayy ;)");
		}
		else
		{
			SayText("I don't need this. Away with you.");
		}
	}

}

}
