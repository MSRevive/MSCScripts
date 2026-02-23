#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Fangtooth : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_RANGE;
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	int CAN_FLEE;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	int NPC_GIVE_EXP;
	string NPC_MOVE_TARGET;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Fangtooth()
	{
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "die";
		ATTACK_DAMAGE = 5;
		ATTACK_RANGE = 90;
		ATTACK_HITCHANCE = 0.65;
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_PAIN = "monsters/rat/squeak1.wav";
		SOUND_ATTACK1 = "monsters/rat/squeak2.wav";
		SOUND_ATTACK2 = "monsters/orc/attack2.wav";
		SOUND_ATTACK3 = "monsters/orc/attack3.wav";
		SOUND_IDLE1 = "monsters/rat/squeak2.wav";
		const string SOUND_DEATH = "monsters/rat/squeak3.wav";
		NPC_MOVE_TARGET = "enemy";
		CAN_FLEE = 1;
		FLEE_HEALTH = 2;
		FLEE_CHANCE = 0.3;
		DROP_ITEM1 = "smallarms_fangstooth";
		DROP_ITEM1_CHANCE = 0.03;
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetHealth(65);
		SetWidth(32);
		SetHeight(32);
		SetName("Fang Tooth");
		SetRoam(true);
		SetHearingSensitivity(3);
		NPC_GIVE_EXP = 30;
		SetRace("vermin");
		SetModel("monsters/giant_rat.mdl");
		SetModelBody(1, 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetAnimMoveSpeed(2.0);
		SetAnimFrameRate(2.0);
		BASE_FRAMERATE = 2.0;
		BASE_MOVESPEED = 2.0;
	}

	void bite1()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, Random(4.5, 6.0), ATTACK_HITCHANCE, "slash");
		string random = RandomInt(1, 3);
		if (random == 1)
		{
			ApplyEffect(m_hLastStruckByMe, "effects/dot_poison", 5, GetEntityIndex(GetOwner()), RandomInt(3, 5));
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK3, SOUND_PAIN
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK3, SOUND_PAIN};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
