#pragma context server

#include "monsters/base_monster.as"
#include "monsters/attack_hack.as"
#include "monsters/base_flyer.as"

namespace MS
{

class Dragonfly : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_IDLE_FLY;
	string ANIM_IDLE_HANG;
	string ANIM_RUN;
	string ANIM_WALK;
	int AS_ATTACKING;
	int ATTACK_DAMAGE;
	int ATTACK_FREQUENCY;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_HUNT;
	int DELETE_ON_DEATH;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	string FLIGHT_STUCK;
	float FREQ_SOUND_HOVER;
	int HUNT_AGRO;
	string LAST_POS;
	float LAST_PROG;
	int NPC_GIVE_EXP;
	int NPC_NO_END_FLY;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_HOVER;
	string SOUND_IDLE;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Dragonfly()
	{
		NPC_NO_END_FLY = 1;
		DELETE_ON_DEATH = 1;
		ANIM_IDLE_HANG = "flapping";
		ANIM_IDLE_FLY = "fly";
		ANIM_RUN = "fly";
		ANIM_WALK = "fly";
		ANIM_ATTACK = "attack";
		ANIM_IDLE = "flapping";
		ATTACK_DAMAGE = 2;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 80;
		ATTACK_HITCHANCE = 0.3;
		ATTACK_FREQUENCY = 10;
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_PAIN = "monsters/sludge/null.wav";
		SOUND_ATTACK1 = "monsters/sludge/null.wav";
		SOUND_ATTACK2 = "monsters/sludge/null.wav";
		SOUND_ATTACK3 = "monsters/sludge/null.wav";
		SOUND_IDLE = "monsters/sludge/null.wav";
		SOUND_DEATH = "monsters/sludge/null.wav";
		HUNT_AGRO = 1;
		CAN_HUNT = 1;
		CAN_FLEE = 1;
		FLEE_HEALTH = 5;
		FLEE_CHANCE = 0.5;
		SOUND_HOVER = "monsters/dragonfly.wav";
		FREQ_SOUND_HOVER = 5.9;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10);
		if (!(IS_HUNTING))
		{
		}
		if ((RandomInt(0, 1)))
		{
		}
		PlayAnim("once", ANIM_IDLE);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(0.5);
		if ((IS_HUNTING))
		{
		}
		npcatk_faceattacker();
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
			SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 200, 0));
		}
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if ((SPITTING))
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if (FLIGHT_STUCK > 4)
		{
			do_rand_tweedee();
			npcatk_suspend_ai(Random(0.3, 0.9));
			SetMoveDest(NEW_DEST);
			ScheduleDelayedEvent(0.1, "horror_boost");
			FLIGHT_STUCK = 0;
		}
		AS_ATTACKING -= 2;
		string TARG_POS = GetEntityOrigin(m_hAttackTarget);
		if (!(SUSPEND_AI))
		{
			SetAngles("face_origin");
		}
		if (AS_ATTACKING <= 0)
		{
		}
		AS_ATTACKING = 0;
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

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(FREQ_SOUND_HOVER);
		EmitSound(GetOwner(), 2, SOUND_HOVER, 10);
	}

	void OnSpawn() override
	{
		SetName("Giant dragonfly");
		SetFly(true);
		SetRace("vermin");
		SetHealth(20);
		SetWidth(24);
		SetHeight(24);
		SetHearingSensitivity(2);
		SetVolume(5);
		SetRoam(true);
		SetDamageResistance("pierce", 0.5);
		SetMonsterClip(0);
		NPC_GIVE_EXP = 10;
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetActionAnim(ANIM_ATTACK);
		SetModel("monsters/dragonfly.mdl");
	}

	void bite1()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void chicken_run()
	{
		ScheduleDelayedEvent(0.1, "horror_boost");
	}

	void horror_boost()
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 200, 0));
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, -200));
	}

}

}
