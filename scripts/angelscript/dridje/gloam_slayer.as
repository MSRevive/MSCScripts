#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_chat.as"

namespace MS
{

class GloamSlayer : CGameScript
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
	string BUSY_CHATTING;
	string CHAT_STEP;
	string CHAT_STEP1;
	string CHAT_STEP2;
	string CHAT_STEP3;
	string CHAT_STEP4;
	string CHAT_STEP5;
	string CHAT_STEP6;
	string CHAT_STEP7;
	string CHAT_STEP8;
	string CHAT_STEPS;
	string CONVO_TYPE;
	string CURRENT_SPEAKER;
	string DID_INTRO;
	string DONE_WARNING;
	string ESCORT_TARGET;
	int FORCED_MOVE_DEST;
	int IN_BATTLE;
	string LAST_DAMAGED;
	int MAX_REWARDS_TOGIVE;
	string MENU_TARGET;
	int MISSION_ACCEPTED;
	int MOVE_RANGE;
	string NEXT_FF_WARNING;
	int NO_HAIL;
	int NO_STUCK_CHECKS;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	string NPC_STUCK_CHECKS;
	int N_REWARDS_GIVEN;
	string OFFERING_REWARD;
	string QUEST_WINNER;
	int SCHAT_STEP;
	string SCHAT_STEP1;
	string SCHAT_STEP2;
	string SCHAT_STEP3;
	int SCHAT_STEPS;

	GloamSlayer()
	{
		const float FREQ_GLOAM = 120.0;
		const string CONV_ANIMS = "converse2;talkleft;talkright;lean;pondering2;pondering3;yes;c1a0_catwalkidle;quicklook";
		const string MAGIC_LIST = "fire;ice;lightning;earth;poison;acid;magic;";
		const float FREQ_FF_WARN = 10.0;
		const float CHAT_DELAY = 5.5;
		const string REWARD_LIST = "scroll2_lightning_storm;blunt_granitemace;blunt_darkmaul;blunt_gauntlets_serpant;mana_leadfoot;armor_helm_golden;item_charm_w3;";
		const string REWARD_NAMES = "a Lightning Storm Scroll;a Granite Mace;a Dark Maul;Serpant Gauntlets;a Potion of Stability;a Golden Helm;a Shadow Wolf Charm;";
		N_REWARDS_GIVEN = 0;
		MAX_REWARDS_TOGIVE = 0;
		const string SOUND_STRUCK = "body/flesh1.wav";
		const string SOUND_DEATH = "voices/human/male_die.wav";
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_DEATH = "diebackward";
		ANIM_ATTACK = "swordswing1_l";
		MOVE_RANGE = 32;
		ATTACK_RANGE = 96;
		ATTACK_HITRANGE = 120;
		const float ATTACK_HITCHANCE = 0.85;
		const string ATTACK_DAMAGE = "$randf(50,200)";
		NPC_GIVE_EXP = 0;
		const int NO_JOB = 1;
		const int NO_RUMOR = 1;
		NO_HAIL = 1;
		const string ANIM_SPELL_SELF = "return_needle";
		const string ANIM_SPELL_OTHER = "give_shot";
		const float FREQ_ICE_SHIELD = 60.0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(30.1);
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 255, 255), 96, 30.0);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(20.0);
		if ((IN_BATTLE))
		{
		}
		string TIME_DIFF = GetGameTime();
		TIME_DIFF -= LAST_DAMAGED;
		if (TIME_DIFF > FREQ_GLOAM)
		{
			LogDebug("******* SPAWNING GLOAM *******");
			string SUMMON_POS = GetEntityOrigin(GetOwner());
			SUMMON_POS += "z";
			SpawnNPC("monsters/gloam1", SUMMON_POS, ScriptMode::Legacy);
			LAST_DAMAGED = GetGameTime();
		}
	}

	void game_precache()
	{
		Precache("monsters/gloam1");
	}

	void OnSpawn() override
	{
		SetName("agrath");
		SetName("Agrath the Gloam Hunter");
		SetInvincible(true);
		SetRoam(false);
		SetBloodType("red");
		NO_STUCK_CHECKS = 1;
		SetRace("human");
		SetWidth(32);
		SetHeight(96);
		SetHealth(1000);
		SetSayTextRange(1024);
		SetHearingSensitivity(8);
		SetModel("npc/royal_guard2.mdl");
		SetIdleAnim("idle1");
		SetMoveAnim("walk");
		ScheduleDelayedEvent(1.0, "set_critical");
		SetAnimMoveSpeed(2.0);
		SetMoveSpeed(2.0);
		ScheduleDelayedEvent(2.0, "light_up");
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_gloam", "gloam");
		CatchSpeech("say_yes", "yes");
	}

	void set_critical()
	{
		if ((NPC_CRITICAL)) return;
		critical_npc();
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
		if (!(IsValidPlayer(param1)))
		{
			LAST_DAMAGED = GetGameTime();
		}
		if (!(IsValidPlayer(param1))) return;
		if (!(GetGameTime() > NEXT_FF_WARNING)) return;
		NEXT_FF_WARNING = GetGameTime();
		NEXT_FF_WARNING += FREQ_FF_WARN;
		if ((param3).findFirst("effect") >= 0)
		{
			int IS_SPELL = 1;
		}
		if (FindToken(MAGIC_LIST, param3, ";") > -1)
		{
			int IS_SPELL = 1;
		}
		if ((IS_SPELL))
		{
			if (GetEntityRange(param1) > 256)
			{
				SayText("Watch where you cast those things!");
			}
			else
			{
				string NAME_PRE = GetEntityName(param1);
				NAME_PRE += "!";
				SayText("NAME_PRE Check your targets!");
			}
		}
		if (!(IS_SPELL))
		{
			if (GetEntityRange(param1) < 256)
			{
				SayText("Careful where you swing that!");
			}
			else
			{
				SayText("GetEntityName(param1) , watch your targets!");
			}
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
			PlayAnim("critical", "idle4");
			ScheduleDelayedEvent(2.0, "fix_anims");
			CONVO_TYPE = "intro";
			CHAT_STEPS = 4;
			CHAT_STEP = 0;
			CHAT_STEP1 = "Bah! Hail there. I am known as Agrath of the Royal Guard. The King sent me here to clear this isle of gloams that we may begin logging the forest safely.";
			CHAT_STEP2 = "But I never imagined there would be so many such beasts in this jungle, and this sad contigent I brought with me would be mere fodder for them.";
			if (GetPlayerCount() > 1)
			{
				CHAT_STEP3 = "You lads look a bit more up to a battle, more so than this sad lot anyways.";
			}
			if (GetPlayerCount() == 1)
			{
				CHAT_STEP3 = "You may yet make better escort than all this sad lot combined.";
			}
			CHAT_STEP4 = "If you will serve as my escort and ferret these beasts out, you will be well rewarded for your efforts.";
			BUSY_CHATTING = 1;
			chat_loop();
		}
		if ((BATTLE_OVER))
		{
			PlayAnim("critical", "yes");
			ScheduleDelayedEvent(2.0, "fix_anims");
			SayText("Thanks again for your assistance.");
		}
	}

	void open_menu()
	{
		OpenMenu(CURRENT_SPEAKER);
	}

	void chat_loop()
	{
		if (!(CHAT_STEP > 1)) return;
		ScheduleDelayedEvent(1.0, "convo_anim");
		if (CHAT_STEP == 4)
		{
			if (CONVO_TYPE == "intro")
			{
			}
			SetMoveDest(CURRENT_SPEAKER);
			ScheduleDelayedEvent(2.0, "open_menu");
		}
		if (CHAT_STEP == 8)
		{
			if (CONVO_TYPE == "info_talk")
			{
			}
			SetMoveDest(CURRENT_SPEAKER);
			CONVO_TYPE = "intro";
			ScheduleDelayedEvent(2.0, "open_menu");
		}
		if (CHAT_STEP == 3)
		{
			if (CONVO_TYPE == "pep_talk")
			{
			}
			DONE_WARNING = 1;
		}
	}

	void game_menu_getoptions()
	{
		LogDebug("game_menu_getoptions");
		if ((BUSY_CHATTING))
		{
			string reg.mitem.title = "(Busy Chatting)";
			string reg.mitem.type = "disabled";
			string reg.mitem.callback = "none";
		}
		if ((IN_BATTLE))
		{
			string HP_TITLE = "HP (";
			HP_TITLE += int(GetEntityHealth(GetOwner()));
			HP_TITLE += "/";
			HP_TITLE += int(GetEntityMaxHealth(GetOwner()));
			HP_TITLE += ")";
			string reg.mitem.title = HP_TITLE;
			string reg.mitem.type = "disabled";
			string reg.mitem.callback = "none";
		}
		if ((BUSY_CHATTING)) return;
		if (CONVO_TYPE != "intro")
		{
			if (!(IN_BATTLE))
			{
			}
			if (CONVO_TYPE != "give_list")
			{
			}
			string reg.mitem.title = "Hail";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_hi";
		}
		if (CONVO_TYPE == "intro")
		{
			string reg.mitem.title = "Yes, I'll help.";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "dude_said_yes";
			string reg.mitem.title = "What are Gloams?";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_gloam";
			string reg.mitem.title = "Sorry, busy.";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "player_deny";
		}
		if ((BATTLE_OVER))
		{
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
			OFFERING_REWARD = param1;
			for (int i = 0; i < GetTokenCount(REWARD_LIST, ";"); i++)
			{
				add_rewards();
			}
			CONVO_TYPE = "none";
		}
	}

	void add_rewards()
	{
		if (!(RandomInt(1, 100) <= 75)) return;
		N_REWARDS += 1;
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

	void game_menu_cancel()
	{
		LogDebug("game_menu_cancel CONVO_TYPE GetEntityName(param1)");
		if (!(OFFERING_REWARD == param1)) return;
		SayText("I see. A noble warrior for whom the battle is reward enough. Good show.");
		CallExternal(OFFERING_REWARD, "ext_set_reward", 1);
		CONVO_TYPE = "none";
	}

	void give_selected_reward()
	{
		LogDebug("give_selected_reward GetEntityName(param1) PARAM2");
		N_REWARDS_GIVEN += 1;
		// TODO: offer PARAM1 GetToken(REWARD_LIST, param2, ";")
		CallExternal(param1, "ext_set_reward", 1);
	}

	void say_yes()
	{
		if (!(CONVO_TYPE == "intro")) return;
		dude_said_yes(GetEntityIndex("ent_lastspoke"));
	}

	void dude_said_yes()
	{
		if (!(true)) return;
		if ((MISSION_ACCEPTED)) return;
		if ((DONE_WARNING)) return;
		if (!(IsEntityAlive(param1))) return;
		MISSION_ACCEPTED = 1;
		ESCORT_TARGET = param1;
		cycle_up("manual_override");
		CONVO_TYPE = "none";
		QUEST_WINNER = param1;
		PlayAnim("critical", "yes");
		IN_BATTLE = 1;
		NO_STUCK_CHECKS = 1;
		DONE_WARNING = 0;
		CONVO_TYPE = "pep_talk";
		SCHAT_STEPS = 3;
		SCHAT_STEP = 0;
		SCHAT_STEP1 = "Alright, the forest beyond that barricade is completely infested with [Gloams]. Nasty work, Gloams are...";
		SCHAT_STEP2 = "If we can slay all the elder, Ether Gloams, the rest shouldnt give us any trouble, and most likely will flee.";
		SCHAT_STEP3 = "Be ready for a good fight. Ill follow you in, but these novices will have to stay behind. No point in leading them to a slaughter.";
		BUSY_CHATTING = 1;
		ScheduleDelayedEvent(1.0, "special_chat_loop");
		SetInvincible(false);
		UseTrigger("ether_gloams_go");
		FREQ_ICE_SHIELD("do_ice_shield");
	}

	void special_chat_loop()
	{
		SCHAT_STEP += 1;
		if (SCHAT_STEP == SCHAT_STEPS)
		{
			BUSY_CHATTING = 0;
		}
		if (SCHAT_STEP > SCHAT_STEPS)
		{
			BUSY_CHATTING = 0;
			SCHAT_STEP = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(SCHAT_STEP <= SCHAT_STEPS)) return;
		CHAT_DELAY("special_chat_loop");
		if (SCHAT_STEP == 1)
		{
			SayText("SCHAT_STEP1");
		}
		if (SCHAT_STEP == 2)
		{
			SayText("SCHAT_STEP2");
		}
		if (SCHAT_STEP == 3)
		{
			SayText("SCHAT_STEP3");
			DONE_WARNING = 1;
		}
	}

	void player_deny()
	{
		CONVO_TYPE = "none";
		PlayAnim("critical", "no");
		CONVO_TYPE = "angry";
		CHAT_STEPS = 2;
		CHAT_STEP = 0;
		CHAT_STEP1 = "Bah, coward! I suppose I could order you in the name of the king...";
		CHAT_STEP2 = "but I'd rather beat these swine into shape than have an escort who'll run at the first sign of danger!";
		BUSY_CHATTING = 1;
		chat_loop();
	}

	void say_gloam()
	{
		if (!(IN_BATTLE))
		{
			ScheduleDelayedEvent(2.0, "fix_anims");
			CONVO_TYPE = "info_talk";
			CHAT_STEPS = 8;
			CHAT_STEP = 0;
			CHAT_STEP1 = "I've seen all sorts of gloams: gloams of stone, of ice, and of fire. Tis why they've sent me, I suppose.";
			CHAT_STEP2 = "These gloams here are the more common, tropical variety. Slimy beasts tend to show up in abandoned wetlands such as this jungle.";
			CHAT_STEP3 = "They move fast, are tough, and in addition to the usual motivation of hunger, are likely also defending their nests.";
			CHAT_STEP4 = "The ether gloams are the elder ones. It seems a good gloam never dies, it just fades away. Sadly, this means the creatures can turn invisible.";
			CHAT_STEP5 = "While they are invisible they are neigh impossible to hit, and if they touches you while in their ethereal state, it'll give you a nasty wallup.";
			CHAT_STEP6 = "The ether gloams are vulnerable to holy weapons due to their unnatural state, so if you have any, have them at the ready...";
			CHAT_STEP7 = "But beware that the same does not apply to the younger ones. For, as the wizards tell me, they are beastly, but still of this world.";
			CHAT_STEP8 = "Beyond that all I can say is keep a sharp eye and a steady hand, and ye may yet survive with all your limbs uneaten.";
			BUSY_CHATTING = 1;
			chat_loop();
		}
		else
		{
			SayText("Oh NOW you want to hear about the gloams!? A bit busy at the moment! You ll learn anything I could have taught you the hard way soon enough!");
		}
	}

	void gloam_raid_over()
	{
		NO_STUCK_CHECKS = 0;
		MAX_REWARDS_TOGIVE = GetPlayerCount();
		BATTLE_OVER = 1;
		npcatk_walk();
		npcatk_clear_targets();
		BATTLLE_OVER = 1;
		IN_BATTLE = 0;
		FORCED_MOVE_DEST = 1;
		SetMoveDest(QUEST_WINNER);
		SetInvincible(true);
		ScheduleDelayedEvent(1.0, "hunt_quest_winner_loop");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(DONE_WARNING)) return;
		if (!(m_hAttackTarget == "unset")) return;
		if (!(IsEntityAlive(ESCORT_TARGET))) return;
		string ESCORT_DIST = GetEntityRange(ESCORT_TARGET);
		if (ESCORT_DIST > 128)
		{
			NPC_STUCK_CHECKS = 0;
			npcatk_setmovedest(ESCORT_TARGET, 128);
			if (ESCORT_DIST > 384)
			{
				SetMoveAnim(ANIM_RUN);
			}
			else
			{
				SetMoveAnim(ANIM_WALK);
			}
		}
		else
		{
			NPC_STUCK_CHECKS = 0;
			SetMoveDest("none");
			string ESCORT_FACE = GetEntityProperty(ESCORT_TARGET, "angles.yaw");
			SetAngles("face");
		}
	}

	void give_reward()
	{
		if (N_REWARDS_GIVEN >= MAX_REWARDS_TOGIVE)
		{
			SayText("Sorry , I ve nothing left to offer.");
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
		SayText("Thank you for your fine aid in battle! Please select a reward , courtesy of the king...");
		CONVO_TYPE = "give_list";
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

	void attack_1()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE);
	}

	void do_ice_shield()
	{
		if (!(IN_BATTLE)) return;
		FREQ_ICE_SHIELD("do_ice_shield");
		if ((false))
		{
			if ((IsValidPlayer(m_hLastSeen)))
			{
			}
			int CANT_SHIELD_TARGET = 0;
			if ((GetEntityProperty(m_hLastSeen, "haseffect")))
			{
				int CANT_SHIELD_TARGET = 1;
			}
			if ((GetEntityProperty(m_hLastSeen, "scriptvar")))
			{
				int CANT_SHIELD_TARGET = 1;
			}
			if (!(CANT_SHIELD_TARGET))
			{
				SetMoveDest(m_hLastSeen);
				PlayAnim("critical", ANIM_SPELL_OTHER);
				ApplyEffect(m_hLastSeen, "effects/iceshield", 45, GetEntityIndex(GetOwner()), 0.5);
				SendColoredMessage(m_hLastSeen, "Agrath casts Ice Shield upon you.");
			}
			else
			{
				PlayAnim("critical", ANIM_SPELL_SELF);
				ApplyEffect(GetOwner(), "effects/iceshield", 45, GetEntityIndex(GetOwner()), 0.5);
			}
		}
		else
		{
			PlayAnim("critical", ANIM_SPELL_SELF);
			ApplyEffect(GetOwner(), "effects/iceshield", 45, GetEntityIndex(GetOwner()), 0.5);
		}
		EmitSound(GetOwner(), 0, "magic/cast.wav", 10);
	}

	void cycle_npc()
	{
		cycle_up("forced");
	}

	void my_target_died()
	{
		npcatk_walk();
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(NPC_CRITICAL))
		{
			SendInfoMsg("all", "CRITICAL NPC DIED Agrath the Gloam Hunter has died.");
		}
	}

	void ext_freeze()
	{
		SetMoveSpeed(0.0);
	}

	void npc_suicide()
	{
	}

}

}
