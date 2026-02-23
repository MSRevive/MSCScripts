#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class KHollowOne : CGameScript
{
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BALL_TYPE;
	string BURN_LIST;
	string CFB_EST_ANG;
	string CFB_EST_ORG;
	int CFB_FIREBALL_ACTIVE;
	string CFB_FIREBALL_IDX;
	int CFB_FIRST_TARGET_FOUND;
	string CFB_FORCE_END;
	string CFB_LIST;
	string CFB_NEXT_SCAN;
	string CL_IDX;
	string CL_IDX_SHADOW;
	string DRAINER_ALIVES;
	int DRAINER_INDEX;
	string DRAINER_LOCS;
	string DRAINER_ROTATIONS;
	string DRAINER_TARGS;
	string DRAINER_TIMES;
	int FADE_LEVEL;
	int FIRE_BREATH_ON;
	int FLIGHT_MODE;
	int FLOAT_DIR;
	int ICE_DIST;
	string ICE_LIST;
	int IS_UNHOLY;
	int MIRRORS_ON;
	string MIRROR_ANG;
	string NEXT_BURN;
	string NEXT_DODGE;
	string NEXT_FLIGHT;
	string NEXT_MIRROR;
	string NEXT_SPECIAL;
	string NEXT_SPIKE;
	string NEXT_ZAP_SCAN;
	int NPC_GIVE_EXP;
	int NPC_RANGED;
	int N_DRAIN_SPRITES;
	string OUT_TARGET;
	int POISON_BREATH_ON;
	int SPECIAL_CYCLE;
	string SPIN_ANG;
	int SPIN_ON;
	int SPIN_SPEED;
	string ZAP_ON;
	string ZAP_TARGET;

	KHollowOne()
	{
		const string ANIM_FLOAT = "float";
		const string ANIM_JUMP = "jump";
		const string ANIM_LEAP = "leap";
		const string ANIM_PREP_DEPLOY = "ref_aim_trip";
		const string ANIM_RELEASE_DEPLOY = "ref_shoot_trip";
		const string ANIM_MIRROR_PREP = "ref_aim_grenade";
		const string ANIM_ICE_SPIRAL = "ref_shoot_smartgun";
		const string ANIM_FIRE_BREATH = "float";
		const int LHAND_ATCH = 1;
		const int RHAND_ATCH = 2;
		const int MOUTH_ATCH = 3;
		const int N_SPECIALS = 9;
		const float MIRROR_DURATION = 60.0;
		const float FREQ_MIRROR = 120.0;
		const float FLIGHT_DURATION = 60.0;
		const float FREQ_FLIGHT = 90.0;
		const int FLIGHT_SPEED = 100;
		const int MAX_DRAIN_SPRITES = 8;
		const int DRAIN_SPRITE_SPEED = 25;
		const float DRAINER_MAX_LIVE_TIME = 180.0;
		const int MP_DRAIN_RATE = -10;
		const int DMG_FIREBALL = 300;
		const int DMG_ICEBALL = 200;
		const int DOT_ICE = 50;
		const int DOT_FIRE = 75;
		const int DOT_FIRE2 = 125;
		const int DOT_POISON = 25;
		const int DMG_ZAP = 25;
		const string FREQ_DODGE = Random(5.0, 15.0);
		const int SHIELD_RANGE = 80;
		IS_UNHOLY = 1;
		ANIM_IDLE = "idle";
		ANIM_DEATH = "die_forwards2";
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		NPC_GIVE_EXP = 5000;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 170;
		ATTACK_MOVERANGE = 128;
		NPC_RANGED = 1;
		const string SOUND_SPELL_PREP = "magic/bolt_start.wav";
		const string SOUND_FIRE_PREP = "magic/spookie1.wav";
		const string SOUND_ICE_PREP = "magic/spookie1.wav";
		const string SOUND_POP = "magic/elecidlepop.wav";
		const string SOUND_FIREBALL_RELEASE = "ambience/alienflyby1.wav";
		const string sOUND_MIRROR = "monsters/gonome/gonome_melee2.wav";
		const string SOUND_MIRROR_OFF = "debris/beamstart15.wav";
		const string SOUND_BREATH = "monsters/goblin/sps_fogfire.wav";
		const string SOUND_ZAP_LOOP = "magic/bolt_loop.wav";
		const string SOUND_ZAP_START = "magic/bolt_end.wav";
		const string SOUND_POISON_BREATH = "magic/flame_loop.wav";
		const string SOUND_POISON_BREATH_START = "magic/flame_loop_start.wav";
		const string SOUND_DODGE = "magic/frost_reverse.wav";
		const string SOUND_FLIGHT_START = "magic/vent3.wav";
		const string SOUND_FLIGHT_LOOP = "magic/vent3.wav";
		const float FREQ_SOUND_FLIGHT_LOOP = 5.92;
		const string SOUND_DEATH = "x/x_pain3.wav";
		Precache(SOUND_DEATH);
		Precache("magic/egon_run3_noloop.wav");
		Precache("magic/energy1_loud.wav1");
		Precache("explode1.spr");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		if (N_DRAIN_SPRITES > 0)
		{
			for (int i = 0; i < 8; i++)
			{
				track_drain_sprites();
			}
		}
	}

	void game_precache()
	{
		Precache("monsters/summon/client_side_fireball");
		Precache("monsters/summon/client_side_iceball");
		Precache("effects/sfx_motionblur_perm");
	}

	void OnSpawn() override
	{
		SetName("Kharaztorant Hollow One");
		Precache("monsters/hollow_one.mdl");
		SetModel("monsters/hollow_one.mdl");
		SetWidth(32);
		SetHeight(80);
		SetIdleAnim("idle");
		SetMoveAnim("walk");
		SetHearingSensitivity(2);
		if (!(true)) return;
		SetRoam(false);
		SetHealth(8000);
		SetRace("demon");
		SetDamageResistance("all", 0.4);
		SetDamageResistance("holy", 1.5);
		SetDamageResistance("poison", 0.0);
		npcatk_suspend_attack();
		N_DRAIN_SPRITES = 0;
		SPECIAL_CYCLE = 0;
		DRAINER_ROTATIONS = "1;2;3;4;5;6;7;8";
		DRAINER_ALIVES = "0;0;0;0;0;0;0;0";
		DRAINER_TARGS = "1;2;3;4;5;6;7;8";
		DRAINER_LOCS = "1;2;3;4;5;6;7;8";
		DRAINER_TIMES = "1;2;3;4;5;6;7;8";
		CL_IDX = "const.localplayer.scriptID";
		ClientEvent("update", "all", CL_IDX, "kh_setup", GetEntityIndex(GetOwner()));
	}

	void game_dynamically_created()
	{
		SPECIAL_CYCLE = param1;
	}

	void cycle_up()
	{
		SetRoam(true);
	}

	void cycle_down()
	{
		npcatk_go_home();
	}

	void npc_made_it_home()
	{
		SetRoam(false);
	}

	void my_target_died()
	{
		if ((POISON_BREATH_ON))
		{
			// svplaysound: if ( POISON_BREATH_ON ) svplaysound 1 0 SOUND_POISON_BREATH
			EmitSound(1, 0, SOUND_POISON_BREATH);
		}
		if ((FIRE_BREATH_ON))
		{
			// svplaysound: if ( FIRE_BREATH_ON ) svplaysound 1 0 SOUND_BREATH
			EmitSound(1, 0, SOUND_BREATH);
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((POISON_BREATH_ON))
		{
			// svplaysound: if ( POISON_BREATH_ON ) svplaysound 1 0 SOUND_POISON_BREATH
			EmitSound(1, 0, SOUND_POISON_BREATH);
		}
		if ((FIRE_BREATH_ON))
		{
			// svplaysound: if ( FIRE_BREATH_ON ) svplaysound 1 0 SOUND_BREATH
			EmitSound(1, 0, SOUND_BREATH);
		}
		SetGravity(1);
		SetVelocity(GetOwner(), 0);
		SetAnimMoveSpeed(0);
		ClientEvent("update", "all", CL_IDX, "kh_end_effects");
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
		if ((CFB_FIREBALL_ACTIVE))
		{
			cfb_explode();
		}
		CallExternal(GAME_MASTER, "gm_hollow_one_died", GetEntityOrigin(GetOwner()));
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((SUSPEND_AI)) return;
		if (m_hAttackTarget != "unset")
		{
			if (GetGameTime() > NEXT_SPECIAL)
			{
				do_special();
			}
			if (GetGameTime() > NEXT_ZAP_SCAN)
			{
				zap_scan();
			}
		}
		if ((IsEntityAlive(ZAP_TARGET)))
		{
			if (GetEntityRange(ZAP_TARGET) <= SHIELD_RANGE)
			{
				if (!(ZAP_ON))
				{
					// svplaysound: svplaysound 2 10 SOUND_ZAP_LOOP
					EmitSound(2, 10, SOUND_ZAP_LOOP);
					EmitSound(GetOwner(), 0, SOUND_ZAP_START, 10);
					ZAP_TARG_RESIST = /* TODO: $get_takedmg */ $get_takedmg(ZAP_TARGET, "lightning");
					ClientEvent("update", "all", CL_IDX, "kh_zap_target_on", GetEntityIndex(ZAP_TARGET));
				}
				ZAP_ON = 1;
				DoDamage(ZAP_TARGET, "direct", DMG_ZAP, 1.0, GetOwner());
				if (Random(0.0, 1.0) < ZAP_TARG_RESIST)
				{
				}
				string TARGET_ORG = GetEntityOrigin(ZAP_TARGET);
				string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
				string NEW_YAW = TARG_ANG;
				AddVelocity(ZAP_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 200, 110)));
			}
			else
			{
				ZAP_ON = 0;
				// svplaysound: svplaysound 2 0 SOUND_ZAP_LOOP
				EmitSound(2, 0, SOUND_ZAP_LOOP);
				ClientEvent("update", "all", CL_IDX, "kh_zap_target_off");
			}
		}
		else
		{
			if ((ZAP_ON))
			{
			}
			ZAP_ON = 0;
			// svplaysound: svplaysound 2 0 SOUND_ZAP_LOOP
			EmitSound(2, 0, SOUND_ZAP_LOOP);
			ClientEvent("update", "all", CL_IDX, "kh_zap_target_off");
		}
		if (!(FLIGHT_MODE)) return;
		string MY_POS = GetEntityOrigin(GetOwner());
		string MY_UP = MY_POS;
		MY_UP += "z";
		string MY_DOWN = MY_POS;
		MY_DOWN += "z";
		string SCAN_UP = TraceLine(MY_POS, MY_UP);
		string SCAN_DOWN = TraceLine(MY_POS, MY_DOWN);
		FLOAT_DIR = 1;
		if (SCAN_UP != MY_UP)
		{
			FLOAT_DIR = -25;
		}
		if (SCAN_DOWN != MY_DOWN)
		{
			FLOAT_DIR = 25;
		}
		string MAX_HEIGHT = /* TODO: $get_ground_height */ $get_ground_height(MY_POS);
		MAX_HEIGHT += 384;
		if ((MY_POS).z >= MAX_HEIGHT)
		{
			FLOAT_DIR = -25;
		}
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, FLOAT_DIR));
	}

	void do_special()
	{
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += 10.0;
		SPECIAL_CYCLE += 1;
		if ((MIRRORS_ON))
		{
			SetProp(GetOwner(), "rendermode", 5);
			SetProp(GetOwner(), "renderamt", 1);
		}
		if (SPECIAL_CYCLE > N_SPECIALS)
		{
			SPECIAL_CYCLE = 1;
		}
		if (SPECIAL_CYCLE == 1)
		{
			if (N_DRAIN_SPRITES < MAX_DRAIN_SPRITES)
			{
			}
			LogDebug("do_special: spawn_drain_sprite");
			spawn_drain_sprite();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 10.0;
		}
		if (SPECIAL_CYCLE == 2)
		{
			LogDebug("do_special: fireball");
			prep_fireball();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 25.0;
		}
		if (SPECIAL_CYCLE == 3)
		{
			LogDebug("do_special: iceball");
			prep_iceball();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 25.0;
		}
		if (SPECIAL_CYCLE == 4)
		{
			if ((FLIGHT_MODE))
			{
				SPECIAL_CYCLE += 1;
				NEXT_SPECIAL = GetGameTime();
			}
			if (!(FLIGHT_MODE))
			{
			}
			LogDebug("do_special: fire breath");
			do_fire_breath();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 10.0;
		}
		if (SPECIAL_CYCLE == 5)
		{
			LogDebug("do_special: ice spiral");
			prep_ice_spiral();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 10.0;
		}
		if (SPECIAL_CYCLE == 6)
		{
			if ((FLIGHT_MODE))
			{
				SPECIAL_CYCLE += 1;
				NEXT_SPECIAL = GetGameTime();
			}
			if (!(FLIGHT_MODE))
			{
			}
			LogDebug("do_special: poison breath");
			do_poison_breath();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 10.0;
		}
		if (SPECIAL_CYCLE == 7)
		{
			LogDebug("do_special: hold person");
			prep_hold_person();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 10.0;
		}
		if (SPECIAL_CYCLE == 8)
		{
			if ((FLIGHT_MODE))
			{
				SPECIAL_CYCLE += 1;
				NEXT_SPECIAL = GetGameTime();
			}
			if (!(FLIGHT_MODE))
			{
			}
			if ((MIRRORS_ON))
			{
				SPECIAL_CYCLE += 1;
				NEXT_SPECIAL = GetGameTime();
			}
			if (!(MIRRORS_ON))
			{
			}
			if (GetGameTime() <= NEXT_MIRROR)
			{
				SPECIAL_CYCLE += 1;
				NEXT_SPECIAL = GetGameTime();
			}
			if (GetGameTime() > NEXT_MIRROR)
			{
			}
			LogDebug("do_special: mirror image");
			prep_mirrors();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 10.0;
		}
		if (SPECIAL_CYCLE == 9)
		{
			LogDebug("do_special: attempt flight");
			if ((FLIGHT_MODE))
			{
				LogDebug("attempt_flight: canceled , already in flight");
				SPECIAL_CYCLE += 1;
				NEXT_SPECIAL = GetGameTime();
			}
			if (!(FLIGHT_MODE))
			{
			}
			if ((MIRRORS_ON))
			{
				LogDebug("attempt_flight: canceled , mirror image up");
				SPECIAL_CYCLE += 1;
				NEXT_SPECIAL = GetGameTime();
			}
			if (!(MIRRORS_ON))
			{
			}
			if (GetGameTime() <= NEXT_FLIGHT)
			{
				LogDebug("attempt_flight: canceled , too soon since light flight");
				SPECIAL_CYCLE += 1;
				NEXT_SPECIAL = GetGameTime();
			}
			if (GetGameTime() > NEXT_FLIGHT)
			{
			}
			prep_flight_mode();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 10.0;
		}
	}

	void OnSuspendAI()
	{
		SetRoam(false);
	}

	void npcatk_resume_ai()
	{
		SetRoam(true);
	}

	void spawn_drain_sprite()
	{
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_PREP_DEPLOY);
		SetIdleAnim(ANIM_PREP_DEPLOY);
		SetMoveAnim(ANIM_PREP_DEPLOY);
		DRAINER_INDEX = -1;
		LogDebug("spawn_drain_sprite alives: DRAINER_ALIVES");
		for (int i = 0; i < 8; i++)
		{
			find_free_drainer_index();
		}
		N_DRAIN_SPRITES += 1;
		Effect("beam", "ents", "lgtning.spr", 5, GetOwner(), LHAND_ATCH, GetOwner(), RHAND_ATCH, Vector3(32, 64, 255), 200, 100, 2.0);
		EmitSound(GetOwner(), 0, SOUND_SPELL_PREP, 10);
		ScheduleDelayedEvent(2.0, "spawn_drain_sprite2");
	}

	void find_free_drainer_index()
	{
		if (!(DRAINER_INDEX < 0)) return;
		string CUR_IDX = i;
		string IS_ALIVE = GetToken(DRAINER_ALIVES, CUR_IDX, ";");
		if (!(IS_ALIVE))
		{
			DRAINER_INDEX = CUR_IDX;
			LogDebug("find_free_drainer_index: Found Free DRAINER_INDEX");
		}
	}

	void spawn_drain_sprite2()
	{
		PlayAnim("critical", ANIM_RELEASE_DEPLOY);
		string TARG_LIST = /* TODO: $get_tbox */ $get_tbox("enemy", 512);
		OUT_TARGET = m_hAttackTarget;
		ScheduleDelayedEvent(0.1, "spawn_drain_sprite3");
		if (!(TARG_LIST != "none")) return;
		if (GetTokenCount(TARG_LIST, ";") > 1)
		{
			ScrambleTokens(TARG_LIST, ";");
		}
		OUT_TARGET = GetToken(TARG_LIST, 0, ";");
	}

	void spawn_drain_sprite3()
	{
		LogDebug("Using target GetEntityName(OUT_TARGET)");
		EmitSound(GetOwner(), 0, SOUND_POP, 10);
		string SPAWN_LOC = GetEntityProperty(GetOwner(), "attachpos");
		string MOVE_DEST = SPAWN_LOC;
		string TARG_ORG = GetEntityOrigin(OUT_TARGET);
		string TARG_ANG = /* TODO: $angles3d */ $angles3d(SPAWN_LOC, TARG_ORG);
		MOVE_DEST += /* TODO: $relvel */ $relvel(TARG_ANG, Vector3(0, DRAIN_SPRITE_SPEED, 0));
		MOVE_DEST = "x";
		ClientEvent("update", "all", CL_IDX, "kh_make_drain_sprite", SPAWN_LOC, DRAINER_INDEX, TARG_ANG);
		SetToken(DRAINER_TARGS, DRAINER_INDEX, OUT_TARGET, ";");
		SetToken(DRAINER_LOCS, DRAINER_INDEX, SPAWN_LOC, ";");
		SetToken(DRAINER_TIMES, DRAINER_INDEX, GetGameTime(), ";");
		SetToken(DRAINER_ROTATIONS, DRAINER_INDEX, RandomInt(0, 359), ";");
		SetToken(DRAINER_ALIVES, DRAINER_INDEX, 1, ";");
		resume_movement();
		npcatk_resume_ai();
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += 1.0;
	}

	void resume_movement()
	{
		if (!(FLIGHT_MODE))
		{
			SetMoveAnim(ANIM_WALK);
			SetIdleAnim(ANIM_IDLE);
		}
		else
		{
			SetMoveAnim(ANIM_FLOAT);
			SetIdleAnim(ANIM_FLOAT);
		}
	}

	void stop_movement()
	{
	}

	void track_drain_sprites()
	{
		string CUR_IDX = i;
		string IS_ALIVE = GetToken(DRAINER_ALIVES, CUR_IDX, ";");
		if (!(IS_ALIVE)) return;
		string MY_TARG = GetToken(DRAINER_TARGS, CUR_IDX, ";");
		string MY_ORG = GetToken(DRAINER_LOCS, CUR_IDX, ";");
		string MY_ORBIT_ANG = GetToken(DRAINER_ROTATIONS, CUR_IDX, ";");
		string MY_TIME = GetToken(DRAINER_TIMES, CUR_IDX, ";");
		string TARG_ORG = GetEntityOrigin(MY_TARG);
		string MY_DEST = TARG_ORG;
		string TARG_HEIGHT_ADJ = GetEntityHeight(MY_TARG);
		TARG_HEIGHT_ADJ /= 2;
		MY_DEST += /* TODO: $relpos */ $relpos(Vector3(0, MY_ORBIT_ANG, 0), Vector3(0, 32, TARG_HEIGHT_ADJ));
		string TARG_MP = GetEntityMP(MY_TARG);
		if (Distance(MY_ORG, TARG_ORG) < 64)
		{
			GiveMP(MY_TARG);
			if (GetGameTime() > NEXT_ALERT)
			{
				if (TARG_MP > 0)
				{
				}
				NEXT_ALERT = GetGameTime();
				NEXT_ALERT += 2.0;
				SendPlayerMessage(MY_TARG, "A corpse-light is draining your mana!");
				int IS_DRAINING = 1;
			}
			if (TARG_MP <= 0)
			{
				SendPlayerMessage(m_hAttackTarget, "Your soul has been drained by a corpse light!");
				DoDamage(m_hAttackTarget, "direct", 99999, 1.0, GetOwner());
				ClientEvent("update", "all", CL_IDX, "kh_sprite_splode", MY_ORG);
				SetToken(DRAINER_ALIVES, CUR_IDX, "0", ";");
				int IS_ALIVE = 0;
				N_DRAIN_SPRITES -= 1;
				LogDebug("Drainer: popped");
			}
			else
			{
				MY_ORBIT_ANG += 45;
				SetToken(DRAINER_ROTATIONS, CUR_IDX, MY_ORBIT_ANG, ";");
			}
		}
		if (!(IS_ALIVE)) return;
		string TIME_ALIVE = GetGameTime();
		TIME_ALIVE -= MY_TIME;
		if (TIME_ALIVE > DRAINER_MAX_LIVE_TIME)
		{
			ClientEvent("update", "all", CL_IDX, "kh_sprite_splode", MY_ORG);
			SetToken(DRAINER_ALIVES, CUR_IDX, "0", ";");
			int IS_ALIVE = 0;
			N_DRAIN_SPRITES -= 1;
			LogDebug("Drainer: Timed out");
		}
		if (!(IS_ALIVE)) return;
		if (!(IsEntityAlive(MY_TARG)))
		{
			ClientEvent("update", "all", CL_IDX, "kh_sprite_splode", MY_ORG);
			SetToken(DRAINER_ALIVES, CUR_IDX, "0", ";");
			int IS_ALIVE = 0;
			N_DRAIN_SPRITES -= 1;
			LogDebug("Drainer: Target Died");
		}
		if (!(IS_ALIVE)) return;
		string DEST_ANG = /* TODO: $angles3d */ $angles3d(MY_ORG, MY_DEST);
		DEST_ANG = "x";
		ClientEvent("update", "all", CL_IDX, "kh_make_drain_sprite", MY_ORG, CUR_IDX, DEST_ANG, IS_DRAINING);
		string OLD_ORG = MY_ORG;
		MY_ORG += /* TODO: $relvel */ $relvel(DEST_ANG, Vector3(0, DRAIN_SPRITE_SPEED, 0));
		SetToken(DRAINER_LOCS, CUR_IDX, MY_ORG, ";");
	}

	void prep_fireball()
	{
		ScheduleDelayedEvent(2.0, "prep_fireball2");
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_PREP_DEPLOY);
		SetIdleAnim(ANIM_PREP_DEPLOY);
		SetMoveAnim(ANIM_PREP_DEPLOY);
		ClientEvent("update", "all", CL_IDX, "kh_hand_sprites", 2.0, Vector3(255, 128, 96));
		EmitSound(GetOwner(), 0, SOUND_FIRE_PREP, 10);
	}

	void prep_fireball2()
	{
		PlayAnim("critical", ANIM_RELEASE_DEPLOY);
		EmitSound(GetOwner(), 0, SOUND_FIREBALL_RELEASE, 10);
		npcatk_resume_ai();
		resume_movement();
		BALL_TYPE = "fire";
		start_ball();
	}

	void prep_iceball()
	{
		ScheduleDelayedEvent(2.0, "prep_iceball2");
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_PREP_DEPLOY);
		SetIdleAnim(ANIM_PREP_DEPLOY);
		SetMoveAnim(ANIM_PREP_DEPLOY);
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), LHAND_ATCH, GetOwner(), RHAND_ATCH, Vector3(128, 164, 255), 200, 200, 2.0);
		EmitSound(GetOwner(), 0, SOUND_ICE_PREP, 10);
	}

	void prep_iceball2()
	{
		PlayAnim("critical", ANIM_RELEASE_DEPLOY);
		EmitSound(GetOwner(), 0, SOUND_FIREBALL_RELEASE, 10);
		npcatk_resume_ai();
		resume_movement();
		BALL_TYPE = "ice";
		start_ball();
	}

	void start_ball()
	{
		if ((CFB_FIREBALL_ACTIVE)) return;
		CFB_FIREBALL_ACTIVE = 1;
		CFB_FIRST_TARGET_FOUND = 0;
		CFB_EST_ORG = /* TODO: $relpos */ $relpos(0, 32, 0);
		string START_ANGS = GetEntityAngles(GetOwner());
		CFB_EST_ANG = START_ANGS;
		if (BALL_TYPE == "fire")
		{
			ClientEvent("new", "all", "monsters/summon/client_side_fireball", CFB_EST_ORG, START_ANGS);
		}
		if (BALL_TYPE == "ice")
		{
			ClientEvent("new", "all", "monsters/summon/client_side_iceball", CFB_EST_ORG, START_ANGS);
		}
		CFB_FIREBALL_IDX = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.1, "cfb_fireball_loop");
		CFB_FORCE_END = GetGameTime();
		CFB_FORCE_END += 20.0;
	}

	void cfb_fireball_loop()
	{
		if (!(CFB_FIREBALL_ACTIVE)) return;
		ScheduleDelayedEvent(0.5, "cfb_fireball_loop");
		if (GetGameTime() > CFB_NEXT_SCAN)
		{
			CFB_NEXT_SCAN = GetGameTime();
			CFB_NEXT_SCAN += 2.0;
			if (!(IsEntityAlive(CFB_TARGET)))
			{
				string OWNER_ORG = GetEntityOrigin(GetOwner());
				string TARGET_TOKENS = FindEntitiesInSphere("enemy", 512);
				if (TARGET_TOKENS != "none")
				{
				}
				if (GetTokenCount(TARGET_TOKENS, ";") > 1)
				{
					ScrambleTokens(TARGET_TOKENS, ";");
				}
				string TEST_TARG = GetToken(TARGET_TOKENS, 0, ";");
				if ((IsEntityAlive(TEST_TARG)))
				{
				}
				if (!(GetEntityProperty(TEST_TARG, "scriptvar")))
				{
				}
				CFB_TARGET = TEST_TARG;
				if (!(CFB_FIRST_TARGET_FOUND))
				{
				}
				CFB_FIRST_TARGET_FOUND = 1;
				string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(CFB_EST_ORG, TARG_ORG);
			}
			else
			{
				string SCAN_DOWN = CFB_EST_ORG;
				string TARGET_TOKENS = FindEntitiesInSphere("enemy", 96);
				if (TARGET_TOKENS != "none")
				{
				}
				cfb_explode("hit_nme");
			}
		}
		if (!(CFB_FIREBALL_ACTIVE)) return;
		if ((IsEntityAlive(CFB_TARGET)))
		{
			string TARG_ORG = GetEntityOrigin(CFB_TARGET);
			if (!(IsValidPlayer(CFB_TARGET)))
			{
				TARG_ORG += "z";
			}
			string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(CFB_EST_ORG, TARG_ORG);
			ANG_TO_TARG = "x";
			ClientEvent("update", "all", CFB_FIREBALL_IDX, "svr_update_fireball_vec", ANG_TO_TARG, CFB_EST_ORG);
			CFB_EST_ANG = ANG_TO_TARG;
			CFB_EST_ORG += /* TODO: $relvel */ $relvel(ANG_TO_TARG, Vector3(0, 60, 0));
		}
		else
		{
			CFB_EST_ORG += /* TODO: $relvel */ $relvel(CFB_EST_ANG, Vector3(0, 60, 0));
		}
		string TRACE_DEST = CFB_EST_ORG;
		TRACE_DEST += /* TODO: $relvel */ $relvel(CFB_EST_ANG, Vector3(0, 60, 0));
		string TRACE_RESULT = TraceLine(CFB_EST_ORG, TRACE_DEST);
		if (TRACE_RESULT != TRACE_DEST)
		{
			cfb_explode("hitwall");
		}
		if (!(CFB_FIREBALL_ACTIVE)) return;
		if (!(GetGameTime() > CFB_FORCE_END)) return;
		cfb_explode("time_out");
	}

	void cfb_explode()
	{
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += 1.0;
		CFB_FIREBALL_ACTIVE = 0;
		ClientEvent("update", "all", CFB_FIREBALL_IDX, "fireball_explode");
		ScheduleDelayedEvent(0.1, "cfb_fireball_release");
		CFB_LIST = FindEntitiesInSphere("enemy", 128);
		if (!(CFB_LIST != "none")) return;
		if (!(GetTokenCount(CFB_LIST, ";") > 0)) return;
		for (int i = 0; i < GetTokenCount(CFB_LIST, ";"); i++)
		{
			cfb_affect_targets();
		}
	}

	void cfb_affect_targets()
	{
		string CHECK_ENT = GetToken(CFB_LIST, i, ";");
		string TARGET_ORG = GetEntityOrigin(CHECK_ENT);
		string TARG_ANG = /* TODO: $angles */ $angles(CFB_EST_ORG, TARGET_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(CHECK_ENT, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
		if (BALL_TYPE == "fire")
		{
			DoDamage(CHECK_ENT, "direct", DMG_FIREBALL, 1.0, GetOwner());
			ApplyEffect(CHECK_ENT, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		}
		if (BALL_TYPE == "ice")
		{
			ApplyEffect(CHECK_ENT, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_ICE);
		}
	}

	void cfb_fireball_end()
	{
		LogDebug("cfb_fireball_end");
		ClientEvent("update", "all", CFB_FIREBALL_IDX, "fireball_end");
		ScheduleDelayedEvent(0.1, "cfb_fireball_release");
	}

	void cfb_fireball_release()
	{
		LogDebug("cfb_fireball_release");
		CFB_FIREBALL_ACTIVE = 0;
	}

	void prep_mirrors()
	{
		EmitSound(GetOwner(), 0, SOUND_MIRROR, 10);
		MIRRORS_ON = 1;
		stop_movement();
		npcatk_suspend_ai();
		SetMoveAnim(ANIM_MIRROR_PREP);
		SetIdleAnim(ANIM_MIRROR_PREP);
		PlayAnim("critical", ANIM_MIRROR_PREP);
		SPIN_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		MIRROR_ANG = SPIN_ANG;
		SPIN_ON = 1;
		SPIN_SPEED = 1;
		FADE_LEVEL = 255;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderfx", 16);
		mirror_spin();
		ScheduleDelayedEvent(3.0, "stop_mirror_spin");
		ClientEvent("update", "all", CL_IDX, "kh_spawn_mirrors", "monsters/hollow_one.mdl", GetEntityOrigin(GetOwner()), SPIN_ANG);
	}

	void stop_mirror_spin()
	{
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 1);
		SetProp(GetOwner(), "renderfx", 0);
		SPIN_ON = 0;
		resume_movement();
		npcatk_resume_ai();
		MIRROR_DURATION("end_mirror_fx");
	}

	void mirror_spin()
	{
		if (!(SPIN_ON)) return;
		ScheduleDelayedEvent(0.05, "mirror_spin");
		FADE_LEVEL -= 10;
		if (FADE_LEVEL < 0)
		{
			FADE_LEVEL = 0;
		}
		LogDebug("FADE_LEVEL");
		SetProp(GetOwner(), "renderamt", FADE_LEVEL);
		SPIN_ANG += SPIN_SPEED;
		SPIN_SPEED += 1;
		if (SPIN_ANG > 359)
		{
			SPIN_ANG -= 359;
		}
		string FACE_POS = GetEntityOrigin(GetOwner());
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, SPIN_ANG, 0), Vector3(0, 100, 0));
		SetMoveDest(FACE_POS);
	}

	void end_mirror_fx()
	{
		NEXT_MIRROR = GetGameTime();
		NEXT_MIRROR += FREQ_MIRROR;
		MIRRORS_ON = 0;
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
		EmitSound(GetOwner(), 0, SOUND_MIRROR_OFF, 10);
		ClientEvent("update", "all", CL_IDX, "kh_mirrors_off");
	}

	void prep_ice_spiral()
	{
		stop_movement();
		npcatk_suspend_ai();
		SetMoveAnim(ANIM_ICE_SPIRAL);
		SetIdleAnim(ANIM_ICE_SPIRAL);
		PlayAnim("critical", ANIM_ICE_SPIRAL);
		SPIN_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		SPIN_ON = 1;
		ICE_DIST = 32;
		ice_spiral_spin();
		ScheduleDelayedEvent(4.0, "stop_ice_spiral_spin");
	}

	void stop_ice_spiral_spin()
	{
		SPIN_ON = 0;
		resume_movement();
		npcatk_resume_ai();
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += 1.0;
	}

	void ice_spiral_spin()
	{
		if (!(SPIN_ON)) return;
		ScheduleDelayedEvent(0.05, "ice_spiral_spin");
		string FACE_POS = GetEntityOrigin(GetOwner());
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, SPIN_ANG, 0), Vector3(0, 100, 0));
		SetMoveDest(FACE_POS);
		if (GetGameTime() > NEXT_SPIKE)
		{
			NEXT_SPIKE = GetGameTime();
			NEXT_SPIKE += 0.25;
			string FREEZE_TARGET = GetEntityOrigin(GetOwner());
			FREEZE_TARGET += /* TODO: $relpos */ $relpos(Vector3(0, SPIN_ANG, 0), Vector3(0, ICE_DIST, 0));
			freeze_area(FREEZE_TARGET);
			ICE_DIST += 16;
		}
		SPIN_ANG += 10;
		if (SPIN_ANG > 359)
		{
			SPIN_ANG -= 359;
		}
	}

	void freeze_area()
	{
		string ICE_POS = param1;
		ICE_POS = "z";
		ICE_LIST = /* TODO: $get_tbox */ $get_tbox("enemy", 96, ICE_POS);
		ClientEvent("update", "all", CL_IDX, "kh_ice_spikes", ICE_POS);
		if (!(ICE_LIST != "none")) return;
		string N_ICE_LIST = GetTokenCount(ICE_LIST, ";");
		if (!(N_ICE_LIST > 0)) return;
		for (int i = 0; i < N_ICE_LIST; i++)
		{
			freeze_targets();
		}
	}

	void freeze_targets()
	{
		string CUR_TARGET = GetToken(ICE_LIST, i, ";");
		ApplyEffect(CUR_TARGET, "effects/dot_cold_freeze", 10.0, GetEntityIndex(GetOwner()), DOT_ICE);
	}

	void do_fire_breath()
	{
		stop_movement();
		npcatk_suspend_ai();
		SetMoveAnim(ANIM_FIRE_BREATH);
		SetIdleAnim(ANIM_FIRE_BREATH);
		PlayAnim("critical", ANIM_FIRE_BREATH);
		SPIN_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		SPIN_ON = 1;
		SPIN_ANG -= 45;
		if (SPIN_ANG < 0)
		{
			SPIN_ANG += 359;
		}
		// svplaysound: svplaysound 1 10 SOUND_BREATH
		EmitSound(1, 10, SOUND_BREATH);
		ClientEvent("update", "all", CL_IDX, "kh_fire_breath_on", "explode1.spr");
		fire_breath_spin();
		ScheduleDelayedEvent(8.0, "stop_fire_breath_spin");
		FIRE_BREATH_ON = 1;
	}

	void stop_fire_breath_spin()
	{
		// svplaysound: svplaysound 1 0 SOUND_BREATH
		EmitSound(1, 0, SOUND_BREATH);
		ClientEvent("update", "all", CL_IDX, "kh_fire_breath_off");
		SPIN_ON = 0;
		resume_movement();
		npcatk_resume_ai();
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += 1.0;
		FIRE_BREATH_ON = 0;
	}

	void fire_breath_spin()
	{
		if (!(SPIN_ON)) return;
		ScheduleDelayedEvent(0.05, "fire_breath_spin");
		string FACE_POS = GetEntityOrigin(GetOwner());
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, SPIN_ANG, 0), Vector3(0, 100, 0));
		SetMoveDest(FACE_POS);
		if (GetGameTime() > NEXT_BURN)
		{
			NEXT_BURN = GetGameTime();
			NEXT_BURN += 0.5;
			string BURN_TARGET = GetEntityOrigin(GetOwner());
			BURN_LIST = FindEntitiesInSphere("enemy", 512);
			string N_BURN_LIST = GetTokenCount(BURN_LIST, ";");
			if (N_BURN_LIST > 0)
			{
			}
			for (int i = 0; i < N_BURN_LIST; i++)
			{
				burn_targets();
			}
		}
		SPIN_ANG += 10;
		if (SPIN_ANG > 359)
		{
			SPIN_ANG -= 359;
		}
	}

	void burn_targets()
	{
		string CUR_TARGET = GetToken(BURN_LIST, i, ";");
		if (!(IsEntityAlive(CUR_TARGET))) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARGET);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		if (!(GetEntityRange(CUR_TARGET) < 256)) return;
		if (!(GetEntityHeight(CUR_TARGET) > 36)) return;
		ApplyEffect(CUR_TARGET, "effects/dot_fire", 10.0, GetEntityIndex(GetOwner()), DOT_FIRE2);
		AddVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(0, 300, 120));
	}

	void zap_scan()
	{
		NEXT_ZAP_SCAN = GetGameTime();
		NEXT_ZAP_SCAN += 1.0;
		string ZAP_LIST = FindEntitiesInSphere("enemy", 64);
		if (!(ZAP_LIST != "none")) return;
		if (GetTokenCount(ZAP_LIST, ";") > 1)
		{
			ScrambleTokens(ZAP_LIST, ";");
		}
		ZAP_TARGET = GetToken(ZAP_LIST, 0, ";");
	}

	void do_poison_breath()
	{
		stop_movement();
		npcatk_suspend_ai();
		SetMoveAnim(ANIM_FIRE_BREATH);
		SetIdleAnim(ANIM_FIRE_BREATH);
		PlayAnim("critical", ANIM_FIRE_BREATH);
		SPIN_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		SPIN_ANG += 180;
		if (SPIN_ANG > 359)
		{
			SPIN_ANG -= 359;
		}
		SPIN_ON = 1;
		// svplaysound: svplaysound 1 10 SOUND_POISON_BREATH
		EmitSound(1, 10, SOUND_POISON_BREATH);
		EmitSound(GetOwner(), 0, SOUND_POISON_BREATH_START, 10);
		ScheduleDelayedEvent(0.06, "cl_breath_on");
		poison_breath_spin();
		ScheduleDelayedEvent(8.0, "stop_poison_breath_spin");
		POISON_BREATH_ON = 1;
	}

	void cl_breath_on()
	{
		ClientEvent("update", "all", CL_IDX, "kh_poison_breath_on", "poison_cloud.spr");
	}

	void stop_poison_breath_spin()
	{
		// svplaysound: svplaysound 1 0 SOUND_POISON_BREATH
		EmitSound(1, 0, SOUND_POISON_BREATH);
		ClientEvent("update", "all", CL_IDX, "kh_poison_breath_off");
		SPIN_ON = 0;
		resume_movement();
		npcatk_resume_ai();
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += 1.0;
		POISON_BREATH_ON = 0;
	}

	void poison_breath_spin()
	{
		if (!(SPIN_ON)) return;
		ScheduleDelayedEvent(0.05, "poison_breath_spin");
		string FACE_POS = GetEntityOrigin(GetOwner());
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, SPIN_ANG, 0), Vector3(0, 100, 0));
		SetMoveDest(FACE_POS);
		if (GetGameTime() > NEXT_BURN)
		{
			NEXT_BURN = GetGameTime();
			NEXT_BURN += 0.5;
			string BURN_TARGET = GetEntityOrigin(GetOwner());
			BURN_LIST = FindEntitiesInSphere("enemy", 512);
			string N_BURN_LIST = GetTokenCount(BURN_LIST, ";");
			if (N_BURN_LIST > 0)
			{
			}
			for (int i = 0; i < N_BURN_LIST; i++)
			{
				poison_targets();
			}
		}
		SPIN_ANG += 10;
		if (SPIN_ANG > 359)
		{
			SPIN_ANG -= 359;
		}
	}

	void poison_targets()
	{
		string CUR_TARGET = GetToken(BURN_LIST, i, ";");
		if (!(IsEntityAlive(CUR_TARGET))) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARGET);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		if (!(GetEntityRange(CUR_TARGET) < 256)) return;
		if (!(GetEntityHeight(CUR_TARGET) > 36)) return;
		ApplyEffect(CUR_TARGET, "effects/dot_poison_blind", 10.0, GetEntityIndex(GetOwner()), DOT_POISON, 0, 0, "none");
		AddVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(0, 200, 110));
	}

	void OnDamage(int damage) override
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(GetEntityHealth(GetOwner()) > param2)) return;
		if ((FLIGHT_MODE))
		{
			if ((param3).findFirst("effect") >= 0)
			{
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (RandomInt(1, 10) == 1)
			{
				npcatk_flee(GetEntityIndex(param1), 4096, 5.0);
			}
		}
		if ((FLIGHT_MODE)) return;
		if ((MIRRORS_ON)) return;
		if ((POISON_BREATH_ON)) return;
		string DMG_TYPE = param3;
		if ((param3).findFirst("effect") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetGameTime() > NEXT_DODGE)) return;
		NEXT_DODGE = GetGameTime();
		NEXT_DODGE += FREQ_DODGE;
		ClientEvent("persist", "all", "effects/sfx_motionblur_perm", GetEntityIndex(GetOwner()), 0, 0);
		CL_IDX_SHADOW = "game.script.last_sent_id";
		string RND_ANG = Random(0, 359);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, RND_ANG, 0), Vector3(0, 1000, 0)));
		EmitSound(GetOwner(), 0, SOUND_DODGE, 10);
		ScheduleDelayedEvent(0.25, "stop_shadow_shift");
	}

	void stop_shadow_shift()
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 0));
		ClientEvent("remove", "all", CL_IDX_SHADOW);
	}

	void prep_hold_person()
	{
		ScheduleDelayedEvent(2.0, "prep_hold_person2");
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_PREP_DEPLOY);
		SetIdleAnim(ANIM_PREP_DEPLOY);
		SetMoveAnim(ANIM_PREP_DEPLOY);
		ClientEvent("update", "all", CL_IDX, "kh_hand_sprites", 2.0, Vector3(255, 255, 255));
		EmitSound(GetOwner(), 0, SOUND_FIRE_PREP, 10);
	}

	void prep_hold_person2()
	{
		PlayAnim("critical", ANIM_RELEASE_DEPLOY);
		EmitSound(GetOwner(), 0, SOUND_FIREBALL_RELEASE, 10);
		npcatk_resume_ai();
		resume_movement();
		TossProjectile("proj_hold_person", /* TODO: $relpos */ $relpos(0, 0, 24), m_hAttackTarget, 50, 0, 0, "none");
	}

	void prep_flight_mode()
	{
		EmitSound(GetOwner(), 0, SOUND_FLIGHT_START, 10);
		FREQ_SOUND_FLIGHT_LOOP("flight_sound");
		FLOAT_DIR = -25;
		FLIGHT_MODE = 1;
		stop_movement();
		npcatk_suspend_ai();
		SetMoveAnim(ANIM_MIRROR_PREP);
		SetIdleAnim(ANIM_MIRROR_PREP);
		PlayAnim("critical", ANIM_MIRROR_PREP);
		SPIN_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		MIRROR_ANG = SPIN_ANG;
		SPIN_ON = 1;
		SPIN_SPEED = 1;
		FADE_LEVEL = 255;
		flight_mode_spinup();
		ScheduleDelayedEvent(2.0, "stop_flight_mode_spinup");
		ClientEvent("update", "all", CL_IDX, "kh_flight_sprites", 1);
		SOUND_FLIGHT_LOOP("flight_sound");
	}

	void stop_flight_mode_spinup()
	{
		SPIN_ON = 0;
		resume_movement();
		npcatk_resume_ai();
		FLIGHT_DURATION("end_flight_mode");
		SetGravity(0);
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += 1.0;
	}

	void flight_mode_spinup()
	{
		if (!(SPIN_ON)) return;
		ScheduleDelayedEvent(0.05, "mirror_spin");
		SPIN_ANG += SPIN_SPEED;
		SPIN_SPEED += 1;
		if (SPIN_ANG > 359)
		{
			SPIN_ANG -= 359;
		}
		string FACE_POS = GetEntityOrigin(GetOwner());
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, SPIN_ANG, 0), Vector3(0, 100, 0));
		SetMoveDest(FACE_POS);
	}

	void end_flight_mode()
	{
		SetGravity(1);
		FLIGHT_MODE = 0;
		NEXT_FLIGHT = GetGameTime();
		NEXT_FLIGHT += FREQ_FLIGHT;
		ClientEvent("update", "all", CL_IDX, "kh_flight_sprites", 0);
	}

	void game_movingto_dest()
	{
		if (!(FLIGHT_MODE)) return;
		SetAnimMoveSpeed(FLIGHT_SPEED);
	}

	void game_stopmoving()
	{
		if (!(FLIGHT_MODE)) return;
		SetAnimMoveSpeed(0);
	}

	void flight_sound()
	{
		if (!(FLIGHT_MODE)) return;
		EmitSound(GetOwner(), 0, SOUND_FLIGHT_LOOP, 10);
		FREQ_SOUND_FLIGHT_LOOP("flight_sound");
	}

}

}
