#pragma context server

#include "monsters/base_flyer.as"
#include "monsters/base_monster_new.as"

namespace MS
{

class Horror : CGameScript
{
	int AM_SUMMONED;
	string ANIM_ATTACK;
	string ANIM_BITE;
	string ANIM_BREATH;
	string ANIM_DEAD;
	string ANIM_DEATH;
	string ANIM_FLY;
	string ANIM_GORE;
	string ANIM_HOVER;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_SPIRAL;
	string ANIM_SPIT;
	string ANIM_WALK;
	int AS_SUMMON_TELE_CHECK;
	float ATTACK_ACCURACY;
	int ATTACK_BLIND_RANGE;
	int ATTACK_DAMAGE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BREATH_AMMO;
	int BREATH_DAMAGE_MAX;
	int BREATH_DAMAGE_MIN;
	string BREATH_SPRITE;
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_FLY;
	int CAN_HEAR;
	int CAN_HUNT;
	int CAN_RETALIATE;
	int CAN_WANDER;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	string FIRE_DELAY;
	int FLEE_CHANCE;
	int FLEE_DISTANCE;
	int FLEE_HEALTH;
	int FLIGHT_SCANNING;
	string FLIGHT_STUCK;
	string FLINCH_ANIM;
	int FLINCH_CHANCE;
	int FLINCH_DELAY;
	int HUNT_AGRO;
	int IS_UNHOLY;
	int I_FLY;
	string LAST_POS;
	float LAST_PROG;
	string LAST_TARGET;
	int MONSTER_WIDTH;
	int MOVE_RAGE;
	string MOVE_RANGE;
	string MY_OWNER;
	string NEXT_HSTUCK_CHECK;
	int NO_SPAWN_STUCK_CHECK;
	int NO_STUCK_CHECKS;
	int NPC_GIVE_EXP;
	int NPC_NO_END_FLY;
	string OLD_HSTUCK_POS;
	int RETALIATE_CHANGETARGET_CHANCE;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_FLAP1;
	string SOUND_FLAP2;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_LAND;
	string SOUND_PAIN0;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_SPIT1;
	string SOUND_SPIT2;
	string SOUND_SPRAY;
	string SPAWNED_ORG;
	string SPITTING;
	int SPIT_AMMO;
	int SPIT_DAMAGE;
	int SPRAYING_GAS;

	Horror()
	{
		AS_SUMMON_TELE_CHECK = 1;
		NPC_NO_END_FLY = 1;
		IS_UNHOLY = 1;
		CAN_ATTACK = 1;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		CAN_FLY = 1;
		CAN_HEAR = 1;
		CAN_WANDER = 1;
		ATTACK_BLIND_RANGE = 200;
		CAN_RETALIATE = 1;
		RETALIATE_CHANGETARGET_CHANCE = 100;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 10;
		FLINCH_ANIM = "bite2";
		FLINCH_DELAY = 1;
		CAN_FLEE = 1;
		FLEE_HEALTH = 25;
		FLEE_CHANCE = 25;
		FLEE_DISTANCE = 2048;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 125;
		MOVE_RAGE = 30;
		ATTACK_ACCURACY = 0.8;
		ATTACK_DAMAGE = 100;
		SPIT_DAMAGE = 50;
		BREATH_DAMAGE_MIN = 10;
		BREATH_DAMAGE_MAX = 20;
		ANIM_IDLE = "hover";
		ANIM_WALK = "fly1";
		ANIM_SPIRAL = "fly2";
		ANIM_FLY = "fly1";
		ANIM_RUN = "fly2";
		ANIM_HOVER = "hover";
		ANIM_ATTACK = "bite1";
		ANIM_SPIT = "bite1";
		ANIM_BITE = "bite1";
		ANIM_GORE = "bite2";
		ANIM_BREATH = "breath";
		ANIM_DEATH = "die";
		ANIM_DEAD = "dead";
		SOUND_IDLE1 = "controller/con_idle1.wav";
		SOUND_IDLE2 = "controller/con_idle2.wav";
		SOUND_IDLE3 = "controller/con_idle3.wav";
		SOUND_ATTACK1 = "controller/con_attack1.wav";
		SOUND_ATTACK2 = "controller/con_attack2.wav";
		SOUND_ATTACK3 = "controller/con_attack3.wav";
		SOUND_DEATH = "controller/con_die1.wav";
		SOUND_PAIN0 = "debris/bustflesh2.wav";
		SOUND_PAIN1 = "controller/con_pain1.wav";
		SOUND_PAIN2 = "controller/con_die2.wav";
		SOUND_SPIT1 = "bullchicken/bc_attack3.wav";
		SOUND_SPIT2 = "bullchicken/bc_attack2.wav";
		SOUND_SPRAY = "ambience/steamburst1.wav";
		SOUND_FLAP1 = "monsters/bat/flap_big1.wav";
		SOUND_FLAP2 = "monsters/bat/flap_big2.wav";
		SOUND_LAND = "player/pl_fallpain1.wav";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 40;
		SPIT_AMMO = 8;
		BREATH_AMMO = 1;
		BREATH_SPRITE = "poison_cloud.spr";
		Precache(BREATH_SPRITE);
		MONSTER_WIDTH = 48;
		NO_STUCK_CHECKS = 1;
		Precache("monsters/edwardgorey.mdl");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		if ((IS_HUNTING))
		{
		}
		npcatk_faceattacker();
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
			if ((false))
			{
			}
			SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 200, 0));
		}
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if ((I_R_FROZEN))
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if ((SPITTING))
		{
			if ((false))
			{
			}
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if (FLIGHT_STUCK > 4)
		{
			do_rand_tweedee();
			npcatk_suspend_ai(Random(0.3, 0.9));
			SetMoveDest(NEW_DEST);
			ScheduleDelayedEvent(0.1, "horror_boost");
			TOTAL_STUCKAGE += 1;
			ScheduleDelayedEvent(5.0, "remove_total_stuckage");
			if (TOTAL_STUCKAGE > 3)
			{
				if ((AM_SUMMONED))
				{
				}
				npc_suicide();
			}
			FLIGHT_STUCK = 0;
		}
		string TARG_POS = GetEntityOrigin(m_hAttackTarget);
		if (!(SUSPEND_AI))
		{
			SetAngles("face_origin");
		}
		if (!(IS_FLEEING))
		{
		}
		if (!(SPITTING))
		{
		}
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
		}
		float CUR_PROG = Distance(GetMonsterProperty("origin"), TARG_POS);
		if (LAST_PROG >= CUR_PROG)
		{
			FLIGHT_STUCK += 1;
		}
		LAST_PROG = Distance(GetMonsterProperty("origin"), TARG_POS);
		LAST_POS = GetMonsterProperty("origin");
	}

	void OnSpawn() override
	{
		SetName("Horror");
		SetHealth(500);
		SetWidth(22);
		SetHeight(22);
		SetRoam(true);
		SetFly(true);
		I_FLY = 1;
		0 = float(0);
		SetRace("demon");
		SetIdleAnim(ANIM_WALK);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("holy", 4.0);
		SetDamageResistance("poison", 0.0);
		SetHearingSensitivity(5);
		SetModel("monsters/edwardgorey.mdl");
		NPC_GIVE_EXP = 200;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		FLIGHT_SCANNING = 1;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (!(false)) return;
		LAST_TARGET = GetEntityIndex("ent_lastsseen");
		if (SPIT_AMMO >= 1)
		{
			SPITTING = 1;
			MOVE_RANGE = 9999;
			SetIdleAnim(ANIM_HOVER);
			SetMoveAnim(ANIM_HOVER);
			if (!(FIRE_DELAY))
			{
			}
			FIRE_DELAY = 1;
			ScheduleDelayedEvent(0.75, "reset_fire_delay");
			PlayAnim("critical", ANIM_ATTACK);
			// PlayRandomSound from: SOUND_SPIT1, SOUND_SPIT2
			array<string> sounds = {SOUND_SPIT1, SOUND_SPIT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			SPIT_AMMO -= 1;
		}
		else
		{
			fly_mode();
		}
	}

	void reset_fire_delay()
	{
		FIRE_DELAY = 0;
	}

	void fly_mode()
	{
		MOVE_RANGE = 30;
		SetIdleAnim(ANIM_HOVER);
		if (BREATH_AMMO > 0)
		{
			ANIM_RUN = ANIM_SPIRAL;
		}
		else
		{
			ANIM_RUN = ANIM_FLY;
		}
		SetMoveAnim(ANIM_RUN);
	}

	void reset_hunt_mode()
	{
		if (!(CYCLED_UP)) return;
		ScheduleDelayedEvent(1.0, "reset_hunt_mode");
		if ((false)) return;
		fly_mode();
	}

	void cycle_up()
	{
		reset_hunt_mode();
	}

	void npc_selectattack()
	{
		if (BREATH_AMMO >= 1)
		{
			ANIM_RUN = ANIM_SPIRAL;
			ANIM_ATTACK = ANIM_BREATH;
			BREATH_AMMO -= 1;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ANIM_RUN = ANIM_FLY;
		int BITE_TYPE = RandomInt(1, 4);
		if (BITE_TYPE > 1)
		{
			ANIM_ATTACK = ANIM_BITE;
		}
		if (BITE_TYPE == 1)
		{
			ANIM_ATTACK = ANIM_GORE;
		}
	}

	void attack1()
	{
		if ((SPITTING))
		{
			TossProjectile("proj_poison_spit2", "view", "none", 500, SPIT_DAMAGE, 0.5, "none");
			SPITTING = 0;
			NEXT_HSTUCK_CHECK = GetGameTime();
			NEXT_HSTUCK_CHECK += 3.0;
			if (SPIT_AMMO == 0)
			{
				fly_mode();
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY, "slash");
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (RandomInt(1, 2) == 1)
		{
			ANIM_ATTACK = ANIM_GORE;
		}
	}

	void attack2()
	{
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_ACCURACY, "slash");
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		ANIM_ATTACK = ANIM_BITE;
		if (!(GetEntityRange(m_hLastStruckByMe) <= ATTACK_HITRANGE)) return;
		ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/effect_push", 1, /* TODO: $relvel */ $relvel(-250, 50, 10), 0);
	}

	void stop_spraying()
	{
		SPRAYING_GAS = 0;
	}

	void spiral_charge()
	{
		if (RandomInt(1, 2) == 1)
		{
			ANIM_RUN = ANIM_FLY;
		}
		// PlayRandomSound from: SOUND_FLAP1, SOUND_FLAP2
		array<string> sounds = {SOUND_FLAP1, SOUND_FLAP2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void turret_horror()
	{
		// PlayRandomSound from: SOUND_FLAP1, SOUND_FLAP2
		array<string> sounds = {SOUND_FLAP1, SOUND_FLAP2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, -200));
		if ((AM_SUMMONED))
		{
			CallExternal(MY_OWNER, "horror_died");
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetMoveAnim(ANIM_DEATH);
		SetIdleAnim(ANIM_DEAD);
		SetActionAnim(ANIM_DEATH);
		EmitSound(GetOwner(), 0, SOUND_DEATH, 10);
		PlayAnim("critical", ANIM_DEATH);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		string MY_HEALTH = GetEntityHealth(GetOwner());
		string MY_HURT_STAGE = GetEntityMaxHealth(GetOwner());
		MY_HURT_STAGE /= 2;
		if (MY_HEALTH >= MY_HURT_STAGE)
		{
			// PlayRandomSound from: SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN1
			array<string> sounds = {SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN1};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (MY_HEALTH <= MY_HURT_STAGE)
		{
			// PlayRandomSound from: SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN2
			array<string> sounds = {SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void breath_reload()
	{
		BREATH_AMMO += 1;
	}

	void breath_attack()
	{
		Effect("tempent", "trail", BREATH_SPRITE, /* TODO: $relpos */ $relpos(0, 32, 0), /* TODO: $relpos */ $relpos(0, 200, 20), 1, 1, 8, 15, 0);
		EmitSound(GetOwner(), 0, SOUND_SPRAY, 10);
		SPRAYING_GAS = 1;
		ScheduleDelayedEvent(1.0, "stop_spraying");
		if (GetEntityRange(m_hLastSeen) <= ATTACK_BLIND_RANGE)
		{
		}
		if (!(BREATH_AMMO <= 0)) return;
		ScheduleDelayedEvent(20.0, "breath_reload");
	}

	void my_target_died()
	{
		SPIT_AMMO += 2;
	}

	void npcatk_stopflee()
	{
		ANIM_RUN = ANIM_SPIRAL;
	}

	void idle_sounds()
	{
		float NEXT_SOUND = Random(3, 10);
		NEXT_SOUND("idle_sounds");
		if (!(HUNT_LASTTARGET == �NONE�)) return;
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		AM_SUMMONED = 1;
		NO_SPAWN_STUCK_CHECK = 1;
		SPAWNED_ORG = GetMonsterProperty("origin");
		ScheduleDelayedEvent(10.0, "check_stuck_summon");
	}

	void check_stuck_summon()
	{
		if ((SPITTING))
		{
			ScheduleDelayedEvent(5.0, "check_stuck_summon");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((false))
		{
			int EXIT_SUB = 1;
			ScheduleDelayedEvent(5.0, "check_stuck_summon");
		}
		if ((EXIT_SUB)) return;
		if (GetMonsterProperty("origin") == SPAWNED_ORG)
		{
			npc_suicide();
		}
		else
		{
			as_tele_stuck_check();
		}
	}

	void remove_total_stuckage()
	{
		TOTAL_STUCKAGE -= 1;
	}

	void chicken_run()
	{
		ScheduleDelayedEvent(0.1, "horror_boost");
	}

	void horror_boost()
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 500, 0));
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(IsEntityAlive(HUNT_LASTTARGET))) return;
		if ((SPITTING))
		{
			if ((false))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(GetGameTime() > NEXT_HSTUCK_CHECK)) return;
		NEXT_HSTUCK_CHECK = GetGameTime();
		NEXT_HSTUCK_CHECK += 0.5;
		if (OLD_HSTUCK_POS == "OLD_HSTUCK_POS")
		{
			OLD_HSTUCK_POS = GetEntityOrigin(GetOwner());
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		string L_POS = GetEntityOrigin(GetOwner());
		if (Distance(L_POS, OLD_HSTUCK_POS) < 32)
		{
			if (GetEntityRange(HUNT_LASTTARGET) > ATTACK_RANGE)
			{
			}
			CUR_SOLUTION += 1;
			if (CUR_SOLUTION == 1)
			{
				if (!(BAST_STUCK_DID_INIT))
				{
				}
				as_tele_stuck_check();
				OLD_HSTUCK_POS = L_POS;
			}
			else
			{
				CUR_SOLUTION = 0;
				float RND_LEFT = Random(-1000, 1000);
				float RND_FWD = Random(-2000, 1000);
				float RND_UP = Random(-1000, 1000);
				LogDebug("solution #2 RND_LEFT RND_FWD RND_UP");
				SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(RND_LEFT, RND_FWD, RND_UP));
			}
		}
		else
		{
			OLD_HSTUCK_POS = L_POS;
		}
	}

}

}
