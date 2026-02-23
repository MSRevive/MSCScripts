#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class BoarBaseRemake : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK_DEF;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_IDLE2;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	string ATTACK_HITRANGE;
	string ATTACK_MOVERANGE;
	string ATTACK_RANGE;
	string BOAR_CHARGE_FX_IDX;
	string BOAR_CHARGE_TARGET;
	string BOAR_CHARGING;
	string BOAR_HEIGHT;
	string BOAR_WIDTH;
	string DMG_ATTACK;
	string NEXT_BACKUP;
	string NEXT_CHARGE;
	string PUSH_VEL;

	BoarBaseRemake()
	{
		ANIM_IDLE = "idle1";
		ANIM_IDLE2 = "idle2";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "gore_forward";
		const string ANIM_ATTACK1_NORM = "gore_forward";
		const string ANIM_ATTACK1_LARGE = "gore_forward2";
		const string ANIM_ATTACK_GORE_RIGHT = "gore_right";
		const string ANIM_ATTACK_GORE_LEFT = "gore_left";
		const string ANIM_STOMP = "stompsnort";
		const string ANIM_CHARGE = "charge";
		ANIM_DEATH = "die1";
		const string ANIM_BACKUP = "back_off";
		const float ATTACK_HITCHANCE = 0.5;
		const int BOAR_WIDTH1 = 50;
		const int BOAR_HEIGHT1 = 50;
		const int BOAR_WIDTH2 = 75;
		const int BOAR_HEIGHT2 = 75;
		const int BOAR_WIDTH3 = 96;
		const int BOAR_HEIGHT3 = 96;
		const string BOAR_RIGHT_PUSH = /* TODO: $relvel */ $relvel(-50, 50, 10);
		const string BOAR_LEFT_PUSH = /* TODO: $relvel */ $relvel(-100, 50, 10);
		const int BOAR_SIZE = 1;
		const int BOAR_SKIN = 0;
		const string BOAR_MODEL = "monsters/boar1.mdl";
		const float FREQ_CHARGE = 20.0;
		const float FREQ_BACKUP = 10.0;
		const string CL_CHARGE_SCRIPT = "monsters/boar_base_cl_charge";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN = "monsters/boar/boarpain.wav";
		const string SOUND_IDLE1 = "monsters/boar/boaridle.wav";
		const string SOUND_IDLE2 = "monsters/boar/boarsight2.wav";
		const string SOUND_CHARGE = "monsters/boar/boarsight.wav";
		const string SOUND_DEATH = "monsters/boar/boardeath.wav";
		const string SOUND_SWIPE1 = "zombie/claw_miss1.wav";
		const string SOUND_SWIPE2 = "zombie/claw_miss2.wav";
		const string SOUND_GORE = "zombie/claw_strike3.wav";
	}

	void game_precache()
	{
		Precache("monsters/boar/hoofbeats_loop.wav");
	}

	void game_postspawn()
	{
		ATTACK_RANGE = BOAR_WIDTH;
		ATTACK_RANGE *= 1.25;
		ATTACK_HITRANGE = BOAR_WIDTH;
		ATTACK_HITRANGE *= 1.5;
		ATTACK_MOVERANGE = BOAR_WIDTH;
		ATTACK_MOVERANGE *= 1.2;
		if (BOAR_SIZE > 1)
		{
			ANIM_ATTACK = ANIM_ATTACK1_LARGE;
			ANIM_ATTACK_DEF = ANIM_ATTACK1_LARGE;
		}
		else
		{
			ANIM_ATTACK = ANIM_ATTACK1_NORM;
			ANIM_ATTACK_DEF = ANIM_ATTACK1_NORM;
		}
	}

	void OnSpawn() override
	{
		SetModel(BOAR_MODEL);
		SetProp(GetOwner(), "skin", BOAR_SKIN);
		if (BOAR_SIZE == 1)
		{
			BOAR_WIDTH = BOAR_WIDTH1;
			BOAR_HEIGHT = BOAR_HEIGHT1;
		}
		if (BOAR_SIZE == 2)
		{
			BOAR_WIDTH = BOAR_WIDTH2;
			BOAR_HEIGHT = BOAR_HEIGHT2;
		}
		if (BOAR_SIZE == 3)
		{
			BOAR_WIDTH = BOAR_WIDTH3;
			BOAR_HEIGHT = BOAR_HEIGHT3;
		}
		SetWidth(BOAR_WIDTH);
		SetHeight(BOAR_HEIGHT);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		if (StringToLower(GetMapName()) == "nightmare_thornlands")
		{
			SetMonsterClip(0);
		}
		SetRace("wildanimal");
		SetRoam(true);
		boar_spawn();
	}

	void npc_targetsighted()
	{
		if ((BOAR_CHARGING)) return;
		if (!(GetGameTime() > NEXT_CHARGE)) return;
		if (!(false)) return;
		if (GetEntityRange(m_hAttackTarget) > ATTACK_HITRANGE)
		{
			NEXT_CHARGE = GetGameTime();
			NEXT_CHARGE += FREQ_CHARGE;
			BOAR_CHARGING = 1;
			boar_charge_sequence();
		}
		else
		{
			if (GetGameTime() > NEXT_BACKUP)
			{
			}
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 6.0;
			NEXT_BACKUP = GetGameTime();
			NEXT_BACKUP += FREQ_BACKUP;
			SetRoam(false);
			PlayAnim("critical", ANIM_BACKUP);
			npcatk_suspend_movement(ANIM_BACKUP, 1.0);
			LogDebug("backingup");
		}
	}

	void npcatk_resume_movement()
	{
		SetRoam(true);
	}

	void boar_charge_sequence()
	{
		BOAR_CHARGE_TARGET = m_hAttackTarget;
		EmitSound(GetOwner(), 1, SOUND_CHARGE, 10);
		SetRoam(false);
		PlayAnim("critical", ANIM_STOMP);
		SetMoveAnim(ANIM_CHARGE);
		SetMoveSpeed(2);
		ScheduleDelayedEvent(1.0, "boar_charge_sequence2");
		ScheduleDelayedEvent(5.0, "boar_charge_stop");
	}

	void boar_charge_sequence2()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ClientEvent("new", "all", CL_CHARGE_SCRIPT, GetEntityIndex(GetOwner()), BOAR_SIZE);
		BOAR_CHARGE_FX_IDX = "game.script.last_sent_id";
		if (BOAR_SIZE == 3)
		{
			LogDebug("sound_loop_start");
			// svplaysound: svplaysound 2 10 monsters/boar/hoofbeats_loop.wav
			EmitSound(2, 10, "monsters/boar/hoofbeats_loop.wav");
		}
		boar_charge_loop();
	}

	void boar_charge_loop()
	{
		if (!(BOAR_CHARGING)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(0.1, "boar_charge_loop");
		SetMoveDest(BOAR_CHARGE_TARGET);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 200, 0));
		if (GetEntityRange(BOAR_CHARGE_TARGET) < ATTACK_RANGE)
		{
			DoDamage(BOAR_CHARGE_TARGET, ATTACK_HITRANGE, DMG_CHARGE, 1.0, "blunt");
			AddVelocity(BOAR_CHARGE_TARGET, /* TODO: $relvel */ $relvel(0, 200, 200));
			ApplyEffect(BOAR_CHARGE_TARGET, "effects/debuff_stun", 3, GetEntityIndex(GetOwner()));
			boar_charge_stop();
		}
	}

	void boar_charge_stop()
	{
		if (BOAR_SIZE == 3)
		{
			LogDebug("sound_loop_stop");
			// svplaysound: svplaysound 2 0 monsters/boar/hoofbeats_loop.wav
			EmitSound(2, 0, "monsters/boar/hoofbeats_loop.wav");
		}
		if (BOAR_CHARGE_FX_IDX > 0)
		{
			ClientEvent("update", "all", BOAR_CHARGE_FX_IDX, "remove_fx");
		}
		BOAR_CHARGE_FX_IDX = 0;
		SetMoveSpeed(1);
		SetRoam(true);
		BOAR_CHARGING = 0;
		SetMoveAnim(ANIM_RUN);
		NEXT_CHARGE = GetGameTime();
		NEXT_CHARGE += FREQ_CHARGE;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((BOAR_CHARGING))
		{
			if (BOAR_SIZE == 3)
			{
			}
			// svplaysound: svplaysound 2 0 monsters/boar/hoofbeats_loop.wav
			EmitSound(2, 0, "monsters/boar/hoofbeats_loop.wav");
		}
		BOAR_CHARGING = 0;
		if (BOAR_CHARGE_FX_IDX > 0)
		{
			ClientEvent("update", "all", BOAR_CHARGE_FX_IDX, "remove_fx");
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN, SOUND_PAIN, SOUND_PAIN
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN, SOUND_PAIN, SOUND_PAIN};
		EmitSound(GetOwner(), 4, sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

	void npc_selectattack()
	{
		string NEXT_ATTACK = RandomInt(0, 2);
		if (NEXT_ATTACK == 0)
		{
			ANIM_ATTACK = ANIM_ATTACK_DEF;
		}
		if (NEXT_ATTACK == 1)
		{
			ANIM_ATTACK = ANIM_ATTACK_GORE_RIGHT;
		}
		if (NEXT_ATTACK == 2)
		{
			ANIM_ATTACK = ANIM_ATTACK_GORE_LEFT;
		}
	}

	void gore_left()
	{
		PUSH_VEL = BOAR_LEFT_PUSH;
		DMG_ATTACK = DMG_GORE_LEFT;
		if (BOAR_SIZE == 3)
		{
			// PlayRandomSound from: SOUND_SWIPE1, SOUND_SWIPE2
			array<string> sounds = {SOUND_SWIPE1, SOUND_SWIPE2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
		}
		gore_damage();
	}

	void gore_right()
	{
		PUSH_VEL = BOAR_RIGHT_PUSH;
		DMG_ATTACK = DMG_GORE_RIGHT;
		if (BOAR_SIZE == 3)
		{
			// PlayRandomSound from: SOUND_SWIPE1, SOUND_SWIPE2
			array<string> sounds = {SOUND_SWIPE1, SOUND_SWIPE2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
		}
		gore_damage();
	}

	void gore_forward()
	{
		DMG_ATTACK = DMG_GORE_FORWARD;
		gore_damage();
		string TARG_RANGE = GetEntityRange(m_hAttackTarget);
		string MAX_PUSH_RANGE = ATTACK_HITRANGE;
		if (!(TARG_RANGE < MAX_PUSH_RANGE)) return;
		string RANGE_PERCENT = TARG_RANGE;
		RANGE_PERCENT /= MAX_PUSH_RANGE;
		string PUSH_STR = /* TODO: $ratio */ $ratio(RANGE_PERCENT, 400, 110);
		PUSH_VEL = /* TODO: $relvel */ $relvel(0, PUSH_STR, 110);
		if (BOAR_SIZE == 3)
		{
			// PlayRandomSound from: SOUND_GORE
			array<string> sounds = {SOUND_GORE};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
		}
	}

	void gore_damage()
	{
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_ATTACK, ATTACK_HITCHANCE, "slash");
		if (!(PUSH_VEL != "PUSH_VEL")) return;
		AddVelocity(m_hAttackTarget, PUSH_VEL);
	}

	void back_off()
	{
		LogDebug("animevent back_off");
		if ((I_R_FROZEN)) return;
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -400, 110));
	}

}

}
