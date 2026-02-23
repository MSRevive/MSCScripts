#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Bloodreaverminion : CGameScript
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
	string SET_GREEK;

	Bloodreaverminion()
	{
		ANIM_DEATH = "diesimple";
		ANIM_RUN = "run";
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
		SetName("A minion of Bloodreaver");
		SetRoam(true);
		SetHearingSensitivity(8);
		NPC_GIVE_EXP = 100;
		SetRace("undead");
		SetModel("monsters/skeleton_enraged.mdl");
		SetModelBody(0, 3);
		SetModelBody(1, 6);
		if (StringToLower(GetMapName()) == "thanatos")
		{
			SET_GREEK = 1;
		}
		if ((SET_GREEK))
		{
			SetModelBody(0, 10);
		}
		SetDamageResistance("all", 0.65);
		SetDamageResistance("holy", 2.0);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
	}

	void attack_1()
	{
		npcatk_dodamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE);
		ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/dot_fire", 5, GetOwner(), 12);
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
		string TAUNT_COMMENT = RandomInt(1, 3);
		if (TAUNT_COMMENT == 1)
		{
			SayText("Rejoice not! My master awaits...");
		}
		if (TAUNT_COMMENT == 2)
		{
			SayText("I die easily , but my master , not so much so.");
		}
		if (TAUNT_COMMENT == 3)
		{
			SayText("Dead I maybe , but my master will have you join me soon.");
		}
	}

}

}
