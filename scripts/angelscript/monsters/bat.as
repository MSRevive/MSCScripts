#pragma context server

#include "monsters/bat_base.as"

namespace MS
{

class Bat : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE_FLY;
	string ANIM_IDLE_HANG;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string BAT_STATUS;
	int CAN_FLEE;
	int CAN_HUNT;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	Bat()
	{
		ANIM_WALK = "IdleFlyNormal";
		ANIM_RUN = ANIM_WALK;
		ANIM_ATTACK = "bite";
		ANIM_IDLE_HANG = "IdleHang";
		ANIM_IDLE_FLY = "IdleFlyNormal";
		ANIM_DEATH = "IdleFlyNormal";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN = "monsters/rat/squeak1.wav";
		const string SOUND_IDLE = "monsters/rat/squeak2.wav";
		const string SOUND_DEATH = "monsters/rat/squeak3.wav";
		MOVE_RANGE = 30;
		ATTACK_RANGE = 65;
		ATTACK_HITRANGE = 100;
		ATTACK_HITCHANCE = 0.6;
		if (StringToLower(GetMapName()) == "catacombs")
		{
			ATTACK_HITCHANCE = 0.8;
		}
		const int ATTACK_DAMAGE = 1;
		NPC_GIVE_EXP = 5;
		CAN_FLEE = 1;
		const int FLEE_HEALTH = 0;
		const float FLEE_CHANCE = 1.0;
		Precache(SOUND_IDLE);
	}

	void bat_spawn()
	{
		SetName("Bat");
		if ((true))
		{
			string L_MAP_NAME = StringToLower(GetMapName());
			if (L_MAP_NAME == "edanasewers")
			{
				int MY_HP = 8;
			}
			if (L_MAP_NAME != "edanasewers")
			{
				int MY_HP = 20;
			}
			if (L_MAP_NAME == "nightmare_edana")
			{
				SetMonsterClip(0);
			}
			SetHealth(MY_HP);
		}
		SetWidth(16);
		SetHeight(16);
		SetHearingSensitivity(3.5);
		SetVolume(5);
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 0));
		SetModel("monsters/bat.mdl");
	}

	void game_postspawn()
	{
	}

	void bat_drop_down()
	{
		CAN_HUNT = 1;
		BAT_STATUS = BAT_FLYING;
		SetIdleAnim(ANIM_IDLE_FLY);
	}

	void bite1()
	{
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		DoDamage(m_hAttackTarget, "direct", ATTACK_DAMAGE, ATTACK_HITCHANCE, GetOwner());
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_PAIN};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

}

}
