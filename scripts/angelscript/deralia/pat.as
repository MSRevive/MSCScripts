#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Pat : CGameScript
{
	int CAN_CHAT;
	string CURRENT_ENEMY;
	int FLEE_PLAYER;
	int HAT_QUEST;
	int NO_JOB;
	int SEE_ENEMY;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;

	Pat()
	{
		FLEE_PLAYER = 0;
		CURRENT_ENEMY = �PNULL�P;
		SOUND_IDLE1 = "voices/human/male_idle4.wav";
		SOUND_IDLE2 = "voices/human/male_idle5.wav";
		SOUND_IDLE3 = "voices/human/male_idle6.wav";
		CAN_CHAT = 1;
		NO_JOB = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(0.5, 1.5));
		if (FLEE_PLAYER == 1)
		{
		}
		SetMoveAnim("run1");
		SetMoveDest("flee");
	}

	void OnSpawn() override
	{
		SetHealth(50);
		SetGold(RandomInt(3, 6));
		SetName("man with a hat");
		SetName("Pat");
		SetWidth(32);
		SetHeight(72);
		SetRace("neutral");
		SetRoam(true);
		SetInvincible(true);
		SetModel("npc/human1.mdl");
		SetMoveAnim("walk_scared");
		SetModelBody(0, 4);
		SetModelBody(1, 2);
		SetBloodType("red");
		GiveItem(GetOwner(), "item_hat");
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_hat", "hat");
		CatchSpeech("say_rumor", "rumours");
		CatchSpeech("say_name", "name");
	}

	void HAT_START()
	{
		HAT_QUEST = 1;
	}

	void say_name()
	{
		SayText("My name is Pat..");
		SetName("Pat with a hat");
	}

	void wander()
	{
		SetMoveAnim("walk_scared");
		SEE_ENEMY = 0;
	}

	void say_hi()
	{
		SayText(I + " didn t do it! I swear!");
	}

	void gossip_1()
	{
		SayText("No thieves in the area! " + I + " know that!");
	}

	void say_hat()
	{
		if (HAT_QUEST == 1)
		{
			SetRace("orc");
			SetInvincible(false);
			SayText("This is my hat! You can t have it!");
			FLEE_PLAYER = 1;
		}
		if (HAT_QUEST == 0)
		{
			SayText("What of " + MY + " hat?");
		}
	}

	void say_rumor()
	{
		PlayAnim("once", "pondering");
		SayText("Rumours? What do " + I + " know of such things? What , huh!? It wasn t me who took those rings!");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		FLEE_PLAYER = 1;
		ScheduleDelayedEvent(60, "reset");
	}

	void reset()
	{
		SetMoveAnim("walk_scared");
		FLEE_PLAYER = 0;
	}

}

}
