#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Ghostrat : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	int HUNT_AGRO;
	int NO_EXP_MULTI;
	int NPC_GIVE_EXP;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Ghostrat()
	{
		NO_EXP_MULTI = 1;
		HUNT_AGRO = 0;
		ANIM_DEATH = "die";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "attack";
		ATTACK_DAMAGE = 4.0;
		ATTACK_RANGE = 68;
		ATTACK_HITCHANCE = 0.6;
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_PAIN = "nightmare/monsters/ghostrat/squeak1.wav";
		SOUND_ATTACK1 = "nightmare/monsters/ghostrat/squeak2.wav";
		SOUND_ATTACK2 = "monsters/orc/attack2.wav";
		SOUND_ATTACK3 = "monsters/orc/attack3.wav";
		SOUND_IDLE1 = "nightmare/monsters/ghostrat/squeak2.wav";
		SOUND_DEATH = "nightmare/monsters/ghostrat/squeak3.wav";
		CAN_FLEE = 1;
		FLEE_HEALTH = 2;
		FLEE_CHANCE = 0.3;
		DROP_ITEM1 = "skin_ratpelt";
		DROP_ITEM1_CHANCE = 0.0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10.1);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(0, 128, 128), 128, 10.0);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(10);
		if (!(IS_HUNTING))
		{
		}
		if ((RandomInt(0, 1)))
		{
		}
		PlayAnim("once", "idle2");
	}

	void OnSpawn() override
	{
		SetHealth(40);
		SetWidth(24);
		SetHeight(24);
		SetName("Ghostly Rat");
		SetRoam(true);
		SetHearingSensitivity(0);
		NPC_GIVE_EXP = 30;
		SetRace("undead");
		SetModel("nightmare/monsters/ghost_rat.mdl");
		SetModelBody(1, 0);
		SetIdleAnim("idle");
		SetMoveAnim(ANIM_WALK);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetProp(GetOwner(), "renderfx", 16);
	}

	void OnPostSpawn() override
	{
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(0, 128, 128), 128, 10.0);
	}

	void bite1()
	{
		// PlayRandomSound from: SOUND_ATTACK1
		array<string> sounds = {SOUND_ATTACK1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
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
