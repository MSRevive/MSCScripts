#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class AntRedWarrior : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int MOVE_RANGE;
	string NEXT_SWITCH_ANIM;
	int NPC_ALLY_RESPONSE_RANGE;
	int NPC_GIVE_EXP;

	AntRedWarrior()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attack";
		ANIM_RUN = "walk";
		ANIM_DEATH = "die";
		const string ANIM_WALK1 = "walk";
		const string ANIM_WALK2 = "walk2";
		const string ANIM_ATTACK1 = "attack";
		const string ANIM_ATTACK2 = "attack2";
		NPC_GIVE_EXP = 100;
		NPC_ALLY_RESPONSE_RANGE = 1024;
		const string FREQ_SWITCH_ANIM = Random(5.0, 15.0);
		const int DMG_BITE = 50;
		ATTACK_RANGE = 32;
		MOVE_RANGE = 16;
		ATTACK_MOVERANGE = 16;
		ATTACK_HITRANGE = 64;
		const string SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		const string SND_STRUCK1 = "body/flesh1.wav";
		const string SND_STRUCK2 = "body/flesh2.wav";
		const string SND_STRUCK3 = "body/flesh3.wav";
		const string SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		const string SOUND_DEATH = "monsters/spider/spiderdie.wav";
		const string SOUND_ATTACK1 = "monsters/spider/spiderhiss2.wav";
		const string SOUND_ATTACK2 = "monsters/spider/spiderhiss.wav";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(3.6);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		// svplaysound: svplaysound 4 5 SOUND_IDLE1
		EmitSound(4, 5, SOUND_IDLE1);
	}

	void OnSpawn() override
	{
		SetName("Giant Ant");
		SetModel("monsters/ant_size1.mdl");
		SetWidth(32);
		SetHeight(16);
		SetRace("ant_red");
		SetHealth(200);
		SetDamageResistance("pierce", 1.25);
		SetRoam(true);
		SetHearingSensitivity(5);
		SetAnimMoveSpeed(2.0);
		SetMoveSpeed(2.0);
	}

	void OnPostSpawn() override
	{
		if (RandomInt(1, 2) == 1)
		{
			ANIM_ATTACK = ANIM_ATTACK1;
		}
		else
		{
			ANIM_ATTACK = ANIM_ATTACK2;
		}
	}

	void frame_attack()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE, 0.9, "pierce");
		if (RandomInt(1, 2) == 1)
		{
			ANIM_ATTACK = ANIM_ATTACK1;
		}
		else
		{
			ANIM_ATTACK = ANIM_ATTACK2;
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(GetGameTime() > NEXT_SWITCH_ANIM)) return;
		NEXT_SWITCH_ANIM = GetGameTime();
		NEXT_SWITCH_ANIM += FREQ_SWITCH_ANIM;
		if (RandomInt(1, 2) == 1)
		{
			ANIM_RUN = ANIM_WALK1;
			ANIM_WALK = ANIM_WALK1;
			SetMoveAnim(ANIM_RUN);
		}
		else
		{
			ANIM_RUN = ANIM_WALK2;
			ANIM_WALK = ANIM_WALK2;
			SetMoveAnim(ANIM_RUN);
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SND_STRUCK1, SND_STRUCK2, SND_STRUCK3, SND_STRUCK1, SND_STRUCK2, SND_STRUCK3, SOUND_PAIN, SOUND_PAIN
		array<string> sounds = {SND_STRUCK1, SND_STRUCK2, SND_STRUCK3, SND_STRUCK1, SND_STRUCK2, SND_STRUCK3, SOUND_PAIN, SOUND_PAIN};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// svplaysound: svplaysound 4 0 SOUND_IDLE1
		EmitSound(4, 0, SOUND_IDLE1);
	}

}

}
