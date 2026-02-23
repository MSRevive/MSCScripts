#pragma context server

#include "monsters/elf_wizard_base.as"
#include "monsters/base_chat.as"

namespace MS
{

class ElfWizardGuard : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_STEP1;
	string ANIM_STEP3;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	float CHAT_DELAY_STEP1;
	float CHAT_DELAY_STEP2;
	float CHAT_DELAY_STEP3;
	float CHAT_DELAY_STEP4;
	float CHAT_DELAY_STEP5;
	float CHAT_DELAY_STEP6;
	float CHAT_DELAY_STEP7;
	float CHAT_DELAY_STEP8;
	float CHAT_DELAY_STEP9;
	string CHAT_MODE;
	string CHAT_SOUND1;
	string CHAT_SOUND2;
	string CHAT_SOUND3;
	string CHAT_SOUND4;
	string CHAT_SOUND5;
	string CHAT_SOUND6;
	string CHAT_SOUND7;
	string CHAT_SOUND8;
	string CHAT_SOUND9;
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
	string INTRO_ID;
	string NEXT_DMG_ALERT;
	int NPC_NO_PLAYER_DMG;
	string NPC_PROXACT_EVENT;
	int NPC_PROXACT_IFSEEN;
	int NPC_PROXACT_RANGE;
	int NPC_PROX_ACTIVATE;
	int NPC_RETURN_HOME;
	int ON_SECOND_SPAWN;
	int PLAYERS_REWARDED;
	string PLAYERS_TO_REWARD;
	string QUEST_WINNER;
	string REWARD_LIST;
	string REWARD_LIST1;
	string REWARD_LIST2;
	string REWARD_LIST3;
	string REWARD_LIST4;
	string REWARD_NAMES4;
	string REWARED_SYMBOL;

	ElfWizardGuard()
	{
		REWARD_LIST1 = "scroll_volcano;armor_helm_gaz2;mana_immune_cold;mana_gprotection;swords_giceblade;shields_rune;scroll2_frost_xolt;scroll_ice_wall";
		REWARD_LIST2 = "scroll2_lightning_chain;scroll2_lightning_storm;mana_leadfoot;mana_demon_blood;mana_immune_lightning";
		REWARD_LIST3 = "armor_helm_gaz1;mana_immune_fire;mana_vampire;item_gwond;axes_dragon;scroll_fire_wall;swords_novablade12;blunt_gauntlets_fire";
		REWARD_LIST4 = "mana_leadfoot;axes_gthunder11;axes_vaxe;blunt_gauntlets_demon;mana_forget;mana_speed;mana_regen;polearms_nag";
		REWARD_NAMES4 = "Leadfoot Potion;Greater Thunderaxe;Blood Axe;Demon Gauntlets;Forgetfulness Potion;Speed Potion;Regeneration Potion;Elven Glaive";
		const int ELF_LIGHTNING_WIZARD = 1;
		const int DMG_SHOCK = 100;
		const int DOT_SHOCK = 50;
		const int DMG_MELEE = 300;
		const int NO_CHAT = 1;
		NPC_NO_PLAYER_DMG = 1;
		NPC_RETURN_HOME = 1;
		NPC_PROX_ACTIVATE = 1;
		NPC_PROXACT_RANGE = 256;
		NPC_PROXACT_EVENT = "do_intro";
		NPC_PROXACT_IFSEEN = 0;
		const string SOUND_ELF_BEAM_LOOP = "magic/bolt_loop.wav";
		const string SOUND_ELF_BEAM_START = "magic/bolt_start.wav";
		const int NPC_BATTLE_ALLY = 1;
		const int ATTACK_HITRANGE_MELEE = 128;
	}

	void game_precache()
	{
		Precache(SOUND_ELF_BEAM_LOOP);
		Precache(SOUND_ELF_BEAM_START);
		Precache("voices/the_wall/vv_azura_dead.wav");
		Precache("voices/the_wall/vv_azura1.wav");
		Precache("voices/the_wall/vv_azura2.wav");
		Precache("voices/the_wall/vv_azura3.wav");
		Precache("voices/the_wall/vv_givereward.wav");
		Precache("voices/the_wall/vv_hi1.wav");
		Precache("voices/the_wall/vv_hi2.wav");
		Precache("voices/the_wall/vv_hi3.wav");
		Precache("voices/the_wall/vv_holdthere1.wav");
		Precache("voices/the_wall/vv_holdthere2.wav");
		Precache("voices/the_wall/vv_holdthere3.wav");
		Precache("voices/the_wall/vv_ihotohr_dead1.wav");
		Precache("voices/the_wall/vv_ihotohr_dead2.wav");
		Precache("voices/the_wall/vv_ihotohr_dead2_solo.wav");
		Precache("voices/the_wall/vv_ihotohr_dead3.wav");
		Precache("voices/the_wall/vv_ihotohr_dead3_solo.wav");
		Precache("voices/the_wall/vv_ihotohr1.wav");
		Precache("voices/the_wall/vv_ihotohr2.wav");
		Precache("voices/the_wall/vv_ihotohr3.wav");
		Precache("voices/the_wall/vv_ihotohr4.wav");
		Precache("voices/the_wall/vv_ihotohr5.wav");
		Precache("voices/the_wall/vv_ivicta_dead.wav");
		Precache("voices/the_wall/vv_ivicta1.wav");
		Precache("voices/the_wall/vv_ivicta2.wav");
		Precache("voices/the_wall/vv_ivicta3.wav");
		Precache("voices/the_wall/vv_melanion.wav");
		Precache("voices/the_wall/vv_playersrewarded.wav");
		Precache("voices/the_wall/vv_thewall1-2.wav");
		Precache("voices/the_wall/vv_thewall3.wav");
		Precache("voices/the_wall/vv_thewall4.wav");
		Precache("voices/the_wall/vv_token.wav");
		Precache("voices/the_wall/vv_traitors1.wav");
		Precache("voices/the_wall/vv_traitors2.wav");
		Precache("voices/the_wall/vv_traitors3.wav");
		Precache("voices/the_wall/vv_traitors4.wav");
		Precache("voices/the_wall/vv_traitors5.wav");
		Precache("voices/the_wall/vv_traitors6.wav");
		Precache("voices/the_wall/vv_traitors7.wav");
		Precache("voices/the_wall/vv_traitors8.wav");
		Precache("voices/the_wall/vv_traitors9.wav");
		Precache("voices/the_wall/vv_ulectrath_dead.wav");
		Precache("voices/the_wall/vv_ulectrath1.wav");
	}

	void elf_spawn()
	{
		SetName("Velend Varon");
		SetHealth(3500);
		SetRace("human");
		SetName("elf_leader");
		SetModelBody(1, 2);
		SetModelBody(2, 0);
		SetProp(GetOwner(), "skin", 6);
		SetRoam(false);
		SetSayTextRange(1024);
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_the_wall", "wall");
		CatchSpeech("say_traitors", "ram");
		CatchSpeech("say_azura", "azur");
		CatchSpeech("say_ulectrath", "ulec");
		CatchSpeech("say_ivicta", "ivict");
		CatchSpeech("say_ihotohr", "iho");
		CatchSpeech("say_melanion", "mel");
		SetHearingSensitivity(10);
		SetMenuAutoOpen(0);
		npcatk_suspend_ai();
	}

	void OnPostSpawn() override
	{
		SetModelBody(2, 0);
		ANIM_ATTACK = "ref_shoot_crowbar";
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 120;
		if (!(StringToLower(GetMapName()) + "the_wall2")) return;
		ON_SECOND_SPAWN = 1;
	}

	void do_intro()
	{
		INTRO_ID = NPC_PROXACT_PLAYERID;
		SetModelBody(2, 0);
		npcatk_resume_ai();
		SetMoveDest(INTRO_ID);
		if ((ON_SECOND_SPAWN)) return;
		SayText("Hold there!");
		EmitSound(GetOwner(), 2, "voices/the_wall/vv_holdthere.wav", 10);
		Say("[0.2] [0.4]");
		PlayAnim("critical", "look_idle");
		CHAT_STEP1 = "Several [Rammata] have escaped us by traveling into the fortresses.";
		CHAT_DELAY_STEP1 = 3.4;
		CHAT_SOUND1 = "voices/the_wall/vv_holdthere1.wav";
		CHAT_STEP2 = "I'm afraid we three aren't enough to dare try to flush them out.";
		CHAT_DELAY_STEP2 = 4.0;
		CHAT_SOUND2 = "voices/the_wall/vv_holdthere2.wav";
		CHAT_STEP3 = "There's too many powerful undead occupying [The Wall] for us to go in.";
		CHAT_DELAY_STEP3 = 4.4;
		CHAT_SOUND3 = "voices/the_wall/vv_holdthere3.wav";
		CHAT_STEPS = 3;
		ScheduleDelayedEvent(3.0, "chat_loop");
	}

	void say_the_wall()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(5.0, "say_the_wall");
		}
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "The Wall is a series of elven fortresses that once stood as the last line of defense";
		CHAT_DELAY_STEP1 = 4.6;
		CHAT_SOUND1 = "voices/the_wall/vv_thewall1-2.wav";
		CHAT_STEP2 = "against Lor Malgoriand's armies during the Age of Blood.";
		CHAT_DELAY_STEP2 = 3.2;
		CHAT_STEP3 = "The former Eswen Empire no longer has the forces to maintain the lines.";
		CHAT_DELAY_STEP3 = 5.1;
		CHAT_SOUND3 = "voices/the_wall/vv_thewall3.wav";
		CHAT_STEP4 = "As a result, the remains of the dark one's armies moved into the ruins.";
		CHAT_SOUND4 = "voices/the_wall/vv_thewall4.wav";
		CHAT_DELAY_STEP4 = 4.5;
		CHAT_STEPS = 4;
		ScheduleDelayedEvent(20.0, "enable_menu");
		chat_loop();
	}

	void enable_menu()
	{
		SetMenuAutoOpen(1);
	}

	void say_traitors()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(5.0, "say_traitors");
		}
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Rammata te Mal are elven worshippers of Torkalath.";
		CHAT_SOUND1 = "voices/the_wall/vv_traitors1.wav";
		CHAT_DELAY_STEP1 = 3.0;
		CHAT_STEP2 = "They're insane, evil. They'll show no mercy, even to you, a legitmate child of their god.";
		CHAT_SOUND2 = "voices/the_wall/vv_traitors2.wav";
		CHAT_DELAY_STEP2 = 5.5;
		CHAT_STEP3 = "We cannot allow traitors of Felewyn to escape justice.";
		CHAT_SOUND3 = "voices/the_wall/vv_traitors3.wav";
		CHAT_DELAY_STEP3 = 4.0;
		CHAT_STEP4 = "This pack's leaders are named [Azura], [Ulectrath], and [Ivicta].";
		CHAT_SOUND4 = "voices/the_wall/vv_traitors4.wav";
		CHAT_DELAY_STEP4 = 4.0;
		CHAT_STEP5 = "They've also several acolytes with them we've no records of.";
		CHAT_SOUND5 = "voices/the_wall/vv_traitors5.wav";
		CHAT_DELAY_STEP5 = 4.5;
		CHAT_STEP6 = "They are all likely seeking the protection of the Rammata [necromancer], Ihotohr, who dwells within.";
		CHAT_SOUND6 = "voices/the_wall/vv_traitors6.wav";
		CHAT_DELAY_STEP6 = 6.2;
		CHAT_STEP7 = "He's insane, and likely not be anymore pleased to see them than will the undead he masters.";
		CHAT_SOUND7 = "voices/the_wall/vv_traitors7.wav";
		CHAT_DELAY_STEP7 = 6.0;
		CHAT_STEP8 = "We don't have authority to enter the ruins, but if you can bring us proof of their deaths...";
		CHAT_SOUND8 = "voices/the_wall/vv_traitors8.wav";
		CHAT_DELAY_STEP8 = 3.5;
		CHAT_STEP9 = "I do have the authority to reward you for each head retrieved.";
		CHAT_SOUND9 = "voices/the_wall/vv_traitors9.wav";
		CHAT_DELAY_STEP9 = 5.7;
		CHAT_STEPS = 9;
		chat_loop();
	}

	void say_azura()
	{
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Azura is actually from north of The Wall, living among the undead around The Bleak.";
		CHAT_DELAY_STEP1 = 4.7;
		CHAT_SOUND1 = "voices/the_wall/vv_azura1.wav";
		CHAT_STEP2 = "She journeyed down from the frozen wastelands to join up with the other two in their effort to assassinate Magistrate Tal'san.";
		CHAT_DELAY_STEP2 = 6.5;
		CHAT_SOUND2 = "voices/the_wall/vv_azura2.wav";
		CHAT_STEP3 = "Apprarently, part of a vendetta, to avenge the slaughter of a coven of Rammata found hiding in [Melanion].";
		CHAT_DELAY_STEP3 = 7.3;
		CHAT_SOUND3 = "voices/the_wall/vv_azura3.wav";
		CHAT_STEPS = 3;
		chat_loop();
	}

	void say_ulectrath()
	{
		if ((BUSY_CHATTING)) return;
		EmitSound(GetOwner(), 2, "voices/the_wall/vv_ulectrath1.wav", 10);
		SayText("Ulectrath the Storm hails from Aluhandra where it is rumored she either bargained for or stole magical powers from the desert orc clans.");
		bchat_auto_mouth_move(7.0);
	}

	void say_ivicta()
	{
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Ivicta was the sole survivor of a [Melanion] cult, subsequently forced into the Badlands.";
		CHAT_DELAY_STEP1 = 6.0;
		CHAT_SOUND1 = "voices/the_wall/vv_ivicta1.wav";
		CHAT_STEP2 = "The slaughter of the cult was ordered by Magistrate Tal'san, so it is likely she who began this mad quest to assassinate him. ";
		CHAT_DELAY_STEP2 = 7.0;
		CHAT_SOUND2 = "voices/the_wall/vv_ivicta2.wav";
		CHAT_STEP3 = "However, how she contacted or organized the other two women is beyond the scope of our knowledge.";
		CHAT_DELAY_STEP3 = 5.5;
		CHAT_SOUND3 = "voices/the_wall/vv_ivicta3.wav";
		CHAT_STEPS = 3;
		chat_loop();
	}

	void say_melanion()
	{
		SayText("The Melanion Ruins lie beneath and around the new elven capital of Kray Eldorad and run all the way to Blood Rose valley.");
		EmitSound(GetOwner(), 2, "voices/the_wall/vv_melanion.wav", 10);
		bchat_auto_mouth_move(7.0);
	}

	void say_ihotohr()
	{
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Ihotohr brought an army of the undead to the elven capital of Kray Eldorad nearly a century ago.";
		CHAT_DELAY_STEP1 = 5.2;
		CHAT_SOUND1 = "voices/the_wall/vv_ihotohr1.wav";
		CHAT_STEP2 = "He was soundly defeated, and has been biding his time in the maze of fortresses that make up The Wall ever since.";
		CHAT_DELAY_STEP2 = 6.7;
		CHAT_SOUND2 = "voices/the_wall/vv_ihotohr2.wav";
		CHAT_STEP3 = "Rammata have sought him out to form alliances before, but none have returned..";
		CHAT_DELAY_STEP3 = 4.3;
		CHAT_SOUND3 = "voices/the_wall/vv_ihotohr3.wav";
		CHAT_STEP4 = "I fear that desperation and fear have driven this trio and their cohorts to attempt it.";
		CHAT_DELAY_STEP4 = 4.5;
		CHAT_SOUND4 = "voices/the_wall/vv_ihotohr4.wav";
		CHAT_STEP5 = "We cannot depend on the necromancer to dispatch our foes for us though. Sooner or later, we must pursue them.";
		CHAT_DELAY_STEP5 = 6.0;
		CHAT_SOUND5 = "voices/the_wall/vv_ihotohr5.wav";
		CHAT_STEPS = 5;
		chat_loop();
	}

	void say_hi()
	{
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Hail, child of Torkaloth...";
		CHAT_DELAY_STEP1 = 1.5;
		CHAT_SOUND1 = "voices/the_wall/vv_hi1.wav";
		CHAT_STEP2 = "As I explained, serveral [Rammata] have escaped into the fortresses.";
		CHAT_DELAY_STEP2 = 4.5;
		CHAT_SOUND2 = "voices/the_wall/vv_hi2.wav";
		CHAT_STEP3 = "Bring us proof of their demise, and I shall reward you.";
		CHAT_DELAY_STEP3 = 3.0;
		CHAT_SOUND3 = "voices/the_wall/vv_hi3.wav";
		CHAT_STEPS = 3;
		chat_loop();
	}

	void game_menu_getoptions()
	{
		SetMoveDest(param1);
		if ((BUSY_CHATTING))
		{
			if (CHAT_MODE != "final_reward")
			{
			}
			string reg.mitem.title = "(Talking...)";
			string reg.mitem.type = "disabled";
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (m_hAttackTarget != "unset")
		{
			string reg.mitem.title = "(In combat...)";
			string reg.mitem.type = "disabled";
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SetMoveDest(param1);
		int HAS_HEAD = 0;
		if ((ItemExists(param1, "item_telfh1")))
		{
			int HAS_HEAD = 1;
			string reg.mitem.title = "Give Azura's Head";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_telfh1";
			string reg.mitem.callback = "got_head1";
		}
		if ((ItemExists(param1, "item_telfh2")))
		{
			int HAS_HEAD = 1;
			string reg.mitem.title = "Give Ulectrath's Head";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_telfh2";
			string reg.mitem.callback = "got_head2";
		}
		if ((ItemExists(param1, "item_telfh3")))
		{
			int HAS_HEAD = 1;
			string reg.mitem.title = "Give Ivicta's Head";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_telfh3";
			string reg.mitem.callback = "got_head3";
		}
		if ((ItemExists(param1, "item_telfh4")))
		{
			int HAS_HEAD = 1;
			string reg.mitem.title = "Give Ihotohr's Head";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_telfh4";
			string reg.mitem.callback = "got_head4";
		}
		if (!(HAS_HEAD))
		{
			if (CHAT_MODE != "final_reward")
			{
			}
			string reg.mitem.title = "Hail";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_hi";
			string reg.mitem.title = "About The Wall";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_the_wall";
			string reg.mitem.title = "About Rammata";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_traitors";
			string reg.mitem.title = "About Azura";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_azura";
			string reg.mitem.title = "About Ulectrath";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_ulectrath";
			string reg.mitem.title = "About Ivicta";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_ivicta";
			string reg.mitem.title = "About Ihotohr";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_ihotohr";
		}
		if (!(CHAT_MODE == "final_reward")) return;
		if (GetEntityMaxHealth(param1) < 200)
		{
			SayText("Yes... You're cute, but you couldn't have possibly had anything to do with this.");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((PLAYERS_TO_REWARD).findFirst(param1) >= 0)
		{
			int GIVE_REWARD = 1;
		}
		if (!(GIVE_REWARD))
		{
			SayText("Thank you again, for all you have done for us, child of Torkalath.");
			EmitSound(GetOwner(), 2, "voices/the_wall/vv_givereward.wav", 10);
			bchat_mouth_move();
		}
		if (!(GIVE_REWARD)) return;
		if (PLAYERS_REWARDED > 1)
		{
			EmitSound(GetOwner(), 2, "voices/the_wall/vv_playersrewarded.wav", 10);
			SayText("Please, select a reward for the part you played in the defeat of Ihotohr.");
			bchat_mouth_move();
		}
		for (int i = 0; i < GetTokenCount(REWARD_LIST4, ";"); i++)
		{
			build_reward_list();
		}
		if (!(REWARED_SYMBOL))
		{
			if ((GetPlayerQuestData(param1, "f")).findFirst("sym") >= 0)
			{
				int NO_SYMB = 1;
			}
			if (!(NO_SYMB))
			{
			}
			REWARED_SYMBOL = 1;
			string CUR_ITEM_NAME = "Symbol of Felewyn ";
			string CUR_ITEM = "item_s";
			string RAND_SYMB = RandomInt(1, 5);
			if (RAND_SYMB == 1)
			{
				string NAME_ADD = "I";
				string ITEM_ADD = "1";
			}
			if (RAND_SYMB == 2)
			{
				string NAME_ADD = "II";
				string ITEM_ADD = "2";
			}
			if (RAND_SYMB == 3)
			{
				string NAME_ADD = "III";
				string ITEM_ADD = "3";
			}
			if (RAND_SYMB == 4)
			{
				string NAME_ADD = "IV";
				string ITEM_ADD = "4";
			}
			if (RAND_SYMB == 5)
			{
				string NAME_ADD = "V";
				string ITEM_ADD = "5";
			}
			CUR_ITEM_NAME += NAME_ADD;
			CUR_ITEM += ITEM_ADD;
			string reg.mitem.title = CUR_ITEM_NAME;
			string reg.mitem.data = CUR_ITEM;
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "give_reward_final";
		}
	}

	void build_reward_list()
	{
		string CUR_IDX = i;
		string CUR_ITEM = GetToken(REWARD_LIST4, CUR_IDX, ";");
		string CUR_ITEM_NAME = GetToken(REWARD_NAMES4, CUR_IDX, ";");
		string reg.mitem.title = CUR_ITEM_NAME;
		string reg.mitem.data = CUR_ITEM;
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "give_reward_final";
	}

	void give_reward_final()
	{
		string PLR_IDX = FindToken(PLAYERS_TO_REWARD, param1, ";");
		RemoveToken(PLAYERS_TO_REWARD, PLR_IDX, ";");
		PLAYERS_REWARDED += 1;
		LogDebug("give_reward_final GetEntityName(param1) PARAM2");
		// TODO: offer PARAM1 PARAM2
	}

	void frame_melee()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_MELEE, 0.9, "blunt");
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(10, 800, 110));
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((IsValidPlayer(m_hLastStruck))) return;
		if (!(param1 > 0)) return;
		if (!(GetGameTime() > NEXT_DMG_ALERT)) return;
		NEXT_DMG_ALERT = GetGameTime();
		NEXT_DMG_ALERT += 10.0;
		SendInfoMsg("all", "CRITICAL NPC UNDER ATTACK Velend Varon is under attack!");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SendInfoMsg("all", "A CRITICAL NPC HAS BEEN SLAIN! Velend Varon is dead!");
	}

	void got_head1()
	{
		LogDebug("got_head1 step 1");
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "got_head1");
		}
		LogDebug("got_head1 step 2");
		if ((BUSY_CHATTING)) return;
		LogDebug("got_head1 step 3");
		CHAT_STEP1 = "Ah yes, the head of Azura. Finally her cold soul can be brought to rest.";
		CHAT_DELAY_STEP1 = 5.3;
		CHAT_SOUND1 = "voices/the_wall/vv_azura_dead.wav";
		CHAT_STEP2 = "Please take token of gratitude from the faithful of the Empire of Eswen.";
		CHAT_DELAY_STEP2 = 4.3;
		CHAT_SOUND2 = "voices/the_wall/vv_token.wav";
		CHAT_STEPS = 2;
		chat_loop();
		LogDebug("got_head1 step 4");
		REWARD_LIST = REWARD_LIST1;
		string QUEST_WINNER = param1;
		reward_random_item(QUEST_WINNER);
	}

	void got_head2()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "got_head2");
		}
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Ulectrath made many shake with fear, like thunder in the night. They may sleep easy, knowing that you have defeated her at last.";
		CHAT_SOUND1 = "voices/the_wall/vv_ulectrath_dead.wav";
		CHAT_DELAY_STEP1 = 5.9;
		CHAT_STEP2 = "Please take token of gratitude from the faithful of the Empire of Eswen.";
		CHAT_DELAY_STEP2 = 4.3;
		CHAT_SOUND2 = "voices/the_wall/vv_token.wav";
		CHAT_STEPS = 2;
		chat_loop();
		REWARD_LIST = REWARD_LIST2;
		string QUEST_WINNER = param1;
		reward_random_item(QUEST_WINNER);
	}

	void got_head3()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "got_head3");
		}
		if ((BUSY_CHATTING)) return;
		CHAT_STEP1 = "Ivicta hatred was not without reason, but it was beyond it. We can only pray that she may now finally be free of it.";
		CHAT_SOUND1 = "voices/the_wall/vv_ivicta_dead.wav";
		CHAT_DELAY_STEP1 = 8.5;
		CHAT_STEP2 = "Please take token of gratitude from the faithful of the Empire of Eswen.";
		CHAT_DELAY_STEP2 = 4.3;
		CHAT_SOUND2 = "voices/the_wall/vv_token.wav";
		CHAT_STEPS = 2;
		chat_loop();
		REWARD_LIST = REWARD_LIST3;
		string QUEST_WINNER = param1;
		reward_random_item(QUEST_WINNER);
	}

	void got_head4()
	{
		if ((BUSY_CHATTING))
		{
			ScheduleDelayedEvent(1.0, "got_head4");
		}
		if ((BUSY_CHATTING)) return;
		int CHAT_DELAY_TOTAL = 0;
		CHAT_STEP1 = "You... You slew Ihotohr himself!? This is more than I ever dared even hope for, let alone ask!";
		CHAT_SOUND1 = "voices/the_wall/vv_ihotohr_dead1.wav";
		CHAT_DELAY_STEP1 = 8.5;
		CHAT_DELAY_TOTAL += 8.5;
		ANIM_STEP1 = "ref_aim_squeak";
		if (GetPlayerCount() > 1)
		{
			CHAT_STEP2 = "All of you must be rewarded! Please, choose from among any of these, each of you!";
			CHAT_SOUND2 = "voices/the_wall/vv_ihotohr_dead2.wav";
			CHAT_DELAY_STEP2 = 5.5;
			CHAT_DELAY_TOTAL += 5.5;
			CHAT_STEP3 = "Tell your allys to come forth! I shall reward each of them in turn.";
			CHAT_SOUND3 = "voices/the_wall/vv_ihotohr_dead3.wav";
			CHAT_DELAY_STEP3 = 3.5;
		}
		else
		{
			CHAT_STEP2 = "And on your own no less? I truly underestimated you. Without doubt Felewyn walks by your side!";
			CHAT_SOUND2 = "voices/the_wall/vv_ihotohr_dead2_solo.wav";
			CHAT_DELAY_STEP2 = 7.9;
			CHAT_DELAY_TOTAL += 7.9;
			CHAT_STEP3 = "Please, select from any of these items.";
			CHAT_SOUND3 = "voices/the_wall/vv_ihotohr_dead3_solo.wav";
			CHAT_DELAY_STEP3 = 2.3;
		}
		ANIM_STEP3 = "deep_idle";
		CHAT_STEPS = 3;
		chat_loop();
		SendInfoMsg("all", "QUEST REWARD Velend Varon has a gift waiting for you, please see him.");
		PLAYERS_TO_REWARD = "";
		GetAllPlayers(PLAYERS_TO_REWARD);
		PLAYERS_REWARDED = 1;
		QUEST_WINNER = param1;
		CHAT_DELAY_TOTAL("reward_final_items");
	}

	void reward_random_item()
	{
		LogDebug("reward_random_item step1");
		string N_REWARDS = GetTokenCount(REWARD_LIST, ";");
		N_REWARDS -= 1;
		string RND_REWARD = RandomInt(0, N_REWARDS);
		LogDebug("reward_random_item step2");
		string RND_ITEM = GetToken(REWARD_LIST, RND_REWARD, ";");
		LogDebug("reward_random_item step3");
		// TODO: offer PARAM1 RND_ITEM
	}

	void reward_final_items()
	{
		CHAT_MODE = "final_reward";
		ScheduleDelayedEvent(0.1, "resend_menu");
	}

	void resend_menu()
	{
		OpenMenu(QUEST_WINNER);
	}

	void second_spawn()
	{
		ON_SECOND_SPAWN = 1;
	}

}

}
