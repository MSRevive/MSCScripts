#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class DarrelinNpc : CGameScript
{
	string ANIM_STEP1;
	string ANIM_STEP3;
	string ANIM_STEP5;
	int CANCHAT;
	float CHAT_DELAY_STEP1;
	float CHAT_DELAY_STEP2;
	float CHAT_DELAY_STEP3;
	float CHAT_DELAY_STEP4;
	float CHAT_DELAY_STEP5;
	float CHAT_DELAY_STEP6;
	float CHAT_DELAY_STEP7;
	float CHAT_DELAY_STEP8;
	float CHAT_DELAY_STEP9;
	string CHAT_EVENT_STEP2;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	string CHAT_STEP6;
	string CHAT_STEP7;
	string CHAT_STEP8;
	string CHAT_STEP9;
	int CHAT_STEPS;
	string NEXT_CHAT_WARN;
	int NO_MOUTH_MOVE;
	string QUEST_COMPLETER;
	int REQ_QUEST_NOTDONE;

	DarrelinNpc()
	{
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
		const int NO_HAIL = 1;
	}

	void OnSpawn() override
	{
		REQ_QUEST_NOTDONE = 1;
		SetHealth(20);
		SetMaxHealth(20);
		SetGold(3);
		SetName("Darrelin");
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetMoveAnim("walk");
		SetInvincible(true);
		CANCHAT = 1;
		CatchSpeech("say_hi", "hello");
		CatchSpeech("say_orc", "orc");
		CatchSpeech("say_myth", "myth");
		CatchSpeech("say_acting", "act");
		CatchSpeech("say_orc", "orc");
		CatchSpeech("say_myth", "myth");
		CatchSpeech("say_acting", "act");
		CatchSpeech("say_name", "name");
		CatchSpeech("say_goblins", "goblin");
		CatchSpeech("say_river", "river");
	}

	void say_hi()
	{
		if ((IsValidPlayer(param1)))
		{
			string L_LAST_SPOKE = param1;
		}
		else
		{
			string L_LAST_SPOKE = GetEntityIndex("ent_lastspoke");
		}
		if ((BUSY_CHATTING))
		{
			chat_warning(L_LAST_SPOKE);
		}
		if ((BUSY_CHATTING)) return;
		EmitSound(GetOwner(), 2, "voices/mscave/actor-say_hi.wav", 10);
		NO_MOUTH_MOVE = 1;
		Say("[.3] [.1] [.1] [.3] [.02] [.2] [.1] [.3] [.3] [.3] [.1] [.1] [.1] [.1] [.1] [.1] [.1] [.1]");
		CHAT_STEP1 = "Hail Traveller! Welcome to... THE DARK CAVES......!";
		ANIM_STEP1 = "studycart";
		CHAT_DELAY_STEP1 = 9.4;
		ScheduleDelayedEvent(9.3, "restore_mouth_move");
		CHAT_STEP2 = "Sorry about that, I used to be an [actor]... I still am, in a way.";
		CHAT_DELAY_STEP2 = 4.7;
		CHAT_STEP3 = "Anyway, the [Orcs] have taken over the caves, so be careful if you plan on going through them.";
		CHAT_DELAY_STEP3 = 7.0;
		CHAT_STEP4 = "You may also be interested to hear about a [goblin] town near here.";
		CHAT_DELAY_STEP4 = 3.0;
		CHAT_STEPS = 4;
		chat_loop();
	}

	void restore_mouth_move()
	{
		NO_MOUTH_MOVE = 0;
		bchat_auto_mouth_move(4.7);
	}

	void say_orc()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "say_orc");
			chat_warning(GetEntityIndex("ent_lastspoke"));
		}
		if ((BUSY_CHATTING)) return;
		EmitSound(GetOwner(), 2, "voices/mscave/actor-say_orc.wav", 10);
		CHAT_STEP1 = "Well, as you probably know, the Orcs have been growing in number faster than usual.";
		CHAT_DELAY_STEP1 = 5.4;
		CHAT_STEP2 = "Since they therefor need more land they use shamans to come in and lock down an area using magic.";
		CHAT_DELAY_STEP2 = 5.0;
		CHAT_STEP3 = "This allows their warriors to march in and absolutely massacre all the men, women, and children of entire towns. It's terribly frightful!";
		CHAT_DELAY_STEP3 = 8.6;
		CHAT_STEP4 = "Unfortunately for us, this is a rather successful tactic, except... Eh, there is one thing...";
		CHAT_DELAY_STEP4 = 7.6;
		CHAT_STEP5 = "Theres a [myth] of sorts surrounding these caves, and I don't think the orcs are using the caves just to store their loot.";
		ANIM_STEP5 = "pondering";
		CHAT_DELAY_STEP5 = 6.3;
		CHAT_STEPS = 5;
		chat_loop();
	}

	void say_myth()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "say_myth");
			chat_warning(GetEntityIndex("ent_lastspoke"));
		}
		if ((BUSY_CHATTING)) return;
		EmitSound(GetOwner(), 2, "voices/mscave/actor-say_myth.wav", 10);
		CHAT_STEP1 = "Well, theres supposed to be some kind of building that's tucked away deep inside the caverns.";
		CHAT_DELAY_STEP1 = 6.3;
		CHAT_STEP2 = "It's probably ancient history now, but it was a fortress literally powered by magic itself, except...";
		CHAT_DELAY_STEP2 = 5.7;
		CHAT_STEP3 = "I can't help wondering why it isn't active... Nobody seems to know why...";
		CHAT_DELAY_STEP3 = 4.9;
		CHAT_STEP4 = "Though the path to the fort is clear, its silent, closed, so I guess whatever's in there, we're doomed to it... I guess.";
		CHAT_DELAY_STEP4 = 6.4;
		CHAT_STEPS = 4;
		chat_loop();
	}

	void say_acting()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "say_acting");
			chat_warning(GetEntityIndex("ent_lastspoke"));
		}
		if ((BUSY_CHATTING)) return;
		EmitSound(GetOwner(), 2, "voices/mscave/actor-say_acting.wav", 10);
		CHAT_STEP1 = "Oh I'm sure you must've heard the [name] of Darrelino the Greatest Actor in ALL of Daragoth, nay the WORLD!";
		ANIM_STEP1 = "converse1";
		CHAT_DELAY_STEP1 = 5.5;
		CHAT_STEP2 = "You haven't!?!...";
		CHAT_DELAY_STEP2 = 2.5;
		CHAT_STEP3 = "Oh well, that's your loss then.";
		ANIM_STEP3 = "no";
		CHAT_DELAY_STEP3 = 2.8;
		CHAT_STEPS = 3;
		chat_loop();
	}

	void say_name()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "say_name");
			chat_warning(GetEntityIndex("ent_lastspoke"));
		}
		if ((BUSY_CHATTING)) return;
		EmitSound(GetOwner(), 2, "voices/mscave/actor-say_name-say_script.wav", 10);
		CHAT_STEP1 = "Well, my stage name is Darrelino Var and I happen to think it's a very good name, thank you very much!";
		CHAT_DELAY_STEP1 = 5.6;
		CHAT_STEP2 = "Too bad I can't practice for the big performance! I don't have my script anymore! I used to go practice my lines in the forest, you see.";
		CHAT_DELAY_STEP2 = 8.4;
		CHAT_STEP3 = "...and then one night, as I was practicing my lines... Something attacked me!";
		CHAT_DELAY_STEP3 = 4.3;
		CHAT_STEP4 = "It lunged at me! I had no idea what it was. I thought it was a thief, maybe waiting in the shadows to steal all my belongings!";
		CHAT_DELAY_STEP4 = 5.9;
		CHAT_STEP5 = "So I managed to run, away from it, but then I heard all kinds of sounds rustling behind me in the bushes.";
		CHAT_DELAY_STEP5 = 5.4;
		CHAT_STEP6 = "So did the first thing that came to mind: I hid all my belongings in a hollow tree, and covered it with some leaves.";
		CHAT_DELAY_STEP6 = 6.1;
		CHAT_STEP7 = "But, on the way out, nobody came and attacked me! I turned around to look, and I could swear I saw pale figures walking in the forest. So I turned and ran away.";
		CHAT_DELAY_STEP7 = 9.2;
		CHAT_STEP8 = "I hear it's really dangerous in the forest now. It turns out that what attacked me wasn't actually a thief, but the living dead itself!";
		CHAT_DELAY_STEP8 = 12.3;
		CHAT_STEP9 = "Oh do you think you could find my manuscript for me? I'm sure it's still in that hollow tree covered by the leaves.";
		CHAT_DELAY_STEP9 = 10.1;
		CHAT_STEPS = 9;
		chat_loop();
	}

	void say_goblins()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "say_goblins");
			chat_warning(GetEntityIndex("ent_lastspoke"));
		}
		if ((BUSY_CHATTING)) return;
		EmitSound(GetOwner(), 2, "voices/mscave/actor-say_goblins.wav", 10);
		CHAT_STEP1 = "The Goblins have a town carved into the mountains through the caves, near a [river] dried up by a dam.";
		CHAT_DELAY_STEP1 = 6.0;
		CHAT_STEP2 = "You'll find one of the goblins to be an extremely tough opponent.... He seems to be their leader, of sorts";
		CHAT_DELAY_STEP2 = 5.8;
		CHAT_STEP3 = "It wouldn't be so bad but they like attacking in large groups! So, do be careful.";
		CHAT_DELAY_STEP3 = 6.4;
		CHAT_STEPS = 3;
		chat_loop();
	}

	void say_river()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "say_river");
			chat_warning(GetEntityIndex("ent_lastspoke"));
		}
		if ((BUSY_CHATTING)) return;
		EmitSound(GetOwner(), 2, "voices/mscave/actor-say_river.wav", 10);
		CHAT_STEP1 = "I learnt recently that the Orcs have decided to block the river. It's a prelude to invading the Goblins to weaken them.";
		CHAT_DELAY_STEP1 = 5.4;
		CHAT_STEP2 = "I don't know which is worse... Those damned Goblins or the Orcs!";
		CHAT_DELAY_STEP2 = 3.0;
		CHAT_STEPS = 2;
		chat_loop();
	}

	void give_manuscript()
	{
		if ((IsEntityAlive(param1)))
		{
			QUEST_COMPLETER = param1;
			REQ_QUEST_NOTDONE = 0;
		}
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "give_manuscript");
			chat_warning(GetEntityIndex(param1));
		}
		if ((BUSY_CHATTING)) return;
		EmitSound(GetOwner(), 0, "voices/mscave/actor-give_manuscript.wav", 10);
		CHAT_STEP1 = "You found my manuscript! Thank you so much, ";
		CHAT_STEP1 += GetEntityName(QUEST_COMPLETER);
		CHAT_STEP1 += ", I can continue practicing!";
		ANIM_STEP1 = "eye_wipe";
		CHAT_DELAY_STEP1 = 4.5;
		CHAT_STEP2 = "Oh, I should reward you... Wait... Here, take this... It's a gold pouch. It's not much, but it's the best I can do.";
		CHAT_DELAY_STEP2 = 6.4;
		CHAT_EVENT_STEP2 = "give_manuscript_reward";
		CHAT_STEPS = 2;
		chat_loop();
	}

	void give_manuscript_reward()
	{
		// TODO: offer QUEST_COMPLETER gold RandomInt(30, 60)
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Say Hello";
		string reg.mitem.type = "say";
		string l.say = RandomInt(1, 4);
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
		if ((ItemExists(param1, "item_manuscript")))
		{
			string reg.mitem.title = "Return manuscript";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_manuscript";
			string reg.mitem.callback = "give_manuscript";
		}
	}

	void chat_warning()
	{
		if (!(GetGameTime() > NEXT_CHAT_WARN)) return;
		NEXT_CHAT_WARN = GetGameTime();
		NEXT_CHAT_WARN += 20.0;
		SendColoredMessage(param1, "Darrelin is still chatting about something else...");
	}

}

}
