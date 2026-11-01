#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_lightning_shield.as"

namespace MS
{

class BurningOne : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DEPLOY;
	string ANIM_DUCK_ATTACK;
	string ANIM_DUCK_BEAM;
	string ANIM_DUCK_IDLE;
	string ANIM_DUCK_MOVE;
	string ANIM_DUCK_RPG;
	string ANIM_DUCK_SPELL;
	string ANIM_DUCK_THROW;
	string ANIM_ICE_BREATH;
	string ANIM_ICE_SPIRAL;
	string ANIM_IDLE;
	string ANIM_JUMP;
	string ANIM_LIMP_WRIST;
	string ANIM_LONG_JUMP;
	string ANIM_MIRROR_PREP;
	string ANIM_PREP_DEPLOY;
	string ANIM_RELEASE_DEPLOY;
	string ANIM_RUN;
	string ANIM_RUN_SKELE_MODE;
	string ANIM_SHOOT;
	string ANIM_SKELE_DUCK_SWIPE;
	string ANIM_SKELE_SWIPE;
	string ANIM_THROW;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_HITRANGE_MELEE;
	int ATTACK_MOVERANGE;
	int ATTACK_MOVERANGE_LONG;
	int ATTACK_MOVERANGE_MELEE;
	int ATTACK_RANGE;
	int ATTACK_RANGE_MELEE;
	string BALL_TYPE;
	string CFB_EST_ANG;
	string CFB_EST_ORG;
	int CFB_FIREBALL_ACTIVE;
	string CFB_FIREBALL_IDX;
	int CFB_FIRST_TARGET_FOUND;
	string CFB_FORCE_END;
	string CFB_LIST;
	string CFB_NEXT_SCAN;
	string CL_PRIMARY_SCRIPT;
	string DEF_ANIM_IDLE;
	string DEF_ANIM_RUN;
	string DEF_ANIM_WALK;
	string DID_INTRO;
	string DID_SUMMONS;
	int DMG_ICE_BALL;
	int DMG_PALPATINE;
	int DMG_SWIPE;
	int DOT_FROST;
	int DOT_ICE_BALL;
	int DOT_ICE_CAGE;
	string DUCK_MODE;
	string FREEZE_LIST;
	string FREEZE_SCRIPT_IDX;
	float FREQ_DODGE;
	float FREQ_DUCK_SWITCH;
	float FREQ_JUMP;
	string HALF_HP;
	int ICE_BREATH_ON;
	int IS_UNHOLY;
	int LHAND_ATCH;
	string LSHIELD_CLFX_SCRIPT;
	int LSHIELD_RADIUS;
	string LSHIELD_TARGET;
	int MOUTH_ATCH;
	string NEXT_DODGE;
	string NEXT_FREEZE;
	string NEXT_SPECIAL;
	string NEXT_TOUCH_ZAP;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	int NPC_NO_ATTACK;
	int N_SPECIALS;
	int PALPATINE_ON;
	string PALPATINE_TARGETS;
	float PROJ_HOLD_DURATION;
	string REPULSE_LIST;
	int RHAND_ATCH;
	string SHENDER_MAP;
	string SOUND_BREATH;
	string SOUND_DEATH;
	string SOUND_DODGE;
	string SOUND_FREEZE_SLAP;
	string SOUND_ICEBALL_RELEASE;
	string SOUND_ICE_PREP;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_SCREAM;
	string SOUND_SKELE_LAUGH1;
	string SOUND_SKELE_LAUGH2;
	string SOUND_SWIPE1;
	string SOUND_SWIPE2;
	string SOUND_SWIPE3;
	string SOUND_SWIPE4;
	string SOUND_ZAP_LOOP;
	string SOUND_ZAP_START;
	int SPECIAL_CYCLE;
	string SPECIAL_OVERRIDE;
	string SPIN_ANG;
	int SPIN_ON;
	string SWIPE_ATTACK;

	BurningOne()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_IDLE = "idle";
		ANIM_DEATH = "die_forwards2";
		ANIM_RUN_SKELE_MODE = "run";
		ANIM_JUMP = "jump";
		ANIM_LONG_JUMP = "long_jump";
		ANIM_THROW = "ref_shoot_crowbar";
		ANIM_SHOOT = "ref_shoot_smartgun";
		ANIM_DEPLOY = "ref_shoot_grenade";
		ANIM_SKELE_SWIPE = "ref_shoot_crowbar";
		ANIM_SKELE_DUCK_SWIPE = "crouch_shoot_crowbar";
		ANIM_LIMP_WRIST = "ref_aim_crowbar";
		ANIM_PREP_DEPLOY = "ref_aim_trip";
		ANIM_RELEASE_DEPLOY = "ref_shoot_trip";
		ANIM_MIRROR_PREP = "ref_aim_grenade";
		ANIM_ICE_SPIRAL = "ref_shoot_smartgun";
		ANIM_ICE_BREATH = "float";
		ANIM_DUCK_IDLE = "crouch_idle";
		ANIM_DUCK_MOVE = "crawl";
		ANIM_DUCK_BEAM = "crouch_shoot_smartgun";
		ANIM_DUCK_THROW = "crouch_shoot_grenade";
		ANIM_DUCK_ATTACK = "crouch_shoot_crowbar";
		ANIM_DUCK_RPG = "crouch_shoot_rpg";
		ANIM_DUCK_SPELL = "crouch_shoot_trip";
		IS_UNHOLY = 1;
		ATTACK_RANGE = 256;
		ATTACK_MOVERANGE = 256;
		ATTACK_HITRANGE = 256;
		NPC_NO_ATTACK = 1;
		NPC_GIVE_EXP = 8000;
		LSHIELD_CLFX_SCRIPT = "monsters/burning_one_lshield_cl";
		LSHIELD_RADIUS = 64;
		SPECIAL_CYCLE = 0;
		N_SPECIALS = 4;
		PROJ_HOLD_DURATION = 20.0;
		CL_PRIMARY_SCRIPT = "monsters/burning_one_cl";
		ATTACK_RANGE_MELEE = 96;
		ATTACK_HITRANGE_MELEE = 160;
		ATTACK_MOVERANGE_MELEE = 64;
		ATTACK_MOVERANGE_LONG = 256;
		LHAND_ATCH = 1;
		RHAND_ATCH = 2;
		MOUTH_ATCH = 3;
		FREQ_DODGE = 4.0;
		DOT_ICE_BALL = 200;
		DMG_ICE_BALL = 800;
		DOT_ICE_CAGE = 200;
		DMG_PALPATINE = 75;
		DMG_SWIPE = 200;
		DOT_FROST = 200;
		FREQ_JUMP = Random(5.0, 15.0);
		FREQ_DUCK_SWITCH = Random(10.0, 20.0);
		SOUND_ICEBALL_RELEASE = "ambience/alienflyby1.wav";
		SOUND_ICE_PREP = "magic/spookie1.wav";
		SOUND_DODGE = "magic/frost_reverse.wav";
		SOUND_BREATH = "monsters/goblin/sps_fogfire.wav";
		SOUND_ZAP_LOOP = "magic/bolt_loop.wav";
		SOUND_ZAP_START = "magic/bolt_end.wav";
		SOUND_SCREAM = "monsters/spooky_scream.wav";
		SOUND_SWIPE1 = "zombie/claw_miss1.wav";
		SOUND_SWIPE2 = "zombie/claw_miss2.wav";
		SOUND_SWIPE3 = "monsters/goblin/c_gargoyle_atk1.wav";
		SOUND_SWIPE4 = "monsters/goblin/c_gargoyle_atk2.wav";
		SOUND_DEATH = "monsters/goblin/c_gargoyle_dead.wav";
		SOUND_PAIN1 = "monsters/goblin/c_gargoyle_hit1.wav";
		SOUND_PAIN2 = "monsters/goblin/c_gargoyle_hit2.wav";
		SOUND_SKELE_LAUGH1 = "monsters/goblin/c_gargoyle_bat1.wav";
		SOUND_SKELE_LAUGH2 = "monsters/goblin/c_gargoyle_bat2.wav";
		SOUND_FREEZE_SLAP = "monsters/goblin/c_gargoyle_atk3.wav";
		SetCallback("touch", "enable");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(20.0);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 128, 0), 256, 20.0);
	}

	void game_precache()
	{
		Precache("monsters/summon/client_side_fireball");
		Precache("effects/sfx_motionblur_perm");
		Precache("monsters/burning_one_cl");
	}

	void OnSpawn() override
	{
		SetName("Burning One");
		SetRace("demon");
		SetWidth(32);
		SetHeight(80);
		SetModel("monsters/hollow_one.mdl");
		SetRoam(false);
		SetHealth(9000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 1.0);
		SetProp(GetOwner(), "skin", 0);
		SetModelBody(0, 2);
		SetModelBody(1, 3);
		SetHearingSensitivity(10);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetRoam(true);
		DEF_ANIM_WALK = ANIM_WALK;
		DEF_ANIM_RUN = ANIM_RUN;
		DEF_ANIM_IDLE = ANIM_IDLE;
	}

	void cycle_up()
	{
		if (!(DID_INTRO))
		{
			DID_INTRO = 1;
			if (StringToLower(GetMapName()) == "shender_east")
			{
			}
			SHENDER_MAP = 1;
			HALF_HP = GetEntityMaxHealth(GetOwner());
			HALF_HP *= 0.5;
			UseTrigger("spawn_ruins_escort");
			ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 128, 0), 256, 20.0);
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		if (GetGameTime() > NEXT_SPECIAL)
		{
			do_special();
		}
		if (GetGameTime() > NEXT_DODGE)
		{
			if (GetEntityRange(m_hAttackTarget) < 96)
			{
			}
			shadow_shift();
		}
	}

	void resume_movement()
	{
		if (!(FLIGHT_MODE))
		{
			ANIM_WALK = DEF_ANIM_WALK;
			ANIM_RUN = DEF_ANIM_RUN;
			ANIM_IDLE = DEF_ANIM_IDLE;
			SetMoveAnim(ANIM_RUN);
			SetIdleAnim(ANIM_IDLE);
			SetRoam(true);
		}
		else
		{
			SetMoveAnim(ANIM_FLOAT);
			SetIdleAnim(ANIM_FLOAT);
		}
	}

	void suspend_movement()
	{
		if (!(FLIGHT_MODE))
		{
			ANIM_WALK = param1;
			ANIM_RUN = param1;
			ANIM_IDLE = param1;
			SetMoveAnim(param1);
			SetIdleAnim(param1);
			SetRoam(false);
		}
	}

	void do_special()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		SPECIAL_CYCLE += 1;
		if (SPECIAL_CYCLE > N_SPECIALS)
		{
			SPECIAL_CYCLE = 1;
		}
		if ((G_DEVELOPER_MODE))
		{
			if (SPECIAL_OVERRIDE > 0)
			{
			}
			SPECIAL_CYCLE = SPECIAL_OVERRIDE;
		}
		if (SPECIAL_CYCLE == 1)
		{
			LogDebug("do_special: iceball");
			prep_iceball();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 25.0;
		}
		if (SPECIAL_CYCLE == 2)
		{
			do_ice_breath();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 10.0;
		}
		if (SPECIAL_CYCLE == 3)
		{
			prep_hold_person();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 5.0;
		}
		if (SPECIAL_CYCLE == 4)
		{
			if (!(DUCK_MODE))
			{
			}
			do_palpatine();
			NEXT_SPECIAL = GetGameTime();
			NEXT_SPECIAL += 10.0;
		}
	}

	void prep_iceball()
	{
		ScheduleDelayedEvent(2.0, "prep_iceball2");
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_PREP_DEPLOY);
		SetIdleAnim(ANIM_PREP_DEPLOY);
		SetMoveAnim(ANIM_PREP_DEPLOY);
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), LHAND_ATCH, GetOwner(), RHAND_ATCH, Vector3(255, 128, 0), 200, 200, 2.0);
		EmitSound(GetOwner(), 0, SOUND_ICE_PREP, 10);
	}

	void prep_iceball2()
	{
		PlayAnim("critical", ANIM_RELEASE_DEPLOY);
		EmitSound(GetOwner(), 0, SOUND_ICEBALL_RELEASE, 10);
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
		ClientEvent("new", "all", "monsters/summon/client_side_fireball", CFB_EST_ORG, START_ANGS);
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
		XDoDamage(CFB_EST_ORG, 128, DMG_ICE_BALL, 0, GetOwner(), GetOwner(), "none", "fire_effect");
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
		ApplyEffect(CHECK_ENT, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_ICE_BALL);
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

	void prep_hold_person()
	{
		ScheduleDelayedEvent(2.0, "prep_hold_person2");
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_PREP_DEPLOY);
		SetIdleAnim(ANIM_PREP_DEPLOY);
		SetMoveAnim(ANIM_PREP_DEPLOY);
		ClientEvent("new", "all", CL_PRIMARY_SCRIPT, "hand_sprites", GetEntityIndex(GetOwner()), 2.0, Vector3(64, 64, 255));
		EmitSound(GetOwner(), 0, SOUND_ICE_PREP, 10);
	}

	void prep_hold_person2()
	{
		PlayAnim("critical", ANIM_RELEASE_DEPLOY);
		EmitSound(GetOwner(), 0, SOUND_ICEBALL_RELEASE, 10);
		npcatk_resume_ai();
		resume_movement();
		TossProjectile("proj_hold_person", /* TODO: $relpos */ $relpos(0, 0, 24), m_hAttackTarget, 50, 0, 0, "none");
	}

	void shadow_shift()
	{
		if (!(GetGameTime() > NEXT_DODGE)) return;
		NEXT_DODGE = GetGameTime();
		NEXT_DODGE += FREQ_DODGE;
		ClientEvent("persist", "all", "effects/sfx_motionblur_temp", GetEntityIndex(GetOwner()), 0, 1, 3.0);
		float RND_ANG = Random(0, 359);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, RND_ANG, 0), Vector3(0, 1000, 0)));
		EmitSound(GetOwner(), 0, SOUND_DODGE, 10);
		ScheduleDelayedEvent(0.25, "stop_shadow_shift");
	}

	void stop_shadow_shift()
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 0));
	}

	void OnDamage(int damage) override
	{
		if ((SHENDER_MAP))
		{
			if (GetEntityHealth(GetOwner()) < HALF_HP)
			{
			}
			if (!(DID_SUMMONS))
			{
			}
			DID_SUMMONS = 1;
			UseTrigger("spawn_ruins_summons");
		}
		if ((PALPATINE_ON))
		{
			if (GetEntityRange(param1) < 256)
			{
			}
			SetMoveDest(param1);
		}
		if ((PALPATINE_ON)) return;
		if (!(GetEntityRange(param1) > 128)) return;
		if (!(param2 > 75)) return;
		shadow_shift();
	}

	void OnTouch(CBaseEntity@ other) override
	{
		if (!(LSHIELD_PASSIVE_ENABLE)) return;
		if (!(GetGameTime() > NEXT_TOUCH_ZAP)) return;
		NEXT_TOUCH_ZAP = GetGameTime();
		NEXT_TOUCH_ZAP += 0.1;
		if (!(GetRelationship(GetOwner()) == "enemy")) return;
		LSHIELD_TARGET = param1;
		lshield_passive_zap_target();
	}

	void do_ice_breath()
	{
		npcatk_suspend_ai();
		suspend_movement(ANIM_ICE_BREATH);
		PlayAnim("critical", ANIM_ICE_BREATH);
		SPIN_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		SPIN_ON = 1;
		SPIN_ANG -= 45;
		if (SPIN_ANG < 0)
		{
			SPIN_ANG += 359;
		}
		// svplaysound: svplaysound 1 10 SOUND_BREATH
		EmitSound(1, 10, SOUND_BREATH);
		ClientEvent("new", "all", CL_PRIMARY_SCRIPT, "ice_breath", GetEntityIndex(GetOwner()), 8.0);
		FREEZE_SCRIPT_IDX = "game.script.last_sent_id";
		ice_breath_spin();
		ScheduleDelayedEvent(8.0, "stop_ice_breath_spin");
		ICE_BREATH_ON = 1;
	}

	void stop_ice_breath_spin()
	{
		// svplaysound: svplaysound 1 0 SOUND_BREATH
		EmitSound(1, 0, SOUND_BREATH);
		ClientEvent("update", "all", FREEZE_SCRIPT_IDX, "ice_breath_off");
		SPIN_ON = 0;
		resume_movement();
		npcatk_resume_ai();
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += 1.0;
		ICE_BREATH_ON = 0;
	}

	void ice_breath_spin()
	{
		if (!(SPIN_ON)) return;
		ScheduleDelayedEvent(0.05, "ice_breath_spin");
		string FACE_POS = GetEntityOrigin(GetOwner());
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, SPIN_ANG, 0), Vector3(0, 100, 0));
		SetMoveDest(FACE_POS);
		if (GetGameTime() > NEXT_FREEZE)
		{
			NEXT_FREEZE = GetGameTime();
			NEXT_FREEZE += 0.5;
			FREEZE_LIST = FindEntitiesInSphere("enemy", 512);
			if (FREEZE_LIST != "none")
			{
			}
			for (int i = 0; i < GetTokenCount(FREEZE_LIST, ";"); i++)
			{
				freeze_targets();
			}
		}
		SPIN_ANG += 10;
		if (SPIN_ANG > 359)
		{
			SPIN_ANG -= 359;
		}
	}

	void freeze_targets()
	{
		string CUR_TARGET = GetToken(FREEZE_LIST, i, ";");
		if (!(IsEntityAlive(CUR_TARGET))) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARGET);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		if (!(GetEntityRange(CUR_TARGET) < 256)) return;
		if (!(GetEntityHeight(CUR_TARGET) > 36)) return;
		LogDebug("freeze_targets GetEntityName(CUR_TARGET)");
		ApplyEffect(CUR_TARGET, "effects/dot_fire", 10.0, GetEntityIndex(GetOwner()), DOT_ICE_CAGE);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		SetVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(0, 500, 0)));
	}

	void do_palpatine()
	{
		ATTACK_MOVERANGE = ATTACK_MOVERANGE_LONG;
		SetMoveDest(m_hAttackTarget);
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai();
		suspend_movement(ANIM_PREP_DEPLOY);
		ClientEvent("new", "all", CL_PRIMARY_SCRIPT, "palpatine", GetEntityIndex(GetOwner()), 8.0);
		EmitSound(GetOwner(), 0, SOUND_ZAP_START, 10);
		// svplaysound: svplaysound 1 10 SOUND_ZAP_LOOP
		EmitSound(1, 10, SOUND_ZAP_LOOP);
		PALPATINE_ON = 1;
		ScheduleDelayedEvent(8.0, "palpatine_end");
		palpatine_loop();
	}

	void palpatine_end()
	{
		PALPATINE_ON = 0;
		npcatk_resume_ai();
		resume_movement();
		// svplaysound: svplaysound 1 0 SOUND_ZAP_LOOP
		EmitSound(1, 0, SOUND_ZAP_LOOP);
	}

	void palpatine_loop()
	{
		if (!(PALPATINE_ON)) return;
		ScheduleDelayedEvent(0.1, "palpatine_loop");
		PALPATINE_TARGETS = FindEntitiesInSphere("enemy", 256);
		if (!(PALPATINE_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(PALPATINE_TARGETS, ";"); i++)
		{
			palpatine_shock_targs();
		}
	}

	void palpatine_shock_targs()
	{
		string CUR_TARG = GetToken(PALPATINE_TARGETS, i, ";");
		if (!(IsEntityAlive(CUR_TARG))) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		if (!(GetEntityHeight(CUR_TARG) > 36)) return;
		DoDamage(CUR_TARG, "direct", DMG_PALPATINE, 1.0, GetOwner());
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(0, 200, 110));
	}

	void game_dynamically_created()
	{
		if (!(param1 > 0)) return;
		SPECIAL_OVERRIDE = param1;
	}

	void toggle_duck_mode()
	{
		if ((DUCK_MODE))
		{
			DUCK_MODE = 1;
			ANIM_ATTACK = ANIM_SKELE_DUCK_SWIPE;
			ANIM_WALK = ANIM_DUCK_MOVE;
			ANIM_RUN = ANIM_DUCK_MOVE;
			ANIM_IDLE = ANIM_DUCK_IDLE;
			DEF_ANIM_WALK = ANIM_WALK;
			DEF_ANIM_RUN = ANIM_RUN;
			DEF_ANIM_IDLE = ANIM_IDLE;
			SetMoveAnim(ANIM_RUN);
			SetIdleAnim(ANIM_IDLE);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(DUCK_MODE))
		{
			DUCK_MODE = 0;
			ANIM_ATTACK = ANIM_SKELE_SWIPE;
			ANIM_WALK = "walk";
			ANIM_RUN = "run";
			ANIM_IDLE = "idle";
			DEF_ANIM_WALK = ANIM_WALK;
			DEF_ANIM_RUN = ANIM_RUN;
			DEF_ANIM_IDLE = ANIM_IDLE;
			SetMoveAnim(ANIM_RUN);
			SetIdleAnim(ANIM_IDLE);
		}
	}

	void leap_away()
	{
		npcatk_suspend_ai(2.0);
		ScheduleDelayedEvent(2.0, "force_leap_end");
		suspend_movement(ANIM_LONG_JUMP);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		if (!(IsEntityAlive(param1)))
		{
			SetMoveDest(m_hAttackTarget);
		}
		else
		{
			SetMoveDest(param1);
		}
		NPC_FORCED_MOVEDEST = 1;
		PlayAnim("critical", ANIM_LONG_JUMP);
		repulse_area(GetEntityOrigin(GetOwner()));
		ScheduleDelayedEvent(0.1, "leap_away_boost");
	}

	void leap_away_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 1000, 800));
	}

	void frame_long_jump_land()
	{
		npcatk_resume_ai();
		resume_movement();
	}

	void force_leap_end()
	{
		npcatk_resume_ai();
		resume_movement();
	}

	void repulse_area()
	{
		EmitSound(GetOwner(), 0, "magic/boom.wav", 10);
		ClientEvent("new", "all", CL_PRIMARY_SCRIPT, "repulse", GetEntityOrigin(GetOwner()), 128);
		REPULSE_LIST = FindEntitiesInSphere("any", 128);
		if (!(REPULSE_LIST != "none")) return;
		for (int i = 0; i < GetTokenCount(REPULSE_LIST, ";"); i++)
		{
			repulse_targets();
		}
	}

	void repulse_targets()
	{
		string CUR_TARG = GetToken(REPULSE_LIST, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 10)));
	}

	void my_target_died()
	{
		// PlayRandomSound from: SOUND_SKELE_LAUGH1, SOUND_SKELE_LAUGH2
		array<string> sounds = {SOUND_SKELE_LAUGH1, SOUND_SKELE_LAUGH2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dodamage()
	{
		if ((SWIPE_ATTACK))
		{
			if (RandomInt(1, 3) == 1)
			{
			}
			if ((param1))
			{
			}
			if (GetRelationship(param2) == "enemy")
			{
			}
			// PlayRandomSound from: SOUND_FREEZE_SLAP
			array<string> sounds = {SOUND_FREEZE_SLAP};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
			ApplyEffect(param2, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FROST);
			SWIPE_ATTACK = 0;
		}
	}

}

}
