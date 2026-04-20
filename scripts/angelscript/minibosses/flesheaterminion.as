#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Flesheaterminion : CGameScript
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
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_HUNT;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int HUNT_AGRO;
	int I_AM_TURNABLE;
	int MOVE_RANGE;
	string MY_ENEMY;
	int NPC_GIVE_EXP;
	float RETALIATE_CHANCE;
	string SET_GREEK;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Flesheaterminion()
	{
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		CAN_ATTACK = 1;
		ANIM_ATTACK = "attack3";
		ATTACK_DAMAGE = 10;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 200;
		MOVE_RANGE = 90;
		ATTACK_HITCHANCE = 0.85;
		SOUND_STRUCK1 = "controller/con_pain3.wav";
		SOUND_STRUCK2 = "controller/con_pain3.wav";
		SOUND_STRUCK3 = "none";
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
		Precache("monsters/skeleton_enraged.mdl");
	}

	void OnSpawn() override
	{
		I_AM_TURNABLE = 0;
		SetHealth(400);
		SetWidth(32);
		SetHeight(80);
		SetName("A minion of Flesheater");
		SetRoam(true);
		SetHearingSensitivity(8);
		NPC_GIVE_EXP = 80;
		SetRace("undead");
		SetModel("monsters/skeleton_enraged.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 7);
		SetDamageResistance("all", 0.65);
		SetDamageResistance("holy", 3.0);
		SetDamageResistance("poison", 0.0);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		if (StringToLower(GetMapName()) == "thanatos")
		{
			SET_GREEK = 1;
		}
		if ((SET_GREEK))
		{
			SetModelBody(0, 10);
		}
		ScheduleDelayedEvent(2, "game_wander");
	}

	void attack_3()
	{
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
		ApplyEffect(m_hLastStruckByMe, "effects/dot_poison", 5, GetOwner(), RandomInt(8, 12));
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
		ANIM_DEATH = "dieheadshot";
		if (RandomInt(0, 1) == 0)
		{
			SayText("My master shall have your flesh!");
		}
	}

	void go_greek()
	{
		SetModelBody(0, 10);
		SET_GREEK = 1;
	}

}

}
