#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_chat.as"
#include "monsters/base_npc_vendor.as"
#include "monsters/base_npc_vendor_confirm.as"
#include "monsters/base_xmass.as"

namespace MS
{

class Olof : CGameScript
{
	int AM_SCREAMING;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_STEP1;
	string ANIM_STEP2;
	string ANIM_STEP3;
	string ANIM_STEP4;
	string ANIM_WALK;
	string CALMER_ID;
	int CANT_TURN;
	float CHAT_DELAY_STEP1;
	float CHAT_DELAY_STEP2;
	float CHAT_DELAY_STEP3;
	float CHAT_DELAY_STEP4;
	float CHAT_DELAY_STEP5;
	string CHAT_EVENT_STEP4;
	string CHAT_EVENT_STEP5;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	int CHAT_STEPS;
	int HAVE_RING;
	string HI_PLAYER;
	int MENTIONED_CURSE;
	string NEXT_STORE_CHATTER;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	int NO_STUCK_CHECKS;
	int NPC_NO_ATTACK;
	int NPC_NO_PLAYER_DMG;
	string QUEST_WINNER;
	string SAW_FIRST_PLAYER;
	string SHOPPER_ID;
	string SND_SCREAM1;
	string SND_SCREAM2;
	string SND_SCREAM3;
	int STORE_BUYMENU;
	string STORE_NAME;
	int STORE_SELLMENU;
	int VENDOR_MENU_OFF;
	int VENDOR_NOT_ON_USE;
	string VENDOR_TARGET;
	string VERIFY_TARGET;

	Olof()
	{
		ANIM_RUN = "run1";
		ANIM_WALK = "walk_scared";
		ANIM_DEATH = "diesimple";
		ANIM_IDLE = "idle1";
		NPC_NO_PLAYER_DMG = 1;
		NO_STUCK_CHECKS = 1;
		NPC_NO_ATTACK = 1;
		CANT_TURN = 1;
		NO_HAIL = 1;
		NO_JOB = 1;
		NO_RUMOR = 1;
		STORE_NAME = "olof_shop";
		VENDOR_MENU_OFF = 1;
		VENDOR_NOT_ON_USE = 1;
		STORE_SELLMENU = 1;
		STORE_BUYMENU = 1;
		SND_SCREAM1 = "scientist/scream7.wav";
		SND_SCREAM2 = "scientist/scream17.wav";
		SND_SCREAM3 = "scientist/scream07.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		if ((CanSee("player", 128)))
		{
		}
		string PLAYER_ID = GetEntityIndex(m_hLastSeen);
		check_player_status(PLAYER_ID, 1);
	}

	void OnSpawn() override
	{
		SetName("Olof Odlaren");
		SetModel("npc/human1.mdl");
		SetHealth(30);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetRoam(false);
		SetIdleAnim("idle1");
		SetNoPush(true);
		CatchSpeech("say_yes", "yes");
		CatchSpeech("say_no", "no");
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_curse", "curse");
		if (!(true)) return;
		SHOPPER_ID = "none";
	}

	void check_player_status()
	{
		string PLAYER_ID = param1;
		string DO_REACT = param2;
		string PLAYER_STATUS = GetEntityProperty(PLAYER_ID, "scriptvar");
		if (PLAYER_STATUS == "PLR_OLOF_STATUS")
		{
			if (GetPlayerQuestData(param1, "r") > 0)
			{
				CallExternal(param1, "ext_olof_setstatus", "friendly");
				if ((DO_REACT))
				{
				}
				calm_down("ring_quest_started", PLAYER_ID);
			}
			else
			{
				if ((ItemExists(param1, "item_ring_percept")))
				{
					CallExternal(param1, "ext_olof_setstatus", "friendly");
					calm_down("ring_percept", PLAYER_ID);
				}
				else
				{
					if ((ItemExists(param1, "item_ring")))
					{
						CallExternal(param1, "ext_olof_setstatus", "friendly");
						calm_down("my_ring", PLAYER_ID);
					}
					else
					{
						CallExternal(param1, "ext_olof_setstatus", "unknown");
						if ((DO_REACT))
						{
						}
						verify_friendly(PLAYER_ID, 0);
					}
				}
			}
		}
		else
		{
			if ((DO_REACT))
			{
			}
			if (PLAYER_STATUS == "evil")
			{
				if (!(AM_SCREAMING))
				{
				}
				start_screaming();
				SayText("Get away from me you evil monster from hell!");
				Say("[0.5] [0.2] [0.1] [0.1] [0.1] [0.1] [0.1]");
			}
		}
	}

	void verify_friendly()
	{
		VERIFY_TARGET = param1;
		string FROM_MENU = param2;
		CallExternal(param1, "ext_olof_setstatus", "unknown");
		if (!(SAW_FIRST_PLAYER))
		{
			SayText("Halt! Are you one of the undead monsters?");
			Say("[0.5] [0.2] [0.1] [0.1] [0.1] [0.1] [0.1]");
			SAW_FIRST_PLAYER = 1;
		}
		else
		{
			SayText("And you? ...are " + YOU + " one of the evil ones?");
			Say("[0.5] [0.2] [0.1] [0.1] [0.1] [0.1] [0.1]");
		}
		PlayAnim("once", "panic");
		if ((FROM_MENU)) return;
		OpenMenu(param1);
	}

	void game_menu_getoptions()
	{
		SetMoveDest(param1);
		VENDOR_TARGET = param1;
		string PLAYER_STATUS = GetEntityProperty(param1, "scriptvar");
		if (PLAYER_STATUS == "PLR_OLOF_STATUS")
		{
			check_player_status(GetEntityIndex(param1), 0);
			string PLAYER_STATUS = GetEntityProperty(param1, "scriptvar");
		}
		if (param1 != VERIFY_TARGET)
		{
			if (PLAYER_STATUS == "unknown")
			{
				verify_friendly(GetEntityIndex(param1), 1);
			}
		}
		if (param1 == VERIFY_TARGET)
		{
			string reg.mitem.title = "Yes!";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_yes";
			string reg.mitem.title = "No!";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_no";
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (PLAYER_STATUS == "evil")
		{
			if ((AM_SCREAMING))
			{
			}
			string reg.mitem.title = "Wait! I'm NOT evil!";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_no";
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (PLAYER_STATUS == "friendly")
		{
			string reg.mitem.title = "Hail?";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_hi";
			string reg.mitem.title = "You have wares?";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "vendor_offerstore";
			if ((MENTIONED_CURSE))
			{
				string reg.mitem.title = "Cursed?";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_curse";
			}
			if ((ItemExists(param1, "item_ring")))
			{
				if (GetPlayerQuestData(param1, "r") == 0)
				{
				}
				if ((HAVE_RING))
				{
					int SECOND_RING = 1;
				}
				if (RING_BOY_ID == "RING_BOY_ID")
				{
					int SECOND_RING = 1;
				}
				if (!(SECOND_RING))
				{
					if (!(ItemExists(param1, "item_ring_percept")))
					{
						RING_BOY_ID = param1;
						not_my_ring();
						return;
					}
					else
					{
						string reg.mitem.title = "Return ring";
						string reg.mitem.type = "payment";
						string reg.mitem.data = "item_ring";
						string reg.mitem.callback = "got_ring";
					}
				}
				else
				{
					string reg.mitem.title = "Return ring";
					string reg.mitem.type = "callback";
					string reg.mitem.callback = "second_ring";
				}
			}
			if ((AM_SCREAMING))
			{
			}
			calm_down("friendly_used", GetEntityIndex(param1));
		}
	}

	void game_menu_cancel()
	{
		if (!(param1 == VERIFY_TARGET)) return;
		SayText("I... I won't talk until you answer me!");
		Say("[0.5] [0.2] [0.1] [0.1] [0.1] [0.1] [0.1]");
		PlayAnim("once", "panic");
	}

	void say_yes()
	{
		if ((IsEntityAlive(param1)))
		{
			string PLAYER_ID = param1;
		}
		else
		{
			string PLAYER_ID = GetEntityIndex("ent_lastspoke");
		}
		VERIFY_TARGET = 0;
		CallExternal(PLAYER_ID, "ext_olof_setstatus", "evil");
		SayText(AAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHH!!!!!!!!);
		PlayAnim("once", "fear2");
		Say("[2]");
		AM_SCREAMING = 1;
		ScheduleDelayedEvent(2.0, "do_screaming");
	}

	void say_no()
	{
		if ((IsEntityAlive(param1)))
		{
			string PLAYER_ID = param1;
		}
		else
		{
			string PLAYER_ID = GetEntityIndex("ent_lastspoke");
		}
		CALMER_ID = PLAYER_ID;
		CallExternal(PLAYER_ID, "ext_olof_setstatus", "friendly");
		VERIFY_TARGET = 0;
		AM_SCREAMING = 0;
		PlayAnim("once", "lean");
		SetMenuAutoOpen(1);
		ScheduleDelayedEvent(3, "say_no2");
	}

	void say_no2()
	{
		calm_down("said_no", CALMER_ID);
		VERIFY_TARGET = 0;
	}

	void start_screaming()
	{
		AM_SCREAMING = 1;
		do_screaming();
	}

	void do_screaming()
	{
		if (!(AM_SCREAMING)) return;
		int RND_ANIM = RandomInt(1, 4);
		if (RND_ANIM == 1)
		{
			PlayAnim("once", "fear1");
		}
		if (RND_ANIM == 2)
		{
			PlayAnim("once", "fear2");
		}
		if (RND_ANIM == 3)
		{
			PlayAnim("once", "crouch_idle2");
		}
		if (RND_ANIM == 4)
		{
			PlayAnim("once", "crouch_idle2");
		}
		// PlayRandomSound from: SND_SCREAM1, SND_SCREAM2, SND_SCREAM3
		array<string> sounds = {SND_SCREAM1, SND_SCREAM2, SND_SCREAM3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 8);
		SetIdleAnim("crouch_idle");
		Random(5_0, 10_0)("do_screaming");
	}

	void calm_down()
	{
		string REASON_CALM = param1;
		SetRoam(false);
		AM_SCREAMING = 0;
		SetIdleAnim("idle1");
		if (REASON_CALM == "ring_quest_started")
		{
			SayText("Oh, it's you... I hope you got that ring back to Galan.");
			bchat_auto_mouth_move(3.0);
		}
		if (REASON_CALM == "my_ring")
		{
			string L_NAME = GetEntityName(param2);
			L_NAME += ",";
			SayText(L_NAME + " have you found the ring yet?");
			Say("[0.5] [0.1] [0.1] [0.1] [0.1] [0.1] [0.2]");
			PlayAnim("once", "pondering3");
		}
		if (REASON_CALM == "skull_blade")
		{
			string L_NAME = GetEntityName(param2);
			L_NAME += ",";
			SayText("Ah , " + L_NAME + " Thank you for the nice ring.");
			Say("[0.5] [0.1] [0.1] [0.1] [0.1] [0.1] [0.2]");
			PlayAnim("once", "yes");
		}
		if (REASON_CALM == "friendly_used")
		{
			SayText("Oh! It... It's you... What can I do for you?");
			bchat_auto_mouth_move(3.0);
		}
		if (REASON_CALM == "said_no")
		{
			SayText("...Ok , " + I + " believe you... for now...");
			Say("[0.2] [0.2] [0.1] [0.2] [0.1] [0.1]");
		}
		if (REASON_CALM == "ring_percept")
		{
			SayText("I... I see you worked things out with Galan's ring.");
			Say("[0.2] [0.2] [0.1] [0.2] [0.1] [0.1]");
		}
		if (REASON_CALM == "ring_boy")
		{
			not_my_ring();
		}
	}

	void say_hi()
	{
		if ((IsEntityAlive(param1)))
		{
			string PLAYER_ID = param1;
		}
		else
		{
			string PLAYER_ID = GetEntityIndex("ent_lastspoke");
		}
		string PLAYER_STATUS = GetEntityProperty(PLAYER_ID, "scriptvar");
		if (!(IsEntityAlive(PLAYER_ID))) return;
		if (PLAYER_STATUS == "PLR_OLOF_STATUS")
		{
			string PLAYER_STATUS = "unknown";
		}
		if (PLAYER_STATUS == "unknown")
		{
			SayText("Stay away from me! You look like evil! Are you evil?!?");
			Say("[0.2] [0.1] [0.05] [0.05] [0.05] [0.05] [0.05] [0.1]");
			PlayAnim("once", "panic");
			verify_friendly(PLAYER_ID, 0);
		}
		if (PLAYER_STATUS == "evil")
		{
			SayText("The evil fiend tried to talk to me!!! No , my ears have been cursed!");
			Say("[0.2] [0.1] [0.1] [0.1] [0.1] [0.1] [0.1] [0.1]");
			PlayAnim("once", "fear1");
		}
		if (PLAYER_STATUS == "friendly")
		{
			HI_PLAYER = PLAYER_ID;
			say_hi2();
		}
	}

	void say_hi2()
	{
		if ((BUSY_CHATTING))
		{
			SendColoredMessage(HI_PLAYER, "Olof is busy babbling about something else...");
		}
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "..Are you really sure you are no monster? ";
		ANIM_STEP1 = "pondering3";
		CHAT_DELAY_STEP1 = 3.0;
		CHAT_STEP2 = "There is too much evil these days..";
		ANIM_STEP2 = "c1a0_catwalkidle";
		CHAT_DELAY_STEP2 = 2.0;
		CHAT_STEP3 = "If you really are a shining light, maybe you could help me?";
		CHAT_DELAY_STEP3 = 4.0;
		CHAT_STEP4 = "All of the people in this town have been [cursed]!";
		CHAT_DELAY_STEP4 = 3.0;
		ANIM_STEP4 = "startle";
		MENTIONED_CURSE = 1;
		CHAT_STEPS = 4;
		chat_loop();
	}

	void say_curse()
	{
		if ((IsEntityAlive(param1)))
		{
			string PLAYER_ID = param1;
		}
		else
		{
			string PLAYER_ID = GetEntityIndex("ent_lastspoke");
		}
		string PLAYER_STATUS = GetEntityProperty(PLAYER_ID, "scriptvar");
		if (!(PLAYER_STATUS == "friendly")) return;
		if ((BUSY_CHATTING))
		{
			SendColoredMessage(PLAYER_ID, "Olof is busy babbling about something else...");
		}
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Yeah, horrible isn't it? ";
		ANIM_STEP1 = "eye_wipe";
		CHAT_DELAY_STEP1 = 2.0;
		CHAT_STEP2 = "The evil Lord Undamael has turned all the people in my town into books!";
		CHAT_DELAY_STEP2 = 4.0;
		CHAT_STEP3 = "I will need my ring to turn them back to normal again.";
		ANIM_STEP3 = "yes";
		CHAT_DELAY_STEP3 = 3.0;
		CHAT_STEP4 = "I will reward you if you find it, but you won't.. because I lost it in the..";
		ANIM_STEP4 = "no";
		CHAT_DELAY_STEP4 = 3.0;
		CHAT_EVENT_STEP4 = "say_curse2";
		CHAT_STEPS = 4;
		chat_loop();
	}

	void say_curse2()
	{
		PlayAnim("critical", "fear1");
		ScheduleDelayedEvent(1.0, "say_curse3");
	}

	void say_curse3()
	{
		SayText(..H-A-U-N-T-E-D + " forest!");
		Say("[1] [0.2] [1] [0.2]");
	}

	void vendor_offerstore()
	{
		string PLAYER_STATUS = GetEntityProperty(param1, "scriptvar");
		if (!(PLAYER_STATUS == "friendly")) return;
		if (!(SHOPPER_ID == "none")) return;
		if (GetGameTime() > NEXT_STORE_CHATTER)
		{
			int RND_CHAT = RandomInt(1, 5);
			if (RND_CHAT == 1)
			{
				SayText("Demons leave the most interesting stuff lying around...");
			}
			if (RND_CHAT == 2)
			{
				SayText("Don t tell anyone, but there s more downstairs...");
			}
			if (RND_CHAT == 3)
			{
				SayText("All this stuff is cursed , you know...");
			}
			if (RND_CHAT == 4)
			{
				SayText(I + " don t sell to demons, but I suppose you re ok.");
			}
			if (RND_CHAT == 5)
			{
				SayText("I'll buy skins if ya have em, they keeps the demons away.");
			}
			bchat_auto_mouth_move(3.0);
			NEXT_STORE_CHATTER = GetGameTime();
			NEXT_STORE_CHATTER += 10.0;
		}
		SHOPPER_ID = param1;
		ScheduleDelayedEvent(2.0, "give_store");
	}

	void give_store()
	{
		basevendor_offerstore(SHOPPER_ID);
		SHOPPER_ID = "none";
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "health_mpotion", RandomInt(10, 20), 105);
		AddStoreItem(STORE_NAME, "health_apple", RandomInt(15, 25), 100);
		AddStoreItem(STORE_NAME, "proj_arrow_wooden", 120, 100, 0, 60);
		AddStoreItem(STORE_NAME, "proj_arrow_poison", 120, 75, 0, 30);
		AddStoreItem(STORE_NAME, "proj_arrow_broadhead", 120, 100, 0, 60);
		AddStoreItem(STORE_NAME, "proj_arrow_silvertipped", 120, 100, 0, 60);
		AddStoreItem(STORE_NAME, "pack_heavybackpack", RandomInt(0, 1), 110);
		AddStoreItem(STORE_NAME, "item_torch", RandomInt(10, 20), 75);
		AddStoreItem(STORE_NAME, "axes_scythe", RandomInt(0, 1), 90);
		AddStoreItem(STORE_NAME, "scroll2_glow", RandomInt(0, 1), 100);
		AddStoreItem(STORE_NAME, "scroll_glow", RandomInt(0, 1), 100);
		AddStoreItem(STORE_NAME, "scroll2_fire_dart", RandomInt(0, 1), 120);
		AddStoreItem(STORE_NAME, "sheath_spellbook", 2, 80);
		AddStoreItem(STORE_NAME, "skin_boar", 0, 150, 1.5);
		AddStoreItem(STORE_NAME, "skin_ratpelt", 0, 250, 2.5);
		AddStoreItem(STORE_NAME, "skin_bear", 0, 150, 1.5);
		AddStoreItem(STORE_NAME, "skin_boar_heavy", 0, 150, 1.5);
		if (!(RandomInt(1, 3) == 1)) return;
		AddStoreItem(STORE_NAME, "sheath_back_holster", 1, 100, SELL_RATIO);
	}

	void closetskel()
	{
		SetMoveAnim("run1");
		SetIdleAnim("walk_scared");
	}

	void OnDamage(int damage) override
	{
		if ((IsValidPlayer(param1))) return;
		SetIdleAnim("walk_scared");
		SetRoam(true);
		SetMenuAutoOpen(0);
		npcatk_flee(GetEntityIndex(param1), 9999, 8.0);
		// PlayRandomSound from: SND_SCREAM1, SND_SCREAM2, SND_SCREAM3
		array<string> sounds = {SND_SCREAM1, SND_SCREAM2, SND_SCREAM3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npcatk_settarget()
	{
	}

	void got_ring()
	{
		HAVE_RING = 1;
		SayText("What's that? Ohh, nice ring!");
		PlayAnim("once", "return_needle");
		Say("[0.2] [0.2] [0.05] [0.05] [0.05] [0.05]");
		QUEST_WINNER = param1;
		ScheduleDelayedEvent(2, "got_ring2");
	}

	void got_ring2()
	{
		SayText("Don't know who it belongs to, but I'll trade it for one of my swords!");
		PlayAnim("once", "pull_needle");
		Say("[0.2 [0.2] [0.1] [0.1] [0.1] [0.2] [0.2] [0.2]");
		ScheduleDelayedEvent(2, "give_sword");
	}

	void give_sword()
	{
		// TODO: offer QUEST_WINNER swords_skullblade4
	}

	void second_ring()
	{
		SayText("Another... Ring? So...");
		PlayAnim("once", "dryhands");
		Say("[1]");
		ScheduleDelayedEvent(1.5, "second_ring2");
	}

	void second_ring2()
	{
		SayText("pretty....");
		Say("[1]");
		ScheduleDelayedEvent(2, "second_ring3");
	}

	void second_ring3()
	{
		SayText("No! I musn't be tempted!");
		Say("[0.2] [0.2] [0.2] [0.2]");
		PlayAnim("critical", "rflinch1");
	}

	void not_my_ring()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "not_my_ring");
		}
		if ((BUSY_CHATTING)) return;
		SetMoveDest(RING_BOY_ID);
		CHAT_STEP1 = "Hey, that rr.r....ring you have there...";
		ANIM_STEP1 = "eye_wipe";
		CHAT_DELAY_STEP1 = 3.0;
		CHAT_STEP2 = "That one's not mine!";
		CHAT_DELAY_STEP2 = 2.0;
		CHAT_STEP3 = "But I bet I know who would know whose it is!";
		CHAT_DELAY_STEP3 = 3.0;
		CHAT_STEP4 = "Galan! In Gatecity...";
		CHAT_DELAY_STEP4 = 2.0;
		CHAT_STEP5 = "He and I were friends... Before... You know... The b..books....";
		CHAT_DELAY_STEP5 = 4.0;
		CHAT_EVENT_STEP5 = "not_my_ring2";
		CHAT_STEPS = 5;
		chat_loop();
	}

	void not_my_ring2()
	{
		SetPlayerQuestData(RING_BOY_ID, "r");
	}

}

}
