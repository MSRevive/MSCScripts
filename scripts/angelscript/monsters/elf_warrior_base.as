#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class ElfWarriorBase : CGameScript
{
	string ALCO_TYPE;
	int AM_BLOCKING;
	int AM_ESCORT;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BLOCK_TARGET;
	string CAUTIOUS_MOVE;
	string DEF_ANIM_IDLE;
	string DEF_ANIM_RUN;
	string DEF_ANIM_WALK;
	int DOING_LEAP;
	string ELF_HALF_HEALTH;
	string FIRST_CYCLE;
	string FREEZE_TARGS;
	string FWD_JUMP_STR;
	string KNIFE_TARGET;
	string LAST_HIT_FOR;
	string LEAP_TARGET;
	string MAX_SUSPEND;
	int MELEE_ATTACK;
	string NEXT_BLOCK;
	string NEXT_CALM_TIME;
	string NEXT_FREEZE_AURA;
	string NEXT_KICK;
	string NEXT_LOOK;
	string NEXT_WAURA;
	int NPC_FORCED_MOVEDEST;
	string REPULSE_LIST;
	string THROWING_KNIFE;
	string UP_JUMP_STR;
	int WAURA_ON;
	string WAURA_TARGETS;

	ElfWarriorBase()
	{
		ANIM_WALK = "walk2";
		ANIM_IDLE = "deep_idle";
		ANIM_RUN = "run";
		ANIM_ATTACK = "swordswing1_R";
		const string ANIM_MOVE_FAST = "run";
		const string ANIM_MOVE_CAUTIOUS = "run_squatwalk1_R";
		const string ANIM_IDLE_CAUTIOUS = "stand_squatwalk1_R";
		const string ANIM_IDLE_NORMAL = "deep_idle";
		const string ANIM_LOOK = "look_idle";
		const string ANIM_GUARD_IDLE = "stand";
		const string ANIM_DUCK_MOVE = "crawl";
		const string ANIM_DUCK_IDLE = "crouch_idle";
		const string ANIM_JUMP = "jump";
		const string ANIM_LONG_JUMP = "long_jump";
		const string ANIM_AURA = "prepare_fireball";
		const string ANIM_DEATH1 = "die_simple";
		const string ANIM_DEATH2 = "die_backwards1";
		const string ANIM_DEATH3 = "die_backwards";
		const string ANIM_DEATH4 = "die_forwards";
		const string ANIM_DEATH5 = "headshot";
		const string ANIM_DEATH6 = "die_spin";
		const string ANIM_DEATH7 = "gutshot";
		const string ANIM_ATTACK_1H = "swordswing1_R";
		const string ANIM_ATTACK_2H = "longsword_swipe_L";
		const string ANIM_ATTACK_JAB = "swordjab1_R";
		const string ANIM_ATTACK_1H_READY = "swordready1_R";
		const string ANIM_ATTACK_GAXE = "battleaxe_swing1_L";
		const string ANIM_SPELL_PREP = "prepare_fireball";
		const string ANIM_SPELL_CUDDLE = "aim_fireball_R";
		const string ANIM_SPELL_FIRE = "throw_fireball_R";
		const string ANIM_DRAW_SWORD = "swordready1_R";
		const string ANIM_MA_IDLE = "aim_fists";
		const string ANIM_ATTACK_MA = "aim_punch1";
		const string ANIM_KICK = "stance_normal_highkick_r1";
		const string ANIM_SWEEP = "stance_normal_lowkick_r1";
		const string ANIM_PARRY = "longsword_parry";
		const string ANIM_BLOCK = "aim_block1_L";
		const string ANIM_HOLD_AURA = "aim_sword1_R";
		const string ELF_MODEL = "npc/elf_f_warrior.mdl";
		ATTACK_MOVERANGE = 48;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 120;
		const int WALK_RANGE = 200;
		const int DMG_MELEE = 300;
		const string DMG_TYPE = "slash";
		const int DMG_KICK = 400;
		const string DOT_SCRIPT = "effects/dot_fire";
		const int DOT_AMT = 50;
		const float DOT_DURATION = 5.0;
		const float ATTACK_HITCHANCE = 0.9;
		const float CHANCE_STUN = 0.0;
		const float CHANCE_DOT = 0.0;
		const float STUN_DURATION = 10.0;
		const float FREQ_LOOK = 5.0;
		const int CAN_THROW = 0;
		const int DMG_THROW = 600;
		const int THROW_SPEED = 600;
		const int THROW_RANGE = 512;
		const float FREQ_THROW = 6.0;
		const string KNIFE_TYPE = "poison";
		const string KNIFE_THROW_ITEM = "proj_k_knife";
		const int CAN_KICK = 0;
		const string FREQ_KICK = Random(10.0, 25.0);
		const int KICK_RANGE = 90;
		const int LEAP_AFTER_KICK = 0;
		const int CAN_JUMP = 1;
		const float FREQ_JUMP = 5.0;
		const int MAX_JUMP_RANGE = 600;
		const int CAN_FREEZE_AURA = 0;
		const int FREEZE_AURA_RADIUS = 128;
		const float FREEZE_AURA_DURATION = 10.0;
		const string FREEZE_AURA_CL_SCRIPT = "effects/sfx_ice_burst";
		const int FREQ_FREEZE_AURA = 25;
		const int WEAPON_AURA = 0;
		const string WAURA_TYPE = "lightning";
		const string WAURA_EFFECT_SCRIPT = "effects/dot_lightning";
		const int WAURA_RANGE = 128;
		const string WEAPON_AURA_CL_SCRIPT = "monsters/telf_warrior_laxe_cl";
		const int DMG_WAURA = 300;
		const int DOT_WAURA = 100;
		const string WAURA_DMG_TYPE = "lightning_effect";
		const string FREQ_WAURA = Random(20.0, 30.0);
		const float WAURA_DURATION = 5.0;
		const string SOUND_WAURA_START = "magic/bolt_end.wav";
		const string SOUND_WAURA_LOOP = "magic/bolt_loop.wav";
		const int CAN_BLOCK = 0;
		const string FREQ_BLOCK = Random(20.0, 30.0);
		const float BLOCK_DURATION = 5.0;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_SHIELD1 = "weapons/axemetal1.wav";
		const string SOUND_SHIELD2 = "weapons/axemetal2.wav";
		const string SOUND_SHIELD3 = "doors/doorstop5.wav";
		const string SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		const string SOUND_ATTACK_CRY1 = "npc/elvenfemale/ElfF_Attack1.wav";
		const string SOUND_ATTACK_CRY2 = "npc/elvenfemale/ElfF_Attack2.wav";
		const string SOUND_ATTACK_CRY3 = "npc/elvenfemale/ElfF_Attack3.wav";
		const string SOUND_PAIN1 = "npc/elvenfemale/ElfF_Criticalhit.wav";
		const string SOUND_PAIN2 = "npc/elvenfemale/ElfF_Pain1.wav";
		const string SOUND_PAIN3 = "npc/elvenfemale/ElfF_Pain2.wav";
		const string SOUND_PAIN4 = "npc/elvenfemale/ElfF_Pain3.wav";
		const string SOUND_DEATH = "npc/elvenfemale/ElfF_Die.wav";
		const string SOUND_THROW = "zombie/claw_miss1.wav";
		const string SOUND_DRAW = "weapons/dagger/dagger2.wav";
		Precache(SOUND_DEATH);
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
		ScheduleDelayedEvent(3.0, "mark_def_anims");
		FIRST_CYCLE = GetGameTime();
		FIRST_CYCLE += 10.0;
	}

	void OnPostSpawn() override
	{
		close_mouth();
		if (!(AM_ARCHER)) return;
		ANIM_ATTACK = "shootbow";
		ATTACK_RANGE = 800;
		ATTACK_HITRANGE = 800;
	}

	void mark_def_anims()
	{
		DEF_ANIM_WALK = ANIM_WALK;
		DEF_ANIM_RUN = ANIM_RUN;
		DEF_ANIM_IDLE = ANIM_IDLE;
	}

	void suspend_movement()
	{
		ANIM_WALK = param1;
		ANIM_RUN = param1;
		ANIM_IDLE = param1;
		SetMoveAnim(param1);
		SetIdleAnim(param1);
		SetRoam(false);
	}

	void resume_movement()
	{
		ANIM_WALK = DEF_ANIM_WALK;
		ANIM_RUN = DEF_ANIM_RUN;
		ANIM_IDLE = DEF_ANIM_IDLE;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		SetRoam(true);
	}

	void cycle_npc()
	{
		if (param1 == "test")
		{
			SetSayTextRange(1024);
			SayText("Is that... An orc?");
			string NEAR_ALLY = FindEntitiesInSphere("ally", 1024);
			if (NEAR_ALLY != "none")
			{
			}
			CallExternal(GetToken(NEAR_ALLY, 0, ";"), "ext_say_orc");
		}
		if (!(StringToLower(GetMapName()) == "the_wall")) return;
		if (!(G_ORC_ALERT)) return;
		SetGlobalVar("G_ORC_ALERT", 0);
		SetSayTextRange(1024);
		SayText("Is that... An Orc?");
		string NEAR_ALLY = FindEntitiesInSphere("ally", 1024);
		if (!(NEAR_ALLY != "none")) return;
		CallExternal(GetToken(NEAR_ALLY, 0, ";"), "ext_say_orc");
	}

	void npc_targetsighted()
	{
		if (!(IsValidPlayer(m_hAttackTarget))) return;
		if (!(G_ESCORT_ALERT_SAYTEXT != "G_ESCORT_ALERT_SAYTEXT")) return;
		if ((AM_ESCORT))
		{
			if (!(G_DID_ESCORT_ALERT))
			{
			}
			SetSayTextRange(1024);
			SayText("G_ESCORT_ALERT_SAYTEXT");
			SetGlobalVar("G_DID_ESCORT_ALERT", 1);
		}
	}

	void cycle_up()
	{
		if (ATTACK_STANCE == "1h")
		{
			PlayAnim("critical", ANIM_ATTACK_1H_READY);
			move_type(1);
		}
		if ((CAN_KICK))
		{
			NEXT_KICK = GetGameTime();
			NEXT_KICK += FREQ_KICK;
		}
	}

	void cycle_down()
	{
		if (ATTACK_STANCE == "1h")
		{
			move_type(0);
		}
	}

	void my_target_died()
	{
		if (ATTACK_STANCE == "1h")
		{
			move_type(0);
		}
	}

	void heard_cycle_down()
	{
		if (ATTACK_STANCE == "1h")
		{
			move_type(0);
		}
	}

	void npc_heard_player()
	{
		if (ATTACK_STANCE == "1h")
		{
			move_type(1);
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((SUSPEND_AI))
		{
			if (GetGameTime() > MAX_SUSPEND)
			{
			}
			npcatk_resume_ai();
		}
		string GAME_TIME = GetGameTime();
		if (!(GAME_TIME > FIRST_CYCLE)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if ((SUSPEND_AI)) return;
		if (ATTACK_STANCE == "1h")
		{
			if (GAME_TIME > NEXT_CALM_TIME)
			{
				if (GetEntityRange(m_hAttackTarget) < WALK_RANGE)
				{
					if ((false))
					{
						move_type(1);
					}
					else
					{
						move_type(0);
					}
				}
				else
				{
					move_type(0);
				}
			}
			else
			{
				move_type(0);
			}
		}
		if ((CAN_THROW))
		{
			if (GAME_TIME > NEXT_THROW)
			{
			}
			if (!(DOING_LEAP))
			{
			}
			if ((false))
			{
			}
			if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
			{
				if (GetEntityRange(m_hAttackTarget) < THROW_RANGE)
				{
				}
				NEXT_THROW = GAME_TIME;
				NEXT_THROW += FREQ_THROW;
				throw_knife(m_hAttackTarget);
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if ((CAN_KICK))
		{
			if (GAME_TIME > NEXT_KICK)
			{
			}
			NEXT_KICK = GAME_TIME;
			if (GetEntityRange(m_hAttackTarget) < KICK_RANGE)
			{
			}
			NEXT_KICK += FREQ_KICK;
			do_kick();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((CAN_JUMP))
		{
			if (GAME_TIME > NEXT_JUMP)
			{
			}
			if (GetEntityRange(m_hAttackTarget) < MAX_JUMP_RANGE)
			{
			}
			string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
			string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
			if ((IsValidPlayer(m_hAttackTarget)))
			{
				TARG_Z -= 38;
			}
			string Z_DIFF = TARG_Z;
			Z_DIFF -= MY_Z;
			if (Z_DIFF > ATTACK_RANGE)
			{
				do_hop(Z_DIFF);
				int EXIT_SUB = 1;
				NEXT_JUMP = GAME_TIME;
				NEXT_JUMP += FREQ_JUMP;
			}
		}
		if ((EXIT_SUB)) return;
		if ((CAN_FREEZE_AURA))
		{
			if (GetEntityRange(m_hAttackTarget) < FREEZE_AURA_RADIUS)
			{
			}
			if (GAME_TIME > NEXT_FREEZE_AURA)
			{
			}
			NEXT_FREEZE_AURA = GAME_TIME;
			NEXT_FREEZE_AURA += FREQ_FREEZE_AURA;
			do_freeze_aura();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string L_CAN_SEE = false;
		if ((WEAPON_AURA))
		{
			if ((L_CAN_SEE))
			{
			}
			if (GetEntityRange(m_hAttackTarget) < WAURA_RANGE)
			{
			}
			if (GAME_TIME > NEXT_WAURA)
			{
			}
			NEXT_WAURA = GAME_TIME;
			NEXT_WAURA += FREQ_WAURA;
			do_waura();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((CAN_BLOCK))
		{
			if ((L_CAN_SEE))
			{
			}
			if (GAME_TIME > NEXT_BLOCK)
			{
			}
			NEXT_BLOCK = GAME_TIME;
			NEXT_BLOCK += FREQ_BLOCK;
			do_block();
		}
	}

	void npc_selectattack()
	{
		if (ATTACK_STANCE == "assasin")
		{
			string RND_ATK = RandomInt(1, 2);
			if (RND_ATK == 1)
			{
				ANIM_ATTACK = ANIM_ATTACK_1H;
			}
			else
			{
				ANIM_ATTACK = ANIM_ATTACK_JAB;
			}
		}
		if (ATTACK_STANCE == "2hsword")
		{
			string RND_ATK = RandomInt(1, 2);
			if (RND_ATK == 1)
			{
				ANIM_ATTACK = ANIM_ATTACK_2H;
			}
			else
			{
				ANIM_ATTACK = ANIM_ATTACK_GAXE;
			}
		}
	}

	void move_type()
	{
		if (!(ATTACK_STANCE == "1h")) return;
		if ((SUSPEND_AI)) return;
		if (param1 == 1)
		{
			if (!(CAUTIOUS_MOVE))
			{
			}
			CAUTIOUS_MOVE = 1;
			SetMoveAnim(ANIM_MOVE_CAUTIOUS);
			SetIdleAnim(ANIM_IDLE_CAUTIOUS);
		}
		else
		{
			if ((CAUTIOUS_MOVE))
			{
			}
			CAUTIOUS_MOVE = 0;
			SetMoveAnim(ANIM_MOVE_FAST);
			SetIdleAnim(ANIM_IDLE_NORMAL);
		}
	}

	void combat_move()
	{
		CAUTIOUS_MOVE = 0;
		SetMoveAnim(ANIM_MOVE_FAST);
		SetIdleAnim(ANIM_IDLE_NORMAL);
	}

	void frame_melee_1h()
	{
		if ((THROWING_KNIFE))
		{
			THROWING_KNIFE = 0;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		melee_attack();
	}

	void frame_jab()
	{
		melee_attack();
	}

	void frame_axe2()
	{
		melee_attack();
	}

	void frame_melee_2h()
	{
		melee_attack();
	}

	void frame_kick_high()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KICK, ATTACK_HITCHANCE, DMG_TYPE);
		if (!(GetEntityRange(m_hAttackTarget) < KICK_RANGE)) return;
		ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 10.0, GetEntityIndex(GetOwner()));
		if (!(LEAP_AFTER_KICK)) return;
		ScheduleDelayedEvent(0.2, "leap_away");
	}

	void melee_attack()
	{
		MELEE_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_MELEE, ATTACK_HITCHANCE, DMG_TYPE);
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(RandomInt(1, 5) == 1)) return;
		// PlayRandomSound from: SOUND_ATTACK_CRY1, SOUND_ATTACK_CRY2, SOUND_ATTACK_CRY3
		array<string> sounds = {SOUND_ATTACK_CRY1, SOUND_ATTACK_CRY2, SOUND_ATTACK_CRY3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		move_mouth();
	}

	void frame_jump_land()
	{
		force_leap_end();
	}

	void frame_hop_land()
	{
		npcatk_resume_ai();
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		LAST_HIT_FOR = param1;
		NEXT_CALM_TIME = GetGameTime();
		NEXT_CALM_TIME += 5.0;
		if ((AM_BLOCKING)) return;
		if (ATTACK_STANCE == "1h")
		{
			move_type(0);
		}
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (param1 > 100)
		{
			sound_pain();
		}
		else
		{
			if (GetEntityHealth(GetOwner()) < ELF_HALF_HEALTH)
			{
			}
			if (RandomInt(1, 5) == 1)
			{
			}
			sound_pain();
		}
	}

	void OnDamage(int damage) override
	{
		if (!(AM_BLOCKING)) return;
		string ATTACKER_ID = GetEntityIndex(param1);
		string ATTACKER_ORG = GetEntityOrigin(param1);
		if (!(WithinCone2D(ATTACKER_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		if ((param3).findFirst("effect") >= 0)
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SetDamage("dmg");
		return;
		string NEG_DMG = /* TODO: $neg */ $neg(param2);
		LogDebug("game_damaged NEG_DMG");
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, NEG_DMG, 110));
		// PlayRandomSound from: SOUND_SHIELD1, SOUND_SHIELD2, SOUND_SHIELD3
		array<string> sounds = {SOUND_SHIELD1, SOUND_SHIELD2, SOUND_SHIELD3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dodamage()
	{
		if ((MELEE_ATTACK))
		{
			if ((param1))
			{
			}
			if (CHANCE_STUN > 0)
			{
				if (RandomInt(1, 100) <= CHANCE_STUN)
				{
				}
				ApplyEffect(param2, "effects/debuff_stun", STUN_DURATION, GetEntityIndex(GetOwner()));
			}
			if (CHANCE_DOT > 0)
			{
				if (RandomInt(1, 100) <= CHANCE_DOT)
				{
				}
				ApplyEffect(param2, DOT_SCRIPT, DOT_DURATION, GetEntityIndex(GetOwner()), DOT_AMT);
			}
		}
		MELEE_ATTACK = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string RND_DEATH = RandomInt(1, 7);
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
		if (LAST_HIT_FOR > 100)
		{
			ANIM_DEATH = ANIM_DEATH6;
		}
		close_mouth();
		if (G_TELF_ESCORTS > 0)
		{
			if ((AM_ESCORT))
			{
			}
			G_TELF_ESCORTS -= 1;
		}
	}

	void throw_knife()
	{
		// PlayRandomSound from: SOUND_ATTACK_CRY1, SOUND_ATTACK_CRY2, SOUND_ATTACK_CRY3
		array<string> sounds = {SOUND_ATTACK_CRY1, SOUND_ATTACK_CRY2, SOUND_ATTACK_CRY3};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		THROWING_KNIFE = 1;
		KNIFE_TARGET = param1;
		AS_ATTACKING = GetGameTime();
		AS_ATTAKCING += 5.0;
		npcatk_suspend_ai();
		SetModelBody(1, 0);
		SetRoam(false);
		SetIdleAnim(ANIM_ATTACK_1H);
		SetMoveAnim(ANIM_ATTACK_1H);
		SetMoveDest(KNIFE_TARGET);
		PlayAnim("critical", ANIM_ATTACK_1H);
		EmitSound(GetOwner(), 0, SOUND_THROW, 10);
		ScheduleDelayedEvent(0.25, "throw_knife2");
		ScheduleDelayedEvent(0.75, "throw_knife_done");
	}

	void throw_knife2()
	{
		ALCO_TYPE = KNIFE_TYPE;
		TossProjectile(KNIFE_THROW_ITEM, /* TODO: $relpos */ $relpos(0, 38, 22), KNIFE_TARGET, THROW_SPEED, DMG_THROW, 0.2, "none");
	}

	void throw_knife_done()
	{
		EmitSound(GetOwner(), 0, SOUND_DRAW, 10);
		SetModelBody(1, 1);
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		npcatk_resume_ai();
	}

	void do_kick()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		PlayAnim("critical", ANIM_KICK);
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
		// PlayRandomSound from: SOUND_ATTACK_CRY1, SOUND_ATTACK_CRY2, SOUND_ATTACK_CRY3
		array<string> sounds = {SOUND_ATTACK_CRY1, SOUND_ATTACK_CRY2, SOUND_ATTACK_CRY3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void leap_away()
	{
		npcatk_suspend_ai();
		DOING_LEAP = 1;
		LEAP_TARGET = param1;
		if (!(IsEntityAlive(LEAP_TARGET)))
		{
			LEAP_TARGET = m_hAttackTarget;
		}
		SetMoveDest(LEAP_TARGET);
		NPC_FORCED_MOVEDEST = 1;
		PlayAnim("critical", ANIM_LONG_JUMP);
		SetMoveAnim(ANIM_LONG_JUMP);
		sound_pain();
		repulse_area(GetEntityOrigin(GetOwner()));
		ScheduleDelayedEvent(0.1, "leap_away_boost");
		ScheduleDelayedEvent(2.0, "force_leap_end");
	}

	void leap_away_boost()
	{
		string LEAP_TARG_ORG = GetEntityOrigin(LEAP_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(LEAP_TARG_ORG, GetMonsterProperty("origin"));
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 800, 120)));
	}

	void force_leap_end()
	{
		if (!(DOING_LEAP)) return;
		DOING_LEAP = 0;
		SetMoveAnim(ANIM_RUN);
		npcatk_resume_ai();
	}

	void repulse_area()
	{
		EmitSound(GetOwner(), 0, "magic/boom.wav", 10);
		ClientEvent("new", "all", "monsters/cold_one_cl", "repulse", GetEntityOrigin(GetOwner()), 128, 1);
		REPULSE_LIST = FindEntitiesInSphere("enemy", 128);
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

	void do_hop()
	{
		// PlayRandomSound from: SOUND_ATTACK_CRY1, SOUND_ATTACK_CRY2, SOUND_ATTACK_CRY3
		array<string> sounds = {SOUND_ATTACK_CRY1, SOUND_ATTACK_CRY2, SOUND_ATTACK_CRY3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		UP_JUMP_STR = param1;
		UP_JUMP_STR *= 5;
		npcatk_suspend_ai(1.0);
		FWD_JUMP_STR = GetEntityRange(m_hAttackTarget);
		LogDebug("do_hop UP_JUMP_STR FWD_JUMP_STR");
		PlayAnim("critical", ANIM_JUMP);
		ScheduleDelayedEvent(0.1, "do_jump_boost");
	}

	void do_jump_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, FWD_JUMP_STR, UP_JUMP_STR));
	}

	void do_freeze_aura()
	{
		ClientEvent("new", "all", FREEZE_AURA_CL_SCRIPT, GetEntityOrigin(GetOwner()), FREEZE_AURA_RADIUS, 1, Vector3(128, 128, 255));
		PlayAnim("critical", ANIM_AURA);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 3.0;
		ScheduleDelayedEvent(0.25, "do_freeze_aura2");
	}

	void do_freeze_aura2()
	{
		FREEZE_TARGS = FindEntitiesInSphere("enemy", FREEZE_AURA_RADIUS);
		if (!(FREEZE_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(FREEZE_TARGS, ";"); i++)
		{
			feeze_targets();
		}
	}

	void feeze_targets()
	{
		string CUR_TARG = GetToken(FREEZE_TARGS, i, ";");
		if (!(IsEntityAlive(CUR_TARG))) return;
		if (!(IsOnGround(CUR_TARG))) return;
		ApplyEffect(CUR_TARG, "effects/dot_cold_freeze", FREEZE_AURA_DURATION, GetEntityIndex(GetOwner()), DOT_AMT);
	}

	void sound_pain()
	{
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3, SOUND_PAIN4
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_PAIN3, SOUND_PAIN4};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		move_mouth();
	}

	void move_mouth()
	{
		string RND_SAY1 = "[";
		RND_SAY1 += Random(0.5, 1.0);
		RND_SAY1 += "]";
		Say("RND_SAY1");
	}

	void do_waura()
	{
		SetProp(GetOwner(), "controller0", 150);
		npcatk_suspend_ai();
		PlayAnim("hold", ANIM_HOLD_AURA);
		suspend_movement(ANIM_HOLD_AURA);
		ClientEvent("new", "all", WEAPON_AURA_CL_SCRIPT, GetEntityIndex(GetOwner()), WAURA_DURATION);
		EmitSound(GetOwner(), 0, SOUND_WAURA_START, 10);
		WAURA_ON = 1;
		ScheduleDelayedEvent(0.5, "do_waura_loop");
		WAURA_DURATION("end_waura");
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		AS_ATTACKING += WAURA_DURATION;
	}

	void do_waura_loop()
	{
		if (!(WAURA_ON)) return;
		ScheduleDelayedEvent(1.0, "do_waura_loop");
		if (SOUND_WAURA_LOOP != "none")
		{
			// svplaysound: if ( SOUND_WAURA_LOOP isnot 'none' ) svplaysound 1 10 SOUND_WAURA_LOOP
			EmitSound(1, 10, SOUND_WAURA_LOOP);
		}
		WAURA_TARGETS = FindEntitiesInSphere("enemy", WAURA_RANGE);
		if (!(WAURA_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(WAURA_TARGETS, ";"); i++)
		{
			do_waura_affect_targs();
		}
	}

	void do_waura_affect_targs()
	{
		string CUR_TARG = GetToken(WAURA_TARGETS, i, ";");
		if (!(GetEntityHeight(CUR_TARG) > 36)) return;
		ApplyEffect(CUR_TARGET, WAURA_EFFECT_SCRIPT, 5.0, GetEntityIndex(GetOwner()), DOT_WAURA);
		DoDamage(CUR_TARG, "direct", DMG_WAURA, 1.0, GetOwner());
		if (WAURA_TYPE == "lightning")
		{
			string TARG_RESIST = /* TODO: $get_takedmg */ $get_takedmg(CUR_TARG, "lightning");
			string RND_ROLL = Random(0.0, 1.0);
			LogDebug("RND_ROLL vs TARG_RESIST");
			if (RND_ROLL <= TARG_RESIST)
			{
				Effect("screenfade", CUR_TARG, 3, 1, Vector3(255, 255, 255), 255, "fadein");
			}
		}
	}

	void end_waura()
	{
		LogDebug("end_waura SOUND_WAURA_LOOP");
		SetProp(GetOwner(), "controller0", -1);
		PlayAnim("once", "break");
		WAURA_ON = 0;
		if (SOUND_WAURA_LOOP != "none")
		{
			// svplaysound: if ( SOUND_WAURA_LOOP isnot 'none' ) svplaysound 1 0 SOUND_WAURA_LOOP
			EmitSound(1, 0, SOUND_WAURA_LOOP);
		}
		npcatk_resume_ai();
		resume_movement();
		if ((CAN_BLOCK))
		{
			NEXT_BLOCK = GetGameTime();
			NEXT_BLOCK += FREQ_BLOCK;
		}
	}

	void do_block()
	{
		LogDebug("do_block");
		SetProp(GetOwner(), "controller0", 60);
		BLOCK_TARGET = m_hAttackTarget;
		npcatk_suspend_ai();
		PlayAnim("once", "break");
		PlayAnim("hold", ANIM_BLOCK);
		suspend_movement(ANIM_BLOCK);
		AM_BLOCKING = 1;
		do_block_loop();
		BLOCK_DURATION("end_block");
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 2.0;
		AS_ATTACKING += BLOCK_DURATION;
	}

	void do_block_loop()
	{
		LogDebug("do_block_loop");
		if (!(AM_BLOCKING)) return;
		if ((IsEntityAlive(BLOCK_TARGET)))
		{
			ScheduleDelayedEvent(0.1, "do_block_loop");
			SetMoveDest(BLOCK_TARGET);
		}
		else
		{
			end_block();
		}
	}

	void end_block()
	{
		LogDebug("end_block");
		if (!(AM_BLOCKING)) return;
		PlayAnim("once", "break");
		SetProp(GetOwner(), "controller0", -1);
		AM_BLOCKING = 0;
		npcatk_resume_ai();
		resume_movement();
	}

	void npcatk_lost_sight()
	{
		if (!(GetGameTime() > NEXT_LOOK)) return;
		NEXT_LOOK = GetGameTime();
		NEXT_LOOK += FREQ_LOOK;
		PlayAnim("critical", ANIM_LOOK);
	}

	void OnSuspendAI()
	{
		MAX_SUSPEND = GetGameTime();
		MAX_SUSPEND += 10.0;
	}

	void ext_con()
	{
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

	void set_escort()
	{
		G_TELF_ESCORTS += 1;
		AM_ESCORT = 1;
	}

	void close_mouth()
	{
		SetProp(GetOwner(), "controller1", 0);
	}

	void ext_say_orc()
	{
		SetSayTextRange(2048);
		SayText("It s an undead orc. Some luckless fool of a Marogar trying to plunder the fortresses, no doubt.");
		ScheduleDelayedEvent(3.0, "ext_say_orc2");
	}

	void ext_say_orc2()
	{
		SetSayTextRange(2048);
		SayText("Wait... He was looking at something before he came at us...");
	}

}

}
