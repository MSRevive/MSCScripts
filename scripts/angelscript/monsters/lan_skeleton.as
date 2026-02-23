#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class LanSkeleton : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
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

	LanSkeleton()
	{
		ANIM_RUN = "walk";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		CAN_HUNT = 1;
		ANIM_ATTACK = "attack1";
		const int ATTACK_DAMAGE = 30;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 200;
		const float ATTACK_HITCHANCE = 0.85;
		const string SOUND_STRUCK1 = "controller/con_pain3.wav";
		const string SOUND_STRUCK2 = "controller/con_pain3.wav";
		const string SOUND_STRUCK3 = "zombie/zo_pain2.wav";
		const string SOUND_PAIN = "zombie/zo_pain2.wav";
		const string SOUND_ATTACK1 = "controller/con_attack1.wav";
		const string SOUND_ATTACK2 = "controller/con_attack2.wav";
		const string SOUND_DEATH = "controller/con_die2.wav";
		const string SOUND_IDLE1 = "controller/con_attack3.wav";
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
		SetHealth(400);
		SetWidth(32);
		SetHeight(80);
		SetName("Maldora's Minion");
		SetRoam(false);
		SetHearingSensitivity(8);
		NPC_GIVE_EXP = 125;
		SetRace("undead");
		SetModel("monsters/skeleton2.mdl");
		SetModelBody(0, 1);
		SetDamageResistance("all", 0.65);
		SetDamageResistance("fire", 0.1);
		SetDamageResistance("holy", 3.0);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
		if (RandomInt(0, 1) == 0)
		{
			SetVolume(5);
			ApplyEffect(m_hLastStruckByMe, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), RandomInt(10, 20));
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
		ANIM_DEATH = "dieforward";
		string TAUNT_COMMENT = RandomInt(1, 3);
		if (TAUNT_COMMENT == 1)
		{
			SayText("Maldora shall destroy you!");
		}
		if (TAUNT_COMMENT == 2)
		{
			SayText("I die - yet Maldora is beyond death... Are you?");
		}
		if (TAUNT_COMMENT == 3)
		{
			SayText("Rest I will , until my master Maldora returns.");
		}
	}

	void turn_undead()
	{
		string INC_HOLY_DMG = param1;
		string THE_EXCORCIST = param2;
		string ME_ME = GetEntityIndex(GetOwner());
		DoDamage(ME_ME, "direct", INC_HOLY_DMG, 100, THE_EXCORCIST);
		Effect("glow", GetOwner(), Vector3(255, 255, 0), 512, 1, 1);
	}

}

}
