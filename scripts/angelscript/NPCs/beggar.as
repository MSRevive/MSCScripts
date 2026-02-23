#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class Beggar : CGameScript
{
	void OnRepeatTimer()
	{
		SetRepeatDelay(30);
		CanSee("ally");
		SetVolume(2);
		Say("chitchat[50] *[20] *[55] *[55] *[23] *[22]");
		SayText("Alms for the poor...");
		ScheduleDelayedEvent(2, "say_alms");
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Beggar");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(0, RandomInt(0, 2));
		SetModelBody(1, RandomInt(0, 5));
		SetIdleAnim("cowering_in_corner");
		SetInvincible(true);
	}

	void say_alms()
	{
		SayText("Please... save a beggar a few coins...");
	}

	void recvoffer_gold()
	{
		ReceiveOffer("accept");
		SayText("Thank you...");
	}

}

}
