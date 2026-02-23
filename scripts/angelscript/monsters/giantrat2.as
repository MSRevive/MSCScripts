#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Giantrat2 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_IDLE2;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int HUNT_AGRO;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	Giantrat2()
	{
		const int NO_EXP_MULTI = 1;
		ANIM_IDLE = "idle1";
		ANIM_IDLE2 = "idle1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "die";
		MOVE_RANGE = 10;
		const float ATTACK_DAMAGE = 0.4;
		ATTACK_RANGE = 48;
		ATTACK_HITRANGE = 100;
		const float ATTACK_HITCHANCE = 0.3;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN = "monsters/rat/squeak1.wav";
		const string SOUND_ATTACK1 = "monsters/rat/squeak2.wav";
		const string SOUND_ATTACK2 = "monsters/orc/attack2.wav";
		const string SOUND_ATTACK3 = "monsters/orc/attack3.wav";
		const string SOUND_IDLE1 = "monsters/rat/squeak2.wav";
		const string SOUND_DEATH = "monsters/rat/squeak3.wav";
		CAN_FLEE = 1;
		const int FLEE_HEALTH = 2;
		const float FLEE_CHANCE = 0.0;
		DROP_ITEM1 = "skin_ratpelt";
		DROP_ITEM1_CHANCE = 0.5;
		HUNT_AGRO = 0;
		Precache(SOUND_IDLE1);
		Precache(SOUND_DEATH);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10);
		if (!(IS_HUNTING))
		{
		}
		string STAND_UP = RandomInt(0, 5);
		if (STAND_UP == 0)
		{
			PlayAnim("once", ANIM_IDLE2);
		}
	}

	void OnSpawn() override
	{
		SetHealth(50000);
		SetWidth(32);
		SetHeight(32);
		SetName("Godlike Giant Rat");
		SetRoam(true);
		SetHearingSensitivity(0);
		NPC_GIVE_EXP = 3;
		SetRace("vermin");
		SetModel("monsters/giant_rat.mdl");
		SetModelBody(1, 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void bite1()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
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
