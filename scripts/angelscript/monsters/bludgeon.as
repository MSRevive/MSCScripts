#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Bludgeon : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_IDLE;
	string ANIM_JUMP;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_DAMAGE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BASE_MOVESPEED;
	int CHARGE_DAMAGE;
	int CHARGE_HITRANGE;
	int CHARGE_MOVESPEED;
	string CHARGE_TARGET;
	string CL_SCRIPT;
	string CL_SCRIPT_ID;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int IN_CHARGE;
	int IN_JUMP;
	int IS_JUMPING;
	int IS_UNHOLY;
	int MOVE_RANGE;
	int NO_ADJ_RANGES;
	string NPC_GIVE_EXP;
	string PUSH_VEL;
	string SOUND_CHARGE;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Bludgeon()
	{
		IS_UNHOLY = 1;
		if (StringToLower(GetMapName()) != "islesofdread2")
		{
			NPC_GIVE_EXP = 120;
		}
		else
		{
			NPC_GIVE_EXP = 0;
		}
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 30;
		SOUND_STRUCK1 = "monsters/bludgeon/bludgeonattack.wav";
		SOUND_STRUCK2 = "monsters/bludgeon/bludgeonattack.wav";
		SOUND_STRUCK3 = "monsters/bludgeon/bludgeonattack.wav";
		SOUND_PAIN = "monsters/bludgeon/bludgeonpain.wav";
		SOUND_IDLE1 = "monsters/bludgeon/bludgeonidle.wav";
		SOUND_IDLE2 = "monsters/bludgeon/bludgeonidle.wav";
		SOUND_CHARGE = "monsters/boar/boarsight.wav";
		SOUND_DEATH = "monsters/bludgeon/bludgeonpain.wav";
		BASE_MOVESPEED = 2;
		CHARGE_MOVESPEED = 6;
		Precache(SOUND_DEATH);
		NO_ADJ_RANGES = 1;
		MOVE_RANGE = 32;
		ATTACK_RANGE = 96;
		ATTACK_HITRANGE = 120;
		ATTACK_DAMAGE = "$rand(20,40)";
		CHARGE_DAMAGE = "$rand(40,80)";
		CHARGE_HITRANGE = 32;
		ANIM_IDLE = "stand";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "punch1";
		ANIM_JUMP = "jump";
		CL_SCRIPT = "monsters/boar_base_cl_charge";
		Precache(CL_SCRIPT);
	}

	void OnSpawn() override
	{
		SetName("Bludgeon Demon");
		SetModel("monsters/bludgeon.mdl");
		SetHealth(200);
		SetWidth(32);
		SetHeight(72);
		SetRace("demon");
		SetRoam(true);
		SetHearingSensitivity(8);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 5.0);
		SetDamageResistance("lightning", 2.0);
		SetDamageResistance("holy", 30.0);
		SetMoveSpeed(BASE_MOVESPEED);
		ScheduleDelayedEvent(5.0, "idle_loop");
		CatchSpeech("debug_props", "debug");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		PlayAnim("once", ANIM_IDLE);
	}

	void debug_props()
	{
		SetSayTextRange(2048);
		SayText("Range " + ATTACK_RANGE);
	}

	void my_target_died()
	{
		IS_JUMPING = 0;
		SayText("Little-G rox0rz your box0rz!");
	}

	void npc_targetsighted()
	{
		if (!(IS_JUMPING))
		{
			IS_JUMPING = 1;
			ScheduleDelayedEvent(2.0, "jump_checks");
		}
		if (!(GetEntityRange(param1) > 256)) return;
		if ((IN_CHARGE)) return;
		if ((IN_JUMP)) return;
		CHARGE_TARGET = HUNT_LASTTARGET;
		do_charge();
	}

	void do_charge()
	{
		IN_CHARGE = 1;
		SetMoveAnim(ANIM_RUN);
		EmitSound(GetOwner(), 0, SOUND_CHARGE, 10);
		npcatk_suspend_ai();
		SetMoveDest(CHARGE_TARGET);
		ScheduleDelayedEvent(1.0, "charge_noise");
		ClientEvent("new", "all_in_sight", CL_SCRIPT, GetEntityIndex(GetOwner()));
		CL_SCRIPT_ID = "game.script.last_sent_id";
		ScheduleDelayedEvent(15.0, "charge_stop");
		charge_scan();
	}

	void charge_noise()
	{
		SetMoveSpeed(CHARGE_MOVESPEED);
		EmitSound(GetOwner(), 0, SOUND_CHARGE, 10);
	}

	void charge_scan()
	{
		if (!(IN_CHARGE)) return;
		ScheduleDelayedEvent(0.1, "charge_scan");
		SetMoveDest(CHARGE_TARGET);
		if (!(GetEntityRange(CHARGE_TARGET) <= ATTACK_RANGE)) return;
		DoDamage(CHARGE_TARGET, ATTACK_HITRANGE, CHARGE_DAMAGE, 1.0, "slash");
		ScheduleDelayedEvent(0.1, "charge_stop");
	}

	void charge_stop()
	{
		SetMoveSpeed(BASE_MOVESPEED);
		IN_CHARGE = 0;
		ClientEvent("remove", "all", CL_SCRIPT);
		npcatk_resume_ai();
		if ((IsEntityAlive(CHARGE_TARGET)))
		{
			npcatk_target(CHARGE_TARGET);
		}
	}

	void jump_checks()
	{
		if (!(IS_JUMPING)) return;
		Random(2, 6)("jump_checks");
		PlayAnim("critical", ANIM_JUMP);
	}

	void attack_1()
	{
		EmitSound(GetOwner(), 0, SOUND_STRUCK1, 10);
		DoDamage(HUNT_LASTTARGET, ATTACK_HITRANGE, CHARGE_DAMAGE, 1.0, "slash");
	}

	void jump_start()
	{
		IN_JUMP = 1;
		ScheduleDelayedEvent(0.1, "jump_boost");
		EmitSound(GetOwner(), 0, SOUND_CHARGE, 10);
	}

	void jump_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 600));
	}

	void jump_land()
	{
		EmitSound(GetOwner(), 0, SOUND_IDLE1, 10);
	}

	void jump_done()
	{
		IN_JUMP = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

	void idle_loop()
	{
		Random(5, 10)("idle_loop");
		if ((false)) return;
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		int L_R = RandomInt(50, 100);
		if (RandomInt(1, 2) == 1)
		{
			string L_R = /* TODO: $neg */ $neg(L_R);
		}
		PUSH_VEL = /* TODO: $relvel */ $relvel(L_R, 50, 10);
		if ((IN_CHARGE))
		{
			charge_hit();
		}
		else
		{
			AddVelocity(m_hLastStruckByMe, PUSH_VEL);
		}
	}

	void charge_hit()
	{
		AddVelocity(m_hLastStruckByMe, /* TODO: $relvel */ $relvel(0, 200, 200));
		ApplyEffect(m_hLastStruckByMe, "effects/debuff_stun", 3, GetEntityIndex(GetOwner()));
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", CL_SCRIPT);
		if (RandomInt(1, 50) == 1)
		{
			SayText("No , little-G , " + I + " have failed you!");
		}
	}

}

}
