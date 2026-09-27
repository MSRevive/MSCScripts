#pragma context server

#include "monsters/base_chat.as"
#include "monsters/debug.as"

namespace MS
{

class LighthouseKeeper : CGameScript
{
	string ANIM_IDLE_CHAT;
	string APPLE_QUEST_ACTIVE;
	string BASIC_REWARDS;
	string BUSY_CHATTING;
	float CHAT_DELAY;
	string CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	string CHAT_STEP6;
	string CHAT_STEPS;
	int CONFIRM_STEP;
	int DONE_CRYSTAL;
	int DONE_FOOD;
	int DONE_GRAVE;
	int DONE_SPIDER;
	string HIRED_CRYSTAL;
	string HIRED_FOOD;
	string HIRED_GRAVE;
	string HIRED_SPIDER;
	string MENU_MODE;
	string MENU_QUEST;
	string MENU_TARGET;
	string MY_YAW;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	string TASK_STRING;
	int TENDING_HOUSE;
	string TEND_ANIMS;
	string WAS_STARTLED;

	LighthouseKeeper()
	{
		TEND_ANIMS = "console;dryhands;writeboard;studycart;lean;pondering;pondering2;pondering3;buysoda;console;console;console;console;console;";
		BASIC_REWARDS = "smallarms_huggerdagger3;smallarms_craftedknife3;smallarms_stiletto;swords_katana;axes_scythe;axes_doubleaxe;blunt_greatmaul;blunt_mace;bows_longbow;scroll_summon_rat;armor_leather_studded;armor_helm_knight;";
		NO_HAIL = 1;
		NO_JOB = 1;
		NO_RUMOR = 1;
		CHAT_DELAY = 4.5;
		ANIM_IDLE_CHAT = "idle1";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(3, 5));
		if ((TENDING_HOUSE))
		{
		}
		SetAngles("face");
		string N_IDLES = GetTokenCount(TEND_ANIMS, ";");
		int RND_IDLE = RandomInt(1, N_IDLES);
		RND_IDLE -= 1;
		string IDLE_ANIM = GetToken(TEND_ANIMS, RND_IDLE, ";");
		SetIdleAnim(IDLE_ANIM);
		SetMoveAnim(IDLE_ANIM);
	}

	void OnSpawn() override
	{
		SetName("lkeeper");
		SetName("Hyehold , the Lighthouse Keep");
		SetHealth(1);
		SetInvincible(true);
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetModel("npc/human1.mdl");
		SetModelBody(0, 3);
		SetModelBody(1, 5);
		SetRoam(false);
		SetMoveAnim("idle1");
		SetHearingSensitivity(10);
		SetSayTextRange(1024);
		SetNoPush(true);
		TENDING_HOUSE = 1;
		ScheduleDelayedEvent(0.1, "get_yaw");
		MENU_MODE = "normal";
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_food", "food");
		CatchSpeech("say_crystal", "crystal");
		CatchSpeech("say_grave", "grave");
		CatchSpeech("say_spider", "spider");
	}

	void get_yaw()
	{
		MY_YAW = GetMonsterProperty("angles.yaw");
	}

	void say_hi()
	{
		if (!(IsValidPlayer(param1)))
		{
			string FACE_TARG = GetEntityIndex("ent_lastspoke");
		}
		if ((IsValidPlayer(param1)))
		{
			string FACE_TARG = GetEntityIndex(param1);
		}
		face_speaker(FACE_TARG);
		say_intro();
	}

	void face_speaker()
	{
		TENDING_HOUSE = 0;
		SetIdleAnim(ANIM_IDLE_CHAT);
		SetMoveAnim(ANIM_IDLE_CHAT);
	}

	void say_intro()
	{
		if ((BUSY_CHATTING)) return;
		if (!(WAS_STARTLED))
		{
			WAS_STARTLED = 1;
			PlayAnim("critical", "eye_wipe");
			CHAT_STEPS = 2;
			CHAT_STEP = 0;
			BUSY_CHATTING = 1;
			CHAT_STEP1 = "Oh! Hello there!";
			CHAT_STEP2 = "Sorry for being so startled. It's not very often I get visitors way up here.";
			chat_loop();
			string NEXT_CHAT = CHAT_DELAY;
			NEXT_CHAT *= CHAT_STEPS;
			NEXT_CHAT += 0.5;
			NEXT_CHAT("say_jobs");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(WAS_STARTLED)) return;
		PlayAnim("critical", ANIM_IDLE_CHAT);
		say_jobs();
	}

	void say_jobs()
	{
		if ((BUSY_CHATTING)) return;
		CHAT_STEPS = 2;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "It's just me up here, and I'm getting on in years, so I often neglect many tasks...";
		build_task_string();
		CHAT_STEP2 = TASK_STRING;
		chat_loop();
		ScheduleDelayedEvent(2.0, "convo_anim");
		MENU_MODE = "pick_quest";
	}

	void build_task_string()
	{
		TASK_STRING = "For instance, ";
		if (!(DONE_SPIDER))
		{
			TASK_STRING += "killing those darn [spiders], ";
			int QUESTS_LEFT = 1;
		}
		if (!(DONE_GRAVE))
		{
			TASK_STRING += "tending Feldar's [grave], ";
			int QUESTS_LEFT = 1;
		}
		if (!(DONE_CRYSTAL))
		{
			TASK_STRING += "gathering lighthouse [crystals], ";
			int QUESTS_LEFT = 1;
		}
		if (!(DONE_FOOD))
		{
			TASK_STRING += "not to mention simply getting some [food]!";
			int QUESTS_LEFT = 1;
		}
		if (!(QUESTS_LEFT))
		{
			TASK_STRING = "But good young lads like yourself come and fix me up from time to time - so - I've nothing that needs doing just now.";
			ScheduleDelayedEvent(2.0, "resume_tending");
		}
	}

	void say_spider()
	{
		if ((BUSY_CHATTING)) return;
		if ((DONE_SPIDER))
		{
			PlayAnim("critical", "wave");
			SayText("Oh , someone already got rid of those for me. Thank you anyways.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(IsValidPlayer(param1)))
		{
			string FACE_TARG = GetEntityIndex("ent_lastspoke");
		}
		if ((IsValidPlayer(param1)))
		{
			string FACE_TARG = GetEntityIndex(param1);
		}
		face_speaker(FACE_TARG);
		if (GetPlayerQuestData(FACE_TARG, "l") != 0)
		{
			target_busy(FACE_TARG);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((IsEntityAlive(HIRED_SPIDER)))
		{
			SayText(GetEntityName(HIRED_SPIDER) + " is already working on that for me.");
			int EXIT_SUB = 1;
			TENDING_HOUSE = 1;
			bchat_mouth_move();
		}
		if ((EXIT_SUB)) return;
		MENU_TARGET = FACE_TARG;
		CHAT_STEPS = 4;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "Well, there's a spider infestation in the caves below. I've put it off for far too long, so...";
		CHAT_STEP2 = "...I figure by now there's got to be a nest and some very sizable eggs.";
		CHAT_STEP3 = "If those hatch I could be in for more than a little trouble!";
		CHAT_STEP4 = "Think you could go down there and take care of that for me? I'd be ever so grateful.";
		MENU_MODE = "confirm";
		MENU_QUEST = "spider";
		CONFIRM_STEP = 4;
		chat_loop();
		ScheduleDelayedEvent(2.0, "convo_anim");
		ScheduleDelayedEvent(6.0, "convo_anim");
	}

	void say_grave()
	{
		if ((BUSY_CHATTING)) return;
		if ((DONE_GRAVE))
		{
			PlayAnim("critical", "wave");
			SayText("Oh , someone already delivered that for me , thanks.");
			bchat_mouth_move();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(IsValidPlayer(param1)))
		{
			string FACE_TARG = GetEntityIndex("ent_lastspoke");
		}
		if ((IsValidPlayer(param1)))
		{
			string FACE_TARG = GetEntityIndex(param1);
		}
		face_speaker(FACE_TARG);
		if (GetPlayerQuestData(FACE_TARG, "l") != 0)
		{
			target_busy(FACE_TARG);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((IsEntityAlive(HIRED_GRAVE)))
		{
			SayText(GetEntityName(HIRED_GRAVE) + " is already working on that for me.");
			int EXIT_SUB = 1;
			bchat_mouth_move();
			TENDING_HOUSE = 1;
		}
		if ((EXIT_SUB)) return;
		MENU_TARGET = FACE_TARG;
		CHAT_STEPS = 6;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "Well, my old friend Feldar, always the good samaritan, was out escorting some fresh adventurers around the Thornlands.";
		CHAT_STEP2 = "Near as the constable could tell, it turns out they were actually bandits, and they assasinated the kindhearted old fool.";
		CHAT_STEP3 = "He loved this old place, so we made his grave just around the back, ... I used to visit it quite often, but lately it's been... Strange.";
		CHAT_STEP4 = "He had a favorite figurine of The Goddess Felewyn, you see. His widow brought it to me recently. I think he wanted it buried with him...";
		CHAT_STEP5 = "Or at least that would explain the... Unrest... Outside.";
		CHAT_STEP6 = "You look like you might be able to brave the denizens around there. If you could bring this statuette there, I'm sure it'd all quiet down.";
		MENU_MODE = "confirm";
		MENU_QUEST = "grave";
		CONFIRM_STEP = 6;
		chat_loop();
	}

	void say_crystal()
	{
		if ((BUSY_CHATTING)) return;
		if ((DONE_CRYSTAL))
		{
			PlayAnim("critical", "wave");
			SayText("Oh , someone already got those for me , thanks.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(IsValidPlayer(param1)))
		{
			string FACE_TARG = GetEntityIndex("ent_lastspoke");
		}
		if ((IsValidPlayer(param1)))
		{
			string FACE_TARG = GetEntityIndex(param1);
		}
		face_speaker(FACE_TARG);
		if (GetPlayerQuestData(FACE_TARG, "l") != 0)
		{
			target_busy(FACE_TARG);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((IsEntityAlive(HIRED_CRYSTAL)))
		{
			SayText(GetEntityName(HIRED_CRYSTAL) + " is already working on that for me.");
			int EXIT_SUB = 1;
			bchat_mouth_move();
			TENDING_HOUSE = 1;
		}
		if ((EXIT_SUB)) return;
		MENU_TARGET = FACE_TARG;
		CHAT_STEPS = 5;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "Ah, well... The lighthouse here's been a bit flickery as of late - I think she needs some new crystals.";
		CHAT_STEP2 = "The light crystals that power the magic core are fairly common in these parts...";
		CHAT_STEP3 = "But with all the things I've seen crawling about lately, I just don't feel up to grabbing them myself!";
		CHAT_STEP4 = "If you could find me a good set, I'll reward ye handsomely.";
		CHAT_STEP5 = "Otherwise we could wind up with a boat smashed up on the rocks, and that'd be bad for business!";
		MENU_MODE = "confirm";
		MENU_QUEST = "crystal";
		CONFIRM_STEP = 4;
		chat_loop();
	}

	void say_food()
	{
		if ((BUSY_CHATTING)) return;
		if ((DONE_FOOD))
		{
			PlayAnim("critical", "wave");
			SayText("Oh, someone already got me some - I'm quite sated, thanks.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(IsValidPlayer(param1)))
		{
			string FACE_TARG = GetEntityIndex("ent_lastspoke");
		}
		if ((IsValidPlayer(param1)))
		{
			string FACE_TARG = GetEntityIndex(param1);
		}
		face_speaker(FACE_TARG);
		if (GetPlayerQuestData(FACE_TARG, "l") != 0)
		{
			target_busy(FACE_TARG);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((IsEntityAlive(HIRED_FOOD)))
		{
			SayText(GetEntityName(HIRED_FOOD) + " is already working on that for me.");
			int EXIT_SUB = 1;
			bchat_mouth_move();
		}
		if ((EXIT_SUB)) return;
		MENU_TARGET = FACE_TARG;
		CHAT_STEPS = 3;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "I... I don't think I've actually eaten a thing in a week, now that I think of it...";
		CHAT_STEP2 = "...and I really try not to, believe me. Too busy for food and all...";
		CHAT_STEP3 = "If you could just bring me an apple or two, anything really, I'd be so very grateful.";
		MENU_MODE = "confirm";
		MENU_QUEST = "food";
		CONFIRM_STEP = 3;
		chat_loop();
	}

	void accept_quest()
	{
		string TRIG_STR = "quest_";
		TRIG_STR += MENU_QUEST;
		UseTrigger(TRIG_STR);
		SetPlayerQuestData(param1, "l");
		MENU_MODE = "normal";
		convo_anim();
		if (MENU_QUEST == "spider")
		{
			HIRED_SPIDER = param1;
			SayText("Thank you , oh so much. Come back here when ya clear out those pests.");
		}
		if (MENU_QUEST == "grave")
		{
			HIRED_GRAVE = param1;
			SayText("Thank you , oh so much. Come back here when you ve done the deed and I ll reward you.");
			// TODO: offer PARAM1 item_fstatue
		}
		if (MENU_QUEST == "crystal")
		{
			HIRED_CRYSTAL = param1;
			SayText("Thank you , oh so much. Be careful with those crystals by the way - they are quite fragile!");
		}
		if (MENU_QUEST == "food")
		{
			HIRED_FOOD = param1;
			SayText("Oh yes, please bring me something, I'd be grateful beyond words.");
			APPLE_QUEST_ACTIVE = 1;
		}
		TENDING_HOUSE = 1;
	}

	void chat_loop()
	{
		WAS_STARTLED = 1;
		if (MENU_MODE == "confirm")
		{
			if (CHAT_STEP == CONFIRM_STEP)
			{
				OpenMenu(MENU_TARGET);
			}
		}
		if (CHAT_STEP == 2)
		{
			convo_anim();
		}
		if (CHAT_STEP == 4)
		{
			convo_anim();
		}
		if (CHAT_STEP == 6)
		{
			convo_anim();
		}
		if (CHAT_STEP == 8)
		{
			convo_anim();
		}
		if (CHAT_STEP == 10)
		{
			convo_anim();
		}
	}

	void decline_quest()
	{
		MENU_MODE = "normal";
		SetPlayerQuestData(param1, "l");
		PlayAnim("critical", "no");
		SayText("Well... That's alright. At least you're some company... I guess.");
		bchat_mouth_move();
		TENDING_HOUSE = 1;
	}

	void game_menu_getoptions()
	{
		string CUR_QUEST = GetPlayerQuestData(param1, "l");
		if (MENU_MODE != "confirm")
		{
			if ((ItemExists(param1, "item_light_crystal")))
			{
				if (!(DONE_CRYSTAL))
				{
				}
				string reg.mitem.title = "Offer Light Crystal";
				string reg.mitem.type = "payment";
				string reg.mitem.data = "item_light_crystal";
				string reg.mitem.callback = "reward_crystal";
			}
			if ((ItemExists(param1, "health_apple")))
			{
				if ((APPLE_QUEST_ACTIVE))
				{
				}
				if (!(DONE_FOOD))
				{
				}
				string reg.mitem.title = "Offer Apple";
				string reg.mitem.type = "payment";
				string reg.mitem.data = "health_apple";
				string reg.mitem.callback = "reward_food";
			}
			if (CUR_QUEST == 0)
			{
			}
			string reg.mitem.title = "Hail";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_hi";
			if ((WAS_STARTLED))
			{
				if (!(DONE_SPIDER))
				{
					string reg.mitem.title = "Ask about spiders";
					string reg.mitem.type = "callback";
					string reg.mitem.callback = "say_spider";
				}
				if (!(DONE_GRAVE))
				{
					string reg.mitem.title = "Ask about Feldar's Grave";
					string reg.mitem.type = "callback";
					string reg.mitem.callback = "say_grave";
				}
				if (!(DONE_CRYSTAL))
				{
					string reg.mitem.title = "Ask about crystals";
					string reg.mitem.type = "callback";
					string reg.mitem.callback = "say_crystal";
				}
				if (!(DONE_FOOD))
				{
					string reg.mitem.title = "Ask about food";
					string reg.mitem.type = "callback";
					string reg.mitem.callback = "say_food";
				}
				string reg.mitem.title = "Ask about forest";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_forest";
			}
		}
		if (MENU_MODE == "confirm")
		{
			if (MENU_QUEST == "spider")
			{
				string reg.mitem.title = "I'll clear the eggs.";
			}
			if (MENU_QUEST == "grave")
			{
				string reg.mitem.title = "I'll visit the grave.";
			}
			if (MENU_QUEST == "crystal")
			{
				string reg.mitem.title = "I'll get the crystals.";
			}
			if (MENU_QUEST == "food")
			{
				string reg.mitem.title = "I'll bring some apples.";
			}
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "accept_quest";
			string reg.mitem.title = "Sorry. I'm busy.";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "decline_quest";
		}
		if ((DONE_SPIDER))
		{
			if (param1 == HIRED_SPIDER)
			{
			}
			if (CUR_QUEST == "spider")
			{
			}
			string reg.mitem.title = "Collect Spider Quest Reward";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "reward_spider";
		}
		if ((DONE_GRAVE))
		{
			if (param1 == HIRED_GRAVE)
			{
			}
			if (CUR_QUEST == "grave")
			{
			}
			string reg.mitem.title = "Collect Grave Quest Reward";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "reward_grave";
		}
		if (CUR_QUEST != 0)
		{
			string REMIND_STR = "Cancel ";
			REMIND_STR += CUR_QUEST;
			REMIND_STR += " quest";
			string reg.mitem.title = REMIND_STR;
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "clear_quest";
		}
	}

	void reward_spider()
	{
		face_speaker(param1);
		convo_anim();
		// TODO: offer PARAM1 gold RandomInt(10, 20)
		string BASIC_WINNER = param1;
		offer_basic_reward(BASIC_WINNER);
		int SCROLL_CHANCE = RandomInt(1, 2);
		if (SCROLL_CHANCE == 1)
		{
			int SCROLL_TOME = RandomInt(1, 2);
			if (SCROLL_TOME == 1)
			{
				// TODO: offer PARAM1 scroll2_ice_shield_lesser
			}
			if (SCROLL_TOME == 2)
			{
				// TODO: offer PARAM1 scroll_ice_shield_lesser
			}
		}
		if (SCROLL_CHANCE == 2)
		{
			offer_basic_reward(BASIC_WINNER);
		}
		SayText("Thank you so very much. I'd hate to have a swarm of eight leggeds creeping up here.");
		SetPlayerQuestData(param1, "l");
		ScheduleDelayedEvent(2.0, "resume_tending");
	}

	void reward_grave()
	{
		string BASIC_WINNER = param1;
		offer_basic_reward(BASIC_WINNER);
		face_speaker(param1);
		convo_anim();
		// TODO: offer PARAM1 gold RandomInt(10, 15)
		SayText("Thank you so very much. I'm sure he'll rest easier now.");
		SetPlayerQuestData(param1, "l");
		ScheduleDelayedEvent(2.0, "resume_tending");
	}

	void reward_crystal()
	{
		string BASIC_WINNER = param1;
		offer_basic_reward(BASIC_WINNER);
		DONE_CRYSTAL = 1;
		face_speaker(param1);
		convo_anim();
		// TODO: offer PARAM1 gold RandomInt(10, 20)
		SayText("A crystal! Thank goodness! I'm sure they'd hang me if we had another... Accident.");
		SetPlayerQuestData(param1, "l");
		ScheduleDelayedEvent(2.0, "resume_tending");
	}

	void reward_food()
	{
		string BASIC_WINNER = param1;
		offer_basic_reward(BASIC_WINNER);
		DONE_FOOD = 1;
		face_speaker(param1);
		convo_anim();
		// TODO: offer PARAM1 gold 5
		SayText("I thank ye! My stomach, doubly so!");
		SetPlayerQuestData(param1, "l");
		ScheduleDelayedEvent(2.0, "resume_tending");
	}

	void resume_tending()
	{
		TENDING_HOUSE = 1;
	}

	void clear_quest()
	{
		string CUR_QUEST = GetPlayerQuestData(param1, "l");
		if (CUR_QUEST == "spider")
		{
			HIRED_SPIDER = 0;
		}
		if (CUR_QUEST == "grave")
		{
			HIRED_GRAVE = 0;
			string METHOD_HACK = ItemExists(param1, "item_fstatue");
		}
		if (CUR_QUEST == "crystal")
		{
			HIRED_CRYSTAL = 0;
		}
		if (CUR_QUEST == "food")
		{
			HIRED_FOOD = 0;
		}
		MENU_MODE = "normal";
		SetPlayerQuestData(param1, "l");
		SayText("That's alright. There's plenty else to do around here too, if you're interested.");
		bchat_mouth_move();
		TENDING_HOUSE = 1;
	}

	void target_busy()
	{
		PlayAnim("critical", "pondering3");
		string CUR_QUEST = GetPlayerQuestData(param1, "l");
		if (CUR_QUEST == "spider")
		{
			SayText("Didn't you say you were going to kill some spiders for me?");
		}
		if (CUR_QUEST == "grave")
		{
			SayText("Didn't you say you were going to tend Feldar's grave for me?");
		}
		if (CUR_QUEST == "crystal")
		{
			SayText("Didn't you say you were going to get some crystals for me?");
		}
		if (CUR_QUEST == "food")
		{
			SayText("Didn't you say you were going to get me some food?");
		}
		MENU_MODE = "confirm";
		MENU_QUEST = CUR_QUEST;
		OpenMenu(param1);
	}

	void quest_done_spider()
	{
		DONE_SPIDER = 1;
	}

	void quest_done_grave()
	{
		DONE_GRAVE = 1;
	}

	void offer_basic_reward()
	{
		string N_REWARDS = GetTokenCount(BASIC_REWARDS, ";");
		int RND_REWARD = RandomInt(0, N_REWARDS);
		// TODO: offer PARAM1 GetToken(BASIC_REWARDS, RND_REWARD, ";")
	}

	void say_forest()
	{
		if ((BUSY_CHATTING)) return;
		if (!(IsValidPlayer(param1)))
		{
			string FACE_TARG = GetEntityIndex("ent_lastspoke");
		}
		if ((IsValidPlayer(param1)))
		{
			string FACE_TARG = GetEntityIndex(param1);
		}
		face_speaker(FACE_TARG);
		CHAT_STEPS = 4;
		CHAT_STEP = 0;
		BUSY_CHATTING = 1;
		CHAT_STEP1 = "Oh, that forest over there. Lots of wolves in that forest. Nasty place.";
		CHAT_STEP2 = "A young adventurer wandered into there the other day. He looked a bit green around the ears, if you catch my meaning.";
		CHAT_STEP3 = "I tried to stop him, but he wouldn't listen.";
		if (GetPlayerCount() == 1)
		{
			CHAT_STEP4 = "You look like a strapping young lad. You might want to go in there and check on him.";
		}
		if (GetPlayerCount() > 1)
		{
			CHAT_STEP4 = "You look like strapping young lads. You might want to go in there and check on him.";
		}
		chat_loop();
	}

}

}
