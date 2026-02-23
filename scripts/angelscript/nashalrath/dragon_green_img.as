#pragma context server

#include "monsters/base_chat_array.as"
#include "monsters/debug.as"

namespace MS
{

class DragonGreenImg : CGameScript
{
	int AM_BREATHING;
	int AM_LIFTING;
	string ANIM_IDLE;
	string ASPECT_ID;
	string ATK_POINTS;
	int BATTLE_ACTIVE;
	int BREATH_CYCLE;
	string BUSY_TALKING;
	string CHAT_CURRENT_SPEAKER;
	string CL_BREATH_IDX;
	string CL_STORM_IDX;
	int CURRENT_NECK_ANG;
	int DEST_NECK_ANG;
	string DG_PULSE_COUNT;
	int DG_PULSE_DIR;
	int DG_PULSE_LOOP;
	int DID_INTRO;
	string DID_MINIONS;
	int FADE_COUNT;
	string FLICKER_BRUSH_ID;
	string FLICKER_BRUSH_ON;
	string FLICKER_COUNT;
	int GLOAT_COUNT;
	string HALF_ASPECT_HEALTH;
	int HAZARD_STRUCK;
	int HEAD_FOLLOW;
	string HEAD_TARGET;
	string HEAD_TRACKING;
	int LIFT_COUNT;
	string LIGHTNING_FLICKERING;
	string NEXT_BALLS;
	string NEXT_BOLTS;
	string NEXT_BREATH;
	string NEXT_LIFT_CHECK;
	string NEXT_PULSE;
	string NEXT_WING_BEAT;
	string PILLAR_CHECK_ID;
	string PILLAR_NAME;
	string PLAYER_LIST;
	int PLAYING_DEAD;
	string RACE_TEXT;
	string RACE_VOICE;
	string STORM_BRUSH_ID;
	int STORM_ON;

	DragonGreenImg()
	{
		ANIM_IDLE = "anim_img_idle2";
		const string ANIM_IDLE_LOOK = "anim_img_idle2_look";
		const string ANIM_TALK = "anim_img_idle2_talk";
		const string ANIM_LEAVE = "anim_img_flyout";
		const string ANIM_LIFT_LEFT = "anim_img_lift_left";
		const string ANIM_LIFT_RIGHT = "anim_img_lift_right";
		const string ANIM_BREATH_STORM = "anim_img_breath_storm";
		const string ANIM_SUMMON = "anim_img_idle2_look";
		const string ANIM_LAUGH = "anim_img_idle2_talk";
		const string ANIM_LAUGH_CONVO = "anim_img_idle2_talk";
		const string ANIM_CONVO1 = "anim_img_idle2_talk";
		const string ANIM_CONVO2 = "anim_img_idle2_look";
		const float ATTN_VOICE = 0.01;
		const int PITCH_VOICE = 50;
		const int CHAT_MOVE_MOUTH = 0;
		const int CHAT_AUTO_FACE = 0;
		const int CHAT_FACE_ON_USE = 0;
		const int CHAT_MENU_ENABLE = 0;
		const string CHAT_PLAYANIM_STYLE = "once";
		const Vector3 STORM_CENTER = Vector3(2496, -2608, -2024);
		const int STORM_RAD = 768;
		const float FREQ_BREATH = 120.0;
		const float DUR_STORM = 60.0;
		const string FREQ_BOLTS = Random(3.0, 7.0);
		const string FREQ_BALLS = Random(5.0, 10.0);
		const string DMG_ICE_SHARD = RandomInt(100, 200);
		const int DOT_COLD = 50;
		const string DMG_LIGHTNING_STRIKE = RandomInt(400, 800);
		const int DOT_LIGHTNING = 150;
		ATK_POINTS = "";
		const int DOT_FIRE = 100;
		const int DMG_METEOR = 800;
		const int NECK_MAX_ANG = 30;
		const int NECK_MIN_ANG = -30;
		DEST_NECK_ANG = 0;
		CURRENT_NECK_ANG = 0;
		const string SOUND_BREATH_IN = "magic/spookie1.wav";
		const string SOUND_BREATH_OUT = "monsters/goblin/sps_fogfire.wav";
		Precache("weather/Storm_exclamation.wav");
		const int DG_BASE_RENDERAMT = 100;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		if ((HEAD_FOLLOW))
		{
		}
		if (!(IsEntityAlive(HEAD_TARGET)))
		{
			SetProp(GetOwner(), "controller0", 0);
			SetProp(GetOwner(), "controller1", 0);
			int EXIT_SUB = 1;
		}
		if (!(EXIT_SUB))
		{
		}
		if (!(IsEntityAlive(HEAD_TARGET)))
		{
			DEST_NECK_ANG = 0;
			if (!(HEAD_TRACKING))
			{
			}
			HEAD_TRACKING = 1;
			head_track();
		}
		if ((IsEntityAlive(HEAD_TARGET)))
		{
		}
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_RANGE = GetEntityRange(HEAD_TARGET);
		if (TARG_RANGE > 128)
		{
			string TARG_ORG = GetEntityOrigin(HEAD_TARGET);
			string ANG_TO_TARG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
			ANG_TO_TARG *= 0.25;
			string ANG_TO_TARG = /* TODO: $neg */ $neg(ANG_TO_TARG);
			DEST_NECK_ANG = ANG_TO_TARG;
		}
		else
		{
			DEST_NECK_ANG = 0;
		}
		if (DEST_NECK_ANG > NECK_MAX_ANG)
		{
			DEST_NECK_ANG = NECK_MAX_ANG;
		}
		if (DEST_NECK_ANG < NECK_MIN_ANG)
		{
			DEST_NECK_ANG = NECK_MIN_ANG;
		}
		if (!(HEAD_TRACKING))
		{
			string DEST_ANG_P = DEST_NECK_ANG;
			string DEST_ANG_M = DEST_NECK_ANG;
			DEST_ANG_P += 2;
			DEST_ANG_M -= 2;
			int L_CLOSE = 0;
			if (CURRENT_NECK_ANG < DEST_ANG_P)
			{
				int L_CLOSE = 1;
			}
			if (CURRENT_NECK_ANG > DEST_ANG_M)
			{
				L_CLOSE += 1;
			}
			if (L_CLOSE == 2)
			{
				HEAD_TRACKING = 0;
			}
			else
			{
				HEAD_TRACKING = 1;
				head_track();
			}
		}
		if (GetGameTime() > NEXT_PULSE)
		{
			NEXT_PULSE = GetGameTime();
			NEXT_PULSE += Random(30.0, 60.0);
			do_pulse();
		}
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_hide1.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_hide1.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_hide2.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_hide2.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_hide3.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_hide3.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_intro01.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_intro01.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_intro02.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_intro02.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_intro03.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_intro03.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_intro04.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_intro04.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_laugh1.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_laugh1.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_laugh2.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_laugh2.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_minions01.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_minions01.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_minions02.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_minions02.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_minions03.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_minions03.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_player_human.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_player_human.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_player_multirace.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_player_multirace.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_players_human.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_players_human.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_win01.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_win01.wav");
		// svplaysound: svplaysound 1 0 voices/dragons/Jaminporlants_win02.wav
		EmitSound(1, 0, "voices/dragons/Jaminporlants_win02.wav");
	}

	void OnSpawn() override
	{
		SetName("Jaminporlants");
		SetModel("monsters/dragon_green_img.mdl");
		SetName("gdragon_img");
		SetRace("demon");
		SetHealth(99999);
		SetInvincible(true);
		PLAYING_DEAD = 1;
		SetNoPush(true);
		SetWidth(1);
		SetHeight(1);
		SetFly(true);
		SetGravity(0);
		SetProp(GetOwner(), "movetype", 0);
		SetSayTextRange(2048);
		ScheduleDelayedEvent(0.1, "scan_for_players");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", DG_BASE_RENDERAMT);
	}

	void scan_for_players()
	{
		if ((DID_INTRO)) return;
		PLAYER_LIST = "";
		GetAllPlayers(PLAYER_LIST);
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			check_players();
		}
		if ((DID_INTRO)) return;
		ScheduleDelayedEvent(1.0, "scan_for_players");
	}

	void check_players()
	{
		string CUR_TARG = GetToken(PLAYER_LIST, i, ";");
		if ((DID_INTRO)) return;
		if (!(GetEntityRange(CUR_TARG) < 768)) return;
		DID_INTRO = 1;
		CHAT_CURRENT_SPEAKER = CUR_TARG;
		ScheduleDelayedEvent(1.0, "do_intro");
	}

	void do_intro()
	{
		FLICKER_BRUSH_ID = FindEntityByName("brush_storm_lightning2");
		GLOAT_COUNT = 0;
		if ((L_RACE_MULTI))
		{
			RACE_VOICE = "voices/dragons/Jaminporlants_player_multirace.wav";
			RACE_TEXT = "Children of the Triad...?";
		}
		else
		{
			if (GetPlayerCount() > 1)
			{
				RACE_VOICE = "voices/dragons/Jaminporlants_players_human.wav";
				RACE_TEXT = "Children of Torkalath...?";
			}
			else
			{
				if (GetPlayerCount() == 1)
				{
					RACE_VOICE = "voices/dragons/Jaminporlants_player_human.wav";
					RACE_TEXT = "A child of Torkalath...?";
				}
			}
		}
		CallExternal("players", "ext_svplaysound_kiss", 2, 10, RACE_VOICE, 0.8, 100);
		SetIdleAnim(ANIM_CONVO1);
		chat_now(RACE_TEXT, 2.6, ANIM_IDLE_LOOK, "do_intro2", "add_to_que");
	}

	void do_intro2()
	{
		HEAD_TARGET = CHAT_CURRENT_SPEAKER;
		HEAD_FOLLOW = 1;
		CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_intro01.wav", ATTN_VOICE, PITCH_VOICE);
		chat_now("Creatures forged by, single, pitiful gods... Dare to seek out me?", 7.9, ANIM_CONVO1, "none", "add_to_que");
		chat_now("...a being who was forged at the dawn of time by thousands of gods!?", 6.91, ANIM_CONVO1, "do_intro3", "add_to_que");
	}

	void do_intro3()
	{
		CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_intro02.wav", ATTN_VOICE, PITCH_VOICE);
		chat_now("...but I'm afraid your efforts, are in vain.", 3.86, ANIM_CONVO2, "do_intro4", "add_to_que");
	}

	void do_intro4()
	{
		CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_intro03.wav", ATTN_VOICE, PITCH_VOICE);
		chat_now("I have long since moved on from this place...", 4.10, ANIM_CONVO1, "none", "add_to_que");
		chat_now("...And have merely left this image here to 'entertain' belated guests.", 6.2, ANIM_CONVO1, "do_intro5", "add_to_que");
	}

	void do_intro5()
	{
		CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_intro04.wav", ATTN_VOICE, PITCH_VOICE);
		chat_now("But fear not... It is not all I have left behind... ", 5.23, ANIM_CONVO1, "none", "add_to_que");
		chat_now("Behold...", 2.2, "none", "none", "add_to_que");
		ScheduleDelayedEvent(4.5, "do_intro6");
	}

	void do_intro6()
	{
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("critical", ANIM_SUMMON);
		ScheduleDelayedEvent(1.0, "start_battle");
		ScheduleDelayedEvent(3.0, "ext_gloat");
	}

	void head_track()
	{
		if (!(HEAD_FOLLOW)) return;
		if (!(HEAD_TRACKING)) return;
		if (CURRENT_NECK_ANG < DEST_NECK_ANG)
		{
			CURRENT_NECK_ANG += 1;
		}
		if (CURRENT_NECK_ANG > DEST_NECK_ANG)
		{
			CURRENT_NECK_ANG -= 1;
		}
		string DEST_ANG_P = DEST_NECK_ANG;
		string DEST_ANG_M = DEST_NECK_ANG;
		DEST_ANG_P += 2;
		DEST_ANG_M -= 2;
		int L_CLOSE = 0;
		if (CURRENT_NECK_ANG < DEST_ANG_P)
		{
			int L_CLOSE = 1;
		}
		if (CURRENT_NECK_ANG > DEST_ANG_M)
		{
			L_CLOSE += 1;
		}
		if (L_CLOSE == 2)
		{
			HEAD_TRACKING = 0;
		}
		SetProp(GetOwner(), "controller0", CURRENT_NECK_ANG);
		if (!(HEAD_TRACKING)) return;
		if (!(IsEntityAlive(HEAD_TARGET)))
		{
			int L_HEAD_ADJ = 0;
		}
		else
		{
			string MY_ORG = GetEntityOrigin(GetOwner());
			string TARG_RANGE = GetEntityRange(HEAD_TARGET);
			string L_RANGE_RATIO = TARG_RANGE;
			L_RANGE_RATIO /= 1000;
			string L_HEAD_ADJ = /* TODO: $ratio */ $ratio(L_RANGE_RATIO, -10, 18);
		}
		SetProp(GetOwner(), "controller1", L_HEAD_ADJ);
		ScheduleDelayedEvent(0.01, "head_track");
	}

	void suspend_head_tracking()
	{
		SetProp(GetOwner(), "controller0", 0);
		SetProp(GetOwner(), "controller1", 0);
		HEAD_TRACKING = 0;
		HEAD_FOLLOW = 0;
		DEST_NECK_ANG = 0;
		CURRENT_NECK_ANG = 0;
	}

	void resume_head_tracking()
	{
		HEAD_FOLLOW = 1;
	}

	void start_battle()
	{
		UseTrigger("spawn_dragon");
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += FREQ_BREATH;
		NEXT_LIFT_CHECK = GetGameTime();
		NEXT_LIFT_CHECK += 20.0;
		BATTLE_ACTIVE = 1;
		BREATH_CYCLE = 0;
		LIFT_COUNT = 0;
		battle_loop();
	}

	void battle_loop()
	{
		if (!(BATTLE_ACTIVE)) return;
		ScheduleDelayedEvent(1.0, "battle_loop");
		if (!(IsEntityAlive(ASPECT_ID)))
		{
			ASPECT_ID = FindEntityByName("gdragon_aspect");
			if ((IsEntityAlive(ASPECT_ID)))
			{
			}
			HALF_ASPECT_HEALTH = GetEntityMaxHealth(ASPECT_ID);
			HALF_ASPECT_HEALTH *= 0.5;
		}
		else
		{
			HEAD_TARGET = GetEntityProperty(ASPECT_ID, "scriptvar");
			if (!(IsEntityAlive(HEAD_TARGET)))
			{
				HEAD_TARGET = ASPECT_ID;
			}
		}
		if (GetEntityHealth(ASPECT_ID) < HALF_ASPECT_HEALTH)
		{
			if (!(DID_MINIONS))
			{
			}
			DID_MINIONS = 1;
			BUSY_TALKING = 1;
			do_minions();
		}
		if ((STORM_ON))
		{
			if (BREATH_CYCLE == 1)
			{
				if (GetGameTime() > NEXT_BALLS)
				{
				}
				NEXT_BALLS = GetGameTime();
				NEXT_BALLS += FREQ_BALLS;
				drop_meteor();
				if (RandomInt(1, 2) == 1)
				{
				}
				Random(0_5, 2_0)("drop_meteor");
				if (RandomInt(1, 4) < 4)
				{
				}
				Random(2_1, 4_0)("drop_meteor");
			}
			if (BREATH_CYCLE == 2)
			{
				if (GetGameTime() > NEXT_BOLTS)
				{
				}
				NEXT_BOLTS = GetGameTime();
				NEXT_BOLTS += FREQ_BOLTS;
				do_lightning_bolt();
				if (RandomInt(1, 2) == 1)
				{
				}
				Random(0_5, 2_0)("do_lightning_bolt");
			}
			if (BREATH_CYCLE == 3)
			{
				if (GetGameTime() > NEXT_BALLS)
				{
				}
				NEXT_BALLS = GetGameTime();
				NEXT_BALLS += FREQ_BALLS;
				do_ice_bolt();
				if (RandomInt(1, 2) == 1)
				{
				}
				Random(0_5, 2_0)("do_ice_bolt");
			}
		}
		if (GetGameTime() > NEXT_BREATH)
		{
			if (!(AM_BREATHING))
			{
			}
			if ((BUSY_TALKING))
			{
				int EXIT_SUB = 1;
				NEXT_BREATH = GetGameTime();
				NEXT_BREATH += 20.0;
			}
			if ((AM_LIFTING))
			{
				int EXIT_SUB = 1;
				NEXT_BREATH = GetGameTime();
				NEXT_BREATH += 10.0;
			}
			if (!(EXIT_SUB))
			{
			}
			do_breath();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetGameTime() > NEXT_LIFT_CHECK)
		{
			if (!(AM_LIFTING))
			{
			}
			NEXT_LIFT_CHECK = GetGameTime();
			NEXT_LIFT_CHECK += 20.0;
			if ((BUSY_TALKING))
			{
				int EXIT_SUB = 1;
				NEXT_LIFT = GetGameTime();
				NEXT_LIFT += 20.0;
			}
			if (!(EXIT_SUB))
			{
			}
			if ((AM_BREATHING))
			{
				int EXIT_SUB = 1;
				NEXT_LIFT = GetGameTime();
				NEXT_LIFT += 20.0;
			}
			if (!(EXIT_SUB))
			{
			}
			string PILLAR_ID = FindEntityByName("lift_pillar_left");
			CallExternal(PILLAR_ID, "ext_check_targets");
			if (GetEntityProperty(PILLAR_ID, "scriptvar") != "none")
			{
				do_lift("left", PILLAR_ID);
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			string PILLAR_ID = FindEntityByName("lift_pillar_right");
			CallExternal(PILLAR_ID, "ext_check_targets");
			if (GetEntityProperty(PILLAR_ID, "scriptvar") != "none")
			{
				do_lift("right", PILLAR_ID);
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
		}
	}

	void ext_breath_now()
	{
		NEXT_BREATH = 0;
	}

	void ext_lift_now()
	{
		NEXT_LIFT_CHECK = 0;
	}

	void do_lift()
	{
		NEXT_LIFT_CHECK = GetGameTime();
		NEXT_LIFT_CHECK += 60.0;
		PILLAR_NAME = param1;
		PILLAR_CHECK_ID = param2;
		string L_ANIM_NAME = "anim_img_lift_";
		L_ANIM_NAME += PILLAR_NAME;
		PlayAnim("critical", L_ANIM_NAME);
		suspend_head_tracking();
		LogDebug("do_lift anim L_ANIM_NAME");
		LIFT_COUNT += 1;
		AM_LIFTING = 1;
		if (LIFT_COUNT == 1)
		{
			chat_now("Hiding already?", 3.0, "none", "none", "add_to_que");
			CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_hide1.wav", ATTN_VOICE, PITCH_VOICE);
		}
		else
		{
			if (LIFT_COUNT == 2)
			{
				chat_now("What are you doing over there? ...Trying to hide?", 3.0, "none", "none", "add_to_que");
				CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_hide2.wav", ATTN_VOICE, PITCH_VOICE);
			}
			else
			{
				if (LIFT_COUNT == 3)
				{
					chat_now("Hiding again, I see...", 3.0, "none", "none", "add_to_que");
					CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_hide3.wav", ATTN_VOICE, PITCH_VOICE);
					LIFT_COUNT = 0;
				}
			}
		}
	}

	void frame_lift()
	{
		string L_TRIGGER_NAME = "door_lift_";
		L_TRIGGER_NAME += PILLAR_NAME;
		UseTrigger(L_TRIGGER_NAME);
		CallExternal(PILLAR_CHECK_ID, "ext_do_shake");
	}

	void frame_release()
	{
		ScheduleDelayedEvent(2.0, "resume_head_tracking");
		AM_LIFTING = 0;
		string L_TRIGGER_NAME = "door_lift_";
		L_TRIGGER_NAME += PILLAR_NAME;
		UseTrigger(L_TRIGGER_NAME);
		CallExternal(PILLAR_CHECK_ID, "ext_do_boom");
		NEXT_LIFT_CHECK = GetGameTime();
		NEXT_LIFT_CHECK += 30.0;
	}

	void do_breath()
	{
		suspend_head_tracking();
		AM_BREATHING = 1;
		BREATH_CYCLE += 1;
		if (BREATH_CYCLE > 3)
		{
			BREATH_CYCLE = 1;
		}
		PlayAnim("critical", ANIM_BREATH_STORM);
	}

	void frame_storm_prep()
	{
		EmitSound(GetOwner(), 0, SOUND_BREATH_IN, 10);
	}

	void frame_storm_breath_start()
	{
		EmitSound(GetOwner(), 0, SOUND_BREATH_OUT, 10);
		ClientEvent("new", "all", "nashalrath/dragon_green_img_cl", GetEntityIndex(GetOwner()), BREATH_CYCLE);
		CL_BREATH_IDX = "game.script.last_sent_id";
		ScheduleDelayedEvent(2.0, "setup_storm");
	}

	void frame_storm_breath_stop()
	{
		ClientEvent("update", "all", CL_BREATH_IDX, "ext_breath_stop");
	}

	void frame_storm_breath_done()
	{
		AM_BREATHING = 0;
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += FREQ_BREATH;
		resume_head_tracking();
	}

	void setup_storm()
	{
		STORM_ON = 1;
		if (BREATH_CYCLE == 1)
		{
			UseTrigger("light_storm_fire");
			CallExternal(GAME_MASTER, "gm_set_weather", "fog_dragon_red", 1);
			STORM_BRUSH_ID = FindEntityByName("brush_storm_fire");
			NEXT_BALLS = GetGameTime();
			NEXT_BALLS += FREQ_BALLS;
		}
		if (BREATH_CYCLE == 2)
		{
			CallExternal(GAME_MASTER, "gm_set_weather", "fog_dragon_black", 1);
			STORM_BRUSH_ID = FindEntityByName("brush_storm_lightning1");
			NEXT_BOLTS = GetGameTime();
			NEXT_BOLTS += FREQ_BOLTS;
		}
		if (BREATH_CYCLE == 3)
		{
			UseTrigger("light_storm_cold");
			CallExternal(GAME_MASTER, "gm_set_weather", "fog_dragon_white", 1);
			STORM_BRUSH_ID = FindEntityByName("brush_storm_cold");
			ClientEvent("new", "all", "nashalrath/dragon_ice_storm_cl", STORM_CENTER);
			CL_STORM_IDX = "game.script.last_sent_id";
		}
		CallExternal(STORM_BRUSH_ID, "storm_fade_in");
		DUR_STORM("end_storm");
	}

	void end_storm()
	{
		if (!(STORM_ON)) return;
		STORM_ON = 0;
		SetGlobalVar("G_WEATHER_LOCK", 0);
		SetGlobalVar("G_CURRENT_WEATHER", "clear");
		CallExternal(GAME_MASTER, "gm_start_weather", "clear");
		CallExternal(STORM_BRUSH_ID, "storm_fade_out");
		if (BREATH_CYCLE == 1)
		{
			UseTrigger("light_storm_fire");
		}
		if (BREATH_CYCLE == 3)
		{
			UseTrigger("light_storm_cold");
			ClientEvent("update", "all", CL_STORM_IDX, "end_fx");
		}
	}

	void do_lightning_bolt()
	{
		if (!(LIGHTNING_FLICKERING))
		{
			LIGHTNING_FLICKERING = 1;
			FLICKER_COUNT = 0;
			lightning_flicker();
			ScheduleDelayedEvent(5.0, "lightning_flicker_end");
		}
		string L_POS = STORM_CENTER;
		string RND_ANG = Random(0, 359.99);
		string RND_DIST = Random(0, STORM_RAD);
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, RND_DIST, 0));
		string L_GROUND = L_POS;
		L_GROUND = "z";
		int L_STRIKE_TIME = 0;
		if ((L_GROUND).z > -3000)
		{
			int L_STRIKE_TIME = 3;
			if (ATK_POINTS.length() > 0) ATK_POINTS += ";";
			ATK_POINTS += L_GROUND;
			L_STRIKE_TIME("lightning_strike");
		}
		ClientEvent("new", "all", "nashalrath/lightning_strike_cl", L_POS, L_STRIKE_TIME);
	}

	void lightning_strike()
	{
		string L_POS = GetToken(ATK_POINTS, 0, ";");
		RemoveToken(ATK_POINTS, 0, ";");
		HAZARD_STRUCK = 1;
		XDoDamage(L_POS, 128, DMG_LIGHTNING_STRIKE, 0.1, GetOwner(), GetOwner(), "none", "lightning_effect");
	}

	void lightning_flicker()
	{
		FLICKER_COUNT += 1;
		if (!(FLICKER_COUNT < 7)) return;
		LogDebug("lightning_flicker");
		Random(0_1, 0_2)("lightning_flicker");
		if (!(FLICKER_BRUSH_ON))
		{
			FLICKER_BRUSH_ON = 1;
			UseTrigger("light_storm_lightning");
			CallExternal(FLICKER_BRUSH_ID, "storm_show");
		}
		else
		{
			FLICKER_BRUSH_ON = 0;
			UseTrigger("light_storm_lightning");
			CallExternal(FLICKER_BRUSH_ID, "storm_hide");
		}
	}

	void lightning_flicker_end()
	{
		if ((FLICKER_BRUSH_ON))
		{
			FLICKER_BRUSH_ON = 0;
			UseTrigger("light_storm_lightning");
			CallExternal(FLICKER_BRUSH_ID, "storm_hide");
		}
		LIGHTNING_FLICKERING = 0;
	}

	void do_ice_bolt()
	{
		string L_POS = STORM_CENTER;
		string RND_ANG = Random(0, 359.99);
		string RND_DIST = Random(0, STORM_RAD);
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, RND_DIST, 0));
		string L_DEST = L_POS;
		L_DEST += "z";
		TossProjectile("proj_ice_bolt", L_POS, L_DEST, 450, DMG_ICE_SHARD, 0, "none");
		CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_scale", 4);
	}

	void drop_meteor()
	{
		string L_POS = STORM_CENTER;
		string RND_ANG = Random(0, 359.99);
		string RND_DIST = Random(0, STORM_RAD);
		L_POS += /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, RND_DIST, 0));
		string L_DEST = /* TODO: $relpos */ $relpos(L_POS, Vector3(-10, -10, -100));
		TossProjectile("proj_staff_fire_bomb", L_POS, L_DEST, 120, DMG_METEOR, 0, "none");
	}

	void ext_fire_bomb()
	{
		HAZARD_STRUCK = 1;
	}

	void game_dodamage()
	{
		if (!(HAZARD_STRUCK)) return;
		HAZARD_STRUCK = 0;
		if (!(param1)) return;
		if (!(int(param6))) return;
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		if (BREATH_CYCLE == 1)
		{
			ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		}
		else
		{
			if (BREATH_CYCLE == 2)
			{
				ApplyEffect(param2, "effects/dot_lightning", 10.0, GetEntityIndex(GetOwner()), DOT_LIGHTNING);
			}
		}
	}

	void do_minions()
	{
		CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_minions01.wav", ATTN_VOICE, PITCH_VOICE);
		chat_now("Did you enjoy my minions?", 3.3, ANIM_CONVO1, "do_minions2", "add_to_que");
	}

	void do_minions2()
	{
		UseTrigger("spawn_minions");
		CallExternal("players", "ext_play_music_me", "dream_battle.mp3");
		CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_minions02.wav", ATTN_VOICE, PITCH_VOICE);
		chat_now("Their creation was inspired by Kharaztorant's pitiful attempts at immortality...", 7.5, ANIM_CONVO1, "do_minions3", "add_to_que");
	}

	void do_minions3()
	{
		CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_minions03.wav", ATTN_VOICE, PITCH_VOICE);
		chat_now("But they are well suited for menial tasks...", 4.1, ANIM_CONVO1, "none", "add_to_que");
		chat_now("...such as crushing insects!", 3.5, ANIM_CONVO1, "do_minions4", "add_to_que");
	}

	void do_minions4()
	{
		BUSY_TALKING = 0;
	}

	void ext_gloat()
	{
		if ((AM_BREATHING)) return;
		if ((BUSY_TALKING)) return;
		if ((AM_LIFTING)) return;
		GLOAT_COUNT += 1;
		if (GLOAT_COUNT == 1)
		{
			CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_laugh1.wav", ATTN_VOICE, PITCH_VOICE);
		}
		else
		{
			CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_laugh2.wav", ATTN_VOICE, PITCH_VOICE);
			GLOAT_COUNT = 0;
		}
	}

	void ext_image_died()
	{
		BATTLE_ACTIVE = 0;
		if ((STORM_ON))
		{
			end_storm();
		}
		ScheduleDelayedEvent(2.0, "win_sequence1");
	}

	void win_sequence1()
	{
		CallExternal("players", "ext_play_music_me", "Nashalrath.mp3");
		CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_win01.wav", ATTN_VOICE, PITCH_VOICE);
		chat_now("Impressive... Most impressive...", 3.81, ANIM_LAUGH, "none", "add_to_que");
		chat_now("When you die, for the final time, should you be fortunate enough to see your god Torkalath...", 9.52, ANIM_CONVO1, "none", "add_to_que");
		chat_now("Remind him... That I still believe in rewarding strength!", 7.02, ANIM_SUMMON, "win_sequence2", "add_to_que");
	}

	void win_sequence2()
	{
		UseTrigger("spawn_dragon_chest");
	}

	void ext_exit_sequence()
	{
		CallExternal("players", "ext_svplaysound_kiss", 2, 10, "voices/dragons/Jaminporlants_win02.wav", ATTN_VOICE, PITCH_VOICE);
		chat_now("Should your efforts continue to be so fruitful...", 7.0, ANIM_CONVO1, "none", "add_to_que");
		chat_now("We may one day, meet in person!", 2.58, "none", "do_exit", "add_to_que");
	}

	void do_exit()
	{
		PlayAnim("hold", ANIM_LEAVE);
		FADE_COUNT = 255;
		DG_PULSE_LOOP = 0;
		drag_fade_out();
	}

	void drag_fade_out()
	{
		if (GetGameTime() > NEXT_WING_BEAT)
		{
			NEXT_WING_BEAT = GetGameTime();
			NEXT_WING_BEAT += 0.75;
			EmitSound(GetOwner(), 0, "weapons/swinghuge.wav", 10);
		}
		FADE_COUNT -= 5;
		if (FADE_COUNT < 0)
		{
			FADE_COUNT = 0;
			DeleteEntity(GetOwner());
		}
		SetProp(GetOwner(), "renderamt", FADE_COUNT);
		if (!(FADE_COUNT > 0)) return;
		ScheduleDelayedEvent(0.1, "drag_fade_out");
	}

	void do_pulse()
	{
		if ((DG_PULSE_LOOP)) return;
		DG_PULSE_COUNT = DG_BASE_RENDERAMT;
		DG_PULSE_LOOP = 1;
		DG_PULSE_DIR = 1;
		do_dgpulse_loop();
	}

	void do_dgpulse_loop()
	{
		if (!(DG_PULSE_LOOP)) return;
		ScheduleDelayedEvent(0.1, "do_dgpulse_loop");
		LogDebug("do_dgpulse_loop DG_PULSE_COUNT");
		if (DG_PULSE_DIR == 1)
		{
			if (DG_PULSE_COUNT < 255)
			{
				DG_PULSE_COUNT += 1;
				SetProp(GetOwner(), "renderamt", DG_PULSE_COUNT);
			}
			else
			{
				DG_PULSE_DIR = -1;
			}
		}
		else
		{
			if (DG_PULSE_COUNT > DG_BASE_RENDERAMT)
			{
				DG_PULSE_COUNT -= 1;
				SetProp(GetOwner(), "renderamt", DG_PULSE_COUNT);
			}
			else
			{
				SetProp(GetOwner(), "renderamt", DG_BASE_RENDERAMT);
				DG_PULSE_LOOP = 0;
			}
		}
	}

}

}
