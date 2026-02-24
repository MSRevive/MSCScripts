#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SlimeGreen : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	float FREQ_SPIT;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	int NPC_RANGED;
	float POISON_DAMAGE;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_IDLE;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	int SPIT_DAMAGE;
	int SPIT_DELAY;
	string SPIT_TARGET;

	SlimeGreen()
	{
		SOUND_DEATH = "monsters/sludge/bio.wav";
		SOUND_STRUCK1 = "barnacle/bcl_bite3.wav";
		SOUND_STRUCK2 = "barnacle/bcl_die3.wav";
		SOUND_IDLE = "barnacle/bcl_alert2.wav";
		SOUND_ATTACK1 = "barnacle/bcl_tongue1.wav";
		SOUND_ATTACK2 = "barnacle/bcl_chew3.wav";
		Precache(SOUND_DEATH);
		ANIM_IDLE = "walk";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		MOVE_RANGE = 256;
		ATTACK_MOVERANGE = 256;
		MOVE_RANGE = 256;
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "die";
		ATTACK_RANGE = 40;
		ATTACK_HITRANGE = 120;
		ATTACK_HITCHANCE = 0.75;
		ATTACK_DAMAGE = Random(5, 15);
		POISON_DAMAGE = Random(1, 5);
		FREQ_SPIT = 2.0;
		SPIT_DAMAGE = RandomInt(5, 20);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(3, 10));
		if (m_hAttackTarget == "unset")
		{
		}
		EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(FREQ_SPIT);
		if ((IsEntityAlive(SPIT_TARGET)))
		{
		}
		string TARG_ORG = GetEntityOrigin(SPIT_TARGET);
		string TARG_TRACE = TraceLine(GetMonsterProperty("origin"), TARG_ORG);
		if (TARG_TRACE == TARG_ORG)
		{
		}
		EmitSound(GetOwner(), 0, SOUND_ATTACK1, 10);
		TossProjectile("proj_poison", /* TODO: $relpos */ $relpos(0, 0, -8), SPIT_TARGET, 300, SPIT_DAMAGE, 2, "none");
	}

	void OnSpawn() override
	{
		SetName("Lesser Green Slime");
		SetHealth(200);
		SetWidth(32);
		SetHeight(32);
		SetModel("monsters/slime.mdl");
		SetModelBody(0, 0);
		SetRace("demon");
		SetBloodType("green");
		SetRoam(true);
		NPC_GIVE_EXP = 80;
		SetHearingSensitivity(10);
		SetDamageResistance("pierce", 0.25);
		SetDamageResistance("slash", 0.75);
		SetDamageResistance("blunt", 1.0);
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("poison", 0);
		NPC_RANGED = 0;
	}

	void bite1()
	{
		// PlayRandomSound from: SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "acid");
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		string SLIME_HEARD = GetEntityIndex("ent_lastheard");
		if (GetRelationship(SLIME_HEARD) == "enemy")
		{
			SPIT_TARGET = SLIME_HEARD;
		}
	}

	void npc_targetsighted()
	{
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_MOVERANGE)) return;
		if (!(RandomInt(1, 5) == 1)) return;
		if ((IS_FLEEING)) return;
		SPIT_TARGET = m_hAttackTarget;
		npcatk_flee(m_hAttackTarget, 512, 2.0);
	}

	void spit_delay_reset()
	{
		SPIT_DELAY = 0;
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(RandomInt(1, 10) == 1)) return;
		if (!(GetEntityRange(m_hLastStruck) < ATTACK_HITRANGE)) return;
		ApplyEffect(m_hLastStruck, "effects/dot_poison", Random(3, 5), GetEntityIndex(GetOwner()), POISON_DAMAGE);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		SPIT_TARGET = GetEntityIndex(m_hLastStruck);
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		npcatk_flee(GetEntityIndex(m_hLastStruck), 512, 1.0);
	}

}

}
