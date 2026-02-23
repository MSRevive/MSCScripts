#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_chat.as"

namespace MS
{

class GAdventurer : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BATTLE_OVER;
	int BATTLLE_OVER;
	string CHAT_DELAY_STEP1;
	string CHAT_DELAY_STEP2;
	string CHAT_DELAY_STEP3;
	string CHAT_SOUND1;
	string CHAT_SOUND2;
	string CHAT_SOUND3;
	string CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEPS;
	string CONVO_TYPE;
	string CURRENT_SPEAKER;
	string DID_INTRO;
	int FORCED_MOVE_DEST;
	int IN_BATTLE;
	int MAX_REWARDS_TOGIVE;
	string MENU_TARGET;
	int MOVE_RANGE;
	string NEXT_FF_WARNING;
	int NO_HAIL;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	int NPC_NO_PLAYER_DMG;
	int N_REWARDS_GIVEN;
	string QUEST_WINNER;
	string REWARD_LIST;
	string REWARD_NAMES;
	string SAID_REWARD;

	GAdventurer()
	{
		const float FREQ_FF_WARN = 10.0;
		REWARD_LIST = "axes_poison1;swords_poison1;swords_liceblade;gauntlets_normal;mana_leadfoot;scroll2_summon_rat;bows_swiftbow;item_charm_w1";
		REWARD_NAMES = "an Envenomed Axe;a Envenomed Shortsword;a Lesser Ice Blade;a set of Gauntlets;a Potion of Stability;a Summon Rat Scroll;an Elven Bow;a Wolf Charm";
		N_REWARDS_GIVEN = 0;
		MAX_REWARDS_TOGIVE = 0;
		const string SOUND_STRUCK = "body/flesh1.wav";
		const string SOUND_DEATH = "voices/human/male_die.wav";
		Precache(SOUND_DEATH);
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_DEATH = "diebackward";
		ANIM_ATTACK = "swordswing1_l";
		MOVE_RANGE = 32;
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 120;
		const float ATTACK_HITCHANCE = 0.85;
		const string ATTACK_DAMAGE = "$randf(5.0,8.0)";
		NPC_GIVE_EXP = 0;
		NPC_NO_PLAYER_DMG = 1;
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
		NO_HAIL = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10.0);
		if ((BATTLE_OVER))
		{
			if (!(GAVE_REWARD))
			{
			}
			SetMoveDest(QUEST_WINNER);
		}
		if (Distance(GetMonsterProperty("origin"), NPC_HOME_LOC) > 800)
		{
		}
		npcatk_suspend_ai(2.0);
		NPC_FORCED_MOVEDEST = 1;
		npcatk_setmovedest(NPC_HOME_LOC, 32);
		SetMoveDest(NPC_HOME_LOC);
		if (m_hAttackTarget != "unset")
		{
			npcatk_run();
		}
	}

	void OnSpawn() override
	{
		SetName("Jerdid the Adventurer");
		SetInvincible(true);
		ScheduleDelayedEvent(0.1, "stay_invuln_damnit");
		SetRace("human");
		SetWidth(32);
		SetHeight(96);
		SetHealth(300);
		SetSayTextRange(800);
		SetHearingSensitivity(8);
		SetModel("npc/royal_guard1.mdl");
		SetModelBody(1, 3);
		ScheduleDelayedEvent(1.0, "critical_npc");
		SetIdleAnim("idle1");
		SetMoveAnim("walk");
		CatchSpeech("say_hi", "hi");
	}

	void stay_invuln_damnit()
	{
		SetInvincible(true);
	}

	void OnDamage(int damage) override
	{
		if ((BATTLE_OVER))
		{
			SetDamage("dmg");
			SetDamage("hit");
			return;
			int EXIT_SUB = 1;
		}
		if (!(IN_BATTLE))
		{
			SetDamage("dmg");
			SetDamage("hit");
			return;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		EmitSound(GetOwner(), 0, SOUND_STRUCK, 5);
		if (!(IsValidPlayer(param1))) return;
		if (!(GetGameTime() > NEXT_FF_WARNING)) return;
		NEXT_FF_WARNING = GetGameTime();
		NEXT_FF_WARNING += FREQ_FF_WARN;
		string L_ITEM_NAME = GetEntityProperty(param1, "scriptvar");
		string L_ITEM_NAME = GetEntityProperty(L_ITEM_NAME, "itemname");
		if ((L_ITEM_NAME).findFirst("magic_hand") == 0)
		{
			int IS_SPELL = 1;
		}
		if ((L_ITEM_NAME).findFirst("blunt_staff") == 0)
		{
			int IS_SPELL = 1;
		}
		if ((IS_SPELL))
		{
			SayText("Watch where you cast your spells!");
			string RND_SPELL = RandomInt(1, 2);
			if (RND_SPELL == 1)
			{
				EmitSound(GetOwner(), 0, "voices/jerdid/Jerdid_8.wav", 10);
			}
			else
			{
				EmitSound(GetOwner(), 0, "voices/jerdid/Jerdid_8_2.wav", 10);
			}
		}
		if (!(IS_SPELL))
		{
			SayText("Hey there! Careful where you swing that!");
			EmitSound(GetOwner(), 0, "voices/jerdid/Jerdid_9.wav", 10);
		}
	}

	void say_hi()
	{
		if ((IN_BATTLE)) return;
		if ((BUSY_CHATTING)) return;
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
		if (!(BATTLE_OVER))
		{
			DID_INTRO = 1;
			PlayAnim("critical", "lean");
			ScheduleDelayedEvent(2.0, "fix_anims");
			CONVO_TYPE = "intro";
			CHAT_STEPS = 3;
			CHAT_STEP = 0;
			CHAT_STEP1 = "Ah, hello there. I've been honing my skills here for awhile now.";
			CHAT_DELAY_STEP1 = 5.01;
			CHAT_SOUND1 = "voices/jerdid/Jerdid_1.wav";
			CHAT_STEP2 = "However, I'm hearing far more howls than I'd feel comfortable dealing with... Should there be wolves attached to them all.";
			CHAT_DELAY_STEP2 = 8.19;
			CHAT_SOUND2 = "voices/jerdid/Jerdid_2.wav";
			CHAT_STEP3 = "If you'd be so kind as to stay a moment and assist me, I'd would be forever grateful.";
			CHAT_DELAY_STEP3 = 6.33;
			CHAT_SOUND3 = "voices/jerdid/Jerdid_3.wav";
			chat_loop();
		}
		if ((BATTLE_OVER))
		{
			PlayAnim("critical", "yes");
			ScheduleDelayedEvent(2.0, "fix_anims");
			SayText("Thanks again for your assistance.");
			EmitSound(GetOwner(), 0, "voices/jerdid/Jerdid_10.wav", 10);
		}
	}

	void chat_loop()
	{
		if (CHAT_STEP == 2)
		{
			if (CONVO_TYPE == "intro")
			{
			}
			SetMoveDest(/* TODO: $relpos */ $relpos(0, -8000, 0));
			UseTrigger("distant_howl");
			PlayAnim("critical", "panic");
			ScheduleDelayedEvent(2.0, "fix_anims");
		}
		if (CHAT_STEP == 3)
		{
			if (CONVO_TYPE == "intro")
			{
			}
			SetMoveDest(CURRENT_SPEAKER);
			PlayAnim("critical", "converse2");
			NO_HAIL = 1;
			ScheduleDelayedEvent(2.0, "open_menu");
		}
	}

	void open_menu()
	{
		OpenMenu(CURRENT_SPEAKER);
	}

	void game_menu_getoptions()
	{
		LogDebug("game_menu_getoptions conv: CONVO_TYPE");
		if (CONVO_TYPE == "intro")
		{
			string reg.mitem.title = "Yes, I'll help.";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "player_accept";
			string reg.mitem.title = "Sorry, busy.";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "player_deny";
		}
		if ((BATTLE_OVER))
		{
			LogDebug("game_menu_getoptions bat BATTLE_OVER");
			if (CONVO_TYPE != "give_list")
			{
			}
			if (!(GetEntityProperty(param1, "scriptvar")))
			{
			}
			string reg.mitem.title = "Collect reward";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "give_reward";
		}
		if (CONVO_TYPE == "give_list")
		{
			if (!(GetEntityProperty(param1, "scriptvar")))
			{
			}
			for (int i = 0; i < GetTokenCount(REWARD_LIST, ";"); i++)
			{
				add_rewards();
			}
			CONVO_TYPE = "none";
			NO_HAIL = 0;
		}
	}

	void add_rewards()
	{
		if (!(RandomInt(1, 2) == 1)) return;
		string CUR_IDX = i;
		string CUR_REWARD = GetToken(REWARD_LIST, CUR_IDX, ";");
		string CUR_NAME = GetToken(REWARD_NAMES, CUR_IDX, ";");
		string reg.mitem.title = CUR_NAME;
		string reg.mitem.type = "callback";
		string reg.mitem.data = CUR_IDX;
		string reg.mitem.cb_failed = "no_want";
		string reg.mitem.callback = "give_selected_reward";
		LogDebug("add_rewards reg.mitem.title reg.mitem.callback");
	}

	void give_selected_reward()
	{
		LogDebug("give_selected_reward GetEntityName(param1) PARAM2");
		N_REWARDS_GIVEN += 1;
		// TODO: offer PARAM1 GetToken(REWARD_LIST, param2, ";")
		CallExternal(param1, "ext_set_reward", 1);
	}

	void player_accept()
	{
		cycle_up("manual_override");
		CONVO_TYPE = "none";
		QUEST_WINNER = param1;
		PlayAnim("critical", "yes");
		SayText("Your assistance is greatly appreciated! Now stand-fast and be ready... I m sure they ve caught our scent by now.");
		EmitSound(GetOwner(), 0, "voices/jerdid/Jerdid_5.wav", 10);
		IN_BATTLE = 1;
		UseTrigger("wolves_go");
		SetInvincible(false);
		SetRoam(true);
	}

	void player_deny()
	{
		NO_HAIL = 0;
		CONVO_TYPE = "none";
		PlayAnim("critical", "eye_wipe");
		SayText("I... Undestand... A powerful warrior like yourself must be busy... Quite often , I suppose...");
		EmitSound(GetOwner(), 0, "voices/jerdid/Jerdid_4.wav", 10);
		SetRoam(true);
	}

	void wolf_raid_over()
	{
		MAX_REWARDS_TOGIVE = "game.playersnb";
		BATTLE_OVER = 1;
		NO_HAIL = 0;
		npcatk_clear_targets();
		BATTLLE_OVER = 1;
		IN_BATTLE = 0;
		FORCED_MOVE_DEST = 1;
		SetMoveDest(QUEST_WINNER);
		SetInvincible(true);
		ScheduleDelayedEvent(1.0, "hunt_quest_winner_loop");
	}

	void hunt_quest_winner_loop()
	{
		if ((GetEntityProperty(QUEST_WINNER, "scriptvar"))) return;
		ScheduleDelayedEvent(1.0, "hunt_quest_winner_loop");
		NPC_FORCED_MOVEDEST = 1;
		if ((CanSee(QUEST_WINNER, 128)))
		{
			if (!(SAID_REWARD))
			{
			}
			SAID_REWARD = 1;
			ScheduleDelayedEvent(0.1, "give_reward");
		}
		else
		{
			SetMoveDest(QUEST_WINNER);
		}
	}

	void give_reward()
	{
		if (N_REWARDS_GIVEN >= MAX_REWARDS_TOGIVE)
		{
			SayText("Sorry , I ve nothing left to offer.");
			EmitSound(GetOwner(), 0, "voices/jerdid/Jerdid_7.wav", 10);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		NPC_FORCED_MOVEDEST = 1;
		PlayAnim("critical", "yes");
		if ((IsEntityAlive(param1)))
		{
			SetMoveDest(param1);
		}
		ScheduleDelayedEvent(2.0, "fix_anims");
		if ((GetEntityProperty(param1, "scriptvar"))) return;
		SayText("Thank you ever-so-much for your assistance! Please select a reward for your aid.");
		EmitSound(GetOwner(), 0, "voices/jerdid/Jerdid_6.wav", 10);
		CONVO_TYPE = "give_list";
		NO_HAIL = 1;
		if ((IsEntityAlive(param1)))
		{
			MENU_TARGET = param1;
		}
		if (!(IsEntityAlive(param1)))
		{
			MENU_TARGET = QUEST_WINNER;
		}
		ScheduleDelayedEvent(0.1, "send_menu");
	}

	void send_menu()
	{
		OpenMenu(MENU_TARGET);
	}

	void fix_anims()
	{
		SetMoveAnim("walk");
		SetIdleAnim("idle1");
		PlayAnim("once", "idle1");
	}

	void game_menu_cancel()
	{
		NO_HAIL = 0;
		CONVO_TYPE = "none";
	}

	void attack_1()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE);
	}

	void npc_suicide()
	{
		LogDebug("No suicide for me");
	}

}

}
