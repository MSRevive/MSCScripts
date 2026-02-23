#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "helena/helena_npc.as"

namespace MS
{

class Armourer : CGameScript
{
	int CANCHAT;
	int GOT_KEYPART_1;
	int GOT_KEYPART_2;
	int GOT_KEYPART_3;
	int HAS_KEYPARTS;
	int JOB;
	int JOB.SPEECH1;
	string JOB.TARGET;
	string JOB.WINNER;
	string KEY_INTRO_DELAY;
	string KEY_STEP;
	string NO_JOB;
	string QUEST_WINNER;
	int STORE_CLOSED;
	int VENDOR_NOT_ON_USE;
	string questboar.angle;
	string questboar.target;
	string script.questlog.target;

	Armourer()
	{
		const string SOUND_DEATH = "none";
		STORE_CLOSED = 0;
		const string STORE_NAME = "edana_armory";
		const string STORE_TRIGGERTEXT = "store trade buy sell purchase sale offer";
		const int STORE_SELLMENU = 1;
		const float SELL_RATIO = 0.75;
		const int NO_RUMOR = 1;
		const int VEND_ARMORER = 1;
		const int NPC_REACTS = 1;
		VENDOR_NOT_ON_USE = 1;
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetGold(25);
		SetName("Iron Fist Ike, the Armourer");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/blacksmith.mdl");
		SetInvincible(true);
		JOB = 0;
		CANCHAT = 1;
		STORE_CLOSED = 0;
		createmystore();
		if (StringToLower(GetMapName()) == "helena")
		{
			SetName("Galhad, Dorfgan's Sales Rep");
			NO_JOB = 1;
		}
		if (!(StringToLower(GetMapName()) != "helena")) return;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_yes", "yes");
		CatchSpeech("say_where", "abulurd");
		CatchSpeech("say_key", "key");
	}

	void npcreact_targetsighted()
	{
		if ((GOT_SCARED)) return;
		if ((STORE_CLOSED)) return;
		if (!(GetEntityDist(param1) <= 90)) return;
		if (!(JOB.TARGET != param1)) return;
		if (JOB.WINNER != param1)
		{
			SayText("Howdy! How about a trade?");
		}
		else
		{
			SayText("Howdy /* TODO: $stradd */ $stradd(GetEntityName(JOB.WINNER), "!") What can I do for you?");
		}
	}

	void say_hi()
	{
		if (!(GetEntityDist("ent_lastspoke") <= 90)) return;
		if ((STORE_CLOSED)) return;
		SayText("'Ello there.  Would you like to [buy] some fine armor, traveler?");
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "armor_leather_torn", RandomInt(1, 2), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_leather", RandomInt(1, 2), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_leather_studded", RandomInt(0, 1), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_plate", RandomInt(0, 2), 125, SELL_RATIO);
		AddStoreItem(STORE_NAME, "armor_helm_plate", RandomInt(0, 2), 125, SELL_RATIO);
		AddStoreItem(STORE_NAME, "skin_boar", 0, 150, 0.75);
		AddStoreItem(STORE_NAME, "skin_ratpelt", 0, 250, 0.75);
		AddStoreItem(STORE_NAME, "skin_bear", 0, 150, 1);
		AddStoreItem(STORE_NAME, "skin_boar_heavy", 0, 150, 1);
		AddStoreItem(STORE_NAME, "shields_ironshield", RandomInt(0, 3), 100, 0.25);
		AddStoreItem(STORE_NAME, "shields_buckler", RandomInt(0, 3), 100, SELL_RATIO);
		AddStoreItem(STORE_NAME, "gown_edana", 10, 100, SELL_RATIO);
	}

	void trade_success()
	{
		if (!(CANCHAT == 1)) return;
		EmitSound(GetOwner(), CHAN_VOICE, "npc/goods.wav", "game.sound.maxvol");
		Say("[.34] [.24] [.35] [.40]");
		CANCHAT = 0;
		ScheduleDelayedEvent(10, "resetchat");
	}

	void resetchat()
	{
		CANCHAT = 1;
	}

	void say_job()
	{
		if (JOB == 0)
		{
			JOB = 1;
			SayText("Well you do look strong enough, I could always use a short-term errand-runner. Are ye interested?");
			OpenMenu("ent_lastspoke");
			ScheduleDelayedEvent(300, "reset_job");
		}
		else
		{
			if (JOB.TARGET != GetEntityIndex("ent_lastspoke"))
			{
				if (GetEntityIndex(JOB.TARGET) != param1)
				{
				}
				PlayAnim("once", "no");
				SayText("Sorry, Ive already got me an errand boy. If you see GetEntityName(JOB.TARGET) tell him to hurry it up!");
			}
		}
		if (JOB >= 3)
		{
			SayText("Sorry, think I've got all the help I need for today.");
		}
	}

	void reset_job()
	{
		JOB = 0;
	}

	void say_yes()
	{
		if (!(JOB == 1)) return;
		if ((JOB.SPEECH1)) return;
		JOB.SPEECH1 = 1;
		JOB.TARGET = GetEntityIndex("ent_lastspoke");
		SayText("Excellent! I need you to go to Abulurd , give him this letter.");
		// TODO: offer ent_lastspoke item_ikeletter
		CallExternal(FindEntityByName("abulurd"), "global_quest_letter");
	}

	void say_where()
	{
		if (!(JOB.SPEECH1 == 1)) return;
		SayText("Abulurd? Why he's outside of town in his house. On the path between here and the Temple.");
	}

	void quest_log_done()
	{
		SayText("Hmmm... this does look like a good set. I'll have him send over the rest.");
		script.questlog.target = param1;
		ScheduleDelayedEvent(4, "quest_log_done_2");
	}

	void quest_log_done_2()
	{
		SayText("Well here's something for your trouble.");
		// TODO: offer script.questlog.target gold 6
		ScheduleDelayedEvent(4, "quest_ledger_start");
	}

	void quest_ledger_start()
	{
		SayText("Head back over to Abulurd and ask if he has the ledger I asked him about yesterday.");
		JOB = 2;
		CallExternal(FindEntityByName("abulurd"), "global_quest_ledger");
	}

	void quest_ledger_done()
	{
		SayText("Yep, this is it. Thanks for your help GetEntityName(param1)");
		// TODO: offer PARAM1 gold 6
		JOB = 3;
		JOB.TARGET = "";
		JOB.WINNER = param1;
	}

	void quest_boar_done()
	{
		SayText("Aah! What's this?");
		questboar.target = param1;
		PlayAnim("critical", "studycart");
		ScheduleDelayedEvent(1, "quest_boar_done_2");
		CallExternal(FindEntityByName("abulurd"), "global_quest_boars_done");
	}

	void quest_boar_done_2()
	{
		SayText("This pelt is of excellent quality , my friend!");
		ScheduleDelayedEvent(2.3, "quest_boar_done_3");
	}

	void quest_boar_done_3()
	{
		SayText("Stay here for a second and I'll make something out of it.");
		questboar.angle = GetMonsterProperty("angles.yaw");
		ScheduleDelayedEvent(1, "quest_boar_done_4");
	}

	void quest_boar_done_4()
	{
		string newang = questboar.angle;
		newang += 180;
		SetAngles("face.yaw");
		ScheduleDelayedEvent(5, "quest_boar_done_5");
	}

	void quest_boar_done_5()
	{
		SayText("Here you go! Hope you will enjoy it.");
		SetAngles("face.yaw");
		// TODO: offer questboar.target armor_leather_torn
	}

	void say_closed()
	{
		SayText("Sorry, I'm closed. I will reopen at seven in the morning");
	}

	void vendor_offerstore()
	{
		if (!(GetEntityDist(param1) <= 90)) return;
		if ((STORE_CLOSED))
		{
			SayText("Sorry, I'm closed. I will reopen at seven in the morning");
		}
		else
		{
			basevendor_offerstore(param1);
		}
	}

	void game_menu_getoptions()
	{
		if (!(StringToLower(GetMapName()) != "helena")) return;
		if (JOB == 1)
		{
			if (!(JOB.SPEECH1))
			{
				string reg.mitem.title = "Accept Job";
				string reg.mitem.type = "say";
				string l.say = RandomInt(1, 6);
				if (l.say == 1)
				{
					string reg.mitem.data = "Yes";
				}
				else
				{
					if (l.say == 2)
					{
						string reg.mitem.data = "Sure";
					}
					else
					{
						if (l.say == 3)
						{
							string reg.mitem.data = "Why not";
						}
						else
						{
							if (l.say == 4)
							{
								string reg.mitem.data = "Ok";
							}
							else
							{
								if (l.say == 5)
								{
									string reg.mitem.data = "Of course";
								}
								else
								{
									if (l.say == 6)
									{
										string reg.mitem.data = "Tell me more";
									}
								}
							}
						}
					}
				}
			}
			else
			{
				if ((ItemExists(param1, "item_ikelog")))
				{
					string reg.mitem.title = "Give Log";
					string reg.mitem.type = "payment";
					string reg.mitem.data = "item_ikelog";
					string reg.mitem.callback = "quest_log_done";
				}
				else
				{
					menuitem_where();
				}
			}
		}
		else
		{
			if (JOB == 2)
			{
				if ((ItemExists(param1, "item_ledger")))
				{
					string reg.mitem.title = "Give Ledger";
					string reg.mitem.type = "payment";
					string reg.mitem.data = "item_ledger";
					string reg.mitem.callback = "quest_ledger_done";
				}
				else
				{
					menuitem_where();
				}
			}
		}
		if ((ItemExists(param1, "skin_boar_heavy")))
		{
			string reg.mitem.title = "Give Pelt";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "skin_boar_heavy";
			string reg.mitem.callback = "quest_boar_done";
		}
		HAS_KEYPARTS = 0;
		if ((ItemExists(param1, "brokenkey_1")))
		{
			string reg.mitem.id = "payment";
			string reg.mitem.title = "Give Key Hilt";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "brokenkey_1";
			string reg.mitem.callback = "got_part_1";
			HAS_KEYPARTS = 1;
		}
		if ((ItemExists(param1, "brokenkey_2")))
		{
			string reg.mitem.id = "payment";
			string reg.mitem.title = "Give Key Middle";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "brokenkey_2";
			string reg.mitem.callback = "got_part_2";
			HAS_KEYPARTS = 1;
		}
		if ((ItemExists(param1, "brokenkey_3")))
		{
			string reg.mitem.id = "payment";
			string reg.mitem.title = "Give Key End";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "brokenkey_3";
			string reg.mitem.callback = "got_part_3";
			HAS_KEYPARTS = 1;
		}
		if ((HAS_KEYPARTS))
		{
			KEY_STEP = 0;
			key_intro();
		}
		if ((GOT_KEYPART_1))
		{
			if ((GOT_KEYPART_2))
			{
				if ((GOT_KEYPART_3))
				{
					FORGE_KEY_STEP = 0;
					string reg.mitem.id = "payment";
					string reg.mitem.title = "Pay 10,000 to reforge key";
					string reg.mitem.type = "payment";
					string reg.mitem.data = "gold:10000";
					string reg.mitem.callback = "start_forge_key";
					string reg.mitem.cb_failed = "not_enough_forge_key";
				}
			}
		}
	}

	void menuitem_where()
	{
		string reg.mitem.title = "I can't find Abulurd";
		string reg.mitem.type = "say";
		string l.say = RandomInt(1, 2);
		if (l.say == 1)
		{
			string reg.mitem.data = "Where is abulurd?";
		}
		else
		{
			if (l.say == 2)
			{
				string reg.mitem.data = "I can't find abulurd";
			}
		}
	}

	void key_intro()
	{
		if ((KEY_INTRO_DELAY)) return;
		KEY_STEP += 1;
		if (KEY_STEP == 1)
		{
			PlayAnim("once", "converse1");
			SayText("Thats a mighty interestin lookin piece of a key you have there...");
		}
		if (KEY_STEP == 2)
		{
			SayText("If ya find all the parts, I maybe able to put it back together for ya.");
		}
		if (KEY_STEP == 3)
		{
			SayText("Best not give me any parts lest ya have them all, as youll not be gettin any back.");
		}
		if (KEY_STEP == 4)
		{
			KEY_INTRO_DELAY = 1;
			ScheduleDelayedEvent(60.0, "reset_keyintro");
			SayText("Oh... And 10,000 gold for the labor. Delicate work, key forging is.");
		}
		if (!(KEY_STEP < 4)) return;
		ScheduleDelayedEvent(2.0, "key_intro");
	}

	void start_forge_key()
	{
		ReceiveOffer("accept");
		QUEST_WINNER = param1;
		GOT_KEYPART_1 = 0;
		GOT_KEYPART_2 = 0;
		GOT_KEYPART_3 = 0;
		ScheduleDelayedEvent(0.1, "forge_key");
	}

	void forge_key()
	{
		FORGE_KEY_STEP += 1;
		if (FORGE_KEY_STEP == 1)
		{
			PlayAnim("once", "portal");
			SayText("Yup, just as I thought, gonna be a tricky little thing...");
		}
		if (FORGE_KEY_STEP == 2)
		{
			SayText("But dont ya worry, Ill get her done alright...");
		}
		if (FORGE_KEY_STEP == 3)
		{
			SayText("...almost got it....");
		}
		if (FORGE_KEY_STEP == 4)
		{
			PlayAnim("once", "push_button2");
			LookAt(1024);
			// TODO: offer QUEST_WINNER key_forged
			SayText("See, there ya go, one re-forged key.");
		}
		if (!(FORGE_KEY_STEP < 4)) return;
		ScheduleDelayedEvent(2.0, "forge_key");
	}

	void not_enough_forge_key()
	{
		PlayAnim("once", "checktie");
		SayText("Reforging an ornate key like this is very delicate work! I will need more gold.");
	}

	void got_part_1()
	{
		PlayAnim("once", "push_button");
		GOT_KEYPART_1 = 1;
		SayText("Mmm hmm... Fancy lookin key this hilt belongs to, no doubt.");
		if ((GOT_KEYPART_2))
		{
			if ((GOT_KEYPART_3))
			{
				SayText("Alright, got all the pieces, now I just need that labor charge...");
			}
		}
	}

	void got_part_2()
	{
		PlayAnim("once", "push_button");
		GOT_KEYPART_2 = 1;
		SayText("Yeah, I bet this key is supposed to open somethin really valuable...");
		if ((GOT_KEYPART_1))
		{
			if ((GOT_KEYPART_3))
			{
				SayText("Alright, got all the pieces, now I just need that labor charge...");
			}
		}
	}

	void got_part_3()
	{
		PlayAnim("once", "push_button");
		GOT_KEYPART_3 = 1;
		SayText("These are about the fanciest lookin key bits Ive ever seen...");
		if ((GOT_KEYPART_1))
		{
			if ((GOT_KEYPART_2))
			{
				SayText("Alright, got all the pieces, now I just need that labor charge...");
			}
		}
	}

	void say_key()
	{
		KEY_STEP = 0;
		key_intro();
	}

	void reset_key_intro()
	{
		KEY_INTRO_DELAY = 0;
	}

}

}
