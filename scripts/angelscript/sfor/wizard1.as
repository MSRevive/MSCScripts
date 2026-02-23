#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Wizard1 : CGameScript
{
	string BEAM_SET;
	int DID_INTRO;
	int DID_WARN;
	int HAS_SYMBOL;
	string MY_CL_IDX;
	string N_PLAYERS;
	int N_SYMBOLS;
	int OMG_WTF;
	float REMOVE_DELAY;
	int UNDI_SPAWN;
	string WIZARD2_ID;
	string WIZARD3_ID;
	string WIZARD4_ID;
	string WIZARD5_ID;

	Wizard1()
	{
		const string CONV_ANIMS = "converse2;converse1;talkleft;talkright;lean;pondering;pondering2;pondering3;";
		const string SYM_QUEST_NAME = "sym1";
		const float CHAT_DELAY = 5.0;
		const float CHAT_DELAY_SHORT = 3.0;
		const float CHAT_DELAY_LONG = 7.0;
		const int NO_RUMOR = 1;
		const int NO_JOB = 1;
		const string SYMB_ITEM = "item_s1";
		const string SOUND_DEATH1 = "scientist/scream1.wav";
		const string SOUND_DEATH2 = "scientist/scream2.wav";
		const string SOUND_DEATH3 = "scientist/scream3.wav";
		const string SOUND_DEATH4 = "scientist/scream4.wav";
	}

	void OnSpawn() override
	{
		SetName("wizard1");
		SetName("Brother Unum");
		SetRace("human");
		SetHealth(60);
		SetModel("npc/balancepriest2.mdl");
		SetWidth(32);
		SetHeight(48);
		SetSayTextRange(1024);
		SetIdleAnim("idle1");
		PlayAnim("once", "idle1");
		SetBlind(true);
		CatchSpeech("say_hi", "Hail");
		N_SYMBOLS = 0;
		BEAM_SET = "";
		ScheduleDelayedEvent(4.0, "scan_for_players");
		ScheduleDelayedEvent(3.0, "gather_wizard_ids");
	}

	void gather_wizard_ids()
	{
		WIZARD2_ID = FindEntityByName("wizard2");
		WIZARD3_ID = FindEntityByName("wizard3");
		WIZARD4_ID = FindEntityByName("wizard4");
		WIZARD5_ID = FindEntityByName("wizard5");
		ScheduleDelayedEvent(0.1, "init_beams");
	}

	void scan_for_players()
	{
		if ((DID_INTRO)) return;
		ScheduleDelayedEvent(1.0, "scan_for_players");
		string T_BOX = /* TODO: $get_tbox */ $get_tbox("player", 512);
		if (!(T_BOX != "none")) return;
		string T_BOX = /* TODO: $sort_entlist */ $sort_entlist(T_BOX, "range");
		string TARG_ID = GetToken(T_BOX, 0, ";");
		string TARG_ORG = GetEntityOrigin(TARG_ID);
		string TARG_TRACE = TraceLine(GetMonsterProperty("origin"), TARG_ORG);
		if (!(TARG_TRACE == TARG_ORG)) return;
		DID_INTRO = 1;
		do_intro();
	}

	void do_intro()
	{
		if (!(DID_INTRO < 2)) return;
		DID_INTRO = 2;
		N_PLAYERS = GetPlayerCount();
		if (N_PLAYERS > 1)
		{
			SayText("By the... How d they d get in here?");
		}
		else
		{
			SayText("By the beard of Urdual... How d he get in here?");
		}
		convo_anim();
		CHAT_DELAY("do_intro2");
	}

	void do_intro2()
	{
		if ((OMG_WTF)) return;
		CallExternal(WIZARD2_ID, "anim_text", "I warned you the seals were failing.");
		CHAT_DELAY_SHORT("do_intro3");
	}

	void do_intro3()
	{
		if ((OMG_WTF)) return;
		SayText("Brother Tress, did not you destroy the bridge?");
		convo_anim();
		CHAT_DELAY_SHORT("do_intro4");
	}

	void do_intro4()
	{
		if ((OMG_WTF)) return;
		CallExternal(WIZARD3_ID, "anim_text", "Yes, but that alone would hardly stop an intrepid explorer who could brave The Dark Forest.");
		CHAT_DELAY("do_intro5");
	}

	void do_intro5()
	{
		if ((OMG_WTF)) return;
		SayText("...then what of the door?");
		convo_anim();
		CHAT_DELAY_SHORT("do_intro6");
	}

	void do_intro6()
	{
		if ((OMG_WTF)) return;
		CallExternal(WIZARD4_ID, "anim_text", "May I remind you, brother Unum, we've been here, maintaining this seal, for over two hundred years now?");
		CHAT_DELAY("do_intro7");
	}

	void do_intro7()
	{
		if ((OMG_WTF)) return;
		CallExternal(WIZARD5_ID, "anim_text", "Yes, between the negative energy of the forest, and the rust... I'd surprised if it were still there.");
		CHAT_DELAY("do_intro8");
	}

	void do_intro8()
	{
		if ((OMG_WTF)) return;
		if (N_PLAYERS > 1)
		{
			SayText("Well , none of them appear to be our apprentices. Perhaps they bring news?");
		}
		else
		{
			SayText("Well , he doesn t appear to be one of our apprentices. Perhaps he brings news?");
		}
		convo_anim();
	}

	void say_hi()
	{
		OMG_WTF = 0;
		if ((UNDI_SPAWN)) return;
		SayText("Umm... Hello young lad. We five wizards are The Bretheren of Zahlon.");
		convo_anim();
		CHAT_DELAY("say_hi2");
		CallExternal("players", "ext_set_fquest");
	}

	void say_hi2()
	{
		if ((OMG_WTF)) return;
		SayText("This chamber was once the meeting place of Undamael and his minions.");
		convo_anim();
		CHAT_DELAY("say_hi3");
	}

	void say_hi3()
	{
		if ((OMG_WTF)) return;
		SayText("It was an arena of sorts , where Undamael would judge enemies which his forces had captured.");
		convo_anim();
		CHAT_DELAY("say_hi4");
	}

	void say_hi4()
	{
		if ((OMG_WTF)) return;
		CallExternal(WIZARD4_ID, "anim_text", "You mean where he would EAT them, as his minions looked on.");
		CHAT_DELAY("say_hi5");
	}

	void say_hi5()
	{
		if ((OMG_WTF)) return;
		SayText("Umm , yes , quite , brother Quatra. *cough* In anycase , while the armies of elvenkind were combatting Lor Malgoriand s forces outside...");
		convo_anim();
		CHAT_DELAY_LONG("say_hi6");
	}

	void say_hi6()
	{
		if ((OMG_WTF)) return;
		CallExternal(WIZARD3_ID, "anim_text", "We were here, sealing Undamael, the right hand of Lor Malgoriand, in his pit.");
		CHAT_DELAY("say_hi7");
	}

	void say_hi7()
	{
		if ((OMG_WTF)) return;
		CallExternal(WIZARD2_ID, "anim_text", "Unfortunately, we could only seal him, not defeat him, with what power we have.");
		CHAT_DELAY("say_hi8");
	}

	void say_hi8()
	{
		if ((OMG_WTF)) return;
		CallExternal(WIZARD5_ID, "anim_text", "Even then, we cannot hold him forever.");
		CHAT_DELAY_SHORT("say_hi9");
	}

	void say_hi9()
	{
		if ((OMG_WTF)) return;
		CallExternal(WIZARD4_ID, "anim_text", "You see, our apprentices were supposed to bring us five symbols of power, forged by the Felewyn priestesses.");
		CHAT_DELAY_LONG("say_hi10");
	}

	void say_hi10()
	{
		if ((OMG_WTF)) return;
		SayText("Sadly, we can only assume our apprentices were slain during the war.");
		convo_anim();
		CHAT_DELAY("say_hi11");
	}

	void say_hi11()
	{
		if ((OMG_WTF)) return;
		CallExternal(WIZARD3_ID, "anim_text", "In which case, the symbols would now be in the hands of the remains of Lor Malgoriand's armies.");
		CHAT_DELAY_LONG("say_hi12");
	}

	void say_hi12()
	{
		if ((OMG_WTF)) return;
		if (GetPlayerCount() > 1)
		{
			SayText("You seem strong warriors. If you could bring us those symbols, we could put an end to Lord Undamael's evil once and for all.");
		}
		if (GetPlayerCount() == 1)
		{
			SayText("You seem a strong warrior. If you could bring us those symbols, we could put an end to Lord Undamael's evil once and for all.");
		}
		convo_anim();
		CHAT_DELAY_LONG("say_hi13");
	}

	void say_hi13()
	{
		if ((OMG_WTF)) return;
		SayText("Even weakened by the power of the symbols, Lord Undamael will still be a force to be feared.");
		convo_anim();
		CHAT_DELAY("say_hi14");
	}

	void say_hi14()
	{
		if ((OMG_WTF)) return;
		CallExternal(WIZARD5_ID, "anim_text", "Indeed, it will take the most powerful warriors in the land to defeat him, even in his weakened state.");
		CHAT_DELAY_LONG("say_hi15");
	}

	void say_hi15()
	{
		if ((OMG_WTF)) return;
		SayText("Please, go forth and seek - return to us the symbols of Felewyn and bring great warriors, that we may bring an end to this evil!");
		convo_anim();
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((UNDI_SPAWN)) return;
		OMG_WTF = 1;
		if ((DID_WARN)) return;
		DID_WARN = 1;
		SayText("What sort of maniac are you!? If any one of us dies Undamael will be freed!");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// PlayRandomSound from: SOUND_DEATH1, SOUND_DEATH2, SOUND_DEATH3, SOUND_DEATH4
		array<string> sounds = {SOUND_DEATH1, SOUND_DEATH2, SOUND_DEATH3, SOUND_DEATH4};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if ((UNDI_SPAWN)) return;
		UseTrigger("mm_undi_spawn");
		UNDI_SPAWN = 1;
		REMOVE_DELAY = 0.5;
		remove_beams();
		CallExternal(WIZARD2_ID, "do_oshi");
		CallExternal(WIZARD3_ID, "do_oshi");
		CallExternal(WIZARD4_ID, "do_oshi");
		CallExternal(WIZARD5_ID, "do_oshi");
		SetIdleAnim("crouch_idle");
		PlayAnim("once", "crouch_idle");
	}

	void wizard_died()
	{
		if ((UNDI_SPAWN)) return;
		UseTrigger("mm_undi_spawn");
		UNDI_SPAWN = 1;
		REMOVE_DELAY = 0.5;
		remove_beams();
		CallExternal(WIZARD2_ID, "do_oshi");
		CallExternal(WIZARD3_ID, "do_oshi");
		CallExternal(WIZARD4_ID, "do_oshi");
		CallExternal(WIZARD5_ID, "do_oshi");
		SetIdleAnim("crouch_idle");
		PlayAnim("once", "crouch_idle");
	}

	void game_menu_getoptions()
	{
		if ((HAS_SYMBOL)) return;
		if (!(/* TODO: $get_scriptflag */ $get_scriptflag(param1, "fwarn", "type_exists")))
		{
			SetScriptFlags(param1, "add", "fwarn", "fwarn");
			ShowHelpTip(param1, "generic", "One Time Quest", "The Felwyn Shard quest can only be completed one time per character.");
		}
		if ((ItemExists(param1, SYMB_ITEM)))
		{
			string reg.mitem.title = "Offer the first symbol";
			string reg.mitem.type = "payment";
			string reg.mitem.data = SYMB_ITEM;
			string reg.mitem.callback = "add_symbol_me";
		}
		else
		{
			string reg.mitem.title = "Offer the first symbol";
			string reg.mitem.type = "disabled";
			string reg.mitem.callback = "none";
		}
	}

	void add_symbol_me()
	{
		SayText("Thank you. Remember we ll need all five at the same time.");
		HAS_SYMBOL = 1;
		add_symbol();
		SetIdleAnim("kneel_idle");
		SetMoveAnim("kneel_idle");
		PlayAnim("critical", "kneel");
	}

	void add_symbol()
	{
		N_SYMBOLS += 1;
		if (!(N_SYMBOLS == 5)) return;
		start_spell();
	}

	void init_beams()
	{
		Effect("beam", "ents", "lgtning.spr", 100, GetEntityIndex(GetOwner()), 1, WIZARD3_ID, 1, Vector3(255, 0, 0), 200, 10, -1);
		if (BEAM_SET.length() > 0) BEAM_SET += ";";
		BEAM_SET += GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(0.5, "init_beam2");
	}

	void init_beam2()
	{
		Effect("beam", "ents", "lgtning.spr", 100, WIZARD3_ID, 1, WIZARD5_ID, 1, Vector3(255, 0, 0), 200, 10, -1);
		if (BEAM_SET.length() > 0) BEAM_SET += ";";
		BEAM_SET += GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(0.5, "init_beam3");
	}

	void init_beam3()
	{
		Effect("beam", "ents", "lgtning.spr", 100, WIZARD5_ID, 1, WIZARD2_ID, 1, Vector3(255, 0, 0), 200, 10, -1);
		if (BEAM_SET.length() > 0) BEAM_SET += ";";
		BEAM_SET += GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(0.5, "init_beam4");
	}

	void init_beam4()
	{
		Effect("beam", "ents", "lgtning.spr", 100, WIZARD2_ID, 1, WIZARD4_ID, 1, Vector3(255, 0, 0), 200, 10, -1);
		if (BEAM_SET.length() > 0) BEAM_SET += ";";
		BEAM_SET += GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(0.5, "init_beam5");
	}

	void init_beam5()
	{
		Effect("beam", "ents", "lgtning.spr", 100, WIZARD4_ID, 0, GetEntityIndex(GetOwner()), 1, Vector3(255, 0, 0), 200, 10, -1);
		if (BEAM_SET.length() > 0) BEAM_SET += ";";
		BEAM_SET += GetEntityIndex(m_hLastCreated);
	}

	void remove_beams()
	{
		for (int i = 0; i < GetTokenCount(BEAM_SET, ";"); i++)
		{
			remove_beams_loop();
		}
	}

	void remove_beams_loop()
	{
		Effect("beam", "update", GetToken(BEAM_SET, i, ";"), "remove", REMOVE_DELAY);
	}

	void start_spell()
	{
		MY_CL_IDX = "game.script.last_sent_id";
		SetGlobalVar("G_UNDAMAEL_VULNERABLE", 1);
		ScheduleDelayedEvent(0.1, "color_beams");
		UNDI_SPAWN = 1;
		ScheduleDelayedEvent(1.0, "splodie_fx");
		UseTrigger("mm_undi_fx");
	}

	void color_beams()
	{
		for (int i = 0; i < GetTokenCount(BEAM_SET, ";"); i++)
		{
			color_beams_loop();
		}
	}

	void color_beams_loop()
	{
		Effect("beam", "update", GetToken(BEAM_SET, i, ";"), "color", Vector3(0, 255, 0));
		Effect("beam", "update", GetToken(BEAM_SET, i, ";"), "remove", 10.0);
	}

	void splodie_fx()
	{
		UseTrigger("mm_undi_spawn");
		ScheduleDelayedEvent(0.1, "remove_us");
	}

	void remove_us()
	{
		CallExternal(WIZARD2_ID, "fade_away");
		CallExternal(WIZARD3_ID, "fade_away");
		CallExternal(WIZARD4_ID, "fade_away");
		CallExternal(WIZARD5_ID, "fade_away");
		SayText("That s the last of our power - it is up to you to defeat him now. Aim for the horn atop his head! That s his weak point!");
		ScheduleDelayedEvent(0.1, "fade_away");
	}

	void fade_away()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
