#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_civilian.as"
#include "monsters/base_chat_array.as"

namespace MS
{

class Drunk : CGameScript
{
	int CAUGHT;
	int DRUNKARD_QUEST;
	int QUEST_DONE;
	string ROB_ATTEMPT;
	int SAID_HI;
	string Thief;

	Drunk()
	{
		const int CHAT_AUTO_HAIL = 1;
		const int CHAT_USE_CONV_ANIMS = 0;
		const int CHAT_AUTO_FACE = 0;
		const int CHAT_FACE_ON_USE = 0;
	}

	void OnSpawn() override
	{
		SetName("Drunkard");
		SetHealth(25);
		SetWidth(32);
		SetHeight(32);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetIdleAnim("sitidle");
		SAID_HI = 0;
		CAUGHT = 0;
		DRUNKARD_QUEST = 0;
		QUEST_DONE = 0;
	}

	void game_menu_getoptions()
	{
		if (CAUGHT == 0)
		{
			string reg.mitem.title = "Pickpocket";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_rob";
		}
		if (SAID_HI == 1)
		{
			string reg.mitem.title = "Drink";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_drink";
		}
		if (DRUNKARD_QUEST == 1)
		{
			if ((ItemExists(param1, "drink_mead")))
			{
				string reg.mitem.title = "Give Mead";
				string reg.mitem.type = "payment";
				string reg.mitem.data = "drink_mead";
				string reg.mitem.callback = "give_mead";
			}
		}
	}

	void say_rob()
	{
		ROB_ATTEMPT = RandomInt(1, 3);
		if (ROB_ATTEMPT == 1)
		{
			rob_fail();
		}
		else
		{
			rob_pass();
		}
	}

	void rob_pass()
	{
		Thief = GetEntityIndex(m_hLastUsed);
		// TODO: offer Thief gold 3
		CAUGHT = 1;
	}

	void rob_fail()
	{
		SayText("Get your hands out of my pockets!");
		CAUGHT = 1;
		bchat_mouth_move();
	}

	void say_hi()
	{
		if ((QUEST_DONE))
		{
			SayText("Thanks for *hic* your help, Adventurer.");
			chat_move_mouth(2);
			DRUNKARD_QUEST = 0;
		}
		else
		{
			SayText("*hic* Can you believe they cut me off. I really need another [drink].");
			SAID_HI = 1;
			chat_move_mouth(2.5);
		}
	}

	void say_drink()
	{
		chat_now("Can you go inside the Inn and get me *hic*", 1.8);
		chat_now("I will give you some gold for your troubles.", 2.0);
		chat_now("I would you to get me *hic* of mead.", 2.0);
		chat_move_mouth(6);
		DRUNKARD_QUEST = 1;
	}

	void give_mead()
	{
		SayText("Cheers! Thanks for your *hic* help adventurer.");
		chat_move_mouth(1.5);
		// TODO: offer PARAM1 gold 10
		QUEST_DONE = 1;
		SAID_HI = 0;
		UseTrigger("RenderMug");
	}

}

}
