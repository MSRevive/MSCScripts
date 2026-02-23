#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Scorpion2 : CGameScript
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
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	int HUNT_AGRO;
	int NPC_GIVE_EXP;
	string NPC_MOVE_TARGET;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Scorpion2()
	{
		const int DELETE_ON_DEATH = 1;
		ANIM_IDLE = "idle_b";
		SOUND_STRUCK1 = "body/flesh1.wav";
		SOUND_STRUCK2 = "body/flesh2.wav";
		SOUND_STRUCK3 = "body/flesh3.wav";
		SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		const string SOUND_DEATH = "monsters/spider/spiderdie.wav";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attackb";
		ANIM_DEATH = "die";
		ATTACK_RANGE = 75;
		ATTACK_HITRANGE = 100;
		ATTACK_HITCHANCE = 0.6;
		ATTACK_DAMAGE = 5;
		CAN_FLEE = 0;
		FLEE_HEALTH = 0;
		FLEE_CHANCE = 1.0;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		NPC_MOVE_TARGET = "enemy";
		Precache(SOUND_DEATH);
		Precache(SOUND_IDLE1);
		Precache("monsters/base_monster");
		Precache("monsters/base_npc_attack");
		Precache("monsters/base_npc");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10);
		SetVolume(5);
		// PlayRandomSound from: SOUND_IDLE1
		array<string> sounds = {SOUND_IDLE1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnSpawn() override
	{
		SetHealth(75);
		SetWidth(40);
		SetHeight(40);
		SetRace("spider");
		SetName("Large Scorpion");
		SetRoam(true);
		SetHearingSensitivity(3);
		NPC_GIVE_EXP = 15;
		SetDamageResistance("all", 0.8);
		SetModel("monsters/scorp2.mdl");
		SetModelBody(1, 0);
		SetIdleAnim("idle_a");
		SetMoveAnim("walk");
		SetActionAnim("attackb");
		// PlayRandomSound from: SOUND_IDLE1
		array<string> sounds = {SOUND_IDLE1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void strike()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
