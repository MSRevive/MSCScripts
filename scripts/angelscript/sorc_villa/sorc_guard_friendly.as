#pragma context server

#include "monsters/base_chat_array.as"

namespace MS
{

class SorcGuardFriendly : CGameScript
{
	string ANIM_NO;
	string ANIM_RAND_IDLE;
	string ANIM_YES;
	int CHAT_NO_CLOSE_MOUTH;
	int CHAT_USE_CONV_ANIMS;
	string CUR_SPEAKER;
	int GOT_RING;
	string NPC_DO_EVENTS;
	string QUEST_WINNER;
	string SCAN_COMMENT;
	string SORC_TYPE;
	int SPOTTED_PLAYER;
	int VENDOR_ALERT;
	string VEND_ID;

	SorcGuardFriendly()
	{
		CHAT_USE_CONV_ANIMS = 0;
		CHAT_NO_CLOSE_MOUTH = 1;
		ANIM_NO = "neigh";
		ANIM_YES = "nod_yes";
	}

	void OnSpawn() override
	{
		SetName("Shadahar Guard");
		SetModel("monsters/sorc.mdl");
		SetHealth(2000);
		SetDamageResistance("all", 0.7);
		SetStat("parry", 110);
		SetInvincible(true);
		SetRace("beloved");
		SetNoPush(true);
		SetWidth(32);
		SetHeight(96);
		SetIdleAnim("idle1");
		SetMoveAnim("idle1");
		PlayAnim("once", "idle1");
		SetModelBody(0, 2);
		SetModelBody(1, 2);
		SetModelBody(2, 7);
		SetSayTextRange(1024);
		CatchSpeech("say_hi", "hail");
		SetMenuAutoOpen(1);
		if (!(true)) return;
		SetGlobalVar("G_GAVE_DIRECTIONS", 0);
	}

	void game_postspawn()
	{
		NPC_DO_EVENTS = param4;
		if (!(param4 != "none")) return;
		for (int i = 0; i < GetTokenCount(NPC_DO_EVENTS, ";"); i++)
		{
			npcatk_do_events();
		}
	}

	void npcatk_do_events()
	{
		string N_EVENT = i;
		string EVENT_NAME = GetToken(NPC_DO_EVENTS, N_EVENT, ";");
		N_EVENT += 1;
		if (N_EVENT <= GetTokenCount(NPC_DO_EVENTS, ";"))
		{
			string NEXT_EVENT = GetToken(NPC_DO_EVENTS, N_EVENT, ";");
		}
		LogDebug("doing token event EVENT_NAME");
		EVENT_NAME(NEXT_EVENT);
	}

	void check_face()
	{
		if ((IsEntityAlive(param1)))
		{
			SetMoveDest(param1);
			CUR_SPEAKER = param1;
		}
		else
		{
			if ((IsEntityAlive("ent_lastspoke")))
			{
			}
			SetMoveDest("ent_lastspoke");
			CUR_SPEAKER = GetEntityIndex("ent_lastspoke");
		}
	}

	void say_hi()
	{
		check_face(GetEntityIndex(param1));
		if (SORC_TYPE == "firstguard")
		{
			SayText("You be guests of the Warchief, but don't overstay your welcome.");
		}
		if (SORC_TYPE == "caveguard")
		{
			SayText("Move along. This cave is closed, for the moment.");
		}
		if (SORC_TYPE == "archer")
		{
			if ((IsEntityAlive(CUR_SPEAKER)))
			{
			}
			if (GetEntityRange(CUR_SPEAKER) < 256)
			{
			}
			SayText("Please don't be up heres. As a guest of the Warchief, I'm not supposeds to shoots yous, but it makes it looks like meez not doing meez job.");
		}
		if (SORC_TYPE == "guard2")
		{
			SayText("Nuttin to see up here, move along.");
		}
		if (SORC_TYPE == "troll1")
		{
			SayText("Hiyaz, humans who be guests of Runegahr who me no supposed to kills.");
			PlayAnim("critical", "idle3");
		}
	}

	void say_town()
	{
		check_face(GetEntityIndex(param1));
		chat_start_sequence("guard_direct");
		SetGlobalVar("G_GAVE_DIRECTIONS", 1);
	}

	void say_well()
	{
		chat_start_sequence("guard_well");
	}

	void say_apple()
	{
		SayText("No thanks. Not while I'm on duty.");
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_hi";
		if (SORC_TYPE == "well")
		{
			string reg.mitem.callback = "say_well";
		}
		if (SORC_TYPE == "firstguard")
		{
			string reg.mitem.title = "Directions";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_town";
		}
		if (SORC_TYPE == "well")
		{
			string reg.mitem.title = "About the well";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_well";
		}
		if (SORC_TYPE == "troll1")
		{
			if (!(GOT_RING))
			{
			}
			string reg.mitem.title = "Ask About Rumors";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_troll_rumors";
			if ((ItemExists(param1, "item_bulge")))
			{
			}
			chat_now("You have Bulge's ring?");
			string reg.mitem.title = "Give Ring";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_bulge";
			string reg.mitem.callback = "troll_got_ring";
		}
	}

	void scan_players()
	{
		if ((SPOTTED_PLAYER)) return;
		ScheduleDelayedEvent(1.0, "scan_players");
		if (!(CanSee("player", 256))) return;
		SPOTTED_PLAYER = 1;
		PlayAnim("once", "nod_yes");
		SayText(SCAN_COMMENT);
	}

	void player_ogre_hole()
	{
		if (SORC_TYPE == "firstguard")
		{
			int WELL_COMMENT = 1;
		}
		if (SORC_TYPE == "caveguard")
		{
			int WELL_COMMENT = 1;
		}
		if ((WELL_COMMENT))
		{
			SPOTTED_PLAYER = 0;
			SCAN_COMMENT = "Silly human jumped down the ogre well, did he? Hahahaha!";
			ScheduleDelayedEvent(0.1, "scan_players");
		}
	}

	void set_first_guard()
	{
		chat_add_text("guard_direct", "Huh? Umm... Most of the shops are downstairs. Smith is at the front of town - opposite of here.", 4.0, "nod_yes");
		chat_add_text("guard_direct", "Alchemist has a shop near the exit to the desert... There's an... Elf... Out there too. He's with Galat.", 5.0);
		chat_add_text("guard_direct", "We, tollerate, having him there - but not in town.", 3.0);
		chat_add_text("guard_direct", "Oh yeah, speaking of tollerate... Above and across from the Alchemist there's a human...", 4.0);
		chat_add_text("guard_direct", "He's here a lot - sells yummy apples. You might wanna meet him. He's very... Nervous... *chuckle*", 4.0);
		CatchSpeech("say_apple", "apple");
		SCAN_COMMENT = "Stay out of trouble and we'll have no problems...";
		SORC_TYPE = "firstguard";
		ScheduleDelayedEvent(0.1, "scan_players");
	}

	void set_cave_guard()
	{
		SORC_TYPE = "caveguard";
	}

	void set_archer_roam()
	{
		SetName("Shadahar Archer");
		SetModelBody(0, 3);
		SetModelBody(1, 2);
		SetModelBody(2, 2);
		SORC_TYPE = "archer";
		SetRoam(true);
		SetMoveAnim("walk");
		SetStepSize(1);
		SetName("roof_archer");
	}

	void set_well_guard1()
	{
		chat_add_text("guard_well", "I knows how yous humans likes to explore, but don't be thinking about going down this well.", 4.0, ANIM_NO);
		chat_add_text("guard_well", "We keeps the ogre-djinn down there, until they be old enough to train. Eat yous alive, they will.", 4.0);
		CatchSpeech("say_well", "well");
		SetModelBody(1, 1);
		SetModelBody(2, 6);
		SORC_TYPE = "well";
	}

	void set_guard2()
	{
		SORC_TYPE = "guard2";
	}

	void ext_under_attack1()
	{
		SetSayTextRange(1024);
		SetMoveAnim("run");
		VENDOR_ALERT = 1;
		VEND_ID = param1;
		SetMoveDest(VEND_ID);
		EmitSound(GetOwner(), 0, "monsters/orc/attack3.wav", 10);
		EmitSound(GetOwner(), 1, "voices/sorc_villa/archer_response1.wav", 10);
		SayText("Those are Runegahr's guests, you stupid human, remember!?");
	}

	void game_reached_destination()
	{
		if (!(VENDOR_ALERT)) return;
		LogDebug("game_reached_destination");
		VENDOR_ALERT = 0;
		SetMoveDest(VEND_ID);
		SetRoam(false);
		SetMoveAnim("walk");
		PlayAnim("critical", "warcry");
	}

	void ext_under_attack2()
	{
		PlayAnim("critical", ANIM_NO);
		SetMoveDest(param1);
		SetMoveAnim("walk");
		SetRoam(true);
		EmitSound(GetOwner(), 0, "voices/sorc_villa/archer_response2.wav", 10);
		SayText("Stupid... Cowardly... Son of a boar...");
	}

	void set_troll1()
	{
		SetName("Shadahar Lightning Djinn");
		SetModel("monsters/troll_shad.mdl");
		SetWidth(36);
		SetHeight(92);
		SORC_TYPE = "troll1";
		SetIdleAnim("idle0");
		SetMoveAnim("idle0");
		SetRoam(false);
		ANIM_RAND_IDLE = "idle1";
		Random(20_0, 30_0)("rand_idle");
	}

	void rand_idle()
	{
		Random(20_0, 30_0)("rand_idle");
		PlayAnim("once", ANIM_RAND_IDLE);
	}

	void say_troll_rumors()
	{
		if ((CHAT_BUSY)) return;
		SetName("Lighting Bulge");
		chat_now("Hmmm... Maybe yoos humans can helps me with somethings...", 4.0, "idle1", "add_to_que");
		chat_now("The call me Bulge - Lighting Bulge... Or at least meez friends do.", "add_to_que");
		chat_now("Some mean orcees, who are not friends, stole Bulge's ring.", 5.0, "idle3", "add_to_que");
		chat_now("Buldge get ring for pretty girl - who live in that Sun place...", "add_to_que");
		chat_now("But mean orcees throw down well.", "add_to_que");
		chat_now("Bulge too big to go in well... Maybe you help Bulge get ring? Maybe Bulge gives you somethings he finds.", "add_to_que");
	}

	void troll_got_ring()
	{
		GOT_RING = 1;
		chat_now("Yes! You got me ring back! Haha! Stupid mean orcees no count on skinny humans helpings meez!", 4.0, "idle2", "clear_que");
		chat_now("Okies, me give you somethings me find. Weird green-skull thingie. Me no knows what is.", 4.0, "idle1", "give_skull", "add_to_que");
		chat_now("Kinda purty, but too spooky for girl. You take, maybe find use for.", "add_to_que");
		QUEST_WINNER = param1;
	}

	void give_skull()
	{
		// TODO: offer QUEST_WINNER item_js
	}

}

}
