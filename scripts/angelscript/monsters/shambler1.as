#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Shambler1 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK_CRUSH;
	string ANIM_ATTACK_SLASH;
	string ANIM_DEATH;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_HITCHANCE_CRUSH;
	float ATTACK_HITCHANCE_SLASH;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string ATTACK_TYPE;
	int CAN_FLEE;
	int CAN_HUNT;
	int CHANCE_STUN;
	int DMG_CRUSH;
	int DMG_SLASH;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int HUNT_AGRO;
	int NPC_GIVE_EXP;
	float RETALIATE_CHANCE;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;

	Shambler1()
	{
		HUNT_AGRO = 1;
		ANIM_DEATH = "dieforward";
		ANIM_RUN = "walk";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack1";
		ANIM_ATTACK_SLASH = "attack1";
		ANIM_ATTACK_CRUSH = "attack2";
		DMG_SLASH = RandomInt(35, 90);
		DMG_CRUSH = RandomInt(170, 300);
		ATTACK_RANGE = 68;
		ATTACK_HITRANGE = 140;
		ATTACK_HITCHANCE_SLASH = 0.7;
		ATTACK_HITCHANCE_CRUSH = 0.4;
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "bullchicken/bc_pain1.wav";
		SOUND_PAIN = "bullchicken/bc_pain1.wav";
		SOUND_ATTACK1 = "ichy/ichy_bite1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		SOUND_IDLE1 = "garg/gar_breathe3.wav";
		SOUND_DEATH = "bullchicken/bc_die3.wav";
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_MIN = 20;
		DROP_GOLD_MAX = 70;
		CHANCE_STUN = 20;
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		SetHealth(2000);
		SetWidth(32);
		SetHeight(100);
		SetName("Shambler");
		SetRoam(true);
		SetBloodType("green");
		SetHearingSensitivity(6);
		NPC_GIVE_EXP = 300;
		SetRace("demon");
		SetModel("monsters/bogcreature.mdl");
		SetModelBody(0, 0);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
	}

	void attack_1()
	{
		ATTACK_TYPE = "slash";
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SLASH, ATTACK_HITCHANCE_SLASH, "slash");
		if (RandomInt(1, 4) == 3)
		{
			ANIM_ATTACK = ANIM_ATTACK_CRUSH;
		}
		AddVelocity(m_hLastStruckByMe, /* TODO: $relvel */ $relvel(0, 110, 105));
		EmitSound(GetOwner(), 2, SOUND_ATTACK1, 10);
	}

	void attack_2()
	{
		ATTACK_TYPE = "crush";
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CRUSH, ATTACK_HITCHANCE_CRUSH, "blunt");
		ANIM_ATTACK = ANIM_ATTACK_SLASH;
		EmitSound(GetOwner(), 2, SOUND_ATTACK2, 10);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_PAIN
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_PAIN};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 7);
	}

	void game_dodamage()
	{
		if (!(ATTACK_TYPE == "crush")) return;
		if (!(param1)) return;
		if (!(RandomInt(1, 100) < CHANCE_STUN)) return;
		ApplyEffect(param2, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
	}

}

}
