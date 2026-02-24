#pragma context server

#include "monsters/base_npc_new.as"

namespace MS
{

class Phlame : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_BEAM;
	string ANIM_BOULDERS;
	string ANIM_DODGE;
	string ANIM_FIRE_BREATH;
	string ANIM_GUIDED_BURST;
	string ANIM_IDLE;
	string ANIM_IDLE_DEF;
	string ANIM_LOOK;
	string ANIM_METEOR;
	string ANIM_REPULSE;
	string ANIM_RUN;
	string ANIM_RUN_DEF;
	string ANIM_SUMMON;
	string ANIM_WALK;
	string ANIM_WALK_DEF;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	float FREQ_GLOAT;
	float FREQ_PAIN;
	int IS_UNHOLY;
	string IS_WEAK;
	string NEXT_GLOBAL_GLOAT;
	string NEXT_LEAP_AWAY;
	string NEXT_PAIN;
	int NO_STUCK_CHECKS;
	float NPC_BOSS_REGEN_RATE;
	int NPC_GIVE_EXP;
	int NPC_IS_BOSS;
	string SOUND_DEATH;
	string SOUND_GLOAT1;
	string SOUND_GLOAT2;
	string SOUND_GLOAT3;
	string SOUND_GLOAT4;
	string SOUND_PAIN1;
	string SOUND_PAIN_HEALTHY;
	string SOUND_PAIN_WEAK;
	string SOUND_STRONG_SWING1;
	string SOUND_STRONG_SWING2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_SUMMON;
	string SOUND_SWING1;
	string SOUND_SWING2;
	string STAFF_STRIKE;

	Phlame()
	{
		ANIM_IDLE = "idle";
		ANIM_WALK = "walk2handed";
		ANIM_RUN = "run2";
		ANIM_ATTACK = "staff_strike";
		ANIM_RUN_DEF = "run2";
		ANIM_WALK_DEF = "walk2handed";
		ANIM_IDLE_DEF = "idle";
		ANIM_LOOK = "idle_look";
		ANIM_SUMMON = "summon";
		ANIM_METEOR = "cieling_strike";
		ANIM_BOULDERS = "cieling_strike";
		ANIM_REPULSE = "fdeploy_strike";
		ANIM_DODGE = "staff_aim";
		ANIM_BEAM = "staff_aim";
		ANIM_FIRE_BREATH = "aim_1";
		ANIM_GUIDED_BURST = "shoot_1";
		NPC_IS_BOSS = 1;
		NPC_BOSS_REGEN_RATE = 0.05;
		NPC_GIVE_EXP = 15000;
		ATTACK_MOVERANGE = 768;
		ATTACK_RANGE = 200;
		ATTACK_HITRANGE = 250;
		FREQ_GLOAT = Random(30.0, 60.0);
		FREQ_PAIN = Random(30.0, 40.0);
		SOUND_GLOAT1 = "voices/phlame/vs_nx0headm_haha.wav";
		SOUND_GLOAT2 = "voices/phlame/vs_nx0headm_attk.wav";
		SOUND_GLOAT3 = "voices/phlame/vs_nx0headm_bat1.wav";
		SOUND_GLOAT4 = "voices/phlame/vs_nx0headm_bat3.wav";
		SOUND_SUMMON = "voices/phlame/vs_nx0headm_bat2.wav";
		SOUND_PAIN1 = "voices/phlame/vs_nx0headm_atk1.wav";
		SOUND_PAIN_HEALTHY = "voices/phlame/vs_nx0headm_yes.wav";
		SOUND_PAIN_WEAK = "voices/phlame/vs_nx0headm_no.wav";
		SOUND_STRUCK1 = "debris/flesh1.wav";
		SOUND_STRUCK2 = "debris/flesh2.wav";
		SOUND_SWING1 = "zombie/claw_miss1.wav";
		SOUND_SWING2 = "zombie/claw_miss2.wav";
		SOUND_STRONG_SWING1 = "zombie/claw_strike1.wav";
		SOUND_STRONG_SWING2 = "zombie/claw_strike2.wav";
		SOUND_DEATH = "none";
	}

	void game_precache()
	{
		Precache("c-tele1.spr");
	}

	void OnSpawn() override
	{
		SetName("Phlame the Ever Burning");
		SetRace("demon");
		SetHealth(15000);
		SetName("phlame_wiz");
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("poison", 0.25);
		SetDamageResistance("acid", 0.5);
		SetDamageResistance("holy", 1.25);
		IS_UNHOLY = 1;
		SetMoveAnim(ANIM_LOOK);
		SetIdleAnim(ANIM_LOOK);
		SetInvincible(true);
		SetSayTextRange(1024);
		npcatk_suspend_ai();
		NO_STUCK_CHECKS = 1;
		ScheduleDelayedEvent(2.0, "speak_begin");
		ScheduleDelayedEvent(5.0, "let_us_begin");
	}

	void speak_begin()
	{
		SayText("Then... Let us... Begin...");
	}

	void let_us_begin()
	{
		SetInvincible(false);
		ANIM_RUN = ANIM_WALK_DEF;
		ANIM_IDLE = ANIM_IDLE_DEF;
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		npcatk_resume_ai();
		NO_STUCK_CHECKS = 0;
		start_cycles();
	}

	void bs_global_command()
	{
		if (!(param3 == "death")) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(GetGameTime() > NEXT_GLOBAL_GLOAT)) return;
		NEXT_GLOBAL_GLOAT = GetGameTime();
		NEXT_GLOBAL_GLOAT += 15.0;
		int RND_GLOAT = RandomInt(1, 4);
		if (RND_GLOAT == 1)
		{
			UseTrigger("snd_gloat1");
		}
		if (RND_GLOAT == 2)
		{
			UseTrigger("snd_gloat2");
		}
		if (RND_GLOAT == 3)
		{
			UseTrigger("snd_gloat3");
		}
		if (RND_GLOAT == 4)
		{
			UseTrigger("snd_gloat4");
		}
	}

	void do_gloat()
	{
		// PlayRandomSound from: SOUND_GLOAT1, SOUND_GLOAT2, SOUND_GLOAT3, SOUND_GLOAT4
		array<string> sounds = {SOUND_GLOAT1, SOUND_GLOAT2, SOUND_GLOAT3, SOUND_GLOAT4};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (GetEntityHealth(GetOwner()) < HALF_HEALTH)
		{
			IS_WEAK = 1;
		}
		else
		{
			IS_WEAK = 0;
		}
		if (GetGameTime() > NEXT_PAIN)
		{
			NEXT_PAIN = GetGameTime();
			if (!(IS_WEAK))
			{
				// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN_HEALTHY
				array<string> sounds = {SOUND_PAIN1, SOUND_PAIN_HEALTHY};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			else
			{
				// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN_WEAK
				array<string> sounds = {SOUND_PAIN1, SOUND_PAIN_WEAK};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
		}
		else
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 8);
		}
		if ((IS_WEAK))
		{
			ANIM_RUN = ANIM_RUN_DEF;
			SetMoveAnim(ANIM_RUN);
		}
		else
		{
			ANIM_RUN = ANIM_WALK_DEF;
			SetMoveAnim(ANIM_RUN);
		}
		if (!(IS_WEAK)) return;
		if ((BUSY_CASTING)) return;
		if (GetEntityRange(m_hLastStruck) < 200)
		{
			if (GetGameTime() > NEXT_LEAP_AWAY)
			{
			}
			NEXT_LEAP_AWAY = GetGameTime();
			NEXT_LEAP_AWAY += FREQ_LEAP_AWAY;
			do_leap_away();
		}
	}

	void game_dodamage()
	{
		if ((STAFF_STRIKE))
		{
			ApplyEffect(m_hAttackTarget, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_FIRE);
			STAFF_STRIKE = 0;
		}
	}

	void frame_staff_strike()
	{
		int RND_STRENGTH = RandomInt(1, 2);
		if (RND_STRENGTH == 1)
		{
			// PlayRandomSound from: SOUND_SWING1, SOUND_SWING2
			array<string> sounds = {SOUND_SWING1, SOUND_SWING2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_STRONG_SWING1, SOUND_STRONG_SWING2
			array<string> sounds = {SOUND_STRONG_SWING1, SOUND_STRONG_SWING2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		string L_DMG = DMG_STAFF;
		if (RND_STRENGTH == 2)
		{
			L_DMG *= 4;
		}
		STAFF_STRIKE = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, L_DMG, 0.9, "blunt");
	}

}

}
