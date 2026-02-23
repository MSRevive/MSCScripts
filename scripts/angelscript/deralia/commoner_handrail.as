#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"

namespace MS
{

class CommonerHandrail : CGameScript
{
	int BUSY_CHATTING;
	int CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	int CHAT_STEPS;
	int MENTIONED_BOAT;
	string RND_TALK;

	CommonerHandrail()
	{
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
	}

	void OnSpawn() override
	{
		SetHealth(15);
		SetWidth(5);
		SetHeight(64);
		SetRace("beloved");
		SetName("Commoner");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 2);
		SetIdleAnim("handrailidle");
		SetInvincible(true);
		CatchSpeech("say_hi", "hello");
		CatchSpeech("say_boat", "boat");
	}

	void say_hi()
	{
		RND_TALK = RandomInt(1, 3);
		if (RND_TALK == 1)
		{
			respond1();
		}
		if (RND_TALK == 2)
		{
			respond2();
		}
		if (RND_TALK == 3)
		{
			respond3();
		}
	}

	void respond1()
	{
		SayText("Sometimes I just come here and look up at the stars.");
	}

	void respond2()
	{
		SayText("...");
	}

	void respond3()
	{
		SayText("I'd love to row that boat and never come back, if these arms weren't so sore.");
		MENTIONED_BOAT = 1;
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Ask about the row boat";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_boat";
		if (!(MENTIONED_BOAT)) return;
		string reg.mitem.title = "Rent the Rowboat (5 gp)";
		string reg.mitem.type = "payment";
		string reg.mitem.data = "gold:5";
		string reg.mitem.callback = "borrow_boat";
		string reg.mitem.cb_failed = "payment_failed";
	}

	void borrow_boat()
	{
		CallExternal(GAME_MASTER, "gm_create_vote", "gm_votemap", "Yes!:gertenheld_cape;No!:0", "Row to Gertenheld Cape?");
		CallExternal("players", "ext_set_map", "gertenheld_cape", "from_deralia", "from_deralia");
	}

	void payment_failed()
	{
		SayText("Oh, ya can't lift yer five pennies? I cannae lift me oars. Thats too bad.");
	}

	void say_boat()
	{
		MENTIONED_BOAT = 1;
		if ((BUSY_CHATTING)) return;
		CHAT_STEPS = 3;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "That little boat down there? I... rent it out sometimes.";
		CHAT_STEP2 = "It doesn't go as far as Charon's galleon, of course, but the little thing can get into places where his beast can't.";
		CHAT_STEP3 = "For instance, you can row up to Gertenheld cape, and see the lighthouse. Easy row that.";
		chat_loop();
	}

}

}
