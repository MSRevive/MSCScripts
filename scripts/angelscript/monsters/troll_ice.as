#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class TrollIce : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int CAN_HUNT;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int HUNT_AGRO;
	int I_R_SUMMONED;
	int MOVE_RANGE;
	string MY_MASTER;
	int NO_SPAWN_STUCK_CHECK;
	int NPC_GIVE_EXP;
	int NPC_MUST_SEE_TARGET;
	string PUSH_VEL;

	TrollIce()
	{
		const int TOO_CLOSE = 100;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "monsters/troll/trollpain.wav";
		const string SOUND_STRUCK3 = "monsters/troll/trollpain.wav";
		const string SOUND_PAIN = "monsters/troll/trollpain.wav";
		const string SOUND_ATTACK1 = "monsters/troll/trollattack.wav";
		const string SOUND_ATTACK2 = "monsters/troll/trollattack.wav";
		const string SOUND_DEATH = "monsters/troll/trolldeath.wav";
		const string SOUND_WALK = "monsters/troll/trollidle.wav";
		const string SOUND_WALK1 = "monsters/troll/step1.wav";
		const string SOUND_WALK2 = "monsters/troll/step2.wav";
		const string SOUND_IDLE = "monsters/troll/trollidle.wav";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 35;
		ANIM_RUN = "walk";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_DEATH = "dieheadshot2";
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 200;
		CAN_FLINCH = 0;
		MOVE_RANGE = 100;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		NPC_MUST_SEE_TARGET = 0;
	}

	void OnSpawn() override
	{
		SetWidth(50);
		SetHeight(100);
		SetRace("orc");
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		SetHealth(600);
		SetName("Ice Troll");
		SetRoam(true);
		NPC_GIVE_EXP = 200;
		SetDamageResistance("all", 1.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("fire", 4.0);
		SetHearingSensitivity(8);
		SetModel("monsters/icetroll.mdl");
		Effect("glow", GetOwner(), Vector3(128, 128, 255), 512, 3, 3);
		troll_spawn();
	}

	void attack_1()
	{
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 200, 10);
		if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
		{
			if ((RandomInt(1, 8) + "=" + 1))
			{
				ApplyEffect(m_hLastStruck, "effects/dot_cold", 10, GetEntityIndex(GetOwner()), Random(5, 15), "none");
			}
			npcatk_dodamage(m_hAttackTarget, "direct", Random(20, 30), 0.75, GetEntityIndex(GetOwner()), "blunt");
		}
		if (RandomInt(0, 3) == 0)
		{
			ANIM_ATTACK = "attack2";
		}
		if ((RandomInt(1, 20) + "=" + 1))
		{
			SetVolume(10);
			EmitSound(GetOwner(), SOUND_IDLE);
		}
		SetVolume(8);
		EmitSound(GetOwner(), SOUND_ATTACK1);
	}

	void attack_2()
	{
		if (RandomInt(0, 3) == 0)
		{
			ANIM_ATTACK = "attack1";
		}
		if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
		{
			if ((RandomInt(1, 4) + "=" + 1))
			{
				ApplyEffect(m_hAttackTarget, "effects/dot_cold", 5, GetEntityIndex(GetOwner()), Random(5, 15), "none");
			}
			npcatk_dodamage(m_hAttackTarget, "direct", Random(35, 45), 0.75, GetEntityIndex(GetOwner()), "blunt");
		}
		// PlayRandomSound from: SOUND_ATTACK1
		array<string> sounds = {SOUND_ATTACK1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK3};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dynamically_created()
	{
		ScheduleDelayedEvent(1, "ice_solidify");
		I_R_SUMMONED = 1;
		MY_MASTER = param1;
		string MY_MASTER_LIVES = IsEntityAlive(MY_MASTER);
		if (!(MY_MASTER_LIVES)) return;
		NO_SPAWN_STUCK_CHECK = 1;
		ScheduleDelayedEvent(0.1, "check_dist");
	}

	void check_dist()
	{
		if (Distance(MY_MASTER, GetMonsterProperty("origin")) < TOO_CLOSE)
		{
			SetSolid("none");
			ScheduleDelayedEvent(0.1, "repeat_addvel");
			npcatk_flee(MY_MASTER, 275, 3);
		}
	}

	void repeat_addvel()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 800, 5));
	}

	void ice_solidify()
	{
		string MY_LOC = GetEntityOrigin(GetOwner());
		string MY_MASTER_LOC = GetEntityOrigin(MY_MASTER);
		string MASTER_DISTANCE = Distance(MY_LOC, MY_MASTER_LOC);
		if (MASTER_DISTANCE > 80)
		{
			SetSolid("box");
		}
		if (MASTER_DISTANCE <= 80)
		{
			if (!(IS_FLEEING))
			{
				npcatk_flee(GetEntityIndex(MY_MASTER), 512, 3);
			}
			ScheduleDelayedEvent(0.25, "ice_solidify");
		}
	}

	void npc_monster_stuck()
	{
		if (!(STUCK_COUNT > 3)) return;
		if ((I_R_SUMMONED))
		{
			CallExternal(GetEntityIndex(MY_MASTER), "my_pet_stuck");
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(I_R_SUMMONED)) return;
		string MASTER_TARGET = GetEntityProperty(MY_MASTER, "scriptvar");
		if (!(MASTER_TARGET != "unset")) return;
		if (!(m_hAttackTarget != MASTER_TARGET)) return;
		npcatk_settarget(MASTER_TARGET);
	}

	void ext_attack_master_target()
	{
		if (!(m_hAttackTarget == "unset")) return;
		npcatk_settarget(param1);
	}

}

}
