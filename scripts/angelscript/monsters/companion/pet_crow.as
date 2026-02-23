#pragma context server

#include "monsters/summon/base_summon.as"
#include "monsters/companion/base_companion.as"

namespace MS
{

class PetCrow : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HEAR;
	int CAN_HUNT;
	int MOVE_RANGE;
	float RETALIATE_CHANCE;
	string SUMMON_MASTER;

	PetCrow()
	{
		ANIM_IDLE = "glide";
		ANIM_WALK = "fly_slow";
		ANIM_RUN = "fly";
		ANIM_ATTACK = "fly";
		MOVE_RANGE = 48;
		ATTACK_RANGE = 64;
		const int ATK_MIN = 2;
		const int ATK_MAX = 4;
		ATTACK_HITRANGE = 100;
		const float ATTACK_HITCHANCE = 0.9;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod1.wav";
		const string SOUND_PAIN = "none";
		const string SOUND_ATTACK1 = "monsters/rat/squeak2.wav";
		const string SOUND_IDLE1 = "monsters/rat/squeak2.wav";
		const string SOUND_DEATH = "monsters/rat/squeak3.wav";
		RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
		CAN_HUNT = 1;
		CAN_HEAR = 0;
		CAN_FLINCH = 0;
	}

	void summon_spawn()
	{
		SetName("Pet Crow");
		SetHealth(10);
		SetWidth(32);
		SetHeight(20);
		SetRoam(true);
		SetHearingSensitivity(3);
		SetSkillLevel(5);
		SetRace("human");
		SetFly(true);
		SetModel("monsters/crow.mdl");
		SetModelBody(1, 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		basesummon_attackall();
		CatchSpeech("regme", "reg");
		CatchSpeech("unregme", "unreg");
	}

	void regme()
	{
		// TODO: companion add ent_me ent_lastspoke
		SUMMON_MASTER = GetEntityIndex("ent_lastspoke");
		basesummon_follow_master();
	}

	void unregme()
	{
		if (GetEntityIndex("ent_lastspoke") == SUMMON_MASTER)
		{
			// TODO: companion remove ent_me ent_lastspoke
			SUMMON_MASTER = "-!-";
			basesummon_say_attackall();
		}
	}

	void bite1()
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_ATTACK1
		array<string> sounds = {SOUND_ATTACK1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, Random(ATK_MIN, ATK_MAX), ATTACK_HITCHANCE, "slash");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
