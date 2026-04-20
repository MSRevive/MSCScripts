#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SlowWalk : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_KICK;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	float BASE_FRAMERATE;
	float BASE_MOVESPEED;
	int CAN_FLINCH;
	string CUR_PLAYERS;
	int DMG_KICK;
	int DROP_GOLD;
	string MONSTER_MODEL;
	int MOVE_RANGE;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_DEATH;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	int TIMES_HIT;

	SlowWalk()
	{
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_KICK = "kick";
		ANIM_ATTACK = ANIM_KICK;
		ANIM_DEATH = "die_fallback";
		ANIM_IDLE = "idle1";
		CAN_FLINCH = 0;
		DROP_GOLD = 0;
		SOUND_DEATH = "voices/orc/die.wav";
		Precache(SOUND_DEATH);
		SOUND_ATTACK1 = "voices/orc/attack.wav";
		SOUND_ATTACK2 = "voices/orc/attack2.wav";
		SOUND_ATTACK3 = "voices/orc/attack3.wav";
		SOUND_STRUCK1 = "body/armour1.wav";
		SOUND_STRUCK2 = "body/armour2.wav";
		SOUND_STRUCK3 = "body/armour3.wav";
		SOUND_PAIN = "monsters/orc/pain.wav";
		MOVE_RANGE = 64;
		ATTACK_RANGE = 90;
		ATTACK_HITRANGE = 120;
		ATTACK_HITCHANCE = 100;
		DMG_KICK = RandomInt(0, 1);
		MONSTER_MODEL = "monsters/Orc.mdl";
		Precache(MONSTER_MODEL);
	}

	void OnSpawn() override
	{
		SetName("Frozen Spirit");
		SetRace("evil");
		SetHealth(10000);
		SetModel(MONSTER_MODEL);
		SetWidth(32);
		SetHeight(72);
		SetDamageResistance("all", 0.5);
		CUR_PLAYERS = GetPlayerCount();
		CUR_PLAYERS *= 4;
		TIMES_HIT = 0;
		SetAnimMoveSpeed(0.5);
		SetAnimFrameRate(0.5);
		BASE_MOVESPEED = 0.5;
		BASE_FRAMERATE = 0.5;
		SetHearingSensitivity(15);
		// TODO: UNCONVERTED: hearingsensitivity
	}

	void OnDamage(int damage) override
	{
		TIMES_HIT += 1;
		if (TIMES_HIT == CUR_PLAYERS)
		{
			SetHealth(0);
		}
		// PlayRandomSound from: SOUND_PAIN
		array<string> sounds = {SOUND_PAIN};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
	}

	void kick_land()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KICK, ATTACK_HITCHANCE, "slash");
	}

}

}
