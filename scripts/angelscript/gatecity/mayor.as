#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Mayor : CGameScript
{
	int ALREADY_GAVE_AXE;
	string L_ZOMBIE_QUEST_DONE;
	string QUESTER_HEAD;
	int QUEST_GOBLINCHIEF;
	int QUEST_STARTER_LEFT;
	string QUEST_WINNER;
	int REMOVED_SPAWNS;
	int REQ_ZOMBIES;
	int RSPAWN_COUNT;
	string SPAWN_LIST;
	string USED_ME;
	int ZOMBIE_COUNT;
	int ZOMBIE_QUEST;
	int ZOMBIE_QUEST_STARTER;

	void OnSpawn() override
	{
		SetName("dwarf_mayor");
		SetHealth(30);
		SetGold(50);
		SetName("|Mayor Vilhelm");
		SetFOV(120);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetModel("dwarf/male1.mdl");
		SetModelBody(0, 0);
		SetModelBody(1, 0);
		SetInvincible(true);
		QUEST_GOBLINCHIEF = 0;
		ZOMBIE_COUNT = 0;
		REQ_ZOMBIES = 40;
		ZOMBIE_QUEST_STARTER = 0;
		SetHearingSensitivity(10);
		SetModelBody(2, 0);
		SetMoveAnim("idle");
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumor", "rumour");
		CatchSpeech("zombie_countup", "zombie");
		CatchSpeech("say_axe", "axe");
		CatchSpeech("say_roland", "roland");
	}

	void say_hi()
	{
		SayText("Welcome to Gate City, Adventurer!");
		ScheduleDelayedEvent(3, "say_hi2");
	}

	void say_hi2()
	{
		if (QUEST_GOBLINCHIEF == 0)
		{
			SayText("I may have a [job] for you.");
		}
	}

	void say_rumor()
	{
		SayText("I've heard Helena has fended off a fierce orc invasion.");
	}

	void say_job()
	{
		if ((ZOMBIE_QUEST_COMPLETE))
		{
			SayText("Nah, I canna possibly ask you to do anymore. Ya've earned yer rest laddie.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((L_ZOMBIE_QUEST_DONE))
		{
			SayText("Nah, I canna possibly ask you to do anymore. Ya've earned yer rest laddie.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((ZOMBIE_QUEST))
		{
			zombie_countup();
		}
		if ((ZOMBIE_QUEST)) return;
		if (QUEST_GOBLINCHIEF == 0)
		{
			SayText("Yes, lately, the city has been bothered by goblins.");
			ScheduleDelayedEvent(3, "say_job2");
		}
		if (QUEST_GOBLINCHIEF == 1)
		{
			SayText("Well, there is ONE other thing I can have ya do.");
			ScheduleDelayedEvent(4.0, "zombie_quest_desc");
		}
	}

	void say_job2()
	{
		SayText("If the goblin chief is killed, the goblins in the area should leave.");
		ScheduleDelayedEvent(3, "say_job3");
	}

	void say_job3()
	{
		SayText("Bring to me the head of the goblin chief and I'll reward you.");
	}

	void game_menu_getoptions()
	{
		USED_ME = param1;
		if ((ZOMBIE_QUEST))
		{
			if (ZOMBIE_COUNT < REQ_ZOMBIES)
			{
			}
			string reg.mitem.title = "How many more Zombies!?";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "zombie_countup";
			string reg.mitem.callback = "zombie_countup";
		}
		if ((ItemExists(param1, "item_gaxe_handle")))
		{
			string reg.mitem.title = "Ask about broken axe";
			string reg.mitem.type = "callback";
			string reg.mitem.data = "say_axe";
			string reg.mitem.callback = "say_axe";
		}
		if (!(QUEST_GOBLINCHIEF))
		{
			if ((ItemExists(param1, "item_goblinhead")))
			{
			}
			QUESTER_HEAD = param1;
			string reg.mitem.title = "Give Goblin's Head";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_goblinhead";
			string reg.mitem.callback = "say_ending";
		}
		if (ZOMBIE_COUNT >= REQ_ZOMBIES)
		{
			SetGlobalVar("ZOMBIE_QUEST_COMPLETE", 1);
			L_ZOMBIE_QUEST_DONE = 1;
		}
		if ((L_ZOMBIE_QUEST_DONE))
		{
			if (!(ALREADY_GAVE_AXE))
			{
			}
			if (!((ZOMBIE_QUEST_STARTER !is null)))
			{
				ZOMBIE_QUEST_STARTER = 0;
				USED_ME = 0;
			}
			if (USED_ME == ZOMBIE_QUEST_STARTER)
			{
			}
			if (!(GAVE_HEAVY_WARN))
			{
				GAVE_HEAVY_WARN = 1;
				SayText("I be warnin' ya - it's a REAL heavy key. Be sure you pack light!");
			}
			string reg.mitem.title = "Collect Zombie Reward";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "axe_em";
		}
	}

	void say_ending()
	{
		QUEST_GOBLINCHIEF = 1;
		SayText("Very good Adventurer! You have proven your worth!");
		ScheduleDelayedEvent(3, "say_ending2");
	}

	void say_ending2()
	{
		SayText("Take this gold as a reward! You will always be welcome in Gate City!");
		// TODO: offer QUESTER_HEAD gold RandomInt(50, 60)
		CallExternal("all", "goblin_remove");
		SetGlobalVar("G_NO_GLOBINS", 1);
	}

	void zombie_quest_desc()
	{
		SayText("Ya see we dwarves , being made of the stuff of Urdual and all , are particularly sensitive to imbalance.");
		ScheduleDelayedEvent(4.0, "zombie_quest_desc2");
	}

	void zombie_quest_desc2()
	{
		SayText("Even , as luck would have it , from beyond the grave.");
		ScheduleDelayedEvent(4.0, "zombie_quest_desc3");
	}

	void zombie_quest_desc3()
	{
		SayText("There's some mighty strange goins on these days, for I swear by the black and white seal more than half the dead are awake.");
		ScheduleDelayedEvent(4.0, "zombie_quest_desc4");
	}

	void zombie_quest_desc4()
	{
		SayText("There's just too many dwarves wandering the catacombs, making it impossible to get to the better mining areas.");
		ScheduleDelayedEvent(4.0, "zombie_quest_desc5");
	}

	void zombie_quest_desc5()
	{
		SayText("And Underkeep's cut off too, which does us no bit of good, not at all.");
		ScheduleDelayedEvent(4.0, "zombie_quest_desc6");
	}

	void zombie_quest_desc6()
	{
		SayText("Kill me " + REQ_ZOMBIES + " zombies - and I'll reward you with the key to the city!");
		ScheduleDelayedEvent(4.0, "zombie_quest_desc7");
	}

	void zombie_quest_desc7()
	{
		SayText("Or well, something shaped vaguely like it, and a mite sharper too!");
		ScheduleDelayedEvent(4.0, "zombie_quest_desc8");
	}

	void zombie_quest_desc8()
	{
		SayText("Gotta get it all done today though, or there'll just be so many it won't be worth doin' no more!");
		ZOMBIE_QUEST = 1;
		if (!(ZOMBIE_QUEST_STARTER == 0)) return;
		ZOMBIE_QUEST_STARTER = QUESTER_HEAD;
	}

	void zombie_countup()
	{
		if (!(QUEST_GOBLINCHIEF))
		{
			SayText("Yes , we have a bit of a problem with the Undead. But one thing at a time , young lad: The goblins first!");
			ScheduleDelayedEvent(3, "say_job2");
		}
		if (!(ZOMBIE_QUEST)) return;
		if (ZOMBIE_COUNT < REQ_ZOMBIES)
		{
			int Z_COUNT = int(ZOMBIE_COUNT);
			string Z_TO_GO = REQ_ZOMBIES;
			Z_TO_GO -= ZOMBIE_COUNT;
			int Z_TO_GO = int(Z_TO_GO);
			SayText("Well, countin' by the screams from down there, I think ya've killed about " + Z_COUNT + " of em.");
			SayText(I + "guess that leaves ya about " + Z_TO_GO + " left to kill. Keep at it!");
			PlayAnim("once", "nod");
		}
		if (ZOMBIE_COUNT >= REQ_ZOMBIES)
		{
			if (!(L_ZOMBIE_QUEST_DONE))
			{
				if ((IsEntityAlive(ZOMBIE_QUEST_STARTER)))
				{
					if (!(QUEST_STARTER_LEFT))
					{
					}
					string STARTER_ORIGIN = GetEntityOrigin(ZOMBIE_QUEST_STARTER);
					if (Distance(ZOMBIE_QUEST_STARTER, GetMonsterProperty("origin")) > 512)
					{
					}
					int EXIT_SUB = 1;
				}
				if (!(EXIT_SUB))
				{
				}
				SayText("I see you've come to collect yer reward?");
				SendInfoMsg("ent_lastspoke", "NPC Interaction Menu Use the +use key to to activate this NPC's interaction menu");
			}
			L_ZOMBIE_QUEST_DONE = 1;
			SetGlobalVar("ZOMBIE_QUEST_COMPLETE", 1);
			if (!(REMOVED_SPAWNS))
			{
				remove_spawns();
			}
		}
	}

	void axe_em()
	{
		if ((ALREADY_GAVE_AXE)) return;
		QUEST_WINNER = param1;
		SayText("Wow, you really did it. Ya must be about as restless as the undead themselves!");
		ScheduleDelayedEvent(4.0, "axe_em2");
	}

	void axe_em2()
	{
		if ((ALREADY_GAVE_AXE)) return;
		ALREADY_GAVE_AXE = 1;
		// TODO: offer QUEST_WINNER axes_golden
		SayText("Well, here ya go, you've earned it. It's forged with my family's special recipe for undead slayin' axe!");
	}

	void zombie_died()
	{
		if (!(ZOMBIE_QUEST)) return;
		ZOMBIE_COUNT += 1;
		if (!(ZOMBIE_COUNT >= REQ_ZOMBIES)) return;
		remove_spawns();
		SendInfoMsg("all", "You have killed a lotta zombies! You should speak with the mayor again...");
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(GetEntityRange("ent_lastheard") < 200)) return;
		SetMoveDest("ent_lastheard");
	}

	void say_axe()
	{
		if (param1 == "PARAM1")
		{
			string SPEAKER_ID = GetEntityIndex("ent_lastspoke");
			if (!(ItemExists(SPEAKER_ID, "item_gaxe_handle")))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SayText("Oh , my , " + I + " see ya broke it...");
		ScheduleDelayedEvent(4.0, "say_axe2");
	}

	void say_axe2()
	{
		SayText("Now don't get angry! Truth be told it be my great, great, great grandfather's recipe for golden axe...");
		ScheduleDelayedEvent(4.0, "say_axe3");
	}

	void say_axe3()
	{
		SayText("He never wrote it down, so I be goin' off memory when I make these.");
		ScheduleDelayedEvent(4.0, "say_axe4");
	}

	void say_axe4()
	{
		SayText("But talk Roland. He's the smith here in Gate City, and a fine one too.");
	}

	void say_roland()
	{
		SayText("He's on the main road, head left as you make your way out.");
		ScheduleDelayedEvent(4.0, "say_axe5");
	}

	void game_playerleave()
	{
		if (!(param1 == ZOMBIE_QUEST_STARTER)) return;
		LogDebug("zombie quest starter disconect");
		QUEST_STARTER_LEFT = 1;
	}

	void remove_spawns()
	{
		REMOVED_SPAWNS = 1;
		SPAWN_LIST = "spawners6;spawners7;spawners8;spawners9;spawners10";
		RSPAWN_COUNT = 0;
		remove_spawns_loop();
	}

	void remove_spawns_loop()
	{
		string L_CUR_SPAWN = GetToken(SPAWN_LIST, RSPAWN_COUNT, ";");
		string L_KILL_SPAWN = FindEntityByName(L_CUR_SPAWN);
		DeleteEntity(L_KILL_SPAWN);
		string L_NSPAWNS = GetTokenCount(SPAWN_LIST, ";");
		L_NSPAWNS -= 1;
		if (!(RSPAWN_COUNT < L_NSPAWNS)) return;
		RSPAWN_COUNT += 1;
		ScheduleDelayedEvent(1.0, "remove_spawns_loop");
	}

}

}
