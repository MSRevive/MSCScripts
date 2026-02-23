#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Shambler2 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string ATTACK_TYPE;
	int CAN_FLEE;
	int NPC_GIVE_EXP;

	Shambler2()
	{
		const int HUNT_AGRO = 1;
		ANIM_DEATH = "diebackward";
		ANIM_RUN = "walk";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack1";
		const string ANIM_ATTACK_SLASH = "attack1";
		const string ANIM_ATTACK_CRUSH = "attack2";
		const string DMG_SLASH = RandomInt(50, 100);
		const string DMG_CRUSH = RandomInt(170, 400);
		ATTACK_RANGE = 80;
		ATTACK_HITRANGE = 220;
		const float ATTACK_HITCHANCE_SLASH = 0.7;
		const float ATTACK_HITCHANCE_CRUSH = 0.4;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "agrunt/ag_attack1.wav";
		const string SOUND_PAIN = "agrunt/ag_attack3.wav";
		const string SOUND_ATTACK1 = "ichy/ichy_bite1.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		const string SOUND_IDLE1 = "garg/gar_breathe3.wav";
		const string SOUND_DEATH = "bullchicken/bc_die3.wav";
		const int CAN_HUNT = 1;
		const int HUNT_AGRO = 1;
		const float RETALIATE_CHANCE = 0.75;
		CAN_FLEE = 0;
		const string SOUND_STEP1 = "debris/flesh1.wav";
		const string SOUND_STEP2 = "debris/flesh2.wav";
		const string SOUND_STEP3 = "debris/flesh3.wav";
		const string SOUND_STEP4 = "debris/flesh7.wav";
		const string SOUND_STEP5 = "debris/flesh5.wav";
		const string SOUND_STEP6 = "debris/flesh6.wav";
		const string SOUND_STEP7 = "debris/flesh7.wav";
		const int GOLD_BAGS = 1;
		const int GOLD_BAGS_PPLAYER = 2;
		const int GOLD_PER_BAG = 25;
		const int GOLD_RADIUS = 64;
		const int GOLD_MAX_BAGS = 32;
		const int CHANCE_STUN = 50;
		Precache(SOUND_DEATH);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(5, 8));
		EmitSound(GetOwner(), 0, SOUND_IDLE1, 10);
		if (!(CYCLED_UP))
		{
		}
		PlayAnim("once", "llflinch");
	}

	void OnSpawn() override
	{
		SetHealth(4000);
		SetWidth(50);
		SetHeight(150);
		SetName("Greater Shambler");
		SetRoam(true);
		SetBloodType("green");
		SetHearingSensitivity(6);
		NPC_GIVE_EXP = 200;
		SetRace("demon");
		SetModel("monsters/shambler.mdl");
		SetModelBody(0, 0);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		SetAnimFrameRate(0.75);
		SetAnimMoveSpeed(0.75);
	}

	void attack_1()
	{
		ATTACK_TYPE = "slash";
		if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
		{
			npcatk_dodamage(m_hAttackTarget, "direct", DMG_SLASH, ATTACK_HITCHANCE_SLASH, GetEntityIndex(GetOwner()), "slash");
		}
		if (RandomInt(1, 4) == 3)
		{
			ANIM_ATTACK = ANIM_ATTACK_CRUSH;
		}
		AddVelocity(m_hLastStruckByMe, /* TODO: $relvel */ $relvel(0, 35, 70));
		EmitSound(GetOwner(), 2, SOUND_ATTACK1, 10);
	}

	void attack_2()
	{
		ATTACK_TYPE = "crush";
		if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
		{
			npcatk_dodamage(m_hAttackTarget, "direct", DMG_CRUSH, ATTACK_HITCHANCE_CRUSH, GetEntityIndex(GetOwner()), "blunt");
		}
		ANIM_ATTACK = ANIM_ATTACK_SLASH;
		AddVelocity(m_hLastStruckByMe, /* TODO: $relvel */ $relvel(0, 300, 200));
		EmitSound(GetOwner(), 2, SOUND_ATTACK2, 10);
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_PAIN
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_PAIN};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dodamage()
	{
		if (!(ATTACK_TYPE == "crush")) return;
		if (!(param1)) return;
		if (!(RandomInt(1, 100) < CHANCE_STUN)) return;
		ApplyEffect(param2, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
	}

	void walk_step()
	{
		// PlayRandomSound from: SOUND_STEP1, SOUND_STEP2, SOUND_STEP3, SOUND_STEP4, SOUND_STEP5, SOUND_STEP6, SOUND_STEP7
		array<string> sounds = {SOUND_STEP1, SOUND_STEP2, SOUND_STEP3, SOUND_STEP4, SOUND_STEP5, SOUND_STEP6, SOUND_STEP7};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

}

}
