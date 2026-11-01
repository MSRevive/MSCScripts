#pragma context server

namespace MS
{

class Ferrin : CGameScript
{
	int RETRIEVE;

	void OnSpawn() override
	{
		SetHealth(30);
		SetGold(50);
		SetName("Ferrin");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(0, 2);
		RETRIEVE = 0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_dangerous", "dangerous");
		CatchSpeech("say_orcs", "orcs");
		CatchSpeech("say_blackhand", "blackhand");
		CatchSpeech("say_keep", "keep");
		CatchSpeech("say_homage", "homage");
		CatchSpeech("say_picture", "picture");
		CatchSpeech("say_retrieve", "retrieve");
	}

	void say_hi()
	{
		SayText("Ahh , another traveller? Please feel free to rest , if you like. It s [dangerous] outside these days.");
	}

	void say_dangerous()
	{
		SayText("Well , it s getting so that I can t even go into the [keep] to pay my respects! That , and [orcs] are ravaging the land.");
	}

	void say_orcs()
	{
		SayText("These terrible [blackhand] Orcs have been tearing through the countryside lately. They leave me alone because they re afraid of the keep.");
	}

	void say_blackhand()
	{
		SayText("It s a new tribe of Orcs that call themselves the Blackhand. They obey some Orcish Shaman named  The Blackhand  and wage war upon humans.");
	}

	void say_keep()
	{
		SayText("The Keledros Keep , of course. " + I + " m the last in a long line of [caretakers] for this bellhouse. We used to serve the Captain Marshall of Keledros.");
	}

	void say_homage()
	{
		SayText(I + " used to go into the keep every seventh day of the week...to pay my respects.");
		ScheduleDelayedEvent(4, "say_homage2");
	}

	void say_homage2()
	{
		SayText("There is a picture of my Great Grandfather Luc where " + I + " would place flowers...");
	}

	void say_homage3()
	{
		SayText("Now the place is so infested with evil " + I + " can t even get the [picture] out");
	}

	void say_picture()
	{
		SayText("Will you go into the keep and retrive my picture for me? " + I + " would be extremely grateful to you! Please say you will go [retrieve] it?");
	}

	void say_retrieve()
	{
		if (!(RETRIEVE == 0)) return;
		RETRIEVE = 1;
		SayText("Thank you so much! Here , you ll need this key to get into the room where it s stored!");
		// TODO: offer ent_lastspoke item_wpkey
	}

	void give_picture()
	{
		ReceiveOffer("accept");
		SayText(A + "picture of my Great Grandfather Luc! Thank you so much adventurer! " + I + "regret " + I + " have little to offer , but take this!");
		// TODO: offer PARAM1 item_storageroomkey
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Say Hello";
		string reg.mitem.type = "say";
		int l.say = RandomInt(2, 4);
		if (l.say == 1)
		{
			string reg.mitem.data = "Hello";
		}
		else
		{
			if (l.say == 2)
			{
				string reg.mitem.data = "Hi";
			}
			else
			{
				if (l.say == 3)
				{
					string reg.mitem.data = "Hail";
				}
				else
				{
					if (l.say == 4)
					{
						string reg.mitem.data = "Greetings!";
					}
				}
			}
		}
		if ((ItemExists(param1, "item_picashlborn")))
		{
			string reg.mitem.title = "Return picture";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_picashlborn";
			string reg.mitem.callback = "give_picture";
		}
	}

}

}
