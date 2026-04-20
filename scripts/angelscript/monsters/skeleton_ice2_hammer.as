#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class SkeletonIce2Hammer : CGameScript
{
	int AM_CHARGING;
	string ANIM_ATTACK;
	string ANIM_RUN;
	int ATTACK_DAMAGE_HIGH;
	int ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	float BASE_MOVESPEED;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CUSTOM_SIZE;
	float DOT_ICE;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	float FREQ_CHARGE;
	string NEXT_CHARGE;
	int NPC_GIVE_EXP;
	string N_SOUND_STEP;
	string PUSH_VEL;
	int SKEL_ATTACK_HITRANGE;
	int SKEL_ATTACK_RANGE;
	int SKEL_HEIGHT;
	int SKEL_HP;
	string SKEL_MODEL;
	int SKEL_MOVE_RANGE;
	float SKEL_RESPAWN_CHANCE;
	int SKEL_RESPAWN_LIVES;
	int SKEL_WIDTH;
	string SOUND_STEP1;
	string SOUND_STEP2;
	string SOUND_STEP3;
	string SOUND_STUN;
	string SOUND_SUMMON;
	int STUN_ATK_COUNT;
	int STUN_ATTACK;
	float WALK_MOVESPEED;

	SkeletonIce2Hammer()
	{
		SKEL_MODEL = "monsters/skeleton_boss2.mdl";
		SKEL_WIDTH = 40;
		SKEL_HEIGHT = 130;
		SKEL_MOVE_RANGE = 64;
		SKEL_ATTACK_RANGE = 150;
		SKEL_ATTACK_HITRANGE = 220;
		ANIM_RUN = "run";
		SKEL_HP = 10000;
		ATTACK_HITCHANCE = 0.85;
		ATTACK_DAMAGE_LOW = 100;
		ATTACK_DAMAGE_HIGH = 200;
		NPC_GIVE_EXP = 2500;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 750;
		SKEL_RESPAWN_CHANCE = 0.0;
		SKEL_RESPAWN_LIVES = 0;
		SOUND_STEP1 = "debris/glass1.wav";
		SOUND_STEP2 = "debris/glass2.wav";
		SOUND_STEP3 = "debris/glass3.wav";
		FREQ_CHARGE = 30.0;
		BASE_MOVESPEED = 2.0;
		WALK_MOVESPEED = 1.0;
		CAN_FLINCH = 0;
		SOUND_STUN = "zombie/claw_strike2.wav";
		SOUND_SUMMON = "monsters/skeleton/calrain3.wav";
		CUSTOM_SIZE = 1;
		DOT_ICE = 50.0;
	}

	void skeleton_spawn()
	{
		SetModelBody(0, 8);
		SetModelBody(1, 3);
		SetName("Frost Hammer");
		SetRoam(true);
		SetBloodType("none");
		SetDamageResistance("all", ".6");
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("fire", 1.5);
		SetHearingSensitivity(3);
		STUN_ATK_COUNT = 0;
	}

	void npc_targetsighted()
	{
		if (!(GetGameTime() > NEXT_CHARGE)) return;
		NEXT_CHARGE = GetGameTime();
		NEXT_CHARGE += FREQ_CHARGE;
		AM_CHARGING = 1;
		CAN_FLEE = 0;
		PlayAnim("once", "break");
		ApplyEffect(GetOwner(), "effects/sfx_motionblur_temp", GetEntityIndex(GetOwner()), 8, 0, 5.0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		SetAnimFrameRate(3.0);
		EmitSound(GetOwner(), 0, "magic/teleport.wav", 10);
		ScheduleDelayedEvent(5.0, "end_charge");
	}

	void end_charge()
	{
		CAN_FLEE = 1;
		PlayAnim("once", "break");
		AM_CHARGING = 0;
		SetProp(GetOwner(), "rendermode", 0);
		SetProp(GetOwner(), "renderamt", 255);
		SetAnimFrameRate(1.0);
	}

	void attack_1()
	{
		STUN_ATTACK = 0;
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 100, 10);
		STUN_ATK_COUNT += 1;
		if (!(STUN_ATK_COUNT >= 10)) return;
		STUN_ATK_COUNT = 0;
		ANIM_ATTACK = "attack2";
	}

	void attack_2()
	{
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 200, 10);
		STUN_ATTACK = 1;
		attack_snd();
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), ATTACK_HITCHANCE, "slash");
		ANIM_ATTACK = "attack1";
	}

	void game_dodamage()
	{
		if ((STUN_ATTACK))
		{
			if ((param1))
			{
			}
			EmitSound(GetOwner(), 0, SOUND_STUN, 10);
			ApplyEffect(param2, "effects/debuff_stun", Random(5, 10), GetEntityIndex(GetOwner()));
		}
		STUN_ATTACK = 0;
	}

	void skele_swing_dodamage()
	{
		if (!(param1)) return;
		AddVelocity(param2, PUSH_VEL);
		if (!(RandomInt(1, 10) == 1)) return;
		ApplyEffect(param2, "effects/dot_cold", 5.0, GetEntityIndex(GetOwner()), DOT_ICE);
	}

	void walk_step1()
	{
		sound_step();
	}

	void walk_step2()
	{
		sound_step();
	}

	void run_step1()
	{
		SetMoveSpeed(BASE_MOVESPEED);
		sound_step();
	}

	void run_step2()
	{
		SetMoveSpeed(BASE_MOVESPEED);
		sound_step();
	}

	void sound_step()
	{
		N_SOUND_STEP += 1;
		if (N_SOUND_STEP > 2)
		{
			N_SOUND_STEP = 1;
		}
		if (N_SOUND_STEP == 1)
		{
			EmitSound(GetOwner(), 0, "weapons/dagger/daggermetal1.wav", 5);
		}
		if (N_SOUND_STEP == 2)
		{
			EmitSound(GetOwner(), 0, "weapons/dagger/daggermetal2.wav", 5);
		}
		if (N_SOUND_STEP == 3)
		{
			EmitSound(GetOwner(), 0, SOUND_STEP3, 5);
		}
	}

	void skeleton_attribs()
	{
		SetDamageResistance("slash", ".7");
		SetDamageResistance("pierce", ".5");
		SetDamageResistance("blunt", 1.2);
		SetDamageResistance("fire", 2.0);
		SetDamageResistance("holy", 3.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("poison", 0.0);
	}

}

}
