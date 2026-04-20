#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class BludgeonGazBase : CGameScript
{
	int AM_CHARGING;
	int AM_DEMON;
	int AM_HAMMER;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_HAMMER;
	string ANIM_IDLE;
	string ANIM_JUMP;
	string ANIM_LEAP;
	string ANIM_RUN;
	string ANIM_THROW;
	string ANIM_THROW_HOLD;
	string ANIM_TRICK;
	string ANIM_WALK;
	string ANIM_WARCRY;
	string AS_ATTACKING;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	float CHANCE_STUN;
	int CHARGE_COUNT;
	string CHARGE_DELAY;
	string CHARGE_DEST;
	string CHARGE_LIST;
	string CHARGE_TARGET;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int CYCLES_STARTED;
	string DID_WARCRY;
	int DMG_CHARGE;
	int DMG_STUN;
	int DMG_SWING;
	int DMG_THROW;
	int DOT_BURN;
	int DOT_POISON;
	int DROPS_CONTAINER;
	float FREQ_CHARGE;
	float FREQ_IDLE;
	float FREQ_JUMP;
	float FREQ_LEAP;
	float FREQ_STOMP;
	float FREQ_THROW;
	int GOLD_BAGS;
	int GOLD_BAGS_PPLAYER;
	int GOLD_MAX_BAGS;
	int GOLD_PER_BAG;
	int GOLD_RADIUS;
	int IS_UNHOLY;
	string LEAP_DELAY;
	int LEAP_RANGE;
	string MONSTER_MODEL;
	string MY_AXE;
	int NPC_GIVE_EXP;
	string POISON_TARGETS;
	string SOUND_ALERT;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_BURN;
	string SOUND_CHARGE_GO;
	string SOUND_CHARGE_START;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_LAND;
	string SOUND_LEAP;
	string SOUND_PAIN;
	string SOUND_SNORT;
	string SOUND_SPELL;
	string SOUND_STEP1;
	string SOUND_STEP2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_SWING_HIT;
	string SOUND_SWING_MISS;
	string SOUND_THROW;
	string SOUND_WARCRY;
	int STEP_SIZE_NORM;
	string SWING_ATTACK;
	int SWING_STEP;
	string THROWING_AXE;
	string THROW_DELAY;

	BludgeonGazBase()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "m_attack1";
		ANIM_FLINCH = "flinch2";
		ANIM_DEATH = "death";
		GOLD_BAGS = 1;
		GOLD_BAGS_PPLAYER = 1;
		GOLD_PER_BAG = 50;
		GOLD_RADIUS = 128;
		GOLD_MAX_BAGS = 8;
		ANIM_TRICK = "idle2";
		ANIM_JUMP = "jump";
		ANIM_LEAP = "longjump";
		ANIM_THROW = "m_attack1";
		ANIM_THROW_HOLD = "m_attack1";
		ANIM_HAMMER = "m_attack2";
		ANIM_WARCRY = "warcry";
		ATTACK_MOVERANGE = 48;
		ATTACK_RANGE = 110;
		ATTACK_HITRANGE = 180;
		CAN_FLINCH = 1;
		LEAP_RANGE = 220;
		ATTACK_HITCHANCE = 80;
		STEP_SIZE_NORM = 48;
		FREQ_IDLE = Random(5, 10);
		FREQ_LEAP = 10.0;
		FREQ_THROW = Random(5, 20);
		FREQ_JUMP = Random(2, 5);
		FREQ_STOMP = Random(10, 20);
		FREQ_CHARGE = Random(10, 20);
		DMG_SWING = RandomInt(50, 100);
		DMG_STUN = RandomInt(25, 50);
		DOT_BURN = RandomInt(100, 200);
		DOT_POISON = RandomInt(25, 75);
		DMG_CHARGE = RandomInt(50, 75);
		DMG_THROW = 80;
		CHANCE_STUN = 0.1;
		SOUND_LEAP = "monsters/bludgeon/bludgeonattack2.wav";
		SOUND_WARCRY = "monsters/bludgeon/bludgeon_gaz_bat2.wav";
		SOUND_ALERT = "monsters/bludgeon/bludgeon_gaz_bat1.wav";
		SOUND_SWING_MISS = "zombie/claw_miss2.wav";
		SOUND_SWING_HIT = "zombie/claw_strike1.wav";
		SOUND_ATTACK1 = "monsters/bludgeon/bludgeon_gaz_atk1.wav";
		SOUND_ATTACK2 = "monsters/bludgeon/bludgeon_gaz_atk2.wav";
		SOUND_ATTACK3 = "monsters/bludgeon/bludgeon_gaz_atk3.wav";
		SOUND_THROW = "monsters/bludgeon/bludgeon_gaz_snort.wav";
		SOUND_DEATH = "monsters/bludgeon/bludgeon_gaz_death.wav";
		SOUND_IDLE1 = "monsters/bludgeon/bludgeon_gaz_ask.wav";
		SOUND_IDLE2 = "monsters/bludgeon/bludgeon_gaz_answer.wav";
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_PAIN = "monsters/bludgeon/bludgeon_gaz_pain.wav";
		SOUND_SPELL = "monsters/bludgeon/bludgeon_gaz_spell.wav";
		SOUND_SNORT = "monsters/bludgeon/bludgeon_gaz_snort.wav";
		SOUND_STEP1 = "gonarch/gon_step1.wav";
		SOUND_STEP2 = "gonarch/gon_step2.wav";
		SOUND_LAND = "garg/gar_step2.wav";
		SOUND_CHARGE_START = "monsters/bludgeon/bludgeon_gaz_snort.wav";
		SOUND_CHARGE_GO = "monsters/bludgeon/bludgeondeath2.wav";
		SOUND_BURN = "ambience/steamburst1.wav";
		Precache("magic/boom.wav");
		Precache("poison_cloud.spr");
		MONSTER_MODEL = "monsters/bludgeon_gaz.mdl";
		Precache(SOUND_DEATH);
		Precache(MONSTER_MODEL);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_IDLE);
		if (m_hAttackTarget == "unset")
		{
		}
		int RND_IDLE = RandomInt(1, 2);
		if (RND_IDLE == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_IDLE1, 10);
			PlayAnim("critical", ANIM_TRICK);
		}
		if (RND_IDLE == 2)
		{
			EmitSound(GetOwner(), 0, SOUND_IDLE2, 10);
			PlayAnim("critical", ANIM_WARCRY);
		}
	}

	void OnSpawn() override
	{
		SetModel(MONSTER_MODEL);
		SetWidth(32);
		SetHeight(96);
		if (!(true)) return;
		if (!(AM_MINI))
		{
			SetName("Bludgeon");
		}
		if ((AM_MINI))
		{
			SetName("Young Bludgeon");
		}
		if (!(AM_HAMMER))
		{
			axe_mode();
		}
		if ((AM_HAMMER))
		{
			hammer_mode();
		}
		SetDamageResistance("all", 0.6);
		SetRace("demon");
		SetRoam(true);
		SetHearingSensitivity(4);
		SWING_STEP = 0;
		if ((AM_DEMON))
		{
			demon_mode();
		}
		if ((AM_CORRUPT))
		{
			corrupt_mode();
		}
	}

	void axe_mode()
	{
		SetHealth(2000);
		LogDebug("Axer");
		NPC_GIVE_EXP = 450;
		SetModelBody(4, 1);
	}

	void hammer_mode()
	{
		SetHealth(3000);
		LogDebug("Hammah");
		NPC_GIVE_EXP = 550;
		SetModelBody(4, 2);
	}

	void demon_mode()
	{
		if (!(NPC_CUSTOM_NAME))
		{
			if (!(AM_MINI))
			{
				SetName("Demon Bludgeon");
			}
			if ((AM_MINI))
			{
				SetName("Young Demon Bludgeon");
			}
		}
		SetProp(GetOwner(), "skin", 1);
		IS_UNHOLY = 1;
		SetDamageResistance("all", 0.4);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("holy", 0.25);
		NPC_GIVE_EXP *= 3.0;
	}

	void corrupt_mode()
	{
		if (!(NPC_CUSTOM_NAME))
		{
			if (!(AM_MINI))
			{
				SetName("Corrupted Bludgeon");
			}
			if ((AM_MINI))
			{
				SetName("Young Corrupted Bludgeon");
			}
		}
		SetProp(GetOwner(), "skin", 2);
		IS_UNHOLY = 1;
		SetDamageResistance("all", 0.4);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 0.25);
		NPC_GIVE_EXP *= 3.0;
		ScheduleDelayedEvent(0.1, "poison_aura");
		ScheduleDelayedEvent(0.1, "poison_aura_scan");
	}

	void OnPostSpawn() override
	{
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		if ((AM_HAMMER))
		{
			ANIM_ATTACK = ANIM_HAMMER;
		}
	}

	void npc_targetsighted()
	{
		if ((I_R_FROZEN)) return;
		if (!(DID_WARCRY))
		{
			DID_WARCRY = 1;
			int WARCRY_TYPE = RandomInt(1, 2);
			if (WARCRY_TYPE == 1)
			{
				PlayAnim("critical", "warcry");
				EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
			}
			if (WARCRY_TYPE == 2)
			{
				EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
			}
			if (!(AM_HAMMER))
			{
			}
			CHARGE_DELAY = 1;
			FREQ_CHARGE("reset_charge_delay");
		}
		string TARGET_RANGE = GetEntityRange(m_hAttackTarget);
		if (!(TARGET_RANGE > ATTACK_RANGE)) return;
		if (!(CHARGE_DELAY))
		{
			if (!(I_R_FROZEN))
			{
			}
			CHARGE_TARGET = m_hAttackTarget;
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 20.0;
			CHARGE_DELAY = 1;
			FREQ_CHARGE("reset_charge_delay");
			npcatk_suspend_ai();
			SetMoveAnim("charge_start");
			SetIdleAnim("charge_start");
			PlayAnim("critical", "charge_start");
			ScheduleDelayedEvent(1.0, "do_charge");
			EmitSound(GetOwner(), 0, SOUND_CHARGE_START, 10);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (TARGET_RANGE < LEAP_RANGE)
		{
			if (!(THROWING_AXE))
			{
			}
			if (!(LEAP_DELAY))
			{
			}
			if (!(AM_CHARGING))
			{
			}
			LEAP_DELAY = 1;
			FREQ_LEAP("reset_leap_delay");
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 20.0;
			EmitSound(GetOwner(), 0, SOUND_LEAP, 10);
			SetMoveAnim(ANIM_LEAP);
			PlayAnim("critical", ANIM_LEAP);
		}
		if (TARGET_RANGE > LEAP_RANGE)
		{
			if (!(AM_HAMMER))
			{
			}
			if (!(THROW_DELAY))
			{
			}
			THROW_DELAY = 1;
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 20.0;
			THROWING_AXE = 1;
			EmitSound(GetOwner(), 0, SOUND_THROW, 10);
			npcatk_suspend_ai();
			SetIdleAnim(ANIM_THROW_HOLD);
			SetMoveAnim(ANIM_THROW_HOLD);
			SetRoam(false);
			PlayAnim("once", "break");
			PlayAnim("hold", ANIM_THROW);
			ScheduleDelayedEvent(0.5, "throw_axe");
		}
	}

	void throw_axe()
	{
		SetModelBody(4, 0);
		string TARG_DEST = GetEntityOrigin(m_hAttackTarget);
		TARG_DEST += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, ATTACK_RANGE, 0));
		string TRACE_START = GetMonsterProperty("origin");
		TRACE_START += "z";
		string TRACE_TARG = TraceLine(TRACE_START, TARGET_DEST);
		string TRACE_DEST = TRACE_TARG;
		if (!(IsValidPlayer(m_hAttackTarget)))
		{
			TARG_DEST += "z";
		}
		SpawnNPC("monsters/summon/bludgeon_axe", /* TODO: $relpos */ $relpos(0, 40, 48), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), TARG_DEST, DMG_THROW
		MY_AXE = m_hLastCreated;
		throw_axe_loop();
	}

	void throw_axe_loop()
	{
		if (!(THROWING_AXE)) return;
		SetMoveDest(MY_AXE);
		ScheduleDelayedEvent(0.1, "throw_axe_loop");
	}

	void reset_throw_delay()
	{
		THROW_DELAY = 0;
	}

	void do_charge()
	{
		SetMoveSpeed(3.0);
		CHARGE_DEST = GetEntityOrigin(CHARGE_TARGET);
		CHARGE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 256, 0));
		SetMoveAnim("charge");
		SetIdleAnim("charge");
		CHARGE_COUNT = 0;
		AM_CHARGING = 1;
		EmitSound(GetOwner(), 0, SOUND_CHARGE_GO, 10);
		charge_loop();
	}

	void charge_loop()
	{
		CHARGE_COUNT += 1;
		SetMoveDest(CHARGE_DEST);
		if (CHARGE_COUNT == 30)
		{
			end_charge();
		}
		if (Distance(CHARGE_DEST, GetMonsterProperty("origin")) < ATTACK_MOVERANGE)
		{
			end_charge();
		}
		if (!(AM_CHARGING)) return;
		ScheduleDelayedEvent(0.1, "charge_loop");
		string SCAN_LOC = /* TODO: $relpos */ $relpos(0, 32, 0);
		CHARGE_LIST = FindEntitiesInSphere("enemy", 96);
		if (CHARGE_LIST != "none")
		{
			EmitSound(GetOwner(), 0, SOUND_STRUCK1, 10);
			for (int i = 0; i < GetTokenCount(CHARGE_LIST, ";"); i++)
			{
				charge_affect_targets();
			}
		}
	}

	void charge_affect_targets()
	{
		string CUR_TARG = GetToken(CHARGE_LIST, i, ";");
		float LR_RAND = Random(-200, 200);
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(LR_RAND, 600, 110));
		DoDamage(CUR_TARG, "direct", DMG_CHARGE, 1.0, GetOwner());
	}

	void end_charge()
	{
		AM_CHARGING = 0;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		SetMoveSpeed(1.0);
		npcatk_resume_ai();
	}

	void swing_dodamage()
	{
		if ((AM_DEMON))
		{
			ApplyEffect(param2, "effects/dot_fire", 3, GetEntityIndex(GetOwner()), DOT_BURN);
		}
		if ((AM_CORRUPT))
		{
			ApplyEffect(param2, "effects/dot_poison", 10.0, GetEntityIndex(GetOwner()), DOT_POISON);
		}
		if ((SWING_ATTACK))
		{
			if (!(param1))
			{
				EmitSound(GetOwner(), 0, SOUND_SWING_MISS, 10);
			}
			if ((param1))
			{
			}
			EmitSound(GetOwner(), 0, SOUND_SWING_HIT, 10);
			AddVelocity(param2, /* TODO: $relvel */ $relvel(-100, 130, 120));
			SWING_ATTACK = 0;
		}
		if ((AM_HAMMER))
		{
			if ((param1))
			{
			}
			if (RandomInt(1, 100) < CHANCE_STUN)
			{
			}
			if (GetEntityRange(param2) < ATTACK_HITRANGE)
			{
			}
			ApplyEffect(param2, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
			EmitSound(GetOwner(), 0, SOUND_SNORT, 10);
		}
	}

	void reset_charge_delay()
	{
		CHARGE_DELAY = 0;
	}

	void reset_leap_delay()
	{
		LEAP_DELAY = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void ext_bd_toggle()
	{
		if ((SUSPEND_AI))
		{
			SetRoam(true);
			npcatk_resume_ai();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(SUSPEND_AI))
		{
			SetRoam(false);
			npcatk_suspend_ai();
		}
	}

	void ext_follow()
	{
		SetMoveDest(param1);
	}

	void ext_playanim()
	{
		PlayAnim("critical", param1);
	}

	void ext_demon()
	{
		AM_DEMON = 1;
		SetProp(GetOwner(), "skin", param1);
	}

	void ext_hammer()
	{
		AM_HAMMER = 1;
		SetModelBody(4, 2);
	}

	void ext_axe()
	{
		AM_HAMMER = 0;
		SetModelBody(4, 1);
	}

	void cycle_up()
	{
		if ((CYCLES_STARTED)) return;
		CYCLES_STARTED = 1;
		jump_check();
	}

	void jump_check()
	{
		FREQ_JUMP("jump_check");
		if (!(m_hAttackTarget != "unset")) return;
		string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
		string MY_Z = (GetMonsterProperty("origin")).z;
		string Z_DIFF = TARG_Z;
		Z_DIFF -= MY_Z;
		if (!(Z_DIFF > ATTACK_RANGE)) return;
		npcatk_faceattacker(m_hAttackTarget);
		ScheduleDelayedEvent(0.1, "do_jump");
		EmitSound(GetOwner(), 0, SOUND_LEAP, 10);
	}

	void do_jump()
	{
		SetStepSize(1000);
		SetMoveAnim(ANIM_JUMP);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -200, 800));
		ScheduleDelayedEvent(0.5, "push_forward");
		ScheduleDelayedEvent(1.0, "jump_done");
	}

	void push_forward()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 400, 100));
	}

	void jump_done()
	{
		SetStepSize(STEP_SIZE_NORM);
		SetMoveAnim(ANIM_RUN);
	}

	void leap_land()
	{
		SetMoveAnim(ANIM_RUN);
		EmitSound(GetOwner(), 0, SOUND_LAND, 10);
		SpawnNPC("monsters/summon/stun_burst", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 128, 0, DMG_STUN
	}

	void attack1()
	{
		SWING_ATTACK = 1;
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWING, ATTACK_HITCHANCE, GetOwner(), GetOwner(), "none", "slash", "dmgevent:swing");
		if ((THROWING_AXE))
		{
			SetAnimFrameRate(0.0001);
		}
	}

	void attack2()
	{
		attack1();
	}

	void walk_step()
	{
	}

	void run_step()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1, 10);
	}

	void swing_start()
	{
		SWING_STEP += 1;
		if (!(SWING_STEP > 2)) return;
		SWING_STEP = 0;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void my_target_died()
	{
		PlayAnim("once", "warcry");
		EmitSound(GetOwner(), 0, SOUND_SPELL, 10);
	}

	void catch_axe()
	{
		npcatk_resume_ai();
		PlayAnim("once", "break");
		SetRoam(true);
		THROWING_AXE = 0;
		SetModelBody(4, 1);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		FREQ_THROW("reset_throw_delay");
		SetAnimFrameRate(1.0);
	}

	void chest_b_castle_bonus()
	{
		DROPS_CONTAINER = 1;
		CONTAINER_DROP_CHANCE = 1.0;
		CONTAINER_SCRIPT = "chests/lostcaverns2";
	}

	void poison_aura()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ClientEvent("new", "all", "effects/sfx_poison_aura", GetEntityIndex(GetOwner()), 96, 19.0);
		ScheduleDelayedEvent(20.0, "poison_aura");
	}

	void poison_aura_scan()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(0.5, "poison_aura_scan");
		if (!(m_hAttackTarget != "unset")) return;
		if ((AM_CHARGING)) return;
		POISON_TARGETS = FindEntitiesInSphere("enemy", 96);
		if (!(POISON_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(POISON_TARGETS, ";"); i++)
		{
			poison_aura_affect();
		}
	}

	void poison_aura_affect()
	{
		string CUR_TARG = GetToken(POISON_TARGETS, i, ";");
		ApplyEffect(CUR_TARG, "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_POISON);
	}

}

}
