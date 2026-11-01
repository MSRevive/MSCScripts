#pragma context server

#include "monsters/base_chat.as"
#include "help/first_marketsquare.as"
#include "monsters/base_react.as"

namespace MS
{

class Mergur : CGameScript
{
	int CHAT_GREET;
	int ENTRY_GOLD;
	int NPC_REACT_SEETARGET_RANGE;
	int STORE_CLOSED;

	Mergur()
	{
		NPC_REACT_SEETARGET_RANGE = 128;
	}

	void OnSpawn() override
	{
		SetHealth(20);
		SetGold(26);
		SetName("Merchant Square Keeper");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(1, 1);
		ENTRY_GOLD = RandomInt(2, 4);
		SetMenuAutoOpen(1);
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumor", "rumor");
		open_store();
	}

	void npcreact_targetsighted()
	{
		if (!(CHAT_GREET)) return;
		if ((STORE_CLOSED)) return;
		say_hi();
	}

	void OnUse(CBaseEntity@ activator, CBaseEntity@ caller, int useType) override
	{
		say_hi();
	}

	void say_hi()
	{
		if (!(CHAT_GREET)) return;
		if (STORE_CLOSED == 0)
		{
			PlayAnim("once", "studycart");
			SayText("Greetings and welcome to the merchant square!");
			Say("[.5] [.1] [.1] [.05] [.05] [.1] [.3]");
			ScheduleDelayedEvent(2, "say_hi_2");
		}
		else
		{
			SayText("Sorry, the square is closed from midnight 'til nine");
			Say("[.3] [.1] [.1] [.1] [.1] [.1] [.05] [.05] [.04] [.5]");
		}
		CHAT_GREET = 0;
		ScheduleDelayedEvent(6, "reset_greet");
	}

	void say_hi_2()
	{
		SayText("The entry fee is " + ENTRY_GOLD + " gold , you can stay as long as you want.");
	}

	void reset_greet()
	{
		CHAT_GREET = 1;
	}

	void game_recvoffer_gold()
	{
		if (STORE_CLOSED == 0)
		{
			if ("game.offer.gold" >= ENTRY_GOLD)
			{
				if ("game.offer.gold" > ENTRY_GOLD)
				{
					SayText("More then I needed!");
				}
				else
				{
					SayText("Thank you very much!");
				}
				Say("[.05] [.05] [.05] [.03] [.1] [.05] [.2]");
				ReceiveOffer("accept");
				PlayAnim("once", "yes");
				recv_payment(GetEntityIndex("ent_lastgave"));
			}
			else
			{
				ReceiveOffer("reject");
				recv_payment_failed(GetEntityIndex("ent_lastgave"));
			}
		}
		else
		{
			SayText("Sorry, the square is closed from midnight 'til nine");
			Say("[.05] [.05] [.05] [.01] [.1] [.05] [.2] [.1] [.1]");
			ReceiveOffer("reject");
			PlayAnim("once", "no");
		}
	}

	void menu_recv_payment()
	{
		SayText("Thank you very much!");
		Say("[.05] [.05] [.05] [.03] [.1] [.05] [.2]");
		ReceiveOffer("accept");
		PlayAnim("once", "yes");
		recv_payment(param1);
	}

	void menu_recv_payment_failed()
	{
		SayText("Thank you very much!");
		Say("[.05] [.05] [.05] [.03] [.1] [.05] [.2]");
		ReceiveOffer("accept");
		PlayAnim("once", "yes");
		recv_payment(param1);
	}

	void recv_payment()
	{
		UseTrigger("door1");
	}

	void recv_payment_failed()
	{
		SayText("I'm sorry, but since we just got this merchant square set up,");
		Say("[.05] [.1] [.1] [.1] [.1] [.1] [.08] [.08] [.05] [.1] [.1] [.2]");
		ScheduleDelayedEvent(1, "speech_materials");
		PlayAnim("once", "no");
	}

	void speech_materials()
	{
		SayText("we have to charge a little extra to pay for materials. I'm sure you understand...");
	}

	void say_job()
	{
		SayText("Well , " + I + "just recently hired a new guard so " + I + " m afraid we re fully staffed now.");
		Say("[.4] [.2] [.2] [.1] [.1] [.1] [.2] [.05] [.05] [.2] [.1] [.3] [.2] [.3] [.1]");
	}

	void say_rumor()
	{
		PlayAnim("once", "pondering");
		SayText("Tristan is after the mayor , but he can t leave his post. He s at the backalley of the merchant square.");
	}

	void open_store()
	{
		CHAT_GREET = 1;
		STORE_CLOSED = 0;
	}

	void close_store()
	{
		CHAT_GREET = 0;
		STORE_CLOSED = 1;
	}

	void game_menu_getoptions()
	{
		if (!(STORE_CLOSED))
		{
			string reg.mitem.id = "payment";
			string reg.mitem.title = "Pay ";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "gold:";
			string reg.mitem.callback = "menu_recv_payment";
			string reg.mitem.cb_failed = "menu_recv_payment_failed";
		}
		else
		{
			string reg.mitem.title = "Merc. Square Closed";
			string reg.mitem.type = "disabled";
		}
	}

}

}
