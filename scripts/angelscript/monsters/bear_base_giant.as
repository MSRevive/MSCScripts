#pragma context server

#include "monsters/bear_base.as"

namespace MS
{

class BearBaseGiant : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	string ATTACK_DAMAGE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BEAR_CANSTAND;
	int BEAR_ISDDEAD;
	int BEAR_ISDEAD;
	int BEAR_ISSTOMPATK;
	int BEAR_STANDING;
	int CAN_ATTACK;
	string DROP_ITEM1_CHANCE;
	string FORWARDPUSH;
	int MOVE_RANGE;
	float MSC_PUSH_RESIST;
	string SIDEPUSH;
	string STAND_HEALTH;
	string UPPUSH;

	BearBaseGiant()
	{
		ANIM_IDLE = ANIM_IDLE;
		ANIM_WALK = ANIM_WALK;
		ANIM_RUN = ANIM_RUN;
		ANIM_ATTACK = ANIM_ATTACK;
		MSC_PUSH_RESIST = 0.75;
		const int ATTACK_NORMAL_DAMAGE = 10;
		const string ATTACK_STANDING_DAMAGE = Random(15, 20);
		ATTACK_DAMAGE = ATTACK_NORMAL_DAMAGE;
		MOVE_RANGE = 108;
		ATTACK_RANGE = 128;
		ATTACK_HITRANGE = 160;
		const int ATTACK_STOMPRANGE = 160;
		const int ATTACK_STOMPDMG = 5;
		const int NPC_BASE_EXP = 90;
		const string BEAR_VOLUME = "game.sound.maxvol";
		const string SOUND_DEATH = "monsters/bear/giantbeardeath.wav";
		const string SOUND_DEATH2 = "monsters/bear/giantbeardeath2.wav";
		const string SOUND_GETUP_GROWL = "monsters/bear/giantbeardeath2.wav";
		const string SOUND_GETUP = "monsters/troll/step1.wav";
		const string SOUND_GETDOWN = "monsters/troll/step2.wav";
		const string SOUND_UPSNARL = "monsters/bear/giantbearupsnarl.wav";
		const string SOUND_UPSTEP1 = "monsters/bear/giantbearstep1.wav";
		const string SOUND_UPSTEP2 = "monsters/bear/giantbearstep2.wav";
		const int NPC_AUTO_DEATH = 0;
		// TODO: removesetvar ANIM_IDLE
		// TODO: removesetvar ANIM_RUN
		// TODO: removesetvar ANIM_WALK
		// TODO: UNCONVERTED: removesetvard ANIM_ATTACK
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(3);
		if ((BEAR_STANDING))
		{
			if (RandomInt(0, 100) < 25)
			{
			}
			EmitSound(GetOwner(), 0, BEAR_VOLUME, 10);
		}
		if (RandomInt(0, 100) < 50)
		{
		}
		if (GetMonsterHP() < STAND_HEALTH)
		{
		}
		if (!(BEAR_STANDING))
		{
		}
		if ((BEAR_CANSTAND))
		{
		}
		if ((IS_HUNTING))
		{
		}
		if (CanSee(m_hLastSeen, "range") < 250)
		{
		}
		bear_standup();
	}

	void game_postspawn()
	{
		if ((StringToLower(GetMapName())).findFirst("skycastle") == 0)
		{
			DROP_ITEM1_CHANCE = 0.0;
		}
	}

	void OnSpawn() override
	{
		SetHealth(170);
		SetWidth(105);
		SetHeight(95);
		SetVolume(10);
		SetModel("monsters/giant_bear.mdl");
		SetHearingSensitivity(8);
		ANIM_ATTACK = "attack";
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		BEAR_STANDING = 0;
		BEAR_CANSTAND = 1;
		BEAR_ISSTOMPATK = 0;
		BEAR_ISDDEAD = 0;
	}

	void OnPostSpawn() override
	{
		STAND_HEALTH = GetMonsterMaxHP();
		STAND_HEALTH *= 0.75;
	}

	void frame_runstomp()
	{
		bear_shake();
	}

	void frame_attack1()
	{
		// PlayRandomSound from: BEAR_VOLUME, SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {BEAR_VOLUME, SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), "game.sound.weapon", sounds[RandomInt(0, sounds.length() - 1)], 10);
		BEAR_ISSTOMPATK = 0;
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		int SHOULD_PUSH_ENTITY = 1;
		if ((BEAR_ISSTOMPATK))
		{
			if (!(IsOnGround(m_hLastStruckByMe)))
			{
				SHOULD_PUSH_ENTITY = 0;
				game.monster.canceldamage = 1;
			}
		}
		if (!(SHOULD_PUSH_ENTITY)) return;
		int FORWARDPUSH = 190;
		string SIDEPUSH = Random(-60, 0);
		int UPPUSH = 10;
		if ((BEAR_ISDEAD))
		{
			FORWARDPUSH = 100;
			SIDEPUSH = 0;
			UPPUSH = 200;
		}
		AddVelocity(m_hLastStruckByMe, /* TODO: $relvel */ $relvel(SIDEPUSH, FORWARDPUSH, UPPUSH));
	}

	void bear_standup()
	{
		BEAR_STANDING = 1;
		ANIM_ATTACK = "upattack";
		ANIM_IDLE = "upidle";
		ANIM_WALK = "upwalk";
		ANIM_RUN = "upwalk";
		ATTACK_DAMAGE = ATTACK_STANDING_DAMAGE;
		RandomInt(7, 15)("bear_getdown");
		SetIdleAnim("upidle");
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("all", 0.6);
		PlayAnim("critical", "getup");
		AS_ATTACKING = GetGameTime();
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_GETUP_GROWL, BEAR_VOLUME);
	}

	void bear_getdown()
	{
		BEAR_STANDING = 0;
		BEAR_CANSTAND = 0;
		ANIM_ATTACK = "attack";
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ATTACK_DAMAGE = ATTACK_NORMAL_DAMAGE;
		CAN_ATTACK = 0;
		SetIdleAnim("idle");
		SetMoveAnim(ANIM_WALK);
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", "getdown");
		SetDamageResistance("all", 1);
		bear_stomp();
		ScheduleDelayedEvent(15, "bear_resetstand");
		ScheduleDelayedEvent(3, "bear_falldelay");
	}

	void bear_falldelay()
	{
		CAN_ATTACK = 1;
	}

	void frame_getup()
	{
		EmitSound(GetOwner(), CHAN_VOICE, SOUND_GETUP, BEAR_VOLUME);
	}

	void frame_upstep()
	{
		bear_walkeffect();
	}

	void frame_hitground()
	{
		bear_shake();
		bear_stomp();
	}

	void bear_resetstand()
	{
		BEAR_CANSTAND = 1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// PlayRandomSound from: SOUND_DEATH, SOUND_DEATH2
		array<string> sounds = {SOUND_DEATH, SOUND_DEATH2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if ((BEAR_STANDING))
		{
			ANIM_DEATH = "updeath";
		}
		PlayAnim("critical", ANIM_DEATH);
		BEAR_ISDEAD = 1;
	}

	void bear_shake()
	{
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 190, 20, 1, 256);
		EmitSound(GetOwner(), SOUND_GETDOWN);
	}

	void bear_walkeffect()
	{
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 128, 10, 1, 128);
		// PlayRandomSound from: SOUND_UPSTEP1, SOUND_UPSTEP2
		array<string> sounds = {SOUND_UPSTEP1, SOUND_UPSTEP2};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void bear_stomp()
	{
		BEAR_ISSTOMPATK = 1;
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), ATTACK_STOMPRANGE, ATTACK_STOMPDMG, 1.0, 0);
	}

}

}
