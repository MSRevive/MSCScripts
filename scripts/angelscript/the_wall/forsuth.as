#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_chat.as"
#include "monsters/base_battle_ally.as"
#include "NPCs/dwarf_lantern_base.as"

namespace MS
{

class Forsuth : CGameScript
{
	string ALLY_FOLLOW_ON;
	string ALLY_FOLLOW_PLR_ID;
	string ALLY_NEXT_FAS_CHECK;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_STEP1;
	string ANIM_STEP9;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	float BASE_MOVESPEED;
	int BUSY_CHATTING;
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
	string CHAT_OVERRIDE_TIME;
	string CHAT_SOUND1;
	string CHAT_SOUND2;
	string CHAT_SOUND3;
	string CHAT_SOUND4;
	string CHAT_SOUND5;
	string CHAT_SOUND6;
	string CHAT_SOUND7;
	string CHAT_SOUND9;
	int CHAT_STEP;
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
	string COMPANION_LR;
	float CYCLCE_TIME;
	int DID_END_EVENT;
	string DID_FF_WARN;
	string DID_INTRO;
	int DID_MOUNTAIN_COMMENT;
	int DID_STAIRS_COMMENT;
	int DID_UNDEAD_COMMENT;
	int DID_WRAITH_COMMENT;
	int FACE_PLAYERS;
	int FOLLOW_RANGE_MAX;
	int FOLLOW_RANGE_MIN;
	int FORSUTH_CRITICAL;
	int GAVE_FIRST_POT;
	string GAVE_POT_LIST;
	int GAVE_REWARD;
	string MAX_CHAT_TIME;
	string NEXT_ALERT;
	string NEXT_CRITICAL;
	string NEXT_HEALER;
	string NEXT_REGEN;
	string NEXT_TELEPORT;
	string NEXT_VICTORY;
	string NO_STUCK_CHECKS;
	int NPC_GIVE_EXP;
	int NPC_NO_PLAYER_DMG;
	string PLAT_SUSPEND_MODE;
	string PLAYER_CHAT;
	string PLAYER_FOLLOW;
	string QUEST_WINNER;
	int REACHED_TOP;
	string REWARD_LIST;
	string TELEPORT_CHEAT;

	Forsuth()
	{
		ANIM_IDLE = "idle";
		ANIM_DEATH = "death";
		ANIM_ATTACK = "attack";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		const float STAIR_TOP_Z = -1519.97;
		ATTACK_RANGE = 50;
		ATTACK_MOVERANGE = 32;
		ATTACK_HITRANGE = 100;
		NPC_GIVE_EXP = 0;
		const int NPC_BATTLE_ALLY = 1;
		NPC_NO_PLAYER_DMG = 1;
		const int NO_RUMOR = 1;
		const int NO_HAIL = 1;
		const int NO_JOB = 1;
		const int DMG_SWING = 200;
		const int ATTACK_HITCHANCE = 90;
		REWARD_LIST = "bows_telf1;bows_telf2;bows_telf3;bows_telf4;axes_b;smallarms_rd;blunt_gauntlets_bear;polearms_h";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_SWING = "weapons/swingsmall.wav";
		const string SOUND_BATTLE_CRY1 = "none";
		const string SOUND_BATTLE_CRY2 = "none";
		const string SOUND_BATTLE_CRY3 = "none";
		const string SOUND_BATTLE_CRY4 = "none";
		const string SOUND_BATTLE_CRY5 = "none";
		const string SOUND_VICTORY1 = "none";
		const string SOUND_VICTORY2 = "none";
		const string SOUND_PAIN1 = "none";
		const string SOUND_PAIN2 = "none";
		const string SOUND_PAIN3 = "none";
		const string SOUND_COME_HERE = "none";
		const string SOUND_HEALER1 = "none";
		const string SOUND_HEALER2 = "none";
		const string SOUND_HI = "none";
		const string SOUND_HI_ALT = "none";
		const string SOUND_BYE = "none";
		const string SOUND_DEATH = "none";
		const string SOUND_YES = "none";
		const string SOUND_NO = "none";
		const string SOUND_LAUGH = "none";
		const string SOUND_ATTACK1 = "none";
		const string SOUND_ATTACK2 = "none";
		const string SOUND_ATTACK3 = "none";
		const float FREQ_ALERT = 120.0;
		const float FREQ_VICTORY = 120.0;
		const float FREQ_HEALER = 30.0;
		const float FREQ_CRITICAL = 60.0;
		const int MY_HP = 5000;
		const int HALF_HP = 2500;
		const float CHAT_DELAY = 4.0;
		const string SOUND_ALLY_JUMP = "none";
		FOLLOW_RANGE_MIN = 64;
		FOLLOW_RANGE_MAX = 256;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(15.0, 60.0));
		if ((GAVE_FIRST_POT))
		{
		}
		if ((false))
		{
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
				PlayAnim("critical", "nod");
				ApplyEffect(m_hLastSeen, "effects/iceshield", 360, GetEntityIndex(GetOwner()), 0.5);
				SendColoredMessage(m_hLastSeen, "Forsuth casts Ice Shield upon you.");
			}
			else
			{
				PlayAnim("critical", "nod");
				ApplyEffect(GetOwner(), "effects/iceshield", 360, GetEntityIndex(GetOwner()), 0.5);
			}
		}
		else
		{
			PlayAnim("critical", "nod");
			ApplyEffect(GetOwner(), "effects/iceshield", 360, GetEntityIndex(GetOwner()), 0.5);
		}
		EmitSound(GetOwner(), 0, "magic/cast.wav", 10);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(10.0);
		if ((BUSY_CHATTING))
		{
		}
		if (GetGameTime() > CHAT_OVERRIDE_TIME)
		{
		}
		BUSY_CHATTING = 0;
		CHAT_STEP = 0;
		CHAT_STEPS = 0;
	}

	void OnSpawn() override
	{
		SetName("Forsuth the Frosty");
		SetName("forsuth_frost");
		SetModel("dwarf/male1.mdl");
		SetHealth(MY_HP);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("cold", 0.0);
		SetWidth(32);
		SetHeight(72);
		SetHearingSensitivity(8);
		SetRace("human");
		SetRoam(false);
		SetSayTextRange(2048);
		SetNoPush(true);
		SetMoveSpeed(3.0);
		SetAnimMoveSpeed(3.0);
		BASE_MOVESPEED = 4.0;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		CatchSpeech("say_seekers", "seekers");
		CatchSpeech("say_stairs", "card");
		SetModelBody(0, 0);
		SetModelBody(1, 2);
		SetModelBody(2, 1);
		set_lantern();
		if (!(true)) return;
		GAVE_POT_LIST = "";
		ScheduleDelayedEvent(90.0, "set_critical");
		NEXT_VICTORY = GetGameTime();
		NEXT_VICTORY += FREQ_VICTORY;
	}

	void OnPostSpawn() override
	{
		SetStepSize(32);
	}

	void set_critical()
	{
		FORSUTH_CRITICAL = 1;
	}

	void OnDamage(int damage) override
	{
		if (!(DID_WRAITH_COMMENT))
		{
			if ((GetEntityName(param1)).findFirst("Wrait") >= 0)
			{
			}
			do_wraith_comment();
		}
		if (GetEntityHealth(GetOwner()) < HALF_HP)
		{
			if (!(IsValidPlayer(param1)))
			{
			}
			if (GetGameTime() > NEXT_HEALER)
			{
			}
			NEXT_HEALER = GetGameTime();
			NEXT_HEALER += FREQ_HEALER;
			int REQUESTED_HEALER = 1;
			// PlayRandomSound from: SOUND_HEALER1, SOUND_HEALER2
			array<string> sounds = {SOUND_HEALER1, SOUND_HEALER2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if ((IsValidPlayer(param1)))
		{
			if (!(DID_FF_WARN))
			{
			}
			DID_FF_WARN = 1;
			SayText("Woah there! Friendly dwarf comin' through!");
			EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/woah_there_friendly.wav", 10);
		}
		else
		{
			string MAX_HP = GetEntityMaxHealth(GetOwner());
			string RND_PAIN = RandomInt(1, MAX_HP);
			if (RND_PAIN > MAX_HP)
			{
				if (!(REQUESTED_HEALER))
				{
				}
				// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
				array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			else
			{
				if (!(REQUESTED_HEALER))
				{
				}
				if (RandomInt(1, 5) != 1)
				{
					// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
					array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
					EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
				}
				else
				{
					// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3
					array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3};
					EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
				}
			}
			NEXT_REGEN = GetGameTime();
			NEXT_REGEN += 10.0;
			if ((FORSUTH_CRITICAL))
			{
			}
			if (GetGameTime() > NEXT_CRITICAL)
			{
			}
			NEXT_CRITICAL = GetGameTime();
			NEXT_CRITICAL += FREQ_CRITICAL;
			SendInfoMsg("all", "CRITICAL NPC UNDER ATTACK Forsuth the Frosty is under attack!");
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		CYCLCE_TIME = 0.1;
		if (!(IsEntityAlive(PLAYER_FOLLOW)))
		{
			if ((IsEntityAlive(ALLY_FOLLOW_PLR_ID)))
			{
			}
			PLAYER_FOLLOW = ALLY_FOLLOW_PLR_ID;
		}
		if (!(IsEntityAlive(ALLY_FOLLOW_PLR_ID)))
		{
			if ((IsEntityAlive(PLAYER_FOLLOW)))
			{
			}
			ALLY_FOLLOW_PLR_ID = PLAYER_FOLLOW;
		}
		if ((TELEPORT_CHEAT))
		{
			string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
			if (MY_Z < STAIR_TOP_Z)
			{
			}
			if (GetGameTime() > NEXT_TELEPORT)
			{
			}
			if (!(BUSY_CHATTING))
			{
			}
			if ((DID_INTRO))
			{
			}
			if (!(DID_END_EVENT))
			{
			}
			if (m_hAttackTarget == "unset")
			{
			}
			if ((IsEntityAlive(PLAYER_FOLLOW)))
			{
			}
			string L_PLR_ORG = GetEntityOrigin(PLAYER_FOLLOW);
			string L_MY_ORG = GetEntityOrigin(GetOwner());
			if (Distance(L_MY_ORG, L_PLR_ORG) > 300)
			{
			}
			basecompanion_catchup();
		}
		if (!(DID_INTRO))
		{
			if (m_hAttackTarget == "unset")
			{
			}
			string NEAR_PLAYER = FindEntitiesInSphere("player", 256);
			SetRoam(false);
			NO_STUCK_CHECKS = 1;
			if (NEAR_PLAYER != "none")
			{
			}
			string NEAR_PLAYER = /* TODO: $sort_entlist */ $sort_entlist(NEAR_PLAYER, "range");
			PLAYER_CHAT = GetToken(NEAR_PLAYER, 0, ";");
			SetMoveDest(PLAYER_CHAT);
			DID_INTRO = 1;
			TELEPORT_CHEAT = 1;
			do_intro();
			ALLY_FOLLOW_ON = 1;
		}
		if ((SUSPEND_AI)) return;
	}

	void do_intro()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "do_intro");
		}
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Hail thar! I heard you were spotted goin into The Wall, so I took the shortcut from my house and wandered on down here.";
		CHAT_SOUND1 = "voices/the_wall/forsuth/hail_there_i_heard_you.wav";
		CHAT_DELAY_STEP1 = 5.9;
		CHAT_STEP2 = "Wanted to make sure ya'll were alright. Dangerous in here, but I guess you already figured that out, from the look of ye.";
		CHAT_SOUND2 = "voices/the_wall/forsuth/wanted_to_make_sure.wav";
		CHAT_DELAY_STEP2 = 6.5;
		CHAT_STEP3 = "Take this, it'll keep ya warm. Though, judging by the frost on yer armor, I think it might have done ya more good earlier.";
		CHAT_SOUND3 = "voices/the_wall/forsuth/take_this_itll_keep_you.wav";
		CHAT_DELAY_STEP3 = 5.8;
		CHAT_STEPS = 3;
		CHAT_EVENT_STEP2 = "give_pot";
		string L_TOTAL_CHAT_TIME = CHAT_STEPS;
		L_TOTAL_CHAT_TIME += 1;
		L_TOTAL_CHAT_TIME *= CHAT_DELAY;
		MAX_CHAT_TIME = L_TOTAL_CHAT_TIME;
		chat_loop();
	}

	void give_pot()
	{
		GAVE_FIRST_POT = 1;
		// TODO: offer PLAYER_CHAT drink_forsuth
		GAVE_POT_LIST += PLAYER_CHAT;
		CHAT_DELAY_STEP3("do_intro2");
	}

	void do_intro2()
	{
		SayText("Now, let's be gettin' out of here before anything too troublesome comes our way.");
		EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/now_lets_be_getting.wav", 10);
		PlayAnim("critical", "nod");
		SetRoam(false);
		PLAYER_FOLLOW = PLAYER_CHAT;
	}

	void game_menu_getoptions()
	{
		if ((PLAT_SUSPEND_MODE))
		{
			npcatk_resume_ai();
			npcatk_resume_movement();
			SayText("Oh , sorry. Dozed off for a sec there.");
			PLAT_SUSPEND_MODE = 0;
		}
		if (m_hAttackTarget != "unset")
		{
			string reg.mitem.title = "(In combat...)";
			string reg.mitem.type = "disabled";
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((BUSY_CHATTING))
		{
			string reg.mitem.title = "(Talking...)";
			string reg.mitem.type = "disabled";
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		EmitSound(GetOwner(), 0, SOUND_YES, 10);
		PLAYER_FOLLOW = param1;
		SetMoveDest(param1);
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_hi";
		string reg.mitem.title = "Ask for Ale";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_ale";
		string reg.mitem.title = "About Seekers";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_seekers";
		if (param1 == QUEST_WINNER)
		{
			if (!(GAVE_REWARD))
			{
			}
			string SAYTEXT_STR = "Thar ye be, ";
			SAYTEXT_STR += GetEntityName(QUEST_WINNER);
			bchat_mouth_move();
			ScheduleDelayedEvent(3.0, "bchat_close_mouth");
			SayText("SAYTEXT_STR");
			EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/there_ye_be_i_have.wav", 10);
			string reg.mitem.title = "Get Reward";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "give_reward";
		}
	}

	void give_reward()
	{
		GAVE_REWARD = 1;
		string N_REWARDS_M1 = GetTokenCount(REWARD_LIST, ";");
		N_REWARDS_M1 -= 1;
		string REWARD_IDX = RandomInt(0, N_REWARDS_M1);
		string REWARD_ITEM = GetToken(REWARD_LIST, REWARD_IDX, ";");
		// TODO: offer PARAM1 REWARD_ITEM
		if (REWARD_ITEM != "smallarms_rd")
		{
			SayText("Thar ya go! Somethin' for a fine warrior. Use it wisely.");
			EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/there_you_go_something.wav", 10);
		}
		else
		{
			CHAT_STEP1 = "This here may not look like much, but I've a feeling it be special.";
			CHAT_SOUND1 = "voices/the_wall/forsuth/now_this_here_might.wav";
			CHAT_DELAY_STEP1 = 4.5;
			CHAT_STEP2 = "You'll be needin a more experienced smith than I to figure it out though.";
			CHAT_SOUND2 = "voices/the_wall/forsuth/youll_be_needing.wav";
			CHAT_DELAY_STEP2 = 4.2;
			CHAT_STEPS = 2;
			string L_TOTAL_CHAT_TIME = CHAT_STEPS;
			L_TOTAL_CHAT_TIME += 1;
			L_TOTAL_CHAT_TIME *= CHAT_DELAY;
			MAX_CHAT_TIME = L_TOTAL_CHAT_TIME;
			chat_loop();
		}
		bchat_mouth_move();
		ScheduleDelayedEvent(3.0, "bchat_close_mouth");
	}

	void say_hi()
	{
		if ((BUSY_CHATTING)) return;
		EmitSound(GetOwner(), 0, SOUND_HI_ALT, 10);
		CHAT_STEP1 = "Ya remember me, surely! Good ol' Forsuth the frosty, who lives up on the Frozen Summit!";
		ANIM_STEP1 = "nod";
		CHAT_SOUND1 = "voices/the_wall/forsuth/you_remember_me_surely.wav";
		CHAT_DELAY_STEP1 = 4.7;
		CHAT_STEP2 = "Word got to me that you got hired by some [Seekers] at the entrance to The Wall.";
		CHAT_SOUND2 = "voices/the_wall/forsuth/word_got_to_me_that.wav";
		CHAT_DELAY_STEP2 = 4.3;
		CHAT_STEP3 = "Got me worried. So I came runnin just as fast as my stubby dwarf legs would carry me.";
		CHAT_SOUND3 = "voices/the_wall/forsuth/got_me_worried_so.wav";
		CHAT_DELAY_STEP3 = 5.1;
		CHAT_STEP4 = "Not that it looks as though you really need the help, mind ye.";
		CHAT_SOUND4 = "voices/the_wall/forsuth/not_as_if_you_need_the.wav";
		CHAT_DELAY_STEP4 = 3.3;
		CHAT_STEP5 = "But it never hurts to have an extra pair of hands on your side. Especially if those hands can wield some dwarven steel!";
		CHAT_SOUND5 = "voices/the_wall/forsuth/but_it_never_hurts_to.wav";
		CHAT_DELAY_STEP5 = 6.2;
		CHAT_STEPS = 5;
		string L_TOTAL_CHAT_TIME = CHAT_STEPS;
		L_TOTAL_CHAT_TIME += 1;
		L_TOTAL_CHAT_TIME *= CHAT_DELAY;
		MAX_CHAT_TIME = L_TOTAL_CHAT_TIME;
		chat_loop();
	}

	void say_ale()
	{
		if ((GAVE_POT_LIST).findFirst(param1) >= 0)
		{
			if (GetPlayerCount() > 1)
			{
				SayText("Sorry, I only brought enough for one for each of ye.");
				EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/sorry_only_brought.wav", 10);
			}
			else
			{
				SayText("I brought more, actually, but me throte got parched along the way here and...");
				EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/i_brought_more_but_my.wav", 10);
			}
		}
		else
		{
			// TODO: offer PARAM1 drink_forsuth
			if (GAVE_POT_LIST.length() > 0) GAVE_POT_LIST += ";";
			GAVE_POT_LIST += param1;
			SayText("Thar ya go, that'll keep you warm through narely anything.");
			EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/there_ya_go_thatll_keep.wav", 10);
			PlayAnim("critical", "nod");
		}
	}

	void say_seekers()
	{
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Those elves who hired you outside. Seekers they are. Bad news they can be.";
		CHAT_SOUND1 = "voices/the_wall/forsuth/those_elves_that_hired.wav";
		CHAT_DELAY_STEP1 = 4.5;
		CHAT_STEP2 = "They ain't evil, per-say, but they are rather... Methodical.";
		CHAT_SOUND2 = "voices/the_wall/forsuth/they_aint_evil_per_se.wav";
		CHAT_DELAY_STEP2 = 4.2;
		CHAT_STEP3 = "They believe in executing the letter of the law, but compassion and mercy ne'er enter into it.";
		CHAT_SOUND3 = "voices/the_wall/forsuth/they_believe_in_executing.wav";
		CHAT_DELAY_STEP3 = 6.0;
		CHAT_STEP4 = "Sometimes that makes them lose sight of the bigger picture, if you get my meaning.";
		CHAT_SOUND4 = "voices/the_wall/forsuth/sometimes_that_makes.wav";
		CHAT_DELAY_STEP4 = 4.5;
		CHAT_STEP5 = "Although I'm a dwarf, born of Urdual, and sworn to Him, first are foremost, I understand Torkalath.";
		CHAT_SOUND5 = "voices/the_wall/forsuth/although_im_a_dwarf.wav";
		CHAT_DELAY_STEP5 = 6.8;
		CHAT_STEP6 = "He values freedom, strength, and independence... And I've always been a bit too independent meself.";
		CHAT_SOUND6 = "voices/the_wall/forsuth/he_values_freedom.wav";
		CHAT_DELAY_STEP6 = 5.9;
		CHAT_STEP7 = "So, I kinda feel sorry for these 'Rammata' those zealots hunt so fanatically. Not that this lot wasn't mad...";
		CHAT_SOUND7 = "voices/the_wall/forsuth/so_i_kind_of_feel_sorry.wav";
		CHAT_DELAY_STEP7 = 7.2;
		CHAT_STEP8 = "But if the Seekers showed some tolerance, they likely would not have become so.";
		CHAT_DELAY_STEP8 = 5.0;
		CHAT_STEP9 = "Anyways, I don't want to go near those Seekers, for fear they might catch onto me disposition, if ya catch me drift.";
		CHAT_SOUND9 = "voices/the_wall/forsuth/anyway_i_dont_want_to.wav";
		CHAT_DELAY_STEP9 = 5.9;
		CHAT_DELAY_STEP9 = "";
		ANIM_STEP9 = "nod";
		CHAT_STEPS = 9;
		string L_TOTAL_CHAT_TIME = CHAT_STEPS;
		L_TOTAL_CHAT_TIME += 1;
		L_TOTAL_CHAT_TIME *= CHAT_DELAY;
		MAX_CHAT_TIME = L_TOTAL_CHAT_TIME;
		chat_loop();
	}

	void attack_1()
	{
		EmitSound(GetOwner(), 0, SOUND_SWING, 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWING, ATTACK_HITCHANCE, "slash");
		if (!(RandomInt(1, 5) == 1)) return;
		ANIM_ATTACK = "attack2";
	}

	void attack_2()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		string L_DMG = DMG_SWING;
		L_DMG *= 2;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, L_DMG, ATTACK_HITCHANCE, "slash");
		ANIM_ATTACK = "attack";
		ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 10.0, GetEntityIndex(GetOwner()));
	}

	void npcatk_clear_targets()
	{
		if (!(GetGameTime() > NEXT_VICTORY)) return;
		NEXT_VICTORY = GetGameTime();
		NEXT_VICTORY += FREQ_VICTORY;
		// PlayRandomSound from: SOUND_VICTORY1, SOUND_VICTORY2
		array<string> sounds = {SOUND_VICTORY1, SOUND_VICTORY2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npc_targetsighted()
	{
		if (!(GetGameTime() > NEXT_ALERT)) return;
		NEXT_ALERT = GetGameTime();
		NEXT_ALERT += FREQ_ALERT;
		// PlayRandomSound from: SOUND_BATTLE_CRY1, SOUND_BATTLE_CRY2, SOUND_BATTLE_CRY3, SOUND_BATTLE_CRY4, SOUND_BATTLE_CRY5
		array<string> sounds = {SOUND_BATTLE_CRY1, SOUND_BATTLE_CRY2, SOUND_BATTLE_CRY3, SOUND_BATTLE_CRY4, SOUND_BATTLE_CRY5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void ext_forsuth_mountain()
	{
		if ((DID_MOUNTAIN_COMMENT)) return;
		DID_MOUNTAIN_COMMENT = 1;
		ScheduleDelayedEvent(5.0, "ext_forsuth_mountain2");
		string FACE_TO = GetEntityOrigin(GetOwner());
		FACE_TO += /* TODO: $relpos */ $relpos(Vector3(0, 90, 0), Vector3(0, 1000, 0));
		SetMoveDest(FACE_TO);
		npcatk_suspend_ai(8.0);
		npcatk_suspend_movement(ANIM_IDLE);
		CHAT_STEP1 = "Them be the mountains surrounding The Bleak. Pretty they are... though deadly";
		ANIM_STEP1 = "nod";
		CHAT_SOUND1 = "voices/the_wall/forsuth/them_be_the_mountains.wav";
		CHAT_DELAY_STEP1 = 4.2;
		CHAT_STEPS = 1;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 15.0;
		ALLY_NEXT_FAS_CHECK = GetGameTime();
		ALLY_NEXT_FAS_CHECK += 15.0;
		string L_TOTAL_CHAT_TIME = CHAT_STEPS;
		L_TOTAL_CHAT_TIME += 1;
		L_TOTAL_CHAT_TIME *= CHAT_DELAY;
		MAX_CHAT_TIME = L_TOTAL_CHAT_TIME;
		chat_loop();
	}

	void ext_forsuth_mountain2()
	{
		npcatk_resume_movement();
		SayText("Oh well, enough gawkin' - let's be movin'.");
		EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/enough_gawking.wav", 10);
	}

	void ext_forsuth_morc()
	{
		CHAT_STEP1 = "Stupid bleedin Marogar orcs come down here, lookin' for lost elven treasure.";
		CHAT_SOUND1 = "voices/the_wall/forsuth/stupid_bleedin_marogar.wav";
		CHAT_DELAY_STEP1 = 4.9;
		CHAT_STEP2 = "Half of them wind up like that poor bloke there - rotting zombies.";
		CHAT_SOUND2 = "voices/the_wall/forsuth/half_of_them_end_up_like.wav";
		CHAT_DELAY_STEP2 = 3.8;
		CHAT_STEPS = 2;
		string L_TOTAL_CHAT_TIME = CHAT_STEPS;
		L_TOTAL_CHAT_TIME += 1;
		L_TOTAL_CHAT_TIME *= CHAT_DELAY;
		MAX_CHAT_TIME = L_TOTAL_CHAT_TIME;
		chat_loop();
	}

	void ext_forsuth_undead()
	{
		if ((DID_UNDEAD_COMMENT)) return;
		DID_UNDEAD_COMMENT = 1;
		CHAT_STEP1 = "Well, will ye be lookin' at that! Orcs and undead, livin' together in harmony!";
		CHAT_SOUND1 = "voices/the_wall/forsuth/orcs_and_undead.wav";
		CHAT_DELAY_STEP1 = 4.8;
		CHAT_STEP2 = "Well... Together, anyways...";
		CHAT_SOUND2 = "voices/the_wall/forsuth/well_together_anyways.wav";
		CHAT_DELAY_STEP2 = 2.4;
		CHAT_STEPS = 2;
		string L_TOTAL_CHAT_TIME = CHAT_STEPS;
		L_TOTAL_CHAT_TIME += 1;
		L_TOTAL_CHAT_TIME *= CHAT_DELAY;
		MAX_CHAT_TIME = L_TOTAL_CHAT_TIME;
		chat_loop();
	}

	void ext_forsuth_stairs()
	{
		if ((DID_STAIRS_COMMENT)) return;
		DID_STAIRS_COMMENT = 1;
		CHAT_STEP1 = "By Urdual's Beard! My poor stubby dwarven legs!";
		CHAT_SOUND1 = "voices/the_wall/forsuth/by_urduals_beard.wav";
		CHAT_DELAY_STEP1 = 5.1;
		CHAT_STEP2 = "Ya'd think... The elves... Such skinny legged folk they be...";
		CHAT_SOUND2 = "voices/the_wall/forsuth/youd_think.wav";
		CHAT_DELAY_STEP2 = 6.2;
		CHAT_STEP3 = "Would be less prone to building endless flights of stairs!";
		CHAT_SOUND3 = "voices/the_wall/forsuth/less_prone_to_building.wav";
		CHAT_DELAY_STEP3 = 6.1;
		CHAT_STEPS = 3;
		string L_TOTAL_CHAT_TIME = CHAT_STEPS;
		L_TOTAL_CHAT_TIME += 1;
		L_TOTAL_CHAT_TIME *= CHAT_DELAY;
		MAX_CHAT_TIME = L_TOTAL_CHAT_TIME;
		chat_loop();
	}

	void say_stairs()
	{
		if (!(DID_STAIRS_COMMENT)) return;
		SayText("We got enough zombies to deal with without draggin' Bill and Francis into this!");
		EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/enough_zombies_to.wav", 10);
		PlayAnim("critical", "nod");
	}

	void ext_forsuth_paint()
	{
		ScheduleDelayedEvent(3.0, "ext_forsuth_paint2");
		string FACE_TO = GetEntityOrigin(GetOwner());
		FACE_TO += /* TODO: $relpos */ $relpos(Vector3(0, 270, 0), Vector3(0, 1000, 0));
		SetMoveDest(FACE_TO);
		npcatk_suspend_ai(3.0);
		npcatk_suspend_movement(ANIM_IDLE);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		ALLY_NEXT_FAS_CHECK = GetGameTime();
		ALLY_NEXT_FAS_CHECK += 5.0;
		SayText("Now who'd go ruinin' a perflectly good paintin' of Felewyn like that?");
		EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/now_whod_go_ruining.wav", 10);
		PlayAnim("critical", "nod");
	}

	void ext_forsuth_paint2()
	{
		npcatk_resume_movement();
	}

	void ext_forsuth_plat()
	{
		ScheduleDelayedEvent(40.0, "forsuth_plat_abort");
		ScheduleDelayedEvent(1.0, "forsuth_plat_loop");
		forsuth_plat_chatter();
		string FACE_TO = GetEntityOrigin(GetOwner());
		FACE_TO += /* TODO: $relpos */ $relpos(Vector3(0, 270, 0), Vector3(0, 1000, 0));
		SetMoveDest(FACE_TO);
		npcatk_suspend_ai();
		npcatk_suspend_movement(ANIM_IDLE);
	}

	void forsuth_plat_loop()
	{
		if ((REACHED_TOP)) return;
		ScheduleDelayedEvent(1.0, "forsuth_plat_loop");
		string ADJ_ORG = GetEntityOrigin(GetOwner());
		ADJ_ORG += "z";
		SetEntityOrigin(GetOwner(), ADJ_ORG);
	}

	void forsuth_plat_chatter()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "ext_forsuth_plat_chatter");
		}
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Alright, here's the pullyworks...";
		CHAT_SOUND1 = "voices/the_wall/forsuth/alright_heres_the_pulleyworks.wav";
		CHAT_DELAY_STEP1 = 2.2;
		CHAT_STEP2 = "Turn that wheel there, and it'll take us up the mountain to the surface.";
		CHAT_SOUND2 = "voices/the_wall/forsuth/turn_that_wheel_there.wav";
		CHAT_DELAY_STEP2 = 3.5;
		CHAT_STEPS = 2;
		string L_TOTAL_CHAT_TIME = CHAT_STEPS;
		L_TOTAL_CHAT_TIME += 1;
		L_TOTAL_CHAT_TIME *= CHAT_DELAY;
		MAX_CHAT_TIME = L_TOTAL_CHAT_TIME;
		chat_loop();
	}

	void reached_top()
	{
		REACHED_TOP = 1;
	}

	void forsuth_plat_abort()
	{
		UseTrigger("spawn_forsuth_extras");
		if ((REACHED_TOP)) return;
		string L_TELEPORT_DEST = FindEntityByName("forsuth_teleport");
		string L_TELEPORT_DEST = GetEntityOrigin(L_TELEPORT_DEST);
		SetEntityOrigin(GetOwner(), L_TELEPORT_DEST);
		SayText("Don t ask me how I did that.");
		EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/dont_ask_me_how.wav", 10);
		REACHED_TOP = 1;
		PLAT_SUSPEND_MODE = 1;
		ScheduleDelayedEvent(120.0, "ext_forsuth_bye");
	}

	void ext_forsuth_reached_top()
	{
		ScheduleDelayedEvent(1.5, "reached_top");
		SayText("Top floor: seekers, undead elves, and lovely mountain vistas.");
		EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/top_floor_seekers.wav", 10);
		npcatk_resume_ai();
		npcatk_resume_movement();
	}

	void ext_forsuth_bye()
	{
		ALLY_FOLLOW_ON = 0;
		TELEPORT_CHEAT = 0;
		if ((DID_END_EVENT)) return;
		DID_END_EVENT = 1;
		CallExternal("players", "ext_clear_valid_gauntlets");
		npcatk_suspend_ai();
		npcatk_suspend_movement(ANIM_IDLE);
		CHAT_STEP1 = "Alright, this is as far as I go.";
		CHAT_SOUND1 = "voices/the_wall/forsuth/alright_this_is_as_far_as_i_go.wav";
		CHAT_DELAY_STEP1 = 2.5;
		CHAT_STEP2 = "I don't blame you for working for the [Seekers]. They pay well...";
		CHAT_SOUND2 = "voices/the_wall/forsuth/i_dont_blame_you_for.wav";
		CHAT_DELAY_STEP2 = 3.8;
		CHAT_STEP3 = "...but I don't want to be goin' anywhere near 'em, meself.";
		CHAT_SOUND3 = "voices/the_wall/forsuth/but_i_dont_want_to_go.wav";
		CHAT_DELAY_STEP3 = 2.7;
		CallExternal(GAME_MASTER, "gm_find_strongest_reset");
		QUEST_WINNER = GetEntityProperty(GAME_MASTER, "scriptvar");
		CHAT_STEP4 = "Send ";
		CHAT_STEP4 += GetEntityName(QUEST_WINNER);
		if (GetGender(QUEST_WINNER) == "male")
		{
			CHAT_STEP4 += " over yonder. He's done more than his share, and I've a reward for him.";
			CHAT_SOUND4 = "voices/the_wall/forsuth/reward_reminder_male.wav";
			CHAT_DELAY_STEP4 = 4.5;
		}
		else
		{
			CHAT_STEP4 += " over yonder. The lass has done more than her share, and I've a reward for her.";
			CHAT_SOUND4 = "voices/the_wall/forsuth/reward_reminder_female.wav";
			CHAT_DELAY_STEP4 = 5.1;
		}
		CHAT_STEPS = 4;
		FACE_PLAYERS = 1;
		string L_TOTAL_CHAT_TIME = CHAT_STEPS;
		L_TOTAL_CHAT_TIME += 1;
		L_TOTAL_CHAT_TIME *= CHAT_DELAY;
		MAX_CHAT_TIME = L_TOTAL_CHAT_TIME;
		chat_loop();
		SetSolid("none");
	}

	void ext_forsuth_follow_close()
	{
		LogDebug("ext_forsuth_follow_close");
		if ((TELEPORT_CHEAT)) return;
		TELEPORT_CHEAT = 1;
		teleport_cheat_loop();
		NO_STUCK_CHECKS = 1;
		FOLLOW_RANGE_MIN = 48;
		FOLLOW_RANGE_MAX = 64;
	}

	void ext_forsuth_follow_norm()
	{
		TELEPORT_CHEAT = 0;
		NO_STUCK_CHECKS = 0;
		FOLLOW_RANGE_MIN = 64;
		FOLLOW_RANGE_MAX = 256;
	}

	void ext_unsolid()
	{
		SetSolid("none");
	}

	void chat_loop()
	{
		CHAT_OVERRIDE_TIME = GetGameTime();
		CHAT_OVERRIDE_TIME += MAX_CHAT_TIME;
	}

	void basecompanion_catchup()
	{
		string L_POS = GetEntityOrigin(PLAYER_FOLLOW);
		COMPANION_LR = GetEntityProperty(PLAYER_FOLLOW, "viewangles");
		string L_ANG = (COMPANION_LR).y;
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_ANG, 0), Vector3(0, -48, 0));
		string OLD_POS = GetEntityOrigin(GetOwner());
		SetEntityOrigin(GetOwner(), L_POS);
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, 90, 0), Vector3(0, 16, 0));
		string reg.npcmove.endpos = L_POS;
		int reg.npcmove.testonly = 1;
		NpcMove(GetOwner(), PLAYER_FOLLOW);
		NEXT_TELEPORT = GetGameTime();
		NEXT_TELEPORT += 3.0;
		if (!("game.ret.npcmove.dist" <= 0)) return;
		SetEntityOrigin(GetOwner(), OLD_POS);
		NEXT_TELEPORT = 0;
	}

	void do_wraith_comment()
	{
		DID_WRAITH_COMMENT = 1;
		SayText("Blast! Wraiths! You ll need a holy weapon to even hit  em!");
		EmitSound(GetOwner(), 0, "voices/the_wall/forsuth/blast_wraiths.wav", 10);
	}

	void npcatk_settarget()
	{
		if (!((GetEntityName(m_hAttackTarget)).findFirst("Wraith") >= 0)) return;
		if (!(DID_WRAITH_COMMENT))
		{
			do_wraith_comment();
		}
	}

}

}
