#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class KChildre : CGameScript
{
	int AM_CRAWLING;
	int AM_INVISIBLE;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	string DID_WARCRY;
	int DOING_FADE;
	int DROP_GOLD;
	string DROP_GOLD_AMT;
	int FADE_STEP;
	string FADE_TARGET;
	int FIREBALL_AMMO;
	int FIREBALL_DELAY;
	int FIREBALL_TOSS;
	string FLINCH_ANIM;
	int FLINCH_CHANCE;
	float FLINCH_DELAY;
	int FLINCH_HEALTH;
	int IS_UNHOLY;
	string NEXT_FADE;
	int NO_STEP_ADJ;
	int NPC_GIVE_EXP;
	int STARTED_CYCLES;
	int STEP_SIZE_NORM;
	int SWIPE_ATTACK;
	int WAS_STRUCK;

	KChildre()
	{
		IS_UNHOLY = 1;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "ability1_alien";
		ANIM_DEATH = "death1_die";
		const string ANIM_IDLE_NORM = "idle1";
		const string ANIM_IDLE_CROUCH = "crouch_idle";
		const string ANIM_WALK_NORM = "walk";
		const string ANIM_RUN_NORM = "run";
		const string ANIM_CRAWL = "crawl";
		ANIM_FLINCH = "new_flinch";
		const string ANIM_JUMP = "jump";
		const string ANIM_DEATH_BACK1 = "death1_die";
		const string ANIM_DEATH_BACK2 = "back_die";
		const string ANIM_DEATH_FORWARD1 = "forward_die";
		const string ANIM_DEATH_CROUCH = "crouch_die";
		ATTACK_RANGE = 125;
		ATTACK_HITRANGE = 200;
		ATTACK_MOVERANGE = 100;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(10, 40);
		NO_STEP_ADJ = 1;
		const string PROJECTILE_SCRIPT = "proj_fire_ball";
		ATTACK_HITCHANCE = 90;
		const string FREQ_FADE = Random(5.0, 20.0);
		const string FREQ_FIREBALL = RandomInt(2, 8);
		const float FREQ_RELOAD = 30.0;
		FIREBALL_AMMO = 3;
		const string DMG_SWIPE = RandomInt(40, 100);
		const string FREQ_IDLE = Random(5, 10);
		const string FREQ_JUMP = Random(2, 5);
		STEP_SIZE_NORM = 64;
		const string SOUND_FIREBALL = "magic/fireball_strike.wav";
		const string SOUND_FLINCH = "monsters/gonome/gonome_pain3.wav";
		const string SOUND_WARCRY = "monsters/gonome/gonome_melee1.wav";
		const string SOUND_FADE = "monsters/gonome/gonome_melee2.wav";
		const string SOUND_UNFADE = "monsters/gonome/gonome_death3.wav";
		const string SOUND_STRUCK1 = "debris/flesh1.wav";
		const string SOUND_STRUCK2 = "debris/flesh2.wav";
		const string SOUND_PAIN1 = "monsters/gonome/gonome_jumpattack.wav";
		const string SOUND_PAIN2 = "monsters/gonome/gonome_melee1.wav";
		const string SOUND_SWING_MISS1 = "zombie/claw_miss1.wav";
		const string SOUND_SWING_MISS2 = "zombie/claw_miss2.wav";
		const string SOUND_SWING_HIT1 = "zombie/claw_strike1.wav";
		const string SOUND_SWING_HIT2 = "zombie/claw_strike2.wav";
		const string SOUND_STEP1 = "common/npc_step1.wav";
		const string SOUND_STEP2 = "common/npc_step2.wav";
		const string SOUND_IDLE1 = "monsters/gonome/gonome_idle1.wav";
		const string SOUND_IDLE2 = "monsters/gonome/gonome_idle2.wav";
		const string SOUND_IDLE3 = "monsters/gonome/gonome_idle3.wav";
		const string SOUND_PARRY = "weapons/axemetal1.wav";
		const string SOUND_DEATH = "bullchicken/bc_die2.wav";
		Precache(SOUND_DEATH);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_RELOAD);
		FIREBALL_AMMO += 1;
		SetProp(GetOwner(), "skin", 1);
		if (FIREBALL_AMMO > 3)
		{
		}
		FIREBALL_AMMO = 3;
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(FREQ_IDLE);
		if (m_hAttackTarget == "unset")
		{
		}
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnSpawn() override
	{
		childre_spawn();
	}

	void childre_spawn()
	{
		NPC_GIVE_EXP = 200;
		SetName("Kharaztorant Childre");
		SetModel("monsters/k_childre.mdl");
		SetHealth(1000);
		SetRace("demon");
		SetWidth(32);
		SetHeight(68);
		SetRoam(true);
		SetHearingSensitivity(4);
		string L_MAP_NAME = StringToLower(GetMapName());
		if ((L_MAP_NAME).findFirst("helena") >= 0)
		{
			STEP_SIZE_NORM = 18;
			int EXIT_SUB = 1;
		}
		if ((L_MAP_NAME).findFirst("demontemple") >= 0)
		{
			STEP_SIZE_NORM = 24;
			int EXIT_SUB = 1;
		}
		if ((L_MAP_NAME).findFirst("islesofdread") >= 0)
		{
			STEP_SIZE_NORM = 24;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SetStepSize(STEP_SIZE_NORM);
	}

	void OnPostSpawn() override
	{
		SetDamageResistance("all", 0.7);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("holy", 0.5);
		SetDamageResistance("stun", 0.5);
		ANIM_FLINCH = "new_flinch";
		CAN_FLINCH = 1;
		FLINCH_HEALTH = 500;
		FLINCH_DELAY = 5.0;
		FLINCH_CHANCE = 50;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetStat("parry", 100);
	}

	void npc_targetsighted()
	{
		if (!(false)) return;
		if (!(DID_WARCRY))
		{
			DID_WARCRY = 1;
			do_warcry();
		}
		if ((STARTED_CYCLES)) return;
		STARTED_CYCLES = 1;
		FREQ_FADE("fade_check");
		ScheduleDelayedEvent(1.0, "fireball_check");
		ScheduleDelayedEvent(1.0, "jump_check");
	}

	void my_target_died()
	{
		DID_WARCRY = 0;
		EmitSound(GetOwner(), 0, SOUND_IDLE1, 10);
		PlayAnim("critical", ANIM_FLINCH);
	}

	void fade_check()
	{
		ScheduleDelayedEvent(1.0, "fade_check");
		if ((DOING_FADE)) return;
		if ((FADE_DELAY)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		if (!(GetGameTime() > NEXT_FADE)) return;
		NEXT_FADE = GetGameTime();
		NEXT_FADE += FREQ_FADE;
		do_fade();
	}

	void do_fade()
	{
		npcatk_flee(m_hAttackTarget, 2048, 3.0);
		FADE_TARGET = m_hAttackTarget;
		DOING_FADE = 1;
		npcatk_suspend_ai(2.0);
		SetMoveAnim(ANIM_RUN);
		WAS_STRUCK = 0;
		ScheduleDelayedEvent(0.1, "do_fade2");
		ScheduleDelayedEvent(1.0, "resume_attack");
	}

	void do_fade2()
	{
		EmitSound(GetOwner(), 0, SOUND_FADE, 10);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 800, 200));
		FADE_STEP = 255;
		fade_loop();
		etherial_immunes();
	}

	void fade_loop()
	{
		FADE_STEP -= 20;
		if (FADE_STEP < 0)
		{
			SetProp(GetOwner(), "renderamt", 1);
		}
		if (!(FADE_STEP >= 0)) return;
		if (!(DOING_FADE)) return;
		ScheduleDelayedEvent(0.1, "fade_loop");
		SetProp(GetOwner(), "rendermode", 2);
		SetProp(GetOwner(), "renderamt", FADE_STEP);
	}

	void resume_attack()
	{
		npcatk_resume_ai();
		SetMoveAnim(ANIM_CRAWL);
		AM_CRAWLING = 1;
		if ((WAS_STRUCK)) return;
		chicken_run(2.0);
		ScheduleDelayedEvent(2.1, "invis_run2");
	}

	void invis_run2()
	{
		if ((WAS_STRUCK)) return;
		if (!(DOING_FADE)) return;
		chicken_run(2.0);
		ScheduleDelayedEvent(2.1, "flank_targ");
	}

	void flank_targ()
	{
		npcatk_flank(FADE_TARGET);
	}

	void do_warcry()
	{
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_IDLE_CROUCH);
		npcatk_faceattacker(m_hAttackTarget);
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
	}

	void fireball_check()
	{
		ScheduleDelayedEvent(1.1, "fireball_check");
		if (!(FIREBALL_AMMO > 0)) return;
		if ((DOING_FADE)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetEntityRange(m_hAttackTarget) > ATTACK_HITRANGE)) return;
		if ((FIREBALL_DELAY)) return;
		FIREBALL_DELAY = 1;
		FREQ_FIREBALL("reset_fireball_delay");
		npcatk_faceattacker(m_hAttackTarget);
		AS_ATTACKING = GetGameTime();
		npcatk_suspend_ai();
		SetRoam(false);
		ScheduleDelayedEvent(0.1, "do_fireball");
	}

	void reset_fireball_delay()
	{
		FIREBALL_DELAY = 0;
	}

	void do_fireball()
	{
		EmitSound(GetOwner(), 0, SOUND_FIREBALL, 10);
		FIREBALL_TOSS = 1;
		PlayAnim("critical", ANIM_ATTACK);
		TossProjectile(PROJECTILE_SCRIPT, /* TODO: $relpos */ $relpos(0, 48, 62), m_hAttackTarget, 400, 200, 0, "none");
		CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_lighten", 0);
		FIREBALL_AMMO -= 1;
		if (FIREBALL_AMMO == 0)
		{
			SetProp(GetOwner(), "skin", 0);
		}
		npcatk_resume_ai();
		SetRoam(true);
	}

	void game_dodamage()
	{
		if (!(SWIPE_ATTACK)) return;
		if ((param1))
		{
			// PlayRandomSound from: SOUND_SWING_HIT1, SOUND_SWING_HIT2
			array<string> sounds = {SOUND_SWING_HIT1, SOUND_SWING_HIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (!(param1))
		{
			// PlayRandomSound from: SOUND_SWING_MISS1, SOUND_SWING_MISS2
			array<string> sounds = {SOUND_SWING_MISS1, SOUND_SWING_MISS2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		SWIPE_ATTACK = 0;
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		EmitSound(GetOwner(), 0, SOUND_PARRY, 10);
	}

	void become_visible()
	{
		NEXT_FADE = GetGameTime();
		NEXT_FADE += FREQ_FADE;
		normal_immunes();
		EmitSound(GetOwner(), 0, SOUND_UNFADE, 10);
		DOING_FADE = 0;
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void OnFlinch()
	{
		string RND_FLINCH = RandomInt(1, 2);
		if (RND_FLINCH == 1)
		{
			FLINCH_ANIM = ANIM_FLINCH1;
		}
		if (RND_FLINCH == 2)
		{
			FLINCH_ANIM = ANIM_FLINCH2;
		}
		EmitSound(GetOwner(), 0, SOUND_FLINCH, 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetProp(GetOwner(), "skin", 2);
		if ((DOING_FADE))
		{
			DOING_FADE = 0;
			CallExternal(GAME_MASTER, "gm_fade_in", GetEntityIndex(GetOwner()));
		}
		if (GetEntityRange(m_hLastStruck) > 256)
		{
			ANIM_DEATH = ANIM_DEATH_FORWARD1;
		}
		if (GetEntityRange(m_hLastStruck) <= 256)
		{
			string RND_DEATH = RandomInt(1, 2);
			if (RND_DEATH == 1)
			{
				ANIM_DEATH = ANIM_DEATH_BACK1;
			}
			if (RND_DEATH == 2)
			{
				ANIM_DEATH = ANIM_DEATH_BACK2;
			}
		}
		if ((AM_CRAWLING))
		{
			ANIM_DEATH = ANIM_DEATH_CROUCH;
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		EmitSound(GetOwner(), 0, SOUND_STRUCK1, 8);
		if (!(AM_CRAWLING)) return;
		if (!(DOING_FADE)) return;
		SetMoveAnim(ANIM_RUN);
		AM_CRAWLING = 0;
		WAS_STRUCK = 1;
		chicken_run(1.5);
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
		EmitSound(GetOwner(), 0, SOUND_FADE, 10);
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

	void walk_step()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1, 4);
	}

	void run_step()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1, 10);
	}

	void attack_strike()
	{
		if ((DOING_FADE))
		{
			if (!(FIREBALL_TOSS))
			{
			}
			become_visible("attack_strike");
		}
		SetMoveAnim(ANIM_RUN);
		AM_CRAWLING = 0;
		FIREBALL_TOSS = 0;
		SWIPE_ATTACK = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWIPE, ATTACK_HITCHANCE, "slash");
	}

	void etherial_immunes()
	{
		ClearFX();
		AM_INVISIBLE = 1;
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 0.0);
	}

	void normal_immunes()
	{
		AM_INVISIBLE = 0;
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("poison", 1.0);
		SetDamageResistance("holy", 0.5);
	}

}

}
