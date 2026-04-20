#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Lanskeleton : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_HUNT;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int I_AM_TURNABLE;
	string MY_ENEMY;
	int NPC_GIVE_EXP;
	float RETALIATE_CHANCE;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Lanskeleton()
	{
		ANIM_RUN = "walk";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		CAN_HUNT = 1;
		ANIM_ATTACK = "attack1";
		ATTACK_DAMAGE = 10;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 200;
		ANIM_DEATH = "dieheadshot2";
		ATTACK_HITCHANCE = 0.85;
		SOUND_STRUCK1 = "controller/con_pain3.wav";
		SOUND_STRUCK2 = "controller/con_pain3.wav";
		SOUND_STRUCK3 = "zombie/zo_pain2.wav";
		SOUND_PAIN = "zombie/zo_pain2.wav";
		SOUND_ATTACK1 = "controller/con_attack1.wav";
		SOUND_ATTACK2 = "controller/con_attack2.wav";
		SOUND_DEATH = "controller/con_die2.wav";
		SOUND_IDLE1 = "controller/con_attack3.wav";
		MY_ENEMY = "enemy";
		RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 15;
		DROP_GOLD_MAX = 240;
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		I_AM_TURNABLE = 0;
		SetHealth(100);
		SetWidth(32);
		SetHeight(80);
		SetName("A lesser minion of Maldora");
		SetRoam(true);
		SetHearingSensitivity(8);
		NPC_GIVE_EXP = 50;
		SetRace("undead");
		SetModel("monsters/skeleton2.mdl");
		SetModelBody(1, 0);
		SetDamageResistance("all", 0.65);
		SetDamageResistance("holy", 3.0);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
		ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 5, GetOwner(), RandomInt(8, 12));
		if (RandomInt(0, 1) == 0)
		{
			SetVolume(5);
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ANIM_DEATH = "dieheadshot2";
		if (RandomInt(0, 1) == 0)
		{
			SayText(I + " have failed my master! They live!");
		}
	}

}

}
