#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Scorpion5 : CGameScript
{
	int AM_SUMMONED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_POISON;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	int CAN_FLEE;
	int CAN_HUNT;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	int HUNT_AGRO;
	string MY_OWNER;
	int NPC_GIVE_EXP;
	string NPC_MOVE_TARGET;

	Scorpion5()
	{
		const int DELETE_ON_DEATH = 1;
		ANIM_IDLE = "idle_a";
		const string SOUND_STRUCK1 = "body/flesh1.wav";
		const string SOUND_STRUCK2 = "body/flesh2.wav";
		const string SOUND_STRUCK3 = "body/flesh3.wav";
		const string SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		const string SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		const string SOUND_DEATH = "monsters/spider/spiderdie.wav";
		ANIM_IDLE = "idle_b";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attackb";
		ANIM_DEATH = "die";
		ANIM_POISON = "attacka";
		ATTACK_RANGE = 75;
		ATTACK_HITRANGE = 100;
		ATTACK_HITCHANCE = 0.6;
		ATTACK_DAMAGE = 30;
		CAN_FLEE = 0;
		FLEE_HEALTH = 0;
		FLEE_CHANCE = 1.0;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		NPC_MOVE_TARGET = "enemy";
		const string SOUND_SWING = "zombie/claw_miss1.wav";
		const string SOUND_BIGSWING = "zombie/claw_miss2.wav";
		Precache(SOUND_DEATH);
		Precache(SOUND_IDLE1);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10);
		SetVolume(10);
		// PlayRandomSound from: SOUND_IDLE1
		array<string> sounds = {SOUND_IDLE1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnSpawn() override
	{
		scorpion_spawn();
	}

	void scorpion_spawn()
	{
		SetHealth(1000);
		SetWidth(40);
		SetHeight(50);
		SetRace("spider");
		SetName("Gigantic Venomous Scorpion");
		SetRoam(true);
		SetHearingSensitivity(3);
		NPC_GIVE_EXP = 200;
		SetModel("monsters/scorp5.mdl");
		SetModelBody(1, 0);
		SetIdleAnim("idle_a");
		SetMoveAnim("walk");
		SetActionAnim("attackb");
		SetAnimFrameRate(0.5);
		SetAnimMoveSpeed(0.25);
		BASE_FRAMERATE = 0.5;
		BASE_MOVESPEED = 0.25;
		// PlayRandomSound from: SOUND_IDLE1
		array<string> sounds = {SOUND_IDLE1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// PlayRandomSound from: SOUND_IDLE1
		array<string> sounds = {SOUND_IDLE1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 0);
		if (!(AM_SUMMONED)) return;
		CallExternal(MY_OWNER, "scorpion_died");
	}

	void strike()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
		if (RandomInt(1, 10) == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_BIGSWING, 10);
			PlayAnim("critical", ANIM_POISON);
			if (GetEntityRange(HUNT_LASTTARGET) < ATTACK_RANGE)
			{
			}
			ApplyEffect(HUNT_LASTTARGET, "effects/dot_poison", 10, GetEntityIndex(GetOwner()), Random(12, 20));
		}
		else
		{
			EmitSound(GetOwner(), 0, SOUND_SWING, 10);
			if (GetEntityRange(HUNT_LASTTARGET) < ATTACK_RANGE)
			{
			}
			string RND_LR = Random(-100, 100);
			string RND_FB = Random(-200, 200);
			AddVelocity(HUNT_LASTTARGET, /* TODO: $relvel */ $relvel(RND_LR, RND_FB, 10));
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dynamically_created()
	{
		MY_OWNER = GetEntityIndex(param1);
		SetRace(GetEntityRace(MY_OWNER));
		AM_SUMMONED = 1;
		ScheduleDelayedEvent(0.1, "summoned_sound");
	}

	void summoned_sound()
	{
		EmitSound(GetOwner(), 0, "ambience/alien_humongo.wav", 10);
	}

}

}
