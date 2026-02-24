#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Scorpion6 : CGameScript
{
	int AM_SUMMONED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_POISON;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_DAMAGE;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int ATTACK_STINGRANGE;
	float BASE_MOVESPEED;
	string BURST_SCRIPT;
	string BURST_TARGS;
	int DMG_BURST;
	float DOT_DMG;
	float DOT_DURATION;
	string DOT_EFFECT;
	string DOT_EFFECT_BURST_TYPE;
	string DOT_EFFECT_STING;
	float FREQ_JUMP;
	string MY_OWNER;
	int NPC_GIVE_EXP;
	int NPC_MUST_SEE_TARGET;
	string SOUND_BIGSWING;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_SWING;

	Scorpion6()
	{
		FREQ_JUMP = 30.0;
		ANIM_IDLE = "idle_a";
		SOUND_STRUCK1 = "body/flesh1.wav";
		SOUND_STRUCK2 = "body/flesh2.wav";
		SOUND_STRUCK3 = "body/flesh3.wav";
		SOUND_PAIN = "monsters/spider/spiderhiss.wav";
		SOUND_IDLE1 = "monsters/spider/spideridle.wav";
		SOUND_DEATH = "monsters/spider/spiderdie.wav";
		ANIM_IDLE = "idle_b";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "attackb";
		ANIM_DEATH = "die";
		ANIM_POISON = "attacka";
		ATTACK_RANGE = 165;
		ATTACK_HITRANGE = 180;
		ATTACK_STINGRANGE = 120;
		ATTACK_HITCHANCE = 0.7;
		ATTACK_DAMAGE = 200;
		DOT_EFFECT = "effects/dot_poison";
		DOT_EFFECT_STING = "effects/dot_poison";
		DOT_EFFECT_BURST_TYPE = "stun";
		DOT_DURATION = 10.0;
		DOT_DMG = 50.0;
		BURST_SCRIPT = "effects/sfx_stun_burst";
		DMG_BURST = 200;
		SOUND_SWING = "zombie/claw_miss1.wav";
		SOUND_BIGSWING = "zombie/claw_miss2.wav";
		Precache(SOUND_DEATH);
		Precache(SOUND_IDLE1);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10);
		SetVolume(10);
		// PlayRandomSound from: SOUND_IDLE1
		array<string> sounds = {SOUND_IDLE1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_precache()
	{
		Precache("monsters/summon/stun_burst");
	}

	void OnSpawn() override
	{
		scorpion_spawn();
	}

	void scorpion_spawn()
	{
		SetHealth(5000);
		SetWidth(196);
		SetHeight(196);
		SetRace("spider");
		SetName("Dread Scorpion");
		SetRoam(true);
		SetHearingSensitivity(3);
		NPC_GIVE_EXP = 800;
		FREQ_JUMP("do_jump");
		SetModel("monsters/scorp6.mdl");
		SetModelBody(1, 0);
		SetIdleAnim("idle_a");
		SetMoveAnim("walk");
		SetProp(GetOwner(), "skin", 1);
		SetAnimMoveSpeed(0.5);
		BASE_MOVESPEED = 0.5;
		// PlayRandomSound from: SOUND_IDLE1
		array<string> sounds = {SOUND_IDLE1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// PlayRandomSound from: SOUND_IDLE1
		array<string> sounds = {SOUND_IDLE1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 0);
		if (!(AM_SUMMONED)) return;
		CallExternal(MY_OWNER, "scorpion_died");
	}

	void OnPostSpawn() override
	{
		NPC_MUST_SEE_TARGET = 0;
	}

	void strike()
	{
		if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
		{
			DoDamage(m_hAttackTarget, "direct", ATTACK_DAMAGE, ATTACK_HITCHANCE, GetOwner());
		}
		if (RandomInt(1, 10) == 1)
		{
			EmitSound(GetOwner(), 0, SOUND_BIGSWING, 10);
			PlayAnim("critical", ANIM_POISON);
			if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
			{
			}
			ApplyEffect(m_hAttackTarget, DOT_EFFECT, DOT_DURATION, GetEntityIndex(GetOwner()), DOT_DMG);
		}
		else
		{
			EmitSound(GetOwner(), 0, SOUND_SWING, 10);
			if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
			{
			}
			float RND_LR = Random(-100, 100);
			float RND_FB = Random(-350, 100);
			AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(RND_LR, RND_FB, 10));
		}
	}

	void poison_strike()
	{
		LogDebug("poison_strike GetEntityName(m_hLastSeen) GetEntityName(HUNT_LASTTARGET)");
		if (GetEntityRange(m_hAttackTarget) < ATTACK_STINGRANGE)
		{
			DoDamage(m_hAttackTarget, "direct", ATTACK_DAMAGE, 0.9, GetOwner());
		}
		EmitSound(GetOwner(), 0, SOUND_BIGSWING, 10);
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_STINGRANGE)) return;
		ApplyEffect(m_hAttackTarget, DOT_EFFECT_STING, DOT_DURATION, GetEntityIndex(GetOwner()), DOT_DMG);
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_STINGRANGE)) return;
		float RND_LR = Random(-100, 100);
		float RND_FB = Random(-300, 400);
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(RND_LR, RND_FB, 10));
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1
		array<string> sounds = {SOUND_PAIN, SOUND_STRUCK2, SOUND_STRUCK1};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void do_jump()
	{
		LogDebug("do_jump GetEntityName(m_hAttackTarget)");
		FREQ_JUMP("do_jump");
		if (!(m_hAttackTarget != "unset")) return;
		string N_BADS = /* TODO: $get_tbox */ $get_tbox("enemy", 640);
		if (N_BADS == "none")
		{
			int DO_JUMP = RandomInt(0, 1);
		}
		else
		{
			if (GetTokenCount(N_BADS, ";") > 1)
			{
				int DO_JUMP = 1;
			}
			else
			{
				int DO_JUMP = RandomInt(0, 1);
			}
		}
		if (!(DO_JUMP)) return;
		LogDebug("do_jumpb N_BADS");
		PlayAnim("critical", "jump");
		ScheduleDelayedEvent(1.0, "do_jump2");
	}

	void do_jump2()
	{
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 640, DMG_BURST, 1.0, 0);
		string BURST_ORG = GetEntityOrigin(GetOwner());
		ClientEvent("new", "all", BURST_SCRIPT, BURST_ORG, 640, 0);
		BURST_TARGS = FindEntitiesInSphere("enemy", 640);
		LogDebug("do_jump2 BURST_TARGS");
		if (!(BURST_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(BURST_TARGS, ";"); i++)
		{
			burst_affect_targets();
		}
	}

	void burst_affect_targets()
	{
		string CUR_TARG = GetToken(BURST_TARGS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		LogDebug("burst_affect_targets GetEntityName(CUR_TARG)");
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
		if (DOT_EFFECT_BURST_TYPE == "stun")
		{
			ApplyEffect(CUR_TARG, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		}
		if (DOT_EFFECT_BURST_TYPE == "effect")
		{
			ApplyEffect(CUR_TARG, DOT_EFFECT, DOT_DURATION, GetEntityIndex(GetOwner()), DOT_DMG);
		}
	}

	void game_dynamically_created()
	{
		if (!(IsEntityAlive(MY_OWNER))) return;
		MY_OWNER = GetEntityIndex(param1);
		SetRace(GetEntityRace(MY_OWNER));
		AM_SUMMONED = 1;
		ScheduleDelayedEvent(0.1, "summoned_sound");
	}

	void summoned_sound()
	{
		EmitSound(GetOwner(), 0, "ambience/alien_humongo.wav", 10);
	}

}

}
