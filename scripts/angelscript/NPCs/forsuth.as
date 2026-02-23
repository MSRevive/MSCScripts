#pragma context server

#include "monsters/base_monster.as"
#include "monsters/base_npc_vendor.as"

namespace MS
{

class Forsuth : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_CHAT;
	int CAN_HEAR;
	float CHAT_SPEED;
	int CLOSE_SHOP;
	int DID_HAIL;
	string DID_PLAYER;
	string DID_WARCRY;
	string FACE_TARG;
	int HUNT_AGRO;
	string HUNT_LASTTARGET;
	int ICE_LORD_PLOT_STEP;
	int INVITED;
	int IN_CHAT;
	int JOB_PLOT_STEP;
	int MONSTER_WIDTH;
	string MY_START;
	int NO_ROTATE;
	int NO_STUCK_CHECKS;
	int ORC_STEP;
	string STORE_TRIGGERTEXT;

	Forsuth()
	{
		const string SOUND_SWING = "weapons/swingsmall.wav";
		const int ATTACK_DAMAGE = 30;
		ATTACK_RANGE = 50;
		ATTACK_HITRANGE = 100;
		const float ATTACK_ACCURACY = 0.7;
		MONSTER_WIDTH = 32;
		NO_STUCK_CHECKS = 1;
		const int STORE_RESTOCK = 0;
		CHAT_SPEED = 5.0;
		HUNT_AGRO = 0;
		const int VENDOR_NOT_ON_USE = 1;
		ANIM_IDLE = "idle";
		ANIM_DEATH = "death";
		ANIM_ATTACK = "attack";
		const string STORE_NAME = "forsuths_store";
		STORE_TRIGGERTEXT = "drink shop store cold ale bitter";
		const int STORE_SELLMENU = 1;
		CAN_HEAR = 0;
	}

	void OnSpawn() override
	{
		ANIM_WALK = "idle";
		ANIM_RUN = "idle";
		SetHealth(200);
		SetGold(10);
		SetName("Forsuth , the Frosty");
		SetWidth(32);
		SetHeight(72);
		SetHearingSensitivity(8);
		SetRace("human");
		SetRoam(false);
		SetModel("dwarf/male1.mdl");
		SetModelBody(0, 0);
		SetModelBody(1, 1);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_IDLE);
		SetMoveSpeed(0.0);
		SetHearingSensitivity(6);
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "job");
		CatchSpeech("say_rumor", "rumour");
		CatchSpeech("npc_say_store", "drink");
		CatchSpeech("say_orcs", "marogar");
		CatchSpeech("lor_lore", "malgoriand");
		CatchSpeech("debug_props", "debug");
		SetDamageResistance("cold", 0.0);
		CAN_CHAT = 1;
		SetMenuAutoOpen(1);
		ScheduleDelayedEvent(1.0, "get_pos");
		ScheduleDelayedEvent(1.0, "watch_for_friends");
	}

	void debug_props()
	{
		SayText("Izhunting IS_HUNTING");
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(IsValidPlayer("ent_lastheard"))) return;
		if (!(GetEntityRange("ent_lastheard") < 100)) return;
		SetMoveDest(GetEntityIndex("ent_lastheard"));
	}

	void get_pos()
	{
		MY_START = GetEntityOrigin(GetOwner());
	}

	void reset_chat()
	{
		if ((IN_CHAT))
		{
			ScheduleDelayedEvent(6.0, "reset_chat");
		}
		if ((IN_CHAT)) return;
		ORC_STEP = 0;
		ICE_LORD_PLOT_STEP = 0;
		JOB_PLOT_STEP = 0;
	}

	void watch_for_friends()
	{
		if ((INVITED)) return;
		ScheduleDelayedEvent(5.0, "watch_for_friends");
		if (!(false)) return;
		FACE_TARG = GetEntityIndex(m_hLastSeen);
		SetSayTextRange(2048);
		SayText("By Urdual s beard! Get in here where it s warm , ya young fool!");
		EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/get_in_here.wav", 10);
		INVITED = 1;
		start_facing_targ();
		ScheduleDelayedEvent(4.0, "invite_in");
	}

	void start_facing_targ()
	{
		SetRepeatDelay(5.0);
		if ((NO_ROTATE)) return;
		if ((CLOSE_STORE)) return;
		SetMoveDest(FACE_TARG);
	}

	void invite_in()
	{
		SayText("That s better! You ll catch yer death of cold out there!");
		EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/thats_better.wav", 10);
		PlayAnim("critical", ANIM_IDLE);
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Hail";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_hi";
		if (!(DID_HAIL)) return;
		string reg.mitem.title = "The Marogar?";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_orcs";
		string reg.mitem.title = "Ice Lord?";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_rumor";
		string reg.mitem.title = "Any jobs?";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_job";
	}

	void say_hi()
	{
		DID_HAIL = 1;
		if ((IsValidPlayer("ent_lastspoke")))
		{
			FACE_TARG = "ent_lastspoke";
		}
		reset_chat();
		PlayAnim("once", "nod");
		if ((IN_CHAT)) return;
		IN_CHAT = 1;
		SayText("Hello thar , they call me Frosty. Forsuth the Frosty.");
		EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/hallo_thar.wav", 10);
		CHAT_SPEED = 4.4;
		ScheduleDelayedEvent(CHAT_SPEED, "hailed2");
	}

	void hailed2()
	{
		SayText("Thar be all sorts of nasty things out in that thar cold.");
		EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/there_be_all_sorts.wav", 10);
		CHAT_SPEED = 3.8;
		ScheduleDelayedEvent(CHAT_SPEED, "hailed3");
	}

	void hailed3()
	{
		SayText("Didn t used to be this way though.");
		EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/didnt_used_to_be.wav", 10);
		CHAT_SPEED = 2.0;
		ScheduleDelayedEvent(CHAT_SPEED, "hailed4");
	}

	void hailed4()
	{
		SayText("Not until the [Ice Lord] woke up... And the [marogar] ain t be helping much either.");
		EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/not_until_the_ice_lord.wav", 10);
		CHAT_SPEED = 4.5;
		ScheduleDelayedEvent(CHAT_SPEED, "hailed5");
	}

	void hailed5()
	{
		PlayAnim("critical", ANIM_IDLE);
		EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/but_nevermind_that.wav", 10);
		CHAT_SPEED = 3.8;
		IN_CHAT = 0;
		SayText("...but never mind ye that , I ve got some things  er that ll warm ya right up!");
	}

	void say_rumor()
	{
		if ((IN_CHAT))
		{
			SayText("...Just a second , ask me about that when I m done... Anyways... Where was I? Oh yes...");
			EmitSound(GetOwner(), 2, "voices/ms_snow/forsuth/just_a_second.wav", 10);
		}
		if ((IN_CHAT)) return;
		IN_CHAT = 1;
		say_icequeen_loop();
	}

	void say_icequeen_loop()
	{
		if ((IsValidPlayer("ent_lastspoke")))
		{
			FACE_TARG = "ent_lastspoke";
		}
		ICE_LORD_PLOT_STEP += 1;
		if (ICE_LORD_PLOT_STEP == 1)
		{
			PlayAnim("once", "nod");
			SayText("Well , truth be told , that thing , it s been here longer than I.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/well_truth_be.wav", 10);
			CHAT_SPEED = 4.7;
		}
		if (ICE_LORD_PLOT_STEP == 2)
		{
			SayText("Longer than me folks too , who be long gone , and let it be known that I am a might older than you...");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/older_than_me_folks_too.wav", 10);
			CHAT_SPEED = 6.3;
		}
		if (ICE_LORD_PLOT_STEP == 3)
		{
			SayText("But before that beast s arrival, you had to go quite a bit further north before it got cold.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/before_that_beasts_arrival.wav", 10);
			CHAT_SPEED = 5.1;
		}
		if (ICE_LORD_PLOT_STEP == 4)
		{
			SayText("It s old, so very old, no one remembers its name - and it ain t tellin  neither.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/its_old_so_old.wav", 10);
			CHAT_SPEED = 6.2;
		}
		if (ICE_LORD_PLOT_STEP == 5)
		{
			SayText("Legends been told that it was once a toy of the Loreldians  themselves, the masters of Fate.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/legends_have_been_told.wav", 10);
			CHAT_SPEED = 6.1;
		}
		if (ICE_LORD_PLOT_STEP == 6)
		{
			PlayAnim("once", "nod");
			SayText("Now it plagues the livin  in retribution for its abandonment, or so it s said.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/now_it_plagues.wav", 10);
			CHAT_SPEED = 5.1;
		}
		if (ICE_LORD_PLOT_STEP == 7)
		{
			SayText("We call it the Ice Bone Lord , but truth be told I know not whether it be lord or lady.. or somethin  else.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/we_call_it.wav", 10);
			CHAT_SPEED = 7.5;
		}
		if (ICE_LORD_PLOT_STEP == 8)
		{
			SayText("Best be careful round these parts, lest you find yourselves face to face with it.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/best_be_careful.wav", 10);
			CHAT_SPEED = 4.6;
		}
		if (ICE_LORD_PLOT_STEP == 9)
		{
			SayText("Thar s certainly no helpin runnin into its creations.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/theres_certainly.wav", 10);
			CHAT_SPEED = 3.5;
		}
		if (ICE_LORD_PLOT_STEP == 10)
		{
			SayText("But I shant complain , that s why I keep this shop here...");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/but_i_shant_complain.wav", 10);
			CHAT_SPEED = 3.3;
		}
		if (ICE_LORD_PLOT_STEP == 11)
		{
			PlayAnim("critical", ANIM_IDLE);
			SayText("People need my wares just to survive in these parts!");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/people_need_my.wav", 10);
			CHAT_SPEED = 3.4;
			IN_CHAT = 0;
		}
		if (ICE_LORD_PLOT_STEP < 11)
		{
			CHAT_SPEED("say_icequeen_loop");
		}
		if (ICE_LORD_PLOT_STEP == 11)
		{
			ICE_LORD_PLOT_STEP = 0;
		}
	}

	void say_job()
	{
		if ((IN_CHAT))
		{
			SayText("...Just a second , ask me about that when I m done... Anyways... Where was I? Oh yes...");
			EmitSound(GetOwner(), 2, "voices/ms_snow/forsuth/just_a_second.wav", 10);
		}
		if ((IN_CHAT)) return;
		IN_CHAT = 1;
		say_job_loop();
	}

	void say_job_loop()
	{
		if ((IsValidPlayer("ent_lastspoke")))
		{
			FACE_TARG = "ent_lastspoke";
		}
		JOB_PLOT_STEP += 1;
		if (JOB_PLOT_STEP == 1)
		{
			PlayAnim("once", "nod");
			SayText("Well , thar is one thing ye could do for me.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/well_theres_one.wav", 10);
			CHAT_SPEED = 2.5;
		}
		if (JOB_PLOT_STEP == 2)
		{
			SayText("Out thar , in the colder parts , thar be some orcs. Talnorgah s boys, the [Marogar].");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/out_there_there.wav", 10);
			CHAT_SPEED = 4.2;
		}
		if (JOB_PLOT_STEP == 3)
		{
			SayText("The stronger of em get have these beautiful ice blades.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/the_stronger_ones.wav", 10);
			CHAT_SPEED = 4.0;
		}
		if (JOB_PLOT_STEP == 4)
		{
			SayText("They aren t nuthin too fancy - I can t sell the really good ones...");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/they_aint.wav", 10);
			CHAT_SPEED = 3.4;
		}
		if (JOB_PLOT_STEP == 5)
		{
			SayText("But these orc ish ones - they sell like hotcakes when I visit Deralia, I ll tell ya that.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/but_these_orcish_ones.wav", 10);
			CHAT_SPEED = 5.1;
		}
		if (JOB_PLOT_STEP == 6)
		{
			SayText("Bring some to me , and I ll give you a fair shake for em.");
			PlayAnim("critical", ANIM_IDLE);
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/bring_some_to_me.wav", 10);
			CHAT_SPEED = 3.1;
			IN_CHAT = 0;
		}
		if (JOB_PLOT_STEP < 6)
		{
			CHAT_SPEED("say_job_loop");
		}
		if (JOB_PLOT_STEP == 6)
		{
			JOB_PLOT_STEP = 0;
		}
	}

	void say_orcs()
	{
		if ((IN_CHAT))
		{
			SayText("...Just a second , ask me about that when I m done... Anyways... Where was I? Oh yes...");
			EmitSound(GetOwner(), 2, "voices/ms_snow/forsuth/just_a_second.wav", 10);
		}
		if ((IN_CHAT)) return;
		IN_CHAT = 1;
		say_orc_loop();
	}

	void say_orc_loop()
	{
		if ((IsValidPlayer("ent_lastspoke")))
		{
			FACE_TARG = "ent_lastspoke";
		}
		ORC_STEP += 1;
		if (ORC_STEP == 1)
		{
			PlayAnim("once", "nod");
			SayText("Ya look like ye are from down south , so let me warn ye...");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/you_look_like.wav", 10);
			CHAT_SPEED = 3.2;
		}
		if (ORC_STEP == 2)
		{
			SayText("The orcs here , are not like the orcs where ye come from , these are the Marogar tribe.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/these_orcs_here.wav", 10);
			CHAT_SPEED = 4.9;
		}
		if (ORC_STEP == 3)
		{
			SayText("When Lor Malgoriand setup , it was cold , so these were his first... Not the worst , but still the first.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/when_lor.wav", 10);
			CHAT_SPEED = 6.6;
		}
		if (ORC_STEP == 4)
		{
			SayText("They dun like the heat , and they certainly dun like fire.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/they_dont_like_heat.wav", 10);
			CHAT_SPEED = 3.1;
		}
		if (ORC_STEP == 5)
		{
			SayText("Ya can usually keep em at bay with it.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/you_can_usually.wav", 10);
			CHAT_SPEED = 2.2;
		}
		if (ORC_STEP == 6)
		{
			SayText("Still , they ve got shamans, and some good warriors.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/still_theyve.wav", 10);
			CHAT_SPEED = 3.2;
		}
		if (ORC_STEP == 7)
		{
			SayText("Their chief , Talnorgah , is a beast indeed. Slow , but strong.");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/their_chief_talnorgah.wav", 10);
			CHAT_SPEED = 5.1;
		}
		if (ORC_STEP == 8)
		{
			SayText("Word has it that he s waitin on the return of Lor Malgoriand himself!");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/word_has_it.wav", 10);
			CHAT_SPEED = 4.4;
		}
		if (ORC_STEP == 9)
		{
			SayText("So my advice to you is , if ya see him , keep running!");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/so_my_advice.wav", 10);
			CHAT_SPEED = 4.4;
			PlayAnim("critical", ANIM_IDLE);
			IN_CHAT = 0;
		}
		if (ORC_STEP < 9)
		{
			CHAT_SPEED("say_orc_loop");
		}
		if (ORC_STEP == 9)
		{
			ORC_STEP = 0;
		}
	}

	void lor_lore()
	{
		if ((IN_CHAT))
		{
			SayText("...Just a second , ask me about that when I m done... Anyways... Where was I? Oh yes...");
			EmitSound(GetOwner(), 2, "voices/ms_snow/forsuth/just_a_second.wav", 10);
		}
		if ((IN_CHAT)) return;
		SayText("Hmmm... Already said too much about that. Better to ask a priest , for all I know of gods and demons.");
		EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/ive_already_said.wav", 10);
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (!(false)) return;
		if (!(GetEntityRange(m_hLastSeen) < 200)) return;
		SetMoveDest(m_hLastSeen);
		SetMoveSpeed(1.0);
		CLOSE_SHOP = 1;
		if (!(DID_WARCRY))
		{
			DID_WARCRY = 1;
			SayText("We ll be havin none of that in here!");
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/well_be_having.wav", 10);
		}
		if ((IS_HUNTING)) return;
		if (!(GetEntityRange(param1) > 100)) return;
		HUNT_LASTTARGET = �NONE�;
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		SetMoveSpeed(1.0);
		CLOSE_SHOP = 1;
		SetMoveAnim(ANIM_RUN);
		if (!(IsValidPlayer(m_hLastStruck))) return;
		if (!(DID_PLAYER))
		{
			DID_PLAYER = 1;
			SetRace("hguard");
			SayText("Argh! GetEntityName(m_hLastStruck) !Yer no better than the orcs!");
			HUNT_LASTTARGET = GetEntityIndex(m_hLastStruck);
			EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/gah_youre_no_better.wav", 10);
		}
	}

	void my_target_died()
	{
		if ((false)) return;
		SayText("There now , nice and peaceful again.");
		SetMoveDest(MY_START);
		CLOSE_SHOP = 0;
		EmitSound(GetOwner(), 0, "voices/ms_snow/forsuth/there_now_nice.wav", 10);
	}

	void attack_1()
	{
		EmitSound(GetOwner(), 0, SOUND_SWING, 10);
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY, "slash");
	}

	void vendor_offerstore()
	{
		if ((CLOSE_SHOP)) return;
		if ((IN_CHAT)) return;
		SayText("What can I do ye for?");
		NO_ROTATE = 1;
	}

	void vendor_addstoreitems()
	{
		AddStoreItem(STORE_NAME, "drink_mead", 20, 100, 2.0);
		AddStoreItem(STORE_NAME, "drink_ale", 20, 100, 2.0);
		AddStoreItem(STORE_NAME, "drink_wine", 0, 100, 2.0);
		AddStoreItem(STORE_NAME, "drink_forsuth", 10, 100, 0);
		AddStoreItem(STORE_NAME, "swords_liceblade", 1, 400, 0.5);
		AddStoreItem(STORE_NAME, "swords_iceblade", 0, 150, 0.2);
		AddStoreItem(STORE_NAME, "mana_resist_cold", 5, 150, 0);
		AddStoreItem(STORE_NAME, "mana_immune_cold", 1, 150, 0);
		AddStoreItem(STORE_NAME, "mana_mpotion", 1, 300, 0);
		AddStoreItem(STORE_NAME, "item_crystal_reloc", 5, 300, 0);
		AddStoreItem(STORE_NAME, "item_crystal_return", 10, 300, 0);
		AddStoreItem(STORE_NAME, "health_spotion", 1, 200, 0);
		AddStoreItem(STORE_NAME, "health_mpotion", 1, 200, 0);
		AddStoreItem(STORE_NAME, "scroll2_frost_xolt", 1, 400, 0);
		AddStoreItem(STORE_NAME, "sheath_spellbook", 1, 150, 0);
		AddStoreItem(STORE_NAME, "proj_arrow_fire", 180, 400, 0, 60);
		AddStoreItem(STORE_NAME, "item_torch", 180, 800, 0);
	}

	void trade_success()
	{
		ScheduleDelayedEvent(60.0, "restore_rotate");
	}

	void restore_rotate()
	{
		NO_ROTATE = 0;
	}

	void npcatk_faceattacker()
	{
		if ((IS_FLEEING)) return;
		if (!(IS_HUNTING)) return;
		SetMoveDest(GetEntityIndex(param1));
		LookAt(1024);
	}

}

}
