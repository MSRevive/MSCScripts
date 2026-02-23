#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class SkeletonPoisonRandom : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_FLINCH;
	string ANIM_RUN;
	string ANIM_WALK;
	string APPLY_EFFECT;
	float ATTACK_DAMAGE_HIGH;
	float ATTACK_DAMAGE_LOW;
	string BASE_FRAMERATE;
	string BASE_MOVESPEED;
	int BOLT_DELAY;
	float BOLT_FREQ;
	string CYCLE_TIME;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	string ENRAGED;
	string FARTS;
	int FART_DELAY;
	int FLINCH_DELAYING;
	string GUARDIAN;
	string IS_BOLTER;
	string IS_BOMBER;
	string IS_VAMPIRE;
	int I_R_SUMMONED;
	string MY_MASTER;
	int NO_SPAWN_STUCK_CHECK;
	string NO_STUCK_CHECKS;
	string NPC_GIVE_EXP;
	int POISON_ATTACK;
	string POISON_BLADE;
	string POISON_TYPE;
	string SPLODIE;
	int SUMMON_DELAY_STUCK_CHECK;
	string SUMMON_OLD_LOC;

	SkeletonPoisonRandom()
	{
		const int SKEL_HP = 350;
		const float ATTACK_HITCHANCE = 0.85;
		ATTACK_DAMAGE_LOW = 5.5;
		ATTACK_DAMAGE_HIGH = 15.5;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 20;
		const float SKEL_RESPAWN_CHANCE = 0.0;
		const int SKEL_RESPAWN_LIVES = 0;
		const float FART_FREQ = 20.0;
		ANIM_FLINCH = "bigflinch";
		const string GUARD_STRUCK1 = "body/armour1.wav";
		const string GUARD_STRUCK2 = "body/armour2.wav";
		const string GUARD_STRUCK3 = "body/armour3.wav";
		const string SOUND_BOLTCHARGE = "bullchicken/bc_attack1.wav";
		const int BOLT_DAMAGE = 20;
		const string SOUND_BOLT1 = "bullchicken/bc_attack2.wav";
		const string SOUND_BOLT2 = "bullchicken/bc_attack3.wav";
		ANIM_ATTACK = "attack1";
		const float BOLT_FREQUENCY = 5.0;
		const int BOLT_DAMAGE = 30;
		Precache("poison_cloud.spr");
		Precache("cactusgibs.mdl");
	}

	void skeleton_spawn()
	{
		SetRace("undead");
		SetRoam(true);
		SetDamageResistance("fire", 1.2);
		SetDamageResistance("cold", 0.25);
		SetHearingSensitivity(5);
		BOLT_FREQ = 3.0;
		APPLY_EFFECT = "effects/dot_poison";
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		if (POISON_TYPE == "POISON_TYPE")
		{
			POISON_TYPE = RandomInt(1, 6);
		}
		if (POISON_TYPE == 1)
		{
			SetModel("monsters/skeleton.mdl");
			SetModelBody(0, 2);
			SetName("Envenomed Bones");
			IS_BOLTER = 1;
			NPC_GIVE_EXP = 100;
		}
		if (POISON_TYPE == 2)
		{
			SetName("Vampyric Poisoner");
			SetModel("monsters/skeleton.mdl");
			SetModelBody(0, 2);
			IS_VAMPIRE = 1;
			SetModelBody(1, 1);
			NPC_GIVE_EXP = 125;
		}
		if (POISON_TYPE == 3)
		{
			SetName("Poisoned Spore");
			SetModel("monsters/skeleton_enraged.mdl");
			SetModelBody(0, 2);
			SetModelBody(1, 0);
			if (StringToLower(GetMapName()) == "thanatos")
			{
				SET_GREEK = 1;
			}
			if ((SET_GREEK))
			{
				SetModelBody(0, 10);
			}
			IS_BOMBER = 1;
			ANIM_RUN = "run";
			ANIM_WALK = "run";
			SetMoveAnim(ANIM_RUN);
			SetMoveSpeed(2.0);
			SetAnimMoveSpeed(2.0);
			BASE_FRAMERATE = 1.5;
			BASE_MOVESPEED = 1.5;
			NPC_GIVE_EXP = 100;
		}
		if (POISON_TYPE == 4)
		{
			SetName("Envenomed Blade");
			SetModel("monsters/skeleton.mdl");
			SetModelBody(0, 2);
			SetModelBody(1, 4);
			POISON_BLADE = 1;
			NPC_GIVE_EXP = 120;
		}
		if (POISON_TYPE == 5)
		{
			SetName("Enraged Poisoner");
			SetModel("monsters/skeleton_enraged.mdl");
			SetModelBody(0, 2);
			SetModelBody(1, 3);
			ANIM_RUN = "run";
			ANIM_WALK = "run";
			SetMoveAnim(ANIM_RUN);
			SetMoveSpeed(1.5);
			SetAnimMoveSpeed(1.5);
			ATTACK_DAMAGE_LOW = 2.5;
			ATTACK_DAMAGE_HIGH = 10.0;
			POISON_BLADE = 1;
			ENRAGED = 1;
			NPC_GIVE_EXP = 150;
		}
		if (POISON_TYPE == 6)
		{
			SetName("Poisonous Guardian");
			SetModel("monsters/skeleton.mdl");
			SetAnimMoveSpeed(0.5);
			SetAnimFrameRate(0.5);
			SetModelBody(0, 2);
			SetModelBody(1, 3);
			SetDamageResistance("all", 0.3);
			SetStat("parry", 40);
			FARTS = 1;
			GUARDIAN = 1;
			ATTACK_DAMAGE_LOW = 0.5;
			ATTACK_DAMAGE_HIGH = 5.5;
			NO_STUCK_CHECKS = 1;
			NPC_GIVE_EXP = 200;
		}
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((ENRAGED))
		{
			BASE_FRAMERATE = 1.5;
		}
		if ((GUARDIAN))
		{
			BASE_FRAMERATE = 0.5;
		}
		if ((IS_VAMPIRE))
		{
			BASE_FRAMERATE = 0.75;
		}
		if ((FARTS))
		{
			if (!(FART_DELAY))
			{
			}
			do_fart();
		}
		if (!(IS_BOLTER)) return;
		if ((BOLT_DELAY)) return;
		if (!(false)) return;
		if (!(GetEntityRange(m_hLastSeen) > 192)) return;
		toss_bolt();
	}

	void toss_bolt()
	{
		BOLT_DELAY = 1;
		BOLT_FREQ("reset_bolt");
		PlayAnim("critical", "attack2");
		EmitSound(GetOwner(), 0, SOUND_BOLTCHARGE, 10);
	}

	void reset_bolt()
	{
		BOLT_DELAY = 0;
	}

	void attack_2()
	{
		if (!(IS_BOLTER)) return;
		// PlayRandomSound from: SOUND_BOLT1, SOUND_BOLT2
		array<string> sounds = {SOUND_BOLT1, SOUND_BOLT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		TossProjectile("proj_poison_spit2", /* TODO: $relpos */ $relpos(0, 15, 8), "none", 300, BOLT_DAMAGE, 0.5, "none");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		if ((GUARDIAN))
		{
			// PlayRandomSound from: GUARD_STRUCK1, GUARD_STRUCK2, GUARD_STRUCK3
			array<string> sounds = {GUARD_STRUCK1, GUARD_STRUCK2, GUARD_STRUCK3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
			if (param1 > 30)
			{
				if (!(FLINCH_DELAYING))
				{
				}
				PlayAnim("critical", ANIM_FLINCH);
				FLINCH_DELAYING = 1;
				ScheduleDelayedEvent(5.0, "reset_flinch");
			}
		}
		if (!(IS_BOMBER)) return;
		if ((SPLODIE)) return;
		if (GetMonsterProperty("health") < 100)
		{
			EmitSound(GetOwner(), 0, "debris/bustflesh1.wav", 10);
			SPLODIE = 1;
			PlayAnim("critical", ANIM_SPLODE);
			ScheduleDelayedEvent(0.5, "go_splodie");
		}
		if ((SPLODIE)) return;
		if (param1 > 30)
		{
			EmitSound(GetOwner(), 0, "debris/bustflesh1.wav", 10);
			SPLODIE = 1;
			PlayAnim("critical", ANIM_SPLODE);
			ScheduleDelayedEvent(0.5, "go_splodie");
		}
	}

	void reset_flinch()
	{
		FLINCH_DELAYING = 0;
	}

	void go_splodie()
	{
		SetSolid("none");
		Effect("tempent", "gibs", "cactusgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1.0, 50, 50, 15, 2.0);
		string CLOUD_POS = GetEntityOrigin(GetOwner());
		string GRND_CLOUD = /* TODO: $get_ground_height */ $get_ground_height(CLOUD_POS);
		GRND_CLOUD += 24;
		CLOUD_POS = "z";
		SpawnNPC("monsters/summon/npc_poison_cloud2", CLOUD_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), RandomInt(10, 15), 30.0, 1
		SetEntityOrigin(GetOwner(), Vector3(20000, 20000, 20000));
		SetRace("hated");
		ScheduleDelayedEvent(20.0, "me_suicide");
	}

	void me_suicide()
	{
		DoDamage(GetOwner(), "direct", 1000, 1.0, GetOwner());
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(IS_VAMPIRE)) return;
		string HP_TO_GIVE = param2;
		string MAX_CHECK = GetMonsterHP();
		MAX_CHECK += HP_TO_GIVE;
		if (!(MAX_CHECK < GetMonsterMaxHP())) return;
		HealEntity(GetOwner(), HP_TO_GIVE);
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 80, 0.5, 0.5);
		EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(POISON_ATTACK)) return;
		ApplyEffect(GetEntityIndex(param1), APPLY_EFFECT, RandomInt(10, 15), GetEntityIndex(GetOwner()), Random(1, 4));
		POISON_ATTACK = 0;
	}

	void attack_1()
	{
		if ((POISON_BLADE))
		{
			APPLY_EFFECT = "effects/dot_poison";
			if (RandomInt(1, 3) == 3)
			{
				POISON_ATTACK = 1;
			}
		}
		if (!(ENRAGED))
		{
			if (RandomInt(1, 3) == 1)
			{
				ANIM_ATTACK = "attack2";
			}
		}
		attack_snd();
		DoDamage(m_hLastSeen, ATTACK_RANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), ATTACK_HITCHANCE, "slash");
	}

	void attack_2()
	{
		if ((POISON_BLADE))
		{
			APPLY_EFFECT = "effects/dot_poison";
			POISON_ATTACK = 1;
		}
		DoDamage(m_hLastSeen, ATTACK_RANGE, ATTACK_DAMAGE_HIGH, ATTACK_HITCHANCE, "slash");
		ANIM_ATTACK = "attack1";
	}

	void do_fart()
	{
		FART_DELAY = 1;
		FART_FREQ("reset_fart");
		if (!(GetEntityRange(m_hLastSeen) < 256)) return;
		PlayAnim("critical", "attack2");
		EmitSound(GetOwner(), 0, "ambience/steamburst1.wav", 10);
		string SPAWN_ORIGIN = GetEntityOrigin(m_hLastSeen);
		SPAWN_ORIGIN += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 32));
		SpawnNPC("monsters/summon/npc_poison_cloud2", SPAWN_ORIGIN, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), RandomInt(10, 15), 5.0, 1
	}

	void reset_fart()
	{
		FART_DELAY = 0;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(I_R_SUMMONED)) return;
		CallExternal(MY_MASTER, "skeleton_died");
	}

	void game_dynamically_created()
	{
		I_R_SUMMONED = 1;
		MY_MASTER = GetEntityIndex("ent_creationowner");
		SUMMON_OLD_LOC = GetMonsterProperty("origin");
		NO_SPAWN_STUCK_CHECK = 1;
		SUMMON_DELAY_STUCK_CHECK = 0;
		CYCLE_TIME = CYCLE_TIME_BATTLE;
		ScheduleDelayedEvent(3.0, "summon_stuck_checks");
	}

	void summon_stuck_checks()
	{
		ScheduleDelayedEvent(2.0, "summon_stuck_checks");
		SUMMON_DELAY_STUCK_CHECK -= 1;
		if (SUMMON_DELAY_STUCK_CHECK < 0)
		{
			SUMMON_DELAY_STUCK_CHECK = 0;
		}
		if (!(SUMMON_DELAY_STUCK_CHECK == 0)) return;
		if (Distance(GetMonsterProperty("origin"), SUMMON_OLD_LOC) == 0)
		{
			CallExternal(MY_MASTER, "skeleton_stuck");
		}
		SUMMON_OLD_LOC = GetMonsterProperty("origin");
	}

	void npc_selectattack()
	{
		if (!(I_R_SUMMONED)) return;
		SUMMON_DELAY_STUCK_CHECK = 5;
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(I_R_SUMMONED)) return;
		SUMMON_DELAY_STUCK_CHECK = 5;
	}

	void check_attack()
	{
		if ((IS_FLEEING)) return;
		if (!(IsEntityAlive(HUNT_LASTTARGET))) return;
		if (GetEntityRange(HUNT_LASTTARGET) <= ATTACK_RANGE)
		{
			int L_ATTACK = 1;
		}
		if (!(L_ATTACK)) return;
		npcatk_attackenemy();
	}

}

}
