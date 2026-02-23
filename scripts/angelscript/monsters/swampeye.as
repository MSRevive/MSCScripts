#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Swampeye : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BEAM_ATTACK;
	int EYE_SKIN;
	string GO_TO_REST;
	int HIDE_MODE;
	string MELEE_TARGET;
	string MIN_FLINCH_DAMAGE;
	string NEXT_FLINCH;
	string NEXT_MELEE;
	string NEXT_SEARCH_SOUND;
	int NO_STUCK_CHECKS;
	string NPCATK_TARGET;
	int NPC_GIVE_EXP;

	Swampeye()
	{
		ANIM_IDLE = "hide_idle";
		ANIM_WALK = "idle";
		ANIM_RUN = "idle";
		ANIM_FLINCH = "flinch1";
		ANIM_ATTACK = "eyeblast";
		ANIM_DEATH = "death2";
		const string ANIM_IDLE_NORM = "idle";
		const string ANIM_HIDE = "hide_idle";
		const string ANIM_LOOK = "idle2";
		const string ANIM_FLINCH1 = "flinch1";
		const string ANIM_FLINCH2 = "flinch2";
		const string ANIM_ALERT = "scream";
		const string ANIM_BEAM = "eyeblast";
		const string ANIM_MELEE = "attack";
		const string ANIM_RISE = "rise";
		const string ANIM_LOWER = "lower";
		NO_STUCK_CHECKS = 1;
		NPC_GIVE_EXP = 400;
		ATTACK_RANGE = 1024;
		ATTACK_HITRANGE = 1024;
		const int BEAM_RANGE = 1024;
		const int DMG_BEAM = 300;
		const int DOT_BEAM = 50;
		const int MELEE_RANGE = 64;
		const int MELEE_HITRANGE = 96;
		const int DMG_MELEE = 100;
		const float FREQ_MELEE = 4.0;
		const string SOUND_BEAM_FIRE1 = "debris/beamstart14.wav";
		const string SOUND_BEAM_FIRE2 = "debris/beamstart15.wav";
		const string SOUND_BEAM_FIRE3 = "debris/beamstart9.wav";
		const string SOUND_BEAM_CHARGE = "debris/beamstart2.wav";
		const string SOUND_ALERT_IDLE1 = "controller/con_alert1.wav";
		const string SOUND_ALERT_IDLE2 = "controller/con_alert2.wav";
		const string SOUND_ALERT_IDLE3 = "controller/con_alert3.wav";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_PAIN1 = "aslave/slv_pain1.wav";
		const string SOUND_PAIN2 = "aslave/slv_pain2.wav";
		const string SOUND_DEATH = "aslave/slv_die2.wav";
		Precache(SOUND_DEATH);
		const string SOUND_CLAW = "zombie/claw_miss2.wav";
		const int NPC_NO_MOVE = 1;
	}

	void OnSpawn() override
	{
		SetName("Swamp Eye");
		SetModel("monsters/swamp_eye.mdl");
		SetWidth(48);
		SetHeight(92);
		SetRace("demon");
		SetBloodType("green");
		SetHealth(1000);
		SetDamageResistance("lightning", 0.25);
		SetHearingSensitivity(11);
		SetMoveAnim(ANIM_HIDE);
		SetIdleAnim(ANIM_HIDE);
		PlayAnim("hold", ANIM_HIDE);
		HIDE_MODE = 1;
		SetNoPush(true);
		SetGravity(0);
		ScheduleDelayedEvent(2.0, "final_props");
	}

	void final_props()
	{
		MIN_FLINCH_DAMAGE = GetEntityMaxHealth(GetOwner());
		MIN_FLINCH_DAMAGE *= 0.05;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (!(HIDE_MODE)) return;
		rise_and_shine();
	}

	void npc_targetsighted()
	{
		GO_TO_REST = GetGameTime();
		GO_TO_REST += 10.0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((HIDE_MODE)) return;
		if (GetGameTime() > GO_TO_REST)
		{
			go_to_sleep();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(m_hAttackTarget != "unset")) return;
		SetMoveDest(m_hAttackTarget);
		if (GetEntityRange(m_hAttackTarget) < MELEE_RANGE)
		{
			if (GetGameTime() > NEXT_MELEE)
			{
			}
			NEXT_MELEE = GetGameTime();
			NEXT_MELEE += 4.0;
			MELEE_TARGET = m_hAttackTarget;
			npcatk_suspend_ai(1.0);
			PlayAnim("critical", ANIM_MELEE);
		}
		if (!(false))
		{
			if (GetGameTime() > NEXT_SEARCH_SOUND)
			{
			}
			NEXT_SEARCH_SOUND = GetGameTime();
			NEXT_SEARCH_SOUND += Random(3.0, 10.0);
			// PlayRandomSound from: SOUND_ALERT_IDLE1, SOUND_ALERT_IDLE2, SOUND_ALERT_IDLE3
			array<string> sounds = {SOUND_ALERT_IDLE1, SOUND_ALERT_IDLE2, SOUND_ALERT_IDLE3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			PlayAnim("once", ANIM_LOOK);
			if (RandomInt(1, 2) == 1)
			{
				do_blink();
			}
		}
	}

	void rise_and_shine()
	{
		HIDE_MODE = 0;
		ANIM_IDLE = ANIM_IDLE_NORM;
		SetMoveAnim(ANIM_IDLE);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("critical", ANIM_RISE);
		GO_TO_REST = GetGameTime();
		GO_TO_REST += 20.0;
		do_blink();
	}

	void go_to_sleep()
	{
		NPCATK_TARGET = "unset";
		ANIM_IDLE = ANIM_HIDE;
		SetMoveAnim(ANIM_IDLE);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_LOWER);
		HIDE_MODE = 1;
	}

	void OnDamage(int damage) override
	{
		GO_TO_REST = GetGameTime();
		GO_TO_REST += 10.0;
		if (!(HIDE_MODE)) return;
		rise_and_shine();
	}

	void frame_beam_charge()
	{
		EmitSound(GetOwner(), 0, SOUND_BEAM_CHARGE, 10);
	}

	void frame_beam_fire()
	{
		// PlayRandomSound from: SOUND_BEAM_FIRE1, SOUND_BEAM_FIRE2, SOUND_BEAM_FIRE3
		array<string> sounds = {SOUND_BEAM_FIRE1, SOUND_BEAM_FIRE2, SOUND_BEAM_FIRE3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		string BEAM_START = GetEntityProperty(GetOwner(), "attachpos");
		string BEAM_END = GetEntityOrigin(m_hAttackTarget);
		if (!(IsValidPlayer(m_hAttackTarget)))
		{
			string HALF_TARG_HEIGHT = GetEntityHeight(m_hAttackTarget);
			HALF_TARG_HEIGHT *= 0.5;
			BEAM_END += "z";
		}
		string TRACE_LINE = TraceLine(BEAM_START, BEAM_END);
		Effect("beam", "end", "lgtning.spr", 30, TRACE_LINE, GetOwner(), 1, Vector3(255, 255, 0), 150, 30.0, 1.0);
		BEAM_ATTACK = 1;
		if (IsInWater(m_hAttackTarget) == 0)
		{
			XDoDamage(BEAM_START, BEAM_END, DMG_BEAM, 1.0, GetOwner(), GetOwner(), "none", "lightning");
		}
		else
		{
			DoDamage(m_hAttackTarget, "direct", DMG_BEAM, 1.0, GetOwner());
		}
	}

	void game_dodamage()
	{
		if ((BEAM_ATTACK))
		{
			ApplyEffect(param2, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_BEAM);
		}
		BEAM_ATTACK = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
		if (!(GetGameTime() > NEXT_FLINCH)) return;
		if (!(param1 > MIN_FLINCH_DAMAGE)) return;
		if (!(RandomInt(1, GetMonsterMaxHP()) > GetEntityHealth(GetOwner()))) return;
		NEXT_FLINCH = GetGameTime();
		NEXT_FLINCH += 20.0;
		npcatk_suspend_ai(1.0);
		if (RandomInt(1, 2) == 1)
		{
			PlayAnim("critical", ANIM_FLINCH1);
			do_blink();
		}
		else
		{
			PlayAnim("critical", ANIM_FLINCH2);
			do_blink();
		}
	}

	void frame_claw()
	{
		EmitSound(GetOwner(), 0, SOUND_CLAW, 10);
		DoDamage(MELEE_TARGET, MELEE_HITRANGE, DMG_MELEE, 0.9, "slash");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetProp(GetOwner(), "skin", 3);
	}

	void do_blink()
	{
		EYE_SKIN = 0;
		do_blink2();
	}

	void do_blink2()
	{
		EYE_SKIN += 1;
		if (EYE_SKIN < 5)
		{
			SetProp(GetOwner(), "skin", EYE_SKIN);
			ScheduleDelayedEvent(0.1, "do_blink2");
		}
		else
		{
			SetProp(GetOwner(), "skin", 0);
		}
	}

}

}
