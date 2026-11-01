#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class FallenArmor : CGameScript
{
	float ACCURACY_SHIELD;
	float ACCURACY_STAB;
	float ACCURACY_SWORD;
	int AM_SUMMONING;
	string ANIM_ATTACK;
	string ANIM_ATTACK_NORM;
	string ANIM_ATTACK_SHIELD;
	string ANIM_ATTACK_STAB;
	string ANIM_DEATH;
	string ANIM_EQUIP;
	string ANIM_EQUIP2;
	string ANIM_GETUP;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_RUN_NORM;
	string ANIM_SHIELD_IDLE;
	string ANIM_SIT_IDLE;
	string ANIM_STANCE_IDLE;
	string ANIM_SUMMON;
	string ANIM_TOSHIELD;
	string ANIM_TOSTANCE;
	string ANIM_WALK;
	string ANIM_WALK_NORM;
	string ANIM_WALK_SHIELD;
	string ATTACK_HITRANGE;
	int ATTACK_HITRANGE_NORM;
	int ATTACK_HITRANGE_SHIELD;
	int ATTACK_HITRANGE_STAB;
	string ATTACK_MOVERANGE;
	int ATTACK_MOVERANGE_NORM;
	int ATTACK_MOVERANGE_SHIELD;
	int ATTACK_RANGE;
	int ATTACK_RANGE_NORM;
	int CAN_FLEE;
	int CAN_FLINCH;
	string CYCLE_TIME;
	int DID_FIRST_SUMMON;
	string DID_PAIN_SOUND;
	int DID_SUMMON;
	int FIN_DID_SUMMON;
	string FIRST_TARGET;
	int HITBACK_FRUST;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	int MONSTER_STEP;
	int MOVE_FAST;
	int MOVE_NORMAL;
	int NO_STUCK_CHECKS;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	string NPC_HACKED_MOVE_SPEED;
	string NPC_IS_BOSS;
	string NPC_STORE_TARGET;
	int PLAYING_STAB;
	int SHIELD_DAMAGE;
	int SHIELD_ON;
	int SHIELD_RANGE;
	string SOUND_DEATH;
	string SOUND_GETUP;
	string SOUND_HIT1;
	string SOUND_HIT2;
	string SOUND_LARGESWING;
	string SOUND_MISS1;
	string SOUND_MISS2;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_POWERUP;
	string SOUND_PRE_STAB;
	string SOUND_STEP1;
	string SOUND_STEP2;
	string SOUND_STEP3;
	string SOUND_STEP4;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCKSHIELD1;
	string SOUND_STRUCKSHIELD2;
	string SOUND_SUMMON;
	string SOUND_SUMMON_START;
	int STAB_DAMAGE;
	float STAB_FREQ;
	string SUPER_STABBING;
	string SWITCHING_STANCE;
	int SWORD_DAMAGE;
	float TOSHIELD_DELAY;
	int TRIGGER_RANGE;
	int WAITING_FOR_PLAYER;

	FallenArmor()
	{
		NPC_GIVE_EXP = 1000;
		if (StringToLower(GetMapName()) == "b_castle")
		{
			NPC_IS_BOSS = 1;
		}
		IS_UNHOLY = 1;
		IMMUNE_VAMPIRE = 1;
		ANIM_WALK_NORM = "walk";
		ANIM_RUN_NORM = "run";
		ANIM_WALK_SHIELD = "shield_walk";
		ANIM_STANCE_IDLE = "idle";
		ANIM_SIT_IDLE = "sit_idle";
		ANIM_SHIELD_IDLE = "shield_idle";
		ANIM_IDLE = ANIM_SIT_IDLE;
		ANIM_WALK = ANIM_WALK_NORM;
		ANIM_RUN = ANIM_RUN_NORM;
		ANIM_DEATH = "dead";
		ANIM_ATTACK_NORM = "attack1";
		ANIM_ATTACK_STAB = "attack2";
		ANIM_ATTACK_SHIELD = "shield_attack";
		ANIM_ATTACK = ANIM_ATTACK_NORM;
		ANIM_SUMMON = "summon";
		ANIM_GETUP = "get_up";
		ANIM_EQUIP = "equip";
		ANIM_EQUIP2 = "equip2";
		ANIM_TOSHIELD = "stance_to_shield";
		ANIM_TOSTANCE = "shield_to_stance";
		CAN_FLINCH = 0;
		CAN_FLEE = 0;
		SHIELD_RANGE = 500;
		TRIGGER_RANGE = 256;
		ATTACK_MOVERANGE_NORM = 28;
		ATTACK_MOVERANGE_SHIELD = 64;
		ATTACK_HITRANGE_SHIELD = 160;
		ATTACK_HITRANGE_STAB = 160;
		ATTACK_HITRANGE_NORM = 128;
		ATTACK_RANGE_NORM = 80;
		ATTACK_MOVERANGE = ATTACK_MOVERANGE_NORM;
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = ATTACK_HITRANGE_NORM;
		STAB_DAMAGE = 2200;
		SWORD_DAMAGE = "$rand(60,120)";
		SHIELD_DAMAGE = "$rand(50,200)";
		ACCURACY_SWORD = 0.8;
		ACCURACY_SHIELD = 0.9;
		ACCURACY_STAB = 1.0;
		STAB_FREQ = "$randf(30,60)";
		SOUND_GETUP = "amb/screeching.wav";
		SOUND_STEP1 = "player/pl_grate1.wav";
		SOUND_STEP2 = "player/pl_grate2.wav";
		SOUND_STEP3 = "player/pl_grate3.wav";
		SOUND_STEP4 = "player/pl_grate4.wav";
		MONSTER_STEP = 0;
		SOUND_STRUCK1 = "debris/metal1.wav";
		SOUND_STRUCK2 = "debris/metal3.wav";
		SOUND_STRUCKSHIELD1 = "debris/metal6.wav";
		SOUND_STRUCKSHIELD2 = "doors/doorstop5.wav";
		SOUND_HIT1 = "zombie/claw_strike1.wav";
		SOUND_HIT2 = "zombie/claw_strike3.wav";
		SOUND_LARGESWING = "zombie/claw_miss2.wav";
		SOUND_MISS1 = "weapons/swingsmall.wav";
		SOUND_MISS2 = "weapons/cbar_miss1.wav";
		SOUND_PAIN1 = "x/x_pain1.wav";
		SOUND_PAIN2 = "x/x_pain3.wav";
		SOUND_SUMMON = "x/x_ballattack1.wav";
		SOUND_SUMMON_START = "x/x_recharge2.wav";
		SOUND_POWERUP = "ambience/particle_suck2.wav";
		SOUND_PRE_STAB = "x/x_attack2.wav";
		SOUND_DEATH = "tentacle/te_death2.wav";
		Precache(SOUND_DEATH);
		MOVE_FAST = 200;
		MOVE_NORMAL = 100;
		NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		if (m_hAttackTarget == "unset")
		{
			if (!(NPC_MOVING_LAST_KNOWN))
			{
			}
			ANIM_WALK = ANIM_WALK_NORM;
			SetMoveAnim(ANIM_WALK);
			SetIdleAnim(ANIM_IDLE);
		}
		if (m_hAttackTarget != "unset")
		{
		}
		if (!(SWITCHING_STANCE))
		{
		}
		string TARGET_RANGE = GetEntityRange(m_hAttackTarget);
		if (TARGET_RANGE > SHIELD_RANGE)
		{
			if ((SHIELD_ON))
			{
				PlayAnim("critical", "shield_to_stance");
			}
			ANIM_RUN = ANIM_RUN_NORM;
			SWITCHING_STANCE = 1;
			int EXIT_SUB = 1;
		}
		if (!(EXIT_SUB))
		{
		}
		if (!(false))
		{
			if ((SHIELD_ON))
			{
			}
			PlayAnim("critical", "shield_to_stance");
			ANIM_RUN = ANIM_RUN_NORM;
			SWITCHING_STANCE = 1;
		}
	}

	void OnSpawn() override
	{
		armor_spawn();
	}

	void armor_spawn()
	{
		SetName("Armor of the Fallen");
		SetHealth(6000);
		SetWidth(32);
		SetHeight(96);
		SetRace("demon");
		SetModel("monsters/enemy.mdl");
		SetHearingSensitivity(11);
		SetIdleAnim(ANIM_SIT_IDLE);
		SetMoveAnim(ANIM_SIT_IDLE);
		PlayAnim("once", ANIM_SIT_IDLE);
		SetStat("parry", 30);
		NO_STUCK_CHECKS = 1;
		SetInvincible(true);
		SetDamageResistance("all", 0.1);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("lightning", 1.5);
		SetDamageResistance("cold", 0.8);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 1.5);
		WAITING_FOR_PLAYER = 1;
		npcatk_suspend_ai();
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(WAITING_FOR_PLAYER)) return;
		armor_heardsound();
	}

	void armor_heardsound()
	{
		if (!(WAITING_FOR_PLAYER)) return;
		if (!(IsValidPlayer("ent_lastheard"))) return;
		if (!(GetEntityRange("ent_lastheard") < TRIGGER_RANGE)) return;
		FIRST_TARGET = GetEntityIndex("ent_lastheard");
		WAITING_FOR_PLAYER = 0;
		oh_it_is_on_biatch();
	}

	void oh_it_is_on_biatch()
	{
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		TOSHIELD_DELAY = Random(10, 30);
		TOSHIELD_DELAY("setup_shield_check");
		PlayAnim("critical", ANIM_GETUP);
	}

	void getup_done()
	{
		SetMoveDest(/* TODO: $relpos */ $relpos(0, 64, 0));
		PlayAnim("critical", ANIM_EQUIP);
	}

	void equip_done()
	{
		UseTrigger("break_throne");
		Effect("glow", GetOwner(), Vector3(255, 255, 255), 256, 5, 5);
		SpawnNPC("monsters/companion/spell_maker_divination", /* TODO: $relpos */ $relpos(0, 0, 50), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "none", "none", 64
		SetModelBody(0, 1);
		EmitSound(GetOwner(), 0, SOUND_POWERUP, 10);
		PlayAnim("critical", ANIM_EQUIP2);
		SetInvincible(false);
		NPC_STORE_TARGET = "unset";
		npcatk_resume_ai();
		if ((IsEntityAlive(FIRST_TARGET)))
		{
			npcatk_settarget(FIRST_TARGET);
		}
		stance_on();
		ANIM_WALK = ANIM_WALK_NORM;
		ANIM_IDLE = ANIM_STANCE_IDLE;
		SetIdleAnim(ANIM_STANCE_IDLE);
		SetMoveAnim(ANIM_WALK_NORM);
		STAB_FREQ("super_stab_check");
		CYCLE_TIME = CYCLE_TIME_BATTLE;
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(/* TODO: $relpos */ $relpos(0, 64, 0));
		ScheduleDelayedEvent(5.0, "restore_stuck_checks");
	}

	void restore_stuck_checks()
	{
		SetRoam(true);
		NO_STUCK_CHECKS = 0;
	}

	void super_stab_check()
	{
		if (m_hAttackTarget == "unset")
		{
			string NEXT_STAB_CHECK = STAB_FREQ;
			NEXT_STAB_CHECK /= 4;
			NEXT_STAB_CHECK("super_stab_check");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(false))
		{
			string NEXT_STAB_CHECK = STAB_FREQ;
			NEXT_STAB_CHECK /= 4;
			NEXT_STAB_CHECK("super_stab_check");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(SHIELD_ON))
		{
			EmitSound(GetOwner(), 0, SOUND_PRE_STAB, 10);
			Effect("glow", GetOwner(), Vector3(200, 200, 255), 256, 5, 5);
			SUPER_STABBING = 1;
			ScheduleDelayedEvent(2.0, "do_super_stab");
			STAB_FREQ("super_stab_check");
		}
		if ((SHIELD_ON))
		{
			string NEXT_STAB_CHECK = STAB_FREQ;
			NEXT_STAB_CHECK /= 2;
			NEXT_STAB_CHECK("super_stab_check");
		}
	}

	void do_super_stab()
	{
		npcatk_suspend_ai(6.0);
		PLAYING_STAB = 1;
		PlayAnim("once", "break");
		PlayAnim("critical", ANIM_ATTACK_STAB);
		SetMoveAnim(ANIM_ATTACK_STAB);
		SetIdleAnim(ANIM_ATTACK_STAB);
	}

	void stab_strike()
	{
		npcatk_dodamage(GetEntityIndex(m_hLastSeen), ATTACK_HITRANGE_STAB, STAB_DAMAGE, ACCURACY_STAB, "magic");
		npcatk_resume_ai();
		SUPER_STABBING = 0;
		PLAYING_STAB = 0;
		stance_on();
	}

	void setup_shield_check()
	{
		TOSHIELD_DELAY = Random(10, 30);
		TOSHIELD_DELAY("setup_shield_check");
		if (!(m_hAttackTarget != "unset")) return;
		if (!(SHIELD_ON))
		{
			if (!(SUPER_STABBING))
			{
			}
			if (GetEntityRange(m_hAttackTarget) <= SHIELD_RANGE)
			{
				npcatk_suspend_ai(1.0);
				PlayAnim("once", "break");
				PlayAnim("critical", ANIM_TOSHIELD);
			}
		}
		if ((SHIELD_ON))
		{
			npcatk_suspend_ai(1.0);
			PlayAnim("once", "break");
			PlayAnim("critical", ANIM_TOSTANCE);
		}
	}

	void sword_strike()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, SWORD_DAMAGE, ACCURACY_SWORD, "slash");
	}

	void shield_strike()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, SHIELD_DAMAGE, ACCURACY_SHIELD, "slash");
	}

	void game_dodamage()
	{
		if (!(param1))
		{
			if (ANIM_ATTACK == "attack1")
			{
				// PlayRandomSound from: SOUND_MISS1, SOUND_MISS2
				array<string> sounds = {SOUND_MISS1, SOUND_MISS2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			if (ANIM_ATTACK == "attack2")
			{
				EmitSound(GetOwner(), 0, SOUND_LARGESWING, 10);
			}
			if (ANIM_ATTACK == "shield_attack")
			{
				EmitSound(GetOwner(), 0, SOUND_LARGESWING, 10);
			}
		}
		if ((param1))
		{
			// PlayRandomSound from: SOUND_HIT1, SOUND_HIT2
			array<string> sounds = {SOUND_HIT1, SOUND_HIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void stance_on()
	{
		SetStat("parry", 30);
		SetDamageResistance("all", 0.4);
		SHIELD_ON = 0;
		ANIM_WALK = ANIM_WALK_NORM;
		ANIM_RUN = ANIM_RUN_NORM;
		SetMoveAnim(ANIM_RUN);
		SetIdleAnim(ANIM_IDLE);
		ANIM_ATTACK = ANIM_ATTACK_NORM;
		ATTACK_MOVERANGE = ATTACK_MOVERANGE_NORM;
		ATTACK_HITRANGE = ATTACK_HITRANGE_NORM;
		SWITCHING_STANCE = 0;
	}

	void shield_on()
	{
		SetStat("parry", 60);
		SetDamageResistance("all", 0.1);
		SHIELD_ON = 1;
		ANIM_WALK = ANIM_WALK_SHIELD;
		ANIM_RUN = ANIM_WALK_SHIELD;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_SHIELD_IDLE);
		ANIM_ATTACK = ANIM_ATTACK_SHIELD;
		ATTACK_MOVERANGE = ATTACK_MOVERANGE_SHIELD;
		ATTACK_HITRANGE = ATTACK_HITRANGE_SHIELD;
		SWITCHING_STANCE = 0;
	}

	void run_step()
	{
		MONSTER_STEP += 1;
		if (MONSTER_STEP == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_STEP1, 10);
		}
		if (MONSTER_STEP == 2)
		{
			EmitSound(GetOwner(), 0, SOUND_STEP2, 10);
		}
		if (MONSTER_STEP == 3)
		{
			EmitSound(GetOwner(), 0, SOUND_STEP3, 10);
		}
		if (MONSTER_STEP == 4)
		{
			EmitSound(GetOwner(), 0, SOUND_STEP4, 10);
			MONSTER_STEP = 0;
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (GetMonsterHP() < 2000)
		{
			if (param1 > 30)
			{
			}
			if (RandomInt(1, 10) == 1)
			{
			}
			// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2
			array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			DID_PAIN_SOUND = 1;
		}
		if (!(DID_PAIN_SOUND))
		{
			if ((SHIELD_ON))
			{
				// PlayRandomSound from: SOUND_STRUCKSHIELD1, SOUND_STRUCKSHIELD2
				array<string> sounds = {SOUND_STRUCKSHIELD1, SOUND_STRUCKSHIELD2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			if (!(SHIELD_ON))
			{
				// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
				array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
		}
		DID_PAIN_SOUND = 0;
		if ((DID_SUMMON)) return;
		if (!(GetMonsterHP() < 4000)) return;
		npcatk_suspend_ai();
		SetMoveAnim(ANIM_SUMMON);
		SetIdleAnim(ANIM_SUMMON);
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 256, 5, 5);
		EmitSound(GetOwner(), 0, SOUND_SUMMON_START, 10);
		PlayAnim("once", "break");
		PlayAnim("critical", ANIM_SUMMON);
		AM_SUMMONING = 1;
		DID_SUMMON = 1;
		FIN_DID_SUMMON = 0;
		ScheduleDelayedEvent(0.25, "summon_loop");
		ScheduleDelayedEvent(5.0, "summon_done");
	}

	void summon_loop()
	{
		if ((FIN_DID_SUMMON)) return;
		ScheduleDelayedEvent(0.25, "summon_loop");
	}

	void cycle_up()
	{
		if ((DID_FIRST_SUMMON)) return;
		DID_FIRST_SUMMON = 1;
		ScheduleDelayedEvent(10.0, "first_summon");
	}

	void first_summon()
	{
		PlayAnim("critical", ANIM_SUMMON);
	}

	void summon_done()
	{
		if ((FIN_DID_SUMMON)) return;
		FIN_DID_SUMMON = 1;
		SpawnNPC("monsters/companion/spell_maker_summoning", /* TODO: $relpos */ $relpos(0, 0, 50), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "none", "none", 64
		npcatk_resume_ai();
		EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
		stance_on();
		UseTrigger("summon_armors");
		AM_SUMMONING = 0;
	}

	void game_movingto_dest()
	{
		NPC_HACKED_MOVE_SPEED = MOVE_FAST;
		if ((SHIELD_ON))
		{
			NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
		}
		if (m_hAttackTarget == "unset")
		{
			NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
		}
		if ((PLAYING_STAB))
		{
			NPC_HACKED_MOVE_SPEED = 0;
		}
		if ((AM_SUMMONING))
		{
			NPC_HACKED_MOVE_SPEED = 0;
		}
		SetAnimMoveSpeed(NPC_HACKED_MOVE_SPEED);
	}

	void game_stopmoving()
	{
		SetAnimMoveSpeed(0);
	}

	void OnSuspendAI()
	{
		HITBACK_FRUST = 0;
		SetMoveDest("none");
		game_stopmoving();
	}

	void npc_selectattack()
	{
		SetAnimMoveSpeed(0);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 190, 20, 15, 1024);
	}

}

}
