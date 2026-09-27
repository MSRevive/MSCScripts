#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class KAlcolyte : CGameScript
{
	int ALCO_TYPE;
	string ANIM_ATTACK;
	string ANIM_ATTACK_CRAWL;
	string ANIM_ATTACK_NORM;
	string ANIM_CAST_CRAWL;
	string ANIM_CAST_NORM;
	string ANIM_CRAWL;
	string ANIM_DEATH;
	string ANIM_DEATH1;
	string ANIM_DEATH2;
	string ANIM_DEATH3;
	string ANIM_DEATH4;
	string ANIM_DEATH5;
	string ANIM_DEATH6;
	string ANIM_DEATH7;
	string ANIM_HOP;
	string ANIM_IDLE;
	string ANIM_IDLE_CRAWL;
	string ANIM_IDLE_NORM;
	string ANIM_JUMP;
	string ANIM_RUN;
	string ANIM_RUN_NORM;
	string ANIM_SEARCH;
	string ANIM_WALK;
	string ANIM_WALK_NORM;
	string AS_ATTACKING;
	string ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	float CHANCE_EFFECT;
	string DID_WARCRY;
	int DMG_KNIFE;
	int DMG_TOSS;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	string EFFECT_DMG;
	string EFFECT_DUR;
	string EFFECT_SCRIPT;
	string FREQ_COMBAT;
	float FREQ_IDLE;
	float FREQ_LEAP;
	float FREQ_LOOK;
	float FREQ_LOTS;
	float FREQ_NORM;
	float FREQ_RARE;
	string FREQ_THROW;
	int JUMP_CHANCE;
	string K_MOVE_TYPE;
	string LEAP_DELAY;
	string NEXT_AIDED_SOUND;
	string NEXT_LH;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	string ORIG_WEAPON;
	int PROJ_SPEED;
	int SEARCH_DELAY;
	string SOUND_ALERT1;
	string SOUND_ALERT2;
	string SOUND_BURN;
	string SOUND_DEATH1;
	string SOUND_DEATH2;
	string SOUND_DRAW;
	string SOUND_EFFECT;
	string SOUND_EFFECT_DELAY;
	string SOUND_FREEZE;
	string SOUND_IDLE;
	string SOUND_JUMP;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PARRY;
	string SOUND_POISON;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_SWING;
	string SOUND_THROW;
	string SOUND_WARCRY1;
	string SOUND_WARCRY2;
	int STARTED_CYCLES;
	string THROW_DELAY;

	KAlcolyte()
	{
		ANIM_WALK = "walk2handed";
		ANIM_RUN = "run2";
		ANIM_IDLE = "idle";
		ANIM_ATTACK = "ref_shoot_knife";
		ANIM_DEATH = "die_simple";
		ANIM_WALK_NORM = "walk2handed";
		ANIM_RUN_NORM = "run2";
		ANIM_IDLE_NORM = "idle";
		ANIM_HOP = "jump";
		ANIM_JUMP = "long_jump";
		ANIM_CRAWL = "crawl";
		ANIM_IDLE_CRAWL = "crouch_idle";
		ANIM_ATTACK_NORM = "ref_shoot_knife";
		ANIM_ATTACK_CRAWL = "crouch_shoot_knife";
		ANIM_SEARCH = "look_idle";
		ANIM_CAST_NORM = "ref_shoot_onehanded";
		ANIM_CAST_CRAWL = "crouch_shoot_onehanded";
		ANIM_DEATH1 = "die_simple";
		ANIM_DEATH2 = "die_backwards1";
		ANIM_DEATH3 = "die_backwards";
		ANIM_DEATH4 = "die_forwards";
		ANIM_DEATH5 = "headshot";
		ANIM_DEATH6 = "die_spin";
		ANIM_DEATH7 = "gutshot";
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 170;
		ATTACK_MOVERANGE = 80;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(10, 20);
		NPC_GIVE_EXP = 100;
		DMG_KNIFE = RandomInt(10, 20);
		CHANCE_EFFECT = 0.3;
		FREQ_IDLE = Random(5.0, 10.0);
		DMG_TOSS = RandomInt(20, 30);
		PROJ_SPEED = 600;
		FREQ_LOOK = 10.0;
		FREQ_LOTS = Random(3, 10);
		FREQ_RARE = Random(20, 30);
		FREQ_NORM = Random(10, 15);
		FREQ_LEAP = 5.0;
		SOUND_JUMP = "voices/kcult_jump.wav";
		SOUND_SWING = "weapons/swingsmall.wav";
		SOUND_THROW = "zombie/claw_miss1.wav";
		SOUND_DRAW = "weapons/dagger/dagger2.wav";
		SOUND_PARRY = "weapons/dagger/daggermetal2.wav";
		SOUND_PAIN1 = "voices/kcult_pain3.wav";
		SOUND_PAIN2 = "voices/kcult_pain2.wav";
		SOUND_DEATH1 = "voices/kcult_pain1.wav";
		SOUND_DEATH2 = "voices/kcult_die1.wav";
		SOUND_ALERT1 = "voices/kcult_ally_alert1.wav";
		SOUND_ALERT2 = "voices/kcult_ally_alert2.wav";
		SOUND_IDLE = "voices/kcult_idle.wav";
		SOUND_WARCRY1 = "voices/kcult_alert1.wav";
		SOUND_WARCRY2 = "voices/kcult_alert2.wav";
		SOUND_STRUCK1 = "debris/flesh1.wav";
		SOUND_STRUCK2 = "debris/flesh2.wav";
		SOUND_BURN = "ambience/steamburst1.wav";
		SOUND_POISON = "bullchicken/bc_bite2.wav";
		SOUND_FREEZE = "magic/frost_forward.wav";
		Precache(SOUND_FREEZE);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_IDLE);
		if (m_hAttackTarget == "unset")
		{
		}
		if (!(NPC_MOVING_LAST_KNOWN))
		{
		}
		PlayAnim("once", ANIM_SEARCH);
		if (GetGameTime() > NEXT_LH)
		{
			NEXT_LH = GetGameTime();
			NEXT_LH += Random(5.0, 15.0);
			EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
		}
		LogDebug("repeat_idle");
	}

	void OnSpawn() override
	{
		SetName("Kharaztorant Acolyte");
		SetModel("monsters/k_alcolyte.mdl");
		if ((true))
		{
			int BASE_HP = RandomInt(200, 300);
			SetHealth(BASE_HP);
		}
		SetRace("demon");
		SetWidth(32);
		if (!(AM_TURRET))
		{
			SetHeight(72);
		}
		if ((AM_TURRET))
		{
			SetHeight(48);
		}
		SetRoam(true);
		SetHearingSensitivity(4);
		if ((OVERRIDE_TYPE)) return;
		ALCO_TYPE = RandomInt(1, 4);
	}

	void OnPostSpawn() override
	{
		NEXT_AIDED_SOUND = GetGameTime();
		NEXT_AIDED_SOUND += Random(3.0, 5.0);
		NEXT_LH = GetGameTime();
		NEXT_LH += Random(3.0, 5.0);
		SetDamageResistance("holy", 0.0);
		JUMP_CHANCE = 1;
		if (ALCO_TYPE == 1)
		{
			ALCO_TYPE = "ninja";
		}
		if (ALCO_TYPE == 2)
		{
			ALCO_TYPE = "fire";
		}
		if (ALCO_TYPE == 3)
		{
			ALCO_TYPE = "poison";
		}
		if (ALCO_TYPE == 4)
		{
			ALCO_TYPE = "cold";
		}
		int RND_FACE = RandomInt(1, 2);
		if (RND_FACE == 1)
		{
			SetModelBody(1, 0);
		}
		if (RND_FACE == 2)
		{
			SetModelBody(1, 2);
		}
		if (ALCO_TYPE == "ninja")
		{
			SetModelBody(2, 0);
			ORIG_WEAPON = 0;
			FREQ_COMBAT = FREQ_LOTS;
			SetDamageResistance("all", 0.5);
			SetStat("parry", 100);
			FREQ_THROW = 5.0;
			ATTACK_HITCHANCE = 90;
			JUMP_CHANCE = 2;
		}
		if (ALCO_TYPE == "fire")
		{
			SetModelBody(2, 1);
			ORIG_WEAPON = 1;
			FREQ_COMBAT = FREQ_RARE;
			EFFECT_SCRIPT = "effects/dot_fire";
			EFFECT_DUR = 5.0;
			EFFECT_DMG = 30;
			SOUND_EFFECT = SOUND_BURN;
			THROW_DELAY = 1;
			FREQ_THROW = 10.0;
			FREQ_THROW("reset_throw_delay");
			ATTACK_HITCHANCE = 80;
		}
		if (ALCO_TYPE == "poison")
		{
			SetModelBody(2, 2);
			ORIG_WEAPON = 2;
			FREQ_COMBAT = FREQ_NORM;
			EFFECT_SCRIPT = "effects/dot_poison";
			EFFECT_DUR = 15.0;
			EFFECT_DMG = 4;
			SOUND_EFFECT = SOUND_POISON;
			FREQ_THROW = 2.0;
			THROW_DELAY = 1;
			FREQ_THROW("reset_throw_delay");
			ATTACK_HITCHANCE = 85;
			JUMP_CHANCE = 3;
		}
		if (ALCO_TYPE == "cold")
		{
			SetModelBody(2, 3);
			ORIG_WEAPON = 3;
			FREQ_COMBAT = FREQ_RARE;
			EFFECT_SCRIPT = "effects/dot_cold";
			EFFECT_DUR = 5.0;
			EFFECT_DMG = 5;
			SOUND_EFFECT = SOUND_FREEZE;
			FREQ_THROW = 10.0;
			THROW_DELAY = 1;
			FREQ_THROW("reset_throw_delay");
			ATTACK_HITCHANCE = 75;
		}
		if ((I_POUNCE))
		{
			SetMoveAnim(ANIM_IDLE_CRAWL);
			SetIdleAnim(ANIM_IDLE_CRAWL);
		}
		SetProp(GetOwner(), "skin", ORIG_WEAPON);
		if ((I_POUNCE)) return;
		walk_mode();
	}

	void ambush()
	{
		LogDebug("*** POUNCE ***");
		npcatk_resume_ai();
		npcatk_faceattacker(NPC_PROXACT_PLAYERID);
		run_mode();
		AS_ATTACKING = GetGameTime();
		ScheduleDelayedEvent(0.01, "leap_ambush");
		cycle_up("ambush");
		SetMoveAnim(ANIM_RUN_NORM);
		SetIdleAnim(ANIM_IDLE_NORM);
	}

	void leap_ambush()
	{
		leap_at(NPC_PROXACT_PLAYERID);
	}

	void npc_targetsighted()
	{
		if (!(DID_WARCRY))
		{
			DID_WARCRY = 1;
			// PlayRandomSound from: SOUND_WARCRY1, SOUND_WARCRY2
			array<string> sounds = {SOUND_WARCRY1, SOUND_WARCRY2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			ScheduleDelayedEvent(0.1, "draw_sound");
		}
		if ((STARTED_CYCLES)) return;
		STARTED_CYCLES = 1;
		FREQ_COMBAT("do_combat_move");
	}

	void draw_sound()
	{
		EmitSound(GetOwner(), 0, SOUND_DRAW, 10);
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
		// PlayRandomSound from: SOUND_DEATH1, SOUND_DEATH2
		array<string> sounds = {SOUND_DEATH1, SOUND_DEATH2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void reset_search_delay()
	{
		SEARCH_DELAY = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		EmitSound(GetOwner(), 0, SOUND_STRUCK1, 8);
		if (param1 > 50)
		{
			if (!(LEAP_DELAY))
			{
			}
			LEAP_DELAY = 1;
			FREQ_LEAP("reset_leap_delay");
			leap_away(GetEntityIndex(m_hLastStruck));
		}
	}

	void run_mode()
	{
		K_MOVE_TYPE = "run";
		ANIM_RUN = ANIM_RUN_NORM;
		ANIM_WALK = ANIM_WALK_NORM;
		ANIM_IDLE = ANIM_IDLE_NORM;
		ANIM_ATTACK = ANIM_ATTACK_NORM;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
	}

	void walk_mode()
	{
		K_MOVE_TYPE = "walk";
		ANIM_RUN = ANIM_RUN_NORM;
		ANIM_WALK = ANIM_WALK_NORM;
		ANIM_IDLE = ANIM_IDLE_NORM;
		ANIM_ATTACK = ANIM_ATTACK_NORM;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
	}

	void crawl_mode()
	{
		K_MOVE_TYPE = "crawl";
		ANIM_RUN = ANIM_CRAWL;
		ANIM_WALK = ANIM_CRAWL;
		ANIM_IDLE = ANIM_IDLE_CRAWL;
		ANIM_ATTACK = ANIM_ATTACK_CRAWL;
		SetMoveAnim(ANIM_CRAWL);
		SetIdleAnim(ANIM_IDLE_CRAWL);
	}

	void leap_at()
	{
		if ((NO_JUMPS)) return;
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(GetEntityIndex(param1));
		AS_ATTACKING = GetGameTime();
		EmitSound(GetOwner(), 0, SOUND_JUMP, 10);
		PlayAnim("critical", ANIM_JUMP);
		ScheduleDelayedEvent(0.1, "leap_boost");
	}

	void leap_away()
	{
		if ((NO_JUMPS)) return;
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(0.2, "leap_away");
		SetMoveDest(GetEntityIndex(param1));
		AS_ATTACKING = GetGameTime();
		EmitSound(GetOwner(), 0, SOUND_JUMP, 10);
		PlayAnim("critical", ANIM_JUMP);
		ScheduleDelayedEvent(0.1, "leap_boost");
	}

	void leap_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 600, 75));
	}

	void toggle_stance()
	{
		if (K_MOVE_TYPE != "crawl")
		{
			ScheduleDelayedEvent(0.1, "crawl_mode");
		}
		if (K_MOVE_TYPE == "crawl")
		{
			ScheduleDelayedEvent(0.1, "run_mode");
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(CYCLED_UP)) return;
		if (GetEntityRange(m_hAttackTarget) >= ATTACK_RANGE)
		{
			if (K_MOVE_TYPE != "run")
			{
				if (ALCO_TYPE != "poison")
				{
				}
				run_mode();
			}
			if (!(THROW_DELAY))
			{
				if ((false))
				{
				}
				THROW_DELAY = 1;
				FREQ_THROW("reset_throw_delay");
				npcatk_faceattacker(m_hAttackTarget);
				EmitSound(GetOwner(), 0, SOUND_THROW, 10);
				PlayAnim("critical", ANIM_ATTACK);
				ScheduleDelayedEvent(0.1, "do_throw");
				NINJA_JUMP = GetGameTime();
				NINJA_JUMP += 2;
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			if (ALCO_TYPE == "ninja")
			{
				if (GetGameTime() > NINJA_JUMP)
				{
				}
				if (!(LEAP_DELAY))
				{
				}
				LEAP_DELAY = 1;
				FREQ_LEAP("reset_leap_delay");
				leap_at(m_hAttackTarget);
			}
		}
	}

	void reset_throw_delay()
	{
		THROW_DELAY = 0;
	}

	void swing_dodamage()
	{
		if (!(ALCO_TYPE != "ninja")) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		if (!(RandomInt(1, 100) < CHANCE_EFFECT)) return;
		if (!(SOUND_EFFECT_DELAY))
		{
			SOUND_EFFECT_DELAY = 1;
			ScheduleDelayedEvent(5.1, "reset_sound_effect_delay");
			EmitSound(GetOwner(), 0, SOUND_EFFECT, 10);
		}
		if (!(EFFECT_SCRIPT != "EFFECT_SCRIPT")) return;
		ApplyEffect(param2, EFFECT_SCRIPT, EFFECT_DUR, GetEntityIndex(GetOwner()), EFFECT_DMG);
	}

	void reset_sound_effect_delay()
	{
		SOUND_EFFECT_DELAY = 0;
	}

	void do_combat_move()
	{
		if ((AM_TURRET)) return;
		FREQ_COMBAT("do_combat_move");
		if (!(m_hAttackTarget != "unset")) return;
		int RND_MOVE = RandomInt(1, 5);
		if (RND_MOVE > JUMP_CHANCE)
		{
			toggle_stance();
		}
		if (RND_MOVE <= JUMP_CHANCE)
		{
			if (!(LEAP_DELAY))
			{
			}
			LEAP_DELAY = 1;
			FREQ_LEAP("reset_leap_delay");
			leap_away(m_hAttackTarget);
		}
	}

	void reset_leap_delay()
	{
		LEAP_DELAY = 0;
	}

	void attack_knife()
	{
		EmitSound(GetOwner(), 0, SOUND_SWING, 5);
		string F_DMG_KNIFE = DMG_KNIFE;
		if (GetPlayerCount() > 4)
		{
			F_DMG_KNIFE *= 2;
		}
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, F_DMG_KNIFE, ATTACK_HITCHANCE, GetOwner(), GetOwner(), "none", "slash", "dmgevent:swing");
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		if (K_MOVE_TYPE != "crawl")
		{
			PlayAnim("critical", ANIM_CAST_NORM);
		}
		if (K_MOVE_TYPE == "crawl")
		{
			PlayAnim("critical", ANIM_CAST_CRAWL);
		}
		EmitSound(GetOwner(), 0, SOUND_PARRY, 10);
	}

	void do_throw()
	{
		string F_DMG_TOSS = DMG_TOSS;
		if (GetPlayerCount() > 4)
		{
			F_DMG_TOSS *= 2;
		}
		if (K_MOVE_TYPE != "crawl")
		{
			int L_UP = 62;
		}
		if (K_MOVE_TYPE == "crawl")
		{
			int L_UP = 34;
		}
		string L_POS = GetEntityOrigin(GetOwner());
		L_POS += "z";
		if (K_MOVE_TYPE != "crawl")
		{
			TossProjectile("proj_k_knife", L_POS, m_hAttackTarget, PROJ_SPEED, F_DMG_TOSS, 0.2, "none");
		}
		SetModelBody(2, 4);
		AS_ATTACKING = GetGameTime();
		npcatk_suspend_ai("do_throw");
		ScheduleDelayedEvent(0.5, "do_reload");
	}

	void do_reload()
	{
		if (K_MOVE_TYPE != "crawl")
		{
			PlayAnim("critical", ANIM_SEARCH);
		}
		if (K_MOVE_TYPE == "crawl")
		{
			PlayAnim("critical", ANIM_CAST_CRAWL);
		}
		ScheduleDelayedEvent(0.5, "do_reload2");
	}

	void do_reload2()
	{
		AS_ATTACKING = GetGameTime();
		npcatk_resume_ai("reload2");
		SetModelBody(2, ORIG_WEAPON);
		EmitSound(GetOwner(), 0, SOUND_DRAW, 10);
	}

	void npcatk_lost_sight()
	{
		LogDebug("npcatk_lost_sight NEXT_LH vs game.time");
		if ((false)) return;
		if (GetGameTime() > NEXT_LH)
		{
			NEXT_LH = GetGameTime();
			NEXT_LH += Random(5.0, 15.0);
			EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
		}
		if ((SEARCH_DELAY)) return;
		SEARCH_DELAY = 1;
		FREQ_LOOK("reset_search_delay");
		PlayAnim("once", ANIM_SEARCH);
		AS_ATTACKING = GetGameTime();
	}

	void OnAidingAlly(CBaseEntity@ ally, CBaseEntity@ enemy)
	{
		CallExternal(NPC_ALLY_TO_AID, "being_aided");
	}

	void being_aided()
	{
		if (!(GetGameTime() > NEXT_AIDED_SOUND)) return;
		NEXT_AIDED_SOUND = GetGameTime();
		NEXT_AIDED_SOUND += Random(3.0, 5.0);
		if (!(false)) return;
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
