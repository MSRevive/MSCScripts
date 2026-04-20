#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class KingOfDeralia : CGameScript
{
	int BUSY_CHATTING;
	float CHAT_DELAY;
	string CURRENT_SPEAKER;
	float FREQ_MOURN;
	string GUARD1_ID;
	string GUARD2_ID;
	int IN_MOURNING;
	string KING_MODEL;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;

	KingOfDeralia()
	{
		FREQ_MOURN = Random(10, 30);
		NO_RUMOR = 1;
		NO_HAIL = 1;
		NO_JOB = 1;
		CHAT_DELAY = 5.0;
		KING_MODEL = "npc/king.mdl";
	}

	void OnSpawn() override
	{
		SetName("da_king");
		SetName("The King of Deralia");
		SetHealth(1);
		SetInvincible(true);
		SetModel(KING_MODEL);
		SetWidth(32);
		SetHeight(96);
		SetSayTextRange(640);
		SetIdleAnim("idle1");
		PlayAnim("once", "idle1");
		CatchSpeech("say_hi", "hail");
		if (!(true)) return;
		ScheduleDelayedEvent(5.0, "get_guard_id");
		if ((G_DAUGHTER_RESCUED)) return;
		IN_MOURNING = 1;
		FREQ_MOURN("do_mourn");
	}

	void get_guard_id()
	{
		GUARD1_ID = FindEntityByName("king_guard1");
		GUARD2_ID = FindEntityByName("king_guard2");
	}

	void do_mourn()
	{
		if ((G_DAUGHTER_RESCUED)) return;
		FREQ_MOURN("do_mourn");
		if ((BUSY_CHATTING)) return;
		int RND_MOURN = RandomInt(1, 3);
		if (RND_MOURN == 1)
		{
			SayText("Oh woe is me! My princess is lost!");
			CallExternal(GUARD1_ID, "ext_comfort_king");
		}
		if (RND_MOURN == 2)
		{
			SayText("My precious daughter! Where for art thou!");
			CallExternal(GUARD2_ID, "ext_comfort_king");
		}
		if (RND_MOURN == 3)
		{
			SayText("Gone is my reason for living! Missing is my beloved daughter!");
		}
	}

	void say_hi()
	{
		if ((BUSY_CHATTING)) return;
		BUSY_CHATTING = 1;
		if ((IsValidPlayer(param1)))
		{
			CURRENT_SPEAKER = GetEntityIndex(param1);
			face_speaker(CURRENT_SPEAKER);
		}
		if ((IsValidPlayer("ent_lastspoke")))
		{
			CURRENT_SPEAKER = GetEntityIndex("ent_lastspoke");
			face_speaker(CURRENT_SPEAKER);
		}
		if ((G_DAUGHTER_RESCUED)) return;
		BUSY_CHATTING = 1;
		CallExternal(GUARD1_ID, "ext_warn_address", CURRENT_SPEAKER);
		CHAT_DELAY("say_daughter1");
	}

	void say_daughter1()
	{
		SayText("No! No... It s alright, he looks as though he maybe able to help.");
		CHAT_DELAY("say_daughter2");
	}

	void say_daughter2()
	{
		PlayAnim("critical", "fear");
		SayText("The jester! You understand!? He s gone mad! He s kidnapped my beautiful young daughter!");
		CHAT_DELAY("say_daughter3");
	}

	void say_daughter3()
	{
		SayText("They say he was seen scurrying off to the dungeons! But these fools won t go after him!");
		ScheduleDelayedEvent(10.0, "say_daughter4");
		CallExternal(GUARD1_ID, "ext_sworn");
	}

	void say_daughter4()
	{
		SayText("...And " + I + " can t go down into the dungeons, why!?");
		PlayAnim("critical", ANIM_PLEADE);
		CallExternal(GUARD2_ID, "ext_no_place_for");
		SetMoveDest(GUARD2_ID);
		ScheduleDelayedEvent(10.0, "say_daughter5");
	}

	void say_daughter5()
	{
		PlayAnim("critical", ANIM_ANGRY);
		face_speaker(CURRENT_SPEAKER);
		SayText("See these useless fools " + I + " am surrounded by!?");
		CHAT_DELAY("say_daughter6");
	}

	void say_daughter6()
	{
		SayText("Captain Agarath could be trusted with the job , but he s not here, and won t be back for weeks.");
		CHAT_DELAY("say_daughter7");
	}

	void say_daughter7()
	{
		PlayAnim("critical", ANIM_CRY);
		SayText("Please , for pity s sake, rescue my daughter from that madman!");
		ScheduleDelayedEvent(10.0, "resume_morning");
	}

	void resume_morning()
	{
		BUSY_CHATTING = 0;
	}

	void game_menu_getoptions()
	{
		if (!(G_DAUGHTER_RESCUED))
		{
			string reg.mitem.title = "Hail";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_hi";
		}
	}

}

}
