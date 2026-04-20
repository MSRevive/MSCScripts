#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class ElfWizardBase : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_DEATH1;
	string ANIM_DEATH2;
	string ANIM_DEATH3;
	string ANIM_DEATH4;
	string ANIM_DEATH5;
	string ANIM_DEATH6;
	string ANIM_DEATH7;
	string ANIM_DUCK_MOVE;
	string ANIM_HOP;
	string ANIM_IDLE;
	string ANIM_JUMP;
	string ANIM_LOOK;
	string ANIM_MELEE;
	string ANIM_MELEE_DUCK;
	string ANIM_PALM_ATTACK;
	string ANIM_PREP_EGG;
	string ANIM_RELEASE_EGG;
	string ANIM_REPELL;
	string ANIM_RUN;
	string ANIM_SHIELD_HOLD;
	string ANIM_SPELL_HOLD;
	string ANIM_SPELL_LEFT_HOLD;
	string ANIM_SPELL_PREP;
	string ANIM_SPELL_RELEASE;
	string ANIM_STAFF_HOLD;
	string ANIM_WALK;
	string ANIM_XBOW_AIM;
	string ANIM_XBOW_AIM_DUCK;
	string ANIM_XBOW_FIRE;
	string ANIM_XBOW_FIRE_DUCK;
	string ANIM_XBOW_RELOAD;
	string ANIM_XBOW_RELOAD_DUCK;
	string AS_ATTACKING;
	int ATTACH_LHAND;
	int ATTACH_RHAND;
	int ATTACH_STAFF_HILT;
	int ATTACH_STAFF_TIP;
	string ATTACK_HITRANGE;
	int ATTACK_HITRANGE_MELEE;
	string ATTACK_RANGE;
	string BEAM_TARGET;
	string CFB_EST_ANG;
	string CFB_EST_ORG;
	string CFB_FIREBALL_IDX;
	int CFB_FIRST_TARGET_FOUND;
	string CFB_FORCE_END;
	string CFB_NEXT_SCAN;
	int CFB_SPEED;
	string DEF_ANIM_IDLE;
	string DEF_ANIM_RUN;
	string DEF_ANIM_WALK;
	int DMG_MELEE;
	int DMG_XBOW;
	string ELF_AIM_ANGLES;
	string ELF_BEAM_ATTACK;
	string ELF_BEAM_COLOR;
	int ELF_BEAM_DMG;
	string ELF_BEAM_DMG_TYPE;
	int ELF_BEAM_DOT;
	float ELF_BEAM_DUR;
	string ELF_BEAM_EFFECT;
	int ELF_BEAM_ON;
	string ELF_BEAM_PUSH_VEL;
	int ELF_BEAM_RANGE;
	string ELF_BEAM_SPECIAL;
	string ELF_BOLT_LAND;
	int ELF_CAN_GUIDED;
	int ELF_EXPLOSIVE_BOLTS;
	int ELF_GUIDED_ACTIVE;
	int ELF_GUIDED_DMG;
	string ELF_GUIDED_DOT;
	string ELF_GUIDED_DOTS;
	float ELF_GUIDED_DURATION;
	string ELF_GUIDED_SCRIPT;
	string ELF_GUIDED_TYPE;
	string ELF_GUIDED_TYPES;
	string ELF_HALF_HEALTH;
	int ELF_IS_ARCHER;
	int ELF_IS_NOVICE;
	string ELF_MELEE_PUSH_VEL;
	string ELF_MISS_COUNT;
	string ELF_MODEL;
	int ELF_PALM_ATTACK;
	string ELF_PALM_CL_SCRIPT;
	int ELF_PALM_DMG;
	int ELF_PALM_RANGE;
	string ELF_PALM_TARGET;
	int ELF_XBOW_ACCURACY;
	int ELF_XBOW_BONE;
	string ELF_XBOW_CL_SCRIPT;
	string ELF_XBOW_CL_SCRIPT_ID;
	string ELF_XBOW_DUCK_OFS;
	string ELF_XBOW_REPELL_POINT;
	int ELF_XBOW_SHOT;
	string ELF_XBOW_STAND_OFS;
	string ELF_XBOW_TARGETS;
	string FIRST_CYCLE;
	float FREQ_GUIDED;
	float FREQ_PALM;
	float FREQ_XBOW_BASH;
	string NEXT_GUIDED;
	string NEXT_SCRIPT_UPDATE;
	string NEXT_XBOW_BASH;
	string NPC_RANGED;
	string SOUND_BOLT_HIT;
	string SOUND_DEATH;
	string SOUND_ELF_BEAM_START;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_XBOW_SHOOT;
	string SOUND_XBOW_STRETCH;

	ElfWizardBase()
	{
		ELF_MODEL = "npc/elf_m_wizard.mdl";
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk2handed";
		ANIM_RUN = "run2";
		ANIM_DEATH = "die_simple";
		ANIM_LOOK = "look_idle";
		ANIM_HOP = "jump";
		ANIM_JUMP = "long_jump";
		ANIM_MELEE = "ref_shoot_crowbar";
		ANIM_PALM_ATTACK = "ref_shoot_trip";
		ANIM_XBOW_AIM = "ref_aim_bow";
		ANIM_XBOW_FIRE = "ref_shoot_bow";
		ANIM_XBOW_RELOAD = "ref_shoot_squeak";
		ANIM_DUCK_MOVE = "crawl";
		ANIM_MELEE_DUCK = "crouch_shoot_crowbar";
		ANIM_XBOW_AIM_DUCK = "crouch_aim_bow";
		ANIM_XBOW_FIRE_DUCK = "crouch_shoot_bow";
		ANIM_XBOW_RELOAD_DUCK = "crouch_aim_squeak";
		ANIM_SPELL_HOLD = "ref_aim_onehanded";
		ANIM_SPELL_LEFT_HOLD = "ref_aim_egon";
		ANIM_SPELL_PREP = "ref_aim_trip";
		ANIM_SPELL_RELEASE = "ref_shoot_trip";
		ANIM_REPELL = "ref_shoot_trip";
		ANIM_PREP_EGG = "ref_aim_squeak";
		ANIM_RELEASE_EGG = "ref_shoot_squeak";
		ANIM_SHIELD_HOLD = "aim_2";
		ANIM_STAFF_HOLD = "ref_aim_crowbar";
		ANIM_DEATH1 = "die_simple";
		ANIM_DEATH2 = "die_backwards1";
		ANIM_DEATH3 = "die_backwards";
		ANIM_DEATH4 = "die_forwards";
		ANIM_DEATH5 = "headshot";
		ANIM_DEATH6 = "die_spin";
		ANIM_DEATH7 = "gutshot";
		SOUND_DEATH = "voices/human/male_die.wav";
		Precache("weapons/bow/bolthit1.wav");
		ELF_IS_ARCHER = 0;
		ELF_EXPLOSIVE_BOLTS = 1;
		ELF_XBOW_CL_SCRIPT = "monsters/elf_xbow_cl";
		ELF_XBOW_STAND_OFS = Vector3(10, 0, 68);
		ELF_XBOW_DUCK_OFS = Vector3(10, 0, 32);
		ELF_XBOW_BONE = 27;
		DMG_XBOW = 200;
		FREQ_XBOW_BASH = 5.0;
		ELF_XBOW_ACCURACY = 75;
		ATTACK_HITRANGE_MELEE = 64;
		ATTACH_STAFF_TIP = 2;
		ATTACH_STAFF_HILT = 1;
		ATTACH_LHAND = 3;
		ATTACH_RHAND = 0;
		ELF_IS_NOVICE = 0;
		FREQ_GUIDED = 25.0;
		ELF_CAN_GUIDED = 0;
		ELF_GUIDED_TYPES = "fire;cold;lightning;poison";
		ELF_GUIDED_DOTS = "100;75;75;75";
		ELF_GUIDED_DMG = 200;
		ELF_GUIDED_DURATION = 20.0;
		ELF_GUIDED_SCRIPT = "monsters/summon/guided_sphere_cl";
		CFB_SPEED = 60;
		ELF_PALM_ATTACK = 0;
		ELF_PALM_DMG = 300;
		ELF_PALM_RANGE = 96;
		FREQ_PALM = 3.0;
		ELF_BEAM_DMG = 100;
		ELF_BEAM_DOT = 100;
		ELF_BEAM_DMG_TYPE = "lightning";
		ELF_BEAM_PUSH_VEL = /* TODO: $relvel */ $relvel(0, 300, 110);
		ELF_BEAM_DUR = 5.0;
		ELF_BEAM_RANGE = 512;
		ELF_BEAM_SPECIAL = "none";
		ELF_PALM_CL_SCRIPT = "effects/sfx_hit_shield";
		DMG_MELEE = 200;
		ELF_MELEE_PUSH_VEL = /* TODO: $relvel */ $relvel(10, 400, 110);
		SOUND_ELF_BEAM_START = "magic/bolt_start.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_XBOW_STRETCH = "weapons/bow/stretch.wav";
		SOUND_XBOW_SHOOT = "weapons/bow/crossbow.wav";
		SOUND_BOLT_HIT = "weapons/bow/bolthit1.wav";
	}

	void game_precache()
	{
		if ((ELF_IS_ARCHER))
		{
			Precache(ELF_XBOW_CL_SCRIPT);
			Precache("weapons/bows/boltexplosive.mdl");
			Precache("explode1.spr");
		}
		if ((ELF_PALM_ATTACK))
		{
			Precache("rain_ripple.spr");
		}
		if ((ELF_CAN_GUIDED))
		{
			Precache("debris/zap1.wav");
			Precache("debris/zap3.wav");
			Precache("debris/zap3.wav");
			Precache("3dmflaora.spr");
			Precache("magic/alien_frantic_1sec_noloop.wav");
			Precache("magic/alien_beacon_1sec_noloop.wav");
		}
	}

	void OnSpawn() override
	{
		SetModel(ELF_MODEL);
		SetWidth(24);
		SetHeight(80);
		SetRoam(true);
		SetHearingSensitivity(10);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("poison", 0.5);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("holy", 0.0);
		elf_spawn();
		ELF_HALF_HEALTH = GetEntityMaxHealth(GetOwner());
		ELF_HALF_HEALTH *= 0.5;
		DEF_ANIM_WALK = ANIM_WALK;
		DEF_ANIM_RUN = ANIM_RUN;
		DEF_ANIM_IDLE = ANIM_IDLE;
		FIRST_CYCLE = GetGameTime();
		FIRST_CYCLE += 5.0;
		if ((ELF_IS_ARCHER))
		{
			ATTACK_RANGE = 1024;
			ATTACK_HITRANGE = 1024;
			ANIM_ATTACK = ANIM_XBOW_FIRE;
			NPC_RANGED = 1;
			ELF_MISS_COUNT = 0;
		}
		if ((ELF_IS_NOVICE))
		{
			ATTACK_RANGE = 64;
			ATTACK_HITRANGE = 120;
			ANIM_ATTACK = ANIM_PALM_ATTACK;
		}
		if ((ELF_LIGHTNING_WIZARD))
		{
			ELF_BEAM_ATTACK = 1;
			ELF_BEAM_COLOR = Vector3(255, 128, 64);
			ELF_BEAM_EFFECT = "effects/dot_lightning";
		}
	}

	void frame_xbow_shoot_stand()
	{
		if ((ELF_IS_ARCHER))
		{
			elf_shoot_xbow();
		}
	}

	void frame_xbow_shoot_crouch()
	{
		if ((ELF_IS_ARCHER))
		{
			elf_shoot_xbow();
		}
	}

	void frame_xbow_reload_now()
	{
		if (!(ELF_IS_ARCHER)) return;
		EmitSound(GetOwner(), 0, SOUND_XBOW_STRETCH, 10);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 10.0;
		if (!(ELF_DUCK_MODE))
		{
			PlayAnim("critical", ANIM_XBOW_RELOAD);
		}
		else
		{
			PlayAnim("critical", ANIM_XBOW_RELOAD_DUCK);
		}
	}

	void frame_xbow_reloaded()
	{
		if (!(ELF_IS_ARCHER)) return;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 10.0;
		if (!(ELF_DUCK_MODE))
		{
			PlayAnim("critical", ANIM_XBOW_AIM);
		}
		else
		{
			PlayAnim("critical", ANIM_XBOW_AIM_DUCK);
		}
	}

	void frame_repell()
	{
		if (!(ELF_PALM_ATTACK)) return;
		string REPELL_SPRITE_ORG = /* TODO: $relpos */ $relpos(0, 32, 32);
		ClientEvent("new", "all", ELF_PALM_CL_SCRIPT, REPELL_SPRITE_ORG, GetEntityProperty(GetOwner(), "angles.yaw"), Vector3(255, 255, 255), 2.0, 2.0);
		EmitSound(GetOwner(), 0, "magic/frost_pulse.wav", 10);
		if ((IsEntityAlive(m_hAttackTarget)))
		{
			string FINAL_TARG = m_hAttackTarget;
		}
		else
		{
			string FINAL_TARG = ELF_PALM_TARGET;
		}
		DoDamage(FINAL_TARG, ELF_PALM_RANGE, ELF_PALM_DMG, 1.0, "magic");
		if (GetEntityRange(FINAL_TARG) < ELF_PALM_RANGE)
		{
			AddVelocity(FINAL_TARG, /* TODO: $relvel */ $relvel(10, 1000, 110));
		}
	}

	void frame_melee()
	{
		DoDamage(m_hAttackTarget, DMG_MELEE, ATTACK_HITRANGE_MELEE, 0.9, "blunt");
		if ((ELF_IS_ARCHER))
		{
			PlayAnim("critical", "frame_xbow_reloaded");
		}
		AddVelocity(m_hAttackTarget, ELF_MELEE_PUSH_VEL);
	}

	void elf_shoot_xbow()
	{
		EmitSound(GetOwner(), 1, SOUND_XBOW_SHOOT, 10);
		string START_LINE = GetEntityProperty(GetOwner(), "svbonepos");
		string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		if (RandomInt(1, 100) > ELF_XBOW_ACCURACY)
		{
			LogDebug("elf_shoot_xbow miss");
			float RND_X = Random(-64.0, 64.0);
			float RND_Y = Random(-64.0, 64.0);
			TARG_ORG += "x";
			TARG_ORG += "y";
		}
		if ((ELF_EXPLOSIVE_BOLTS))
		{
			TARG_ORG = "z";
		}
		ELF_AIM_ANGLES = /* TODO: $angles3d */ $angles3d(START_LINE, TARG_ORG);
		LogDebug("before ELF_AIM_ANGLES");
		string L_ANG = (ELF_AIM_ANGLES).x;
		string L_ANG = /* TODO: $neg */ $neg(L_ANG);
		ELF_AIM_ANGLES = "x";
		LogDebug("after ELF_AIM_ANGLES");
		string END_LINE = START_LINE;
		END_LINE += /* TODO: $relpos */ $relpos(ELF_AIM_ANGLES, Vector3(0, 2048, 0));
		ELF_XBOW_SHOT = 1;
		string END_LINE = TraceLine(START_LINE, END_LINE);
		ELF_BOLT_LAND = END_LINE;
		XDoDamage(START_LINE, END_LINE, DMG_XBOW, 1.0, GetOwner(), GetOwner(), "none", "pierce");
		ELF_XBOW_REPELL_POINT = END_LINE;
		if (ELF_XBOW_CL_SCRIPT_ID != "ELF_XBOW_CL_SCRIPT_ID")
		{
			ClientEvent("update", "all", ELF_XBOW_CL_SCRIPT_ID, "fire_bolt", START_LINE, END_LINE, ELF_AIM_ANGLES, ELF_EXPLOSIVE_BOLTS);
		}
		if ((ELF_EXPLOSIVE_BOLTS))
		{
			ScheduleDelayedEvent(0.1, "elf_do_explode");
		}
	}

	void elf_do_explode()
	{
		XDoDamage(ELF_BOLT_LAND, 128, DMG_XBOW, 0, GetOwner(), GetOwner(), "none", "fire_effect", "dmgevent:dbolt");
	}

	void game_dodamage()
	{
		if ((ELF_XBOW_SHOT))
		{
			if ((ELF_EXPLOSIVE_BOLTS))
			{
			}
			ELF_XBOW_TARGETS = FindEntitiesInSphere("enemy", 128);
			if (ELF_XBOW_TARGETS != "none")
			{
			}
			ELF_XBOW_REPELL_POINT = param4;
			for (int i = 0; i < GetTokenCount(ELF_XBOW_TARGETS, ";"); i++)
			{
				elf_xbow_repell_targs();
			}
		}
		ELF_XBOW_SHOT = 0;
		if ((ELF_GUIDED_ACTIVE))
		{
			if (ELF_GUIDED_EFFECT != "ELF_GUIDED_EFFECT")
			{
			}
			ApplyEffect(ELF_GUIDED_EFFECT, 5.0, GetEntityIndex(GetOwner()), ELF_GUIDED_DOT);
		}
	}

	void dbolt_dodamage()
	{
		string CUR_TARG = param2;
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(ELF_XBOW_REPELL_POINT, TARG_ORG);
		float TARG_DIST = Distance(TARG_ORG, ELF_XBOW_REPELL_POINT);
		TARG_DIST /= 128;
		string PUSH_STR = /* TODO: $get_skill_ratio */ $get_skill_ratio(TARG_DIST, 500, 100);
		string HALF_PUSH_STR = PUSH_STR;
		HALF_PUSH_STR /= 2;
		LogDebug("game_dodamage str PUSH_STR ratio TARG_DIST");
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, PUSH_STR, HALF_PUSH_STR)));
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "unset")) return;
		if (!(false)) return;
		if ((ELF_CAN_GUIDED))
		{
			if (!(ELF_GUIDED_ACTIVE))
			{
			}
			if (GetGameTime() > NEXT_GUIDED)
			{
			}
			NEXT_GUIDED = GetGameTime();
			NEXT_GUIDED += FREQ_GUIDED;
			setup_guided();
			int EXIT_SUB = 1;
		}
		if ((ELF_BEAM_ATTACK))
		{
			if (!(ELF_BEAM_ON))
			{
			}
			if (GetEntityRange(m_hAttackTarget) < ELF_BEAM_RANGE)
			{
			}
			string TRACE_START = GetEntityProperty(GetOwner(), "attachpos");
			string TRACE_END = GetEntityOrigin(m_hAttackTarget);
			string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
			if (TRACE_LINE == TRACE_END)
			{
			}
			elf_do_beam();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((ELF_IS_ARCHER))
		{
			if (GetEntityRange(m_hAttackTarget) < 32)
			{
			}
			if (GetGameTime() > NEXT_XBOW_BASH)
			{
			}
			NEXT_XBOW_BASH = GetGameTime();
			NEXT_XBOW_BASH += FREQ_XBOW_BASH;
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 5.0;
			PlayAnim("critical", ANIM_MELEE);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
	}

	void setup_guided()
	{
		SetProp(GetOwner(), "controller2", 100);
		npcatk_suspend_movement(ANIM_SPELL_LEFT_HOLD);
		PlayAnim("critical", ANIM_RELEASE_EGG);
		ScheduleDelayedEvent(0.3, "setup_guided2");
	}

	void setup_guided2()
	{
		string N_TYPES = GetTokenCount(ELF_GUIDED_TYPES, ";");
		N_TYPES -= 1;
		int RND_TYPE = RandomInt(0, N_TYPES);
		ELF_GUIDED_TYPE = GetToken(ELF_GUIDED_TYPES, RND_TYPE, ";");
		ELF_GUIDED_DOT = GetToken(ELF_GUIDED_DOTS, RND_TYPE, ";");
		ELF_GUIDED_ACTIVE = 1;
		CFB_FIRST_TARGET_FOUND = 0;
		CFB_EST_ORG = /* TODO: $relpos */ $relpos(0, 32, 40);
		string START_ANGS = GetEntityAngles(GetOwner());
		CFB_EST_ANG = START_ANGS;
		ClientEvent("new", "all", ELF_GUIDED_SCRIPT, CFB_EST_ORG, START_ANGS, ELF_GUIDED_TYPE, GetEntityIndex(GetOwner()), ATTACH_LHAND, GetEntityIndex(m_hAttackTarget));
		CFB_FIREBALL_IDX = "game.script.last_sent_id";
		ScheduleDelayedEvent(0.1, "cfb_fireball_loop");
		CFB_FORCE_END = GetGameTime();
		CFB_FORCE_END += ELF_GUIDED_DURATION;
	}

	void cfb_fireball_loop()
	{
		if (!(ELF_GUIDED_ACTIVE)) return;
		if ((IsEntityAlive(CFB_TARGET)))
		{
			SetMoveDest(CFB_TARGET);
		}
		else
		{
			SetMoveDest(CFB_EST_ORG);
		}
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
		}
		XDoDamage(CFB_EST_ORG, 128, ELF_GUIDED_DMG, 0, GetOwner(), GetOwner(), "none", ELF_GUIDED_DMG_TYPE);
		if ((IsEntityAlive(CFB_TARGET)))
		{
			string TARG_ORG = GetEntityOrigin(CFB_TARGET);
			if (!(IsValidPlayer(CFB_TARGET)))
			{
				TARG_ORG += "z";
			}
			string ANG_TO_TARG = /* TODO: $angles3d */ $angles3d(CFB_EST_ORG, TARG_ORG);
			ANG_TO_TARG = "x";
			CFB_EST_ANG = ANG_TO_TARG;
			CFB_EST_ORG += /* TODO: $relvel */ $relvel(ANG_TO_TARG, Vector3(0, CFB_SPEED, 0));
		}
		else
		{
			CFB_EST_ORG += /* TODO: $relvel */ $relvel(CFB_EST_ANG, Vector3(0, CFB_SPEED, 0));
			string ANG_TO_TARG = CFB_EST_ANG;
		}
		ClientEvent("update", "all", CFB_FIREBALL_IDX, "svr_update_fireball_vec", ANG_TO_TARG, CFB_EST_ORG, GetEntityIndex(CFB_TARGET));
		if (GetGameTime() > CFB_FORCE_END)
		{
			ELF_GUIDED_ACTIVE = 0;
			ScheduleDelayedEvent(1.0, "npcatk_resume_movement");
			ClientEvent("update", "all", CFB_FIREBALL_IDX, "fireball_end");
			SetProp(GetOwner(), "controller2", 120);
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
		ELF_GUIDED_ACTIVE = 0;
	}

	void OnDamage(int damage) override
	{
		EmitSound(GetOwner(), 0, SOUND_STRUCK1, 10);
		if (!(ELF_PALM_ATTACK)) return;
		if (!((param1 !is null))) return;
		if (!(IsEntityAlive(param1))) return;
		if (GetEntityRange(param1) < ELF_PALM_RANGE)
		{
			ELF_PALM_TARGET = param1;
			SetMoveDest(param1);
			PlayAnim("once", ANIM_REPELL);
		}
	}

	void elf_do_beam()
	{
		BEAM_TARGET = m_hAttackTarget;
		npcatk_suspend_movement(ANIM_SPELL_HOLD);
		npcatk_suspend_ai();
		ELF_BEAM_ON = 1;
		string L_ATTACH_STAFF_TIP = ATTACH_STAFF_TIP;
		L_ATTACH_STAFF_TIP += 1;
		Effect("beam", "ents", "lgtning.spr", 50, GetOwner(), L_ATTACH_STAFF_TIP, BEAM_TARGET, 1, ELF_BEAM_COLOR, 200, 30, ELF_BEAM_DUR);
		ClientEvent("new", "all", "effects/sfx_beam_sparks", GetEntityIndex(GetOwner()), GetEntityIndex(BEAM_TARGET), ATTACH_STAFF_TIP, ELF_BEAM_COLOR, ELF_BEAM_DUR);
		ELF_BEAM_DUR("elf_beam_end");
		elf_beam_loop();
		EmitSound(GetOwner(), 2, SOUND_ELF_BEAM_START, 10);
		// svplaysound: svplaysound 1 10 SOUND_ELF_BEAM_LOOP
		EmitSound(1, 10, SOUND_ELF_BEAM_LOOP);
	}

	void elf_beam_end()
	{
		ELF_BEAM_ON = 0;
		npcatk_resume_ai();
		npcatk_resume_movement();
		// svplaysound: svplaysound 1 0 SOUND_ELF_BEAM_LOOP
		EmitSound(1, 0, SOUND_ELF_BEAM_LOOP);
	}

	void elf_beam_loop()
	{
		if (!(ELF_BEAM_ON)) return;
		ScheduleDelayedEvent(0.25, "elf_beam_loop");
		string TRACE_START = GetEntityProperty(GetOwner(), "attachpos");
		string TRACE_END = GetEntityOrigin(BEAM_TARGET);
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		SetMoveDest(BEAM_TARGET);
		if (!(TRACE_LINE == TRACE_END)) return;
		if (ELF_BEAM_SPECIAL == "none")
		{
			ApplyEffect(BEAM_TARGET, ELF_BEAM_EFFECT, 5.0, GetEntityIndex(GetOwner()), ELF_BEAM_DOT);
		}
		else
		{
			elf_beam_special(BEAM_TARGET);
		}
		DoDamage(BEAM_TARGET, "direct", ELF_BEAM_DMG, 1.0, ELF_BEAM_DMG_TYPE);
		AddVelocity(BEAM_TARGET, ELF_BEAM_PUSH_VEL);
	}

	void ext_con()
	{
		LogDebug("got ext_con PARAM1 PARAM2");
		if (param1 == 0)
		{
			SetProp(GetOwner(), "controller0", param2);
		}
		if (param1 == 1)
		{
			SetProp(GetOwner(), "controller1", param2);
		}
		if (param1 == 2)
		{
			SetProp(GetOwner(), "controller2", param2);
		}
		if (param1 == 3)
		{
			SetProp(GetOwner(), "controller3", param2);
		}
	}

	void close_mouth()
	{
		SetProp(GetOwner(), "controller1", 0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		int RND_DEATH = RandomInt(1, 7);
		if (RND_DEATH == 1)
		{
			ANIM_DEATH = ANIM_DEATH1;
		}
		if (RND_DEATH == 2)
		{
			ANIM_DEATH = ANIM_DEATH2;
		}
		if (RND_DEATH == 3)
		{
			ANIM_DEATH = ANIM_DEATH3;
		}
		if (RND_DEATH == 4)
		{
			ANIM_DEATH = ANIM_DEATH4;
		}
		if (RND_DEATH == 5)
		{
			ANIM_DEATH = ANIM_DEATH5;
		}
		if (RND_DEATH == 6)
		{
			ANIM_DEATH = ANIM_DEATH6;
		}
		if (RND_DEATH == 7)
		{
			ANIM_DEATH = ANIM_DEATH7;
		}
		if (!(ELF_GUIDED_ACTIVE)) return;
		ELF_GUIDED_ACTIVE = 0;
		ClientEvent("update", "all", CFB_FIREBALL_IDX, "fireball_end");
	}

	void npc_targetsighted()
	{
		if (ELF_XBOW_CL_SCRIPT_ID == "ELF_XBOW_CL_SCRIPT_ID")
		{
			ClientEvent("new", "all", ELF_XBOW_CL_SCRIPT, 40.0);
			NEXT_SCRIPT_UPDATE = GetGameTime();
			NEXT_SCRIPT_UPDATE += 40.0;
			ELF_XBOW_CL_SCRIPT_ID = "game.script.last_sent_id";
		}
		else
		{
			if (GetGameTime() > NEXT_SCRIPT_UPDATE)
			{
			}
			ELF_XBOW_CL_SCRIPT_ID = "ELF_XBOW_CL_SCRIPT_ID";
		}
	}

}

}
