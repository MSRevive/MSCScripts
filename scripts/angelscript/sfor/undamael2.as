#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Undamael2 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK1_RANGE;
	int ATTACK2_RANGE;
	string ATTACK_RANGE;
	int CAN_FLINCH;
	int FLINCH_DELAY;
	int IGNORE_ENEMY;
	int I_AM_TURNABLE;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	string NPC_MOVE_TARGET;
	int SEE_ENEMY;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_PAIN;
	string SOUND_PISSED;
	string SOUND_REGEN;
	string SOUND_SPAWN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Undamael2()
	{
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		SOUND_PAIN = "controller/con_pain2.wav";
		SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		SOUND_DEATH = "npc/undamael2.wav";
		SOUND_SPAWN = "npc/undamael1.wav";
		ANIM_RUN = "walk";
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack1";
		ATTACK1_RANGE = 600;
		ATTACK2_RANGE = 200;
		MOVE_RANGE = 500;
		SEE_ENEMY = 0;
		IGNORE_ENEMY = 0;
		CAN_FLINCH = 0;
		FLINCH_DELAY = 12;
		NPC_MOVE_TARGET = "enemy";
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SPAWN);
		Precache(SOUND_DEATH);
		Precache("lgtning.spr");
		SOUND_PISSED = "nihilanth/nil_done.wav";
		SOUND_REGEN = "x/x_laugh1.wav";
		I_AM_TURNABLE = 0;
	}

	void OnSpawn() override
	{
		SetName("Lord Undamael");
		SetInvincible(true);
		SetHealth(9000);
		SetGold(RandomInt(100, 400));
		SetWidth(50);
		SetHeight(128);
		SetRace("undead");
		SetRoam(false);
		SetHearingSensitivity(10);
		NPC_GIVE_EXP = 400;
		SetModel("monsters/skeleton_hood.mdl");
		SetModelBody(0, 0);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetActionAnim(ANIM_ATTACK);
		SetDamageResistance("all", 0.25);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 0.1);
		SetDamageResistance("lightning", 0.1);
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SPAWN);
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, 600, Random(20.0, 150.0), 0.75, "slash");
	}

	void attack_2()
	{
		DoDamage(m_hLastSeen, ATTACK2_RANGE, Random(10.0, 100.0), 1.0, "slash");
		DoDamage(m_hLastSeen, ATTACK2_RANGE, Random(10.0, 100.0), 1.0, "slash");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void npc_attack()
	{
		if (RandomInt(0, 10) > 9)
		{
			ANIM_ATTACK = "attack1";
			ATTACK_RANGE = 600;
			MOVE_RANGE = 500;
		}
		else
		{
			ANIM_ATTACK = "attack2";
			ATTACK_RANGE = 160;
			MOVE_RANGE = 130;
		}
	}

	void death()
	{
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_DEATH);
		GiveItem(GetOwner(), "bows_swiftbow");
		GiveItem(GetOwner(), "smallarms_huggerdagger3");
	}

	void vulnerable()
	{
		SetInvincible(false);
		EmitSound(GetOwner(), 0, SOUND_PISSED, 10);
		SetSayTextRange(1024);
		SayText("No! What have you done!?");
	}

	void OnDamage(int damage) override
	{
		// TODO: UNCONVERTED: 'reflect attacks >100dmg
		if (param2 > 100)
		{
			DoDamage(param1, "direct", 1.0, param2, GetOwner());
		}
	}

	void my_target_died()
	{
		// TODO: UNCONVERTED: 'regen all health on kill
		EmitSound(GetOwner(), 0, SOUND_REGEN, 10);
		Effect("glow", GetOwner(), Vector3(0, 255, 0), 128, 2, 2);
		SetHealth(GetMonsterMaxHP());
	}

}

}
