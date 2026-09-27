#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SlimeGreenLarge : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CLOUD_DAMAGE;
	float CLOUD_DELAY;
	float CLOUD_DURATION;
	float FREQ_CLOUD;
	float FREQ_SPIT;
	float FREQ_SPIT_SCAN;
	string NEXT_CLOUD;
	string NEXT_SPIT;
	string NEXT_SPIT_SCAN;
	int NPC_GIVE_EXP;
	string N_SPIT_TARGETS;
	float POISON_DAMAGE;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_IDLE;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	int SPIT_DAMAGE;
	int SPIT_RANGE;
	float SPIT_ROF;
	string SPIT_TARGET;
	string SPIT_TARGETS;

	SlimeGreenLarge()
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
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "die";
		ATTACK_RANGE = 60;
		ATTACK_HITRANGE = 120;
		ATTACK_HITCHANCE = 0.75;
		ATTACK_DAMAGE = Random(35, 55);
		POISON_DAMAGE = Random(10, 15);
		SPIT_RANGE = 1024;
		SPIT_ROF = 2.0;
		SPIT_DAMAGE = RandomInt(30, 50);
		CLOUD_DELAY = 15.0;
		CLOUD_DAMAGE = RandomInt(10, 30);
		CLOUD_DURATION = 10.0;
		FREQ_SPIT = 1.0;
		FREQ_SPIT_SCAN = 2.0;
		FREQ_CLOUD = 30.0;
		if (m_hAttackTarget == "unset")
		{
		}
		EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
	}

	void OnSpawn() override
	{
		SetName("Large Green Slime");
		SetHealth(800);
		SetWidth(70);
		SetHeight(64);
		SetModel("monsters/slime_large.mdl");
		SetRace("demon");
		SetRoam(true);
		NPC_GIVE_EXP = 450;
		SetDamageResistance("pierce", 0.25);
		SetDamageResistance("slash", 0.75);
		SetDamageResistance("blunt", 1.0);
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("poison", 0.0);
	}

	void bite1()
	{
		npcatk_dodamage(/* TODO: $relpos */ $relpos(0, 0, 0), ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, 0.0, "reflective", "acid");
	}

	void npc_targetsighted()
	{
		if (!(GetGameTime() > NEXT_SPIT_SCAN)) return;
		NEXT_SPIT_SCAN = GetGameTime();
		NEXT_SPIT_SCAN += FREQ_SPIT_SCAN;
		SPIT_TARGETS = FindEntitiesInSphere("enemy", 512);
		N_SPIT_TARGETS = GetTokenCount(SPIT_TARGETS, ";");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((I_R_FROZEN)) return;
		if (!(m_hAttackTarget != "none")) return;
		if (!(N_SPIT_TARGETS > 0)) return;
		if (!(GetGameTime() > NEXT_SPIT)) return;
		NEXT_SPIT = GetGameTime();
		NEXT_SPIT += FREQ_SPIT;
		if (N_SPIT_TARGETS > 1)
		{
			string N_MINUS = N_SPIT_TARGETS;
			N_MINUS -= 1;
			int RND_TARGET = RandomInt(0, N_MINUS);
			SPIT_TARGET = GetToken(SPIT_TARGETS, RND_TARGET, ";");
		}
		else
		{
			SPIT_TARGET = m_hAttackTarget;
		}
		TossProjectile("proj_poison_spit2", /* TODO: $relpos */ $relpos(0, 0, -16), SPIT_TARGET, 300, SPIT_DAMAGE, 0.1, "none");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(RandomInt(1, 10) == 1)) return;
		if (!(GetEntityRange(m_hLastStruck) < ATTACK_HITRANGE)) return;
		ApplyEffect(m_hLastStruck, "effects/dot_poison", Random(3, 5), GetEntityIndex(GetOwner()), POISON_DAMAGE);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(GetGameTime() > NEXT_CLOUD)) return;
		NEXT_CLOUD = GetGameTime();
		NEXT_CLOUD += FREQ_CLOUD;
		SpawnNPC("monsters/summon/npc_poison_cloud2", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), CLOUD_DAMAGE, CLOUD_DURATION, 1
	}

}

}
