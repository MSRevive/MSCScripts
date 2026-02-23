#pragma context server

#include "monsters/base.as"
#include "monsters/base_chat.as"

namespace MS
{

class Idlesoldier : CGameScript
{
	Idlesoldier()
	{
		const int NO_RUMOR = 1;
		const int NO_JOB = 1;
	}

	void OnSpawn() override
	{
		SetHealth(300);
		SetWidth(32);
		SetHeight(72);
		SetRace("human_guard");
		SetName("Soldier");
		SetModel("npc/guard1.mdl");
		SetRoam(false);
		SetInvincible(true);
		SetIdleAnim("idle7");
	}

	void say_hi()
	{
		SayText("Sorry adeventurer , we re too busy to talk.");
	}

}

}
