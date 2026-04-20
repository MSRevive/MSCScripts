#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_chat.as"

namespace MS
{

class Findlebind : CGameScript
{
	string ANIM_DEAD;
	string ANIM_DEATH_SPEECH;
	string ANIM_DIEING;
	int BEAR_DEAD;
	float BRAP_DELAY;
	int CANCHAT;
	string FOUND_WORTHY;
	int GAVE_JOB;
	int I_R_DIEING;
	string MENTIONED_PRIESTESS;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	int QUEST2_AVAILABLE;
	string QUEST_PLAYER;
	string QUEST_WINNER;
	int RECIEVED_CLAW;
	int SAYSTEP_ELF;
	string SOUND_COUGH;
	string SOUND_DEATH;
	string TARGET_PLAYER;

	Findlebind()
	{
		ANIM_DIEING = "c1a4_wounded_idle";
		ANIM_DEATH_SPEECH = "c1a4_dying_speech";
		ANIM_DEAD = "dead_sitting";
		SOUND_COUGH = "scientist/cough.wav";
		SOUND_DEATH = "scientist/sci_die1.wav";
		Precache(SOUND_DEATH);
		BRAP_DELAY = 3.5;
		NO_JOB = 1;
		NO_RUMOR = 1;
	}

	void OnSpawn() override
	{
		SetName("npc_findlebind");
		SetHealth(25);
		SetGold(25);
		SetName("Findlebind Goodheart");
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetRoam(false);
		SetModel("npc/elf1.mdl");
		SetInvincible(true);
		CANCHAT = 1;
		SetHearingSensitivity(6);
		CatchSpeech("say_hi", "hail");
		CatchSpeech("say_rumor", "door");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_priest", "priest");
		CatchSpeech("say_elf", "elves");
	}

	void resetchat()
	{
		CANCHAT = 1;
		ScheduleDelayedEvent(10, "resetchat");
	}

	void say_hi()
	{
		if ((RECIEVED_CLAW)) return;
		if (param1 == "PARAM1")
		{
			SetMoveDest(GetEntityOrigin("ent_lastspoke"));
		}
		PlayAnim("once", "converse1");
		SayText("Blessings to ye , adventurer! Would ye care to assist me with a bit of a problem?");
		Say("[.3] [.3] [.3] [.2] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/greeting.wav", 10);
		BRAP_DELAY = 5.1;
		ScheduleDelayedEvent(BRAP_DELAY, "say_hi2");
	}

	void say_hi2()
	{
		PlayAnim("once", "castspell");
		SayText("There's this large bear out there. I can't hardly go outside, and he's scared off all the good hunting!");
		Say("[.3] [.3] [.3] [.2] [.1] [.3]");
		UseTrigger("make_bear");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/theres_this_large_bear.wav", 10);
		BRAP_DELAY = 5.7;
		ScheduleDelayedEvent(BRAP_DELAY, "say_hi3");
	}

	void say_hi3()
	{
		PlayAnim("once", "fear1");
		SayText("Aye! " + A + "kodiak , believe it or not! Bring me proof of its death , and " + I + " shall reward ye!");
		Say("[.3] [.3] [.3] [.2] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/aye_a_kodiak.wav", 10);
		GAVE_JOB = 1;
	}

	void gave_claw()
	{
		QUEST_WINNER = param1;
		RECIEVED_CLAW = 1;
		NO_HAIL = 1;
		PlayAnim("once", "pondering");
		SayText("Wow! You actually killed it! ...and here I feared you'd only keep its belly full...");
		Say("[.1] [.2] [.3] [.2] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/you_actually_killed_it.wav", 10);
		BRAP_DELAY = 4.8;
		BRAP_DELAY("gave_claw2");
	}

	void gave_claw2()
	{
		SayText("I suppose you've earned a reward for that...");
		Say("[.3] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/i_suppose_youve.wav", 10);
		BRAP_DELAY = 2.6;
		BRAP_DELAY("gave_claw3");
	}

	void gave_claw3()
	{
		SayText("Here... It's not as if I get to town often enough to spend this.");
		Say("[.3] [.1] [.3] [.2] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/heres_a_reward.wav", 10);
		BRAP_DELAY = 3.4;
		BRAP_DELAY("offer_quest2");
		// TODO: offer QUEST_WINNER gold 50
	}

	void say_rumor()
	{
		if (param1 == "PARAM1")
		{
			SetMoveDest(GetEntityOrigin("ent_lastspoke"));
		}
		SayText("That mine door has been sealed , though it once lead to the ruins of Melanion , our ancient elven capital.");
		PlayAnim("once", "lean");
		Say("[.3] [.1] [.3] [.2] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/that_mine_door_is_sealed.wav", 10);
		BRAP_DELAY = 6.0;
		BRAP_DELAY("say_door2");
	}

	void say_door2()
	{
		SayText("Kray Eldorad was later built upon its ruins... Those poor fools...");
		Say("[.3] [.1] [.3] [.2] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/kray_eldorad.wav", 10);
		BRAP_DELAY = 4.1;
		BRAP_DELAY("say_door3");
	}

	void say_door3()
	{
		PlayAnim("once", "panic");
		SayText("Beneath that veneer of elven paradise , lurk monsters that you cannot even imagine!");
		Say("[.3] [.1] [.3] [.2] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/beneath_that_veneer.wav", 10);
		BRAP_DELAY = 6.0;
		BRAP_DELAY("say_door4");
	}

	void say_door4()
	{
		SayText("That's why *I* live HERE! At least here, the horrors don't hide under your feet.");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/thats_why_i_live_here.wav", 10);
		Say("[.3] [.1] [.3] [.2] [.1] [.3]");
	}

	void offer_quest2()
	{
		PlayAnim("once", "lean");
		SayText("I... Have another job you could do for me... But it won't be nearly so easy.");
		Say("[.1] [.2] [.3] [.1] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/i_have_another_job.wav", 10);
		BRAP_DELAY = 5.5;
		QUEST2_AVAILABLE = 1;
	}

	void say_job()
	{
		if (param1 == "PARAM1")
		{
			SetMoveDest(GetEntityOrigin("ent_lastspoke"));
		}
		if (!(QUEST2_AVAILABLE))
		{
			SayText("That bear won't know what hit it, thanks!");
			EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/that_bear_wont_know.wav", 10);
		}
		if (!(QUEST2_AVAILABLE)) return;
		QUEST_PLAYER = param1;
		if (QUEST_PLAYER == "PARAM1")
		{
			QUEST_PLAYER = GetEntityIndex("ent_lastspoke");
		}
		if ((ItemExists(QUEST_PLAYER, "key_red")))
		{
			SayText("Ah , " + I + " see you have the key , now you just have to find his lair!");
			Say("[.3] [.1] [.3] [.2] [.1] [.3]");
			EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/ah_you_have_the_key.wav", 10);
			BRAP_DELAY = 3.5;
			BRAP_DELAY("say_lair2");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SayText("Well, there's this necromancer that's been causing all this pandemonium in these parts.");
		Say("[.3] [.1] [.3] [.2] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/theres_this_necromancer.wav", 10);
		BRAP_DELAY = 5.2;
		BRAP_DELAY("say_job2");
	}

	void say_lair2()
	{
		SayText("There's a sinister door, up to the north, I'm not sure, but that maybe it.");
		Say("[.1] [.2] [.3] [.1] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/the_sinister_looking_door.wav", 10);
	}

	void say_job2()
	{
		SayText("Rather, it's his apprentice that does all the dirty work, Lord of Snakes... Slithar, I believe.");
		Say("[.1] [.2] [.3] [.1] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/rather_its_his_apprentice.wav", 10);
		BRAP_DELAY = 6.5;
		BRAP_DELAY("say_job3");
	}

	void say_job3()
	{
		SayText("Bring me proof that he has been slain, and I'll grant you something a lot better than pocket change.");
		Say("[.3] [.1] [.3] [.2] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/bring_me_proof.wav", 10);
		BRAP_DELAY = 5.2;
		BRAP_DELAY("say_job4");
	}

	void say_job4()
	{
		if (QUEST_PLAYER == "PARAM1")
		{
			QUEST_PLAYER = GetEntityIndex("ent_lastspoke");
		}
		if (GetEntityMaxHealth(QUEST_PLAYER) >= 200)
		{
			PlayAnim("once", "give_shot");
			UseTrigger("key_chest");
			MENTIONED_PRIESTESS = 1;
			SayText(I + " once had a key that , if what the [priestess] said was true , would get you into his lair.");
			Say("[.1] [.2] [.3] [.1] [.1] [.3]");
			EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/i_once_had_a_key.wav", 10);
			BRAP_DELAY = 5.3;
			BRAP_DELAY("say_key1");
		}
		if (!(GetEntityMaxHealth(QUEST_PLAYER) < 200)) return;
		PlayAnim("once", "no");
		SayText("I warn ye though, ye do not look nearly prepared for this, he'd very likely mean be the end of you.");
		Say("[.1] [.2] [.3] [.1] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/player_underprepared.wav", 10);
		BRAP_DELAY = 5.2;
		BRAP_DELAY("say_job5");
	}

	void say_key1()
	{
		SayText("Sadly , " + I + "left it behind in a wardrobe , when " + I + " had to make a hasty move from the old village.");
		Say("[.3] [.2] [.1] [.1] [.2] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/sadly_i_left_it_behind.wav", 10);
		BRAP_DELAY = 4.7;
		BRAP_DELAY("say_key3");
	}

	void say_key2()
	{
		SayText("Finding the key is nothing you can't handle, to be sure, after slaying that bear. But the Snake Lord...");
		Say("[.1] [.2] [.3] [.1] [.1] [.2]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/finding_the_key.wav", 10);
		BRAP_DELAY = 6.2;
		BRAP_DELAY("say_key3");
	}

	void say_key3()
	{
		SayText("He's turned all the people who were once there into his minions!");
		Say("[.1] [.2] [.3] [.1]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/he_turned_all_the_people.wav", 10);
		BRAP_DELAY = 3.6;
		BRAP_DELAY("say_key4");
	}

	void say_key4()
	{
		SayText("No matter... You may retain anything else you happen to find in that old dresser as well , should you find it of value.");
		Say("[.1] [.2] [.3] [.1] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/no_matter_you_can.wav", 10);
	}

	void say_job5()
	{
		PlayAnim("once", "retina");
		SayText("I think you should train some more first. I'll grant you the key to his lair when you appear ready.");
		Say("[.1] [.2] [.3] [.1] [.1] [.3] [.1] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/player_underprepared2.wav", 10);
	}

	void say_priest()
	{
		if (!(QUEST2_AVAILABLE)) return;
		if (param1 == "PARAM1")
		{
			SetMoveDest(GetEntityOrigin("ent_lastspoke"));
		}
		PlayAnim("once", "yes");
		SayText(A + " priestess of Felewyn came here a few years back...");
		Say("[.1] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/a_priestess_of_felewyn.wav", 10);
		BRAP_DELAY = 3.2;
		BRAP_DELAY("say_priest2");
	}

	void say_priest2()
	{
		SayText("She said she was too weak to defeat the Snake Lord and his master , but...");
		Say("[.2] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/she_said_she_was.wav", 10);
		BRAP_DELAY = 4.2;
		BRAP_DELAY("say_priest3");
	}

	void say_priest3()
	{
		SayText("She also said that " + I + "should give that red key to anyone " + I + " thought strong enough to try.");
		Say("[.1] [.1] [.3] [.1] [.1] [.3]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/she_said_i_should_give.wav", 10);
	}

	void slithar_died()
	{
		SetMenuAutoOpen(0);
		I_R_DIEING = 1;
		NO_RUMOR = 1;
		NO_JOB = 1;
		NO_HAIL = 1;
		SetIdleAnim(ANIM_DIEING);
		SetMoveAnim(ANIM_DIEING);
		PlayAnim("once", ANIM_DIEING);
		ScheduleDelayedEvent(0.1, "scan_for_worthy");
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if ((I_R_DIEING))
		{
			if (!(FOUND_WORTHY))
			{
			}
			if (GetEntityRange("ent_lastheard") < 256)
			{
			}
			if ((IsValidPlayer("ent_lastheard")))
			{
			}
			TARGET_PLAYER = GetEntityIndex("ent_lastheard");
			found_player();
		}
		if ((I_R_DIEING)) return;
		SetMoveDest(GetEntityOrigin("ent_lastheard"));
	}

	void scan_for_worthy()
	{
		if ((FOUND_WORTHY)) return;
		if (!(GetEntityRange(m_hLastSeen) < 256)) return;
		if ((IsValidPlayer(m_hLastSeen)))
		{
			TARGET_PLAYER = GetEntityIndex(m_hLastSeen);
			found_player();
		}
		ScheduleDelayedEvent(0.2, "scan_for_worthy");
	}

	void found_player()
	{
		if (GetEntityMaxHealth(TARGET_PLAYER) >= 300)
		{
			EmitSound(GetOwner(), 0, SOUND_COUGH, 10);
			PlayAnim("critical", ANIM_DEATH_SPEECH);
			FOUND_WORTHY = 1;
			UseTrigger("findlebind_died");
			SetSayTextRange(2048);
			SayText("*cough* Good! " + I + " see you defeated the snake lord! *gasp*");
			Say("[.1] [.1] [.3]");
			EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/you_killed_the_snake_lord.wav", 10);
			BRAP_DELAY = 6.8;
			BRAP_DELAY("found_player2");
		}
	}

	void found_player2()
	{
		SetSayTextRange(2048);
		SayText("Sadly , his master did not take kindly to that. *cough*");
		Say("[.2] [.1] [.4]");
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/his_master_didnt_like_that.wav", 10);
		BRAP_DELAY = 6.2;
		BRAP_DELAY("found_player3");
	}

	void found_player3()
	{
		SetSayTextRange(2048);
		SayText("He said , to give you... This...");
		Say("[.1] [.1] [.3] [.1] [.1] [.3] [.1] [.1] [.4]");
		SpawnItem("item_necro_note", /* TODO: $relpos */ $relpos(20, 40, 32));
		SpawnItem("key_green", /* TODO: $relpos */ $relpos(20, 40, 32));
		SetIdleAnim(ANIM_DEAD);
		SetMoveAnim(ANIM_DEAD);
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/he_told_me_to_give.wav", 10);
		ScheduleDelayedEvent(8.0, "death_rattle");
		ScheduleDelayedEvent(15.0, "npc_fade_away");
	}

	void death_rattle()
	{
		EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/death_rattle.wav", 10);
	}

	void say_elf()
	{
		SAYSTEP_ELF = 0;
		elf_joke();
	}

	void elf_joke()
	{
		if (param1 == "PARAM1")
		{
			SetMoveDest(GetEntityOrigin("ent_lastspoke"));
		}
		SAYSTEP_ELF += 1;
		Say("[.1] [.2] [.3] [.2] [.2] [.3] [.2]");
		if (SAYSTEP_ELF == 1)
		{
			SayText("Yes, it is true, you don't see many of us these days.");
			EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/you_dont_see_many_elves.wav", 10);
			BRAP_DELAY = 3.6;
		}
		if (SAYSTEP_ELF == 2)
		{
			SayText("We've been hiding in this mess.");
			EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/were_hiding_in_this_mess.wav", 10);
			BRAP_DELAY = 3.0;
		}
		if (SAYSTEP_ELF == 3)
		{
			SayText("Bad magic , " + I + " say.");
			EmitSound(GetOwner(), 0, "voices/bloodrose/findlebind/bad_magic_i_say.wav", 10);
			BRAP_DELAY = 1.7;
		}
		if (SAYSTEP_ELF < 3)
		{
			BRAP_DELAY("elf_joke");
		}
		else
		{
			SAYSTEP_ELF = 0;
		}
	}

	void game_menu_getoptions()
	{
		if ((I_R_DIEING)) return;
		SetMoveDest(GetEntityOrigin(param1));
		if (!(RECIEVED_CLAW))
		{
			if ((BEAR_DEAD))
			{
			}
			if ((ItemExists(param1, "item_bearclaw")))
			{
			}
			string reg.mitem.title = "Offer the Bear Claw";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_bearclaw";
			string reg.mitem.callback = "gave_claw";
		}
		if (!(BEAR_DEAD))
		{
			if (!(QUEST2_AVAILABLE))
			{
			}
			if ((GAVE_JOB))
			{
				string reg.mitem.title = "Jobs";
				string reg.mitem.type = "callback";
				string reg.mitem.callback = "say_job";
			}
		}
		if ((QUEST2_AVAILABLE))
		{
			if ((ItemExists(QUEST_PLAYER, "key_red")))
			{
				int L_HAS_KEY = 1;
			}
			if ((ItemExists(param1, "key_red")))
			{
				int L_HAS_KEY = 1;
			}
			if (!(L_HAS_KEY))
			{
				string reg.mitem.title = "Another job?";
			}
			else
			{
				string reg.mitem.title = "Where is Slithar?";
			}
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_job";
			if ((MENTIONED_PRIESTESS))
			{
			}
			string reg.mitem.title = "A preistess?";
			string reg.mitem.type = "callback";
			string reg.mitem.callback = "say_priest";
		}
		string reg.mitem.title = "What's that large gate?";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_rumor";
		string reg.mitem.title = "You're an elf!";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "elf_joke";
	}

	void da_bear_died()
	{
		BEAR_DEAD = 1;
	}

}

}
