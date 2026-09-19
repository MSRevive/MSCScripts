#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class SkeletonGstone1 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_RUN;
	string AS_ATTACKING;
	int ATTACK_DAMAGE_HIGH;
	int ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	float BASE_MOVESPEED;
	int CAN_FLINCH;
	int CUSTOM_SIZE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int G_SUMMING_ROCKS;
	string MY_ROCK_STORM;
	int NPC_GIVE_EXP;
	string PUSH_VEL;
	int ROCK_DAMAGE;
	int ROCK_DELAY;
	float ROCK_FREQ;
	int ROCK_ON;
	int SKEL_ATTACK_HITRANGE;
	int SKEL_ATTACK_RANGE;
	int SKEL_HEIGHT;
	int SKEL_HP;
	string SKEL_MODEL;
	int SKEL_MOVE_RANGE;
	float SKEL_RESPAWN_CHANCE;
	int SKEL_RESPAWN_LIVES;
	int SKEL_WIDTH;
	string SOUND_RUN1;
	string SOUND_RUN2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_STUN;
	string SOUND_SUMMON;
	string SOUND_WALK1;
	string SOUND_WALK2;
	int STONE_SKELETON;
	int STUN_ATK_CHANCE;
	int STUN_ATTACK;
	float WALK_MOVESPEED;
	string WAS_SLEEPING;
	string XSOUND_LEVITATE;
	string XSOUND_SPIN;
	string XSOUND_SUMMON;

	SkeletonGstone1()
	{
		SKEL_MODEL = "monsters/skeleton_boss2.mdl";
		SKEL_WIDTH = 40;
		SKEL_HEIGHT = 130;
		SKEL_MOVE_RANGE = 64;
		SKEL_ATTACK_RANGE = 150;
		SKEL_ATTACK_HITRANGE = 220;
		ANIM_RUN = "run";
		SKEL_HP = 4000;
		ATTACK_HITCHANCE = 0.85;
		ATTACK_DAMAGE_LOW = 26;
		ATTACK_DAMAGE_HIGH = 60;
		NPC_GIVE_EXP = 1000;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 100;
		DROP_GOLD_MAX = 200;
		SKEL_RESPAWN_CHANCE = 0.0;
		SKEL_RESPAWN_LIVES = 0;
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STRUCK3 = "debris/concrete1.wav";
		SOUND_RUN1 = "monsters/troll/step1.wav";
		SOUND_RUN2 = "monsters/troll/step2.wav";
		SOUND_WALK1 = "common/npc_step1.wav";
		SOUND_WALK2 = "common/npc_step2.wav";
		BASE_MOVESPEED = 2.0;
		WALK_MOVESPEED = 1.0;
		CAN_FLINCH = 0;
		SOUND_STUN = "zombie/claw_strike2.wav";
		SOUND_SUMMON = "monsters/skeleton/calrain3.wav";
		ROCK_DAMAGE = "$rand(400,800)";
		STUN_ATK_CHANCE = 10;
		STONE_SKELETON = 1;
		ROCK_FREQ = 30.0;
		CUSTOM_SIZE = 1;
		XSOUND_LEVITATE = "fans/fan4on.wav";
		XSOUND_SPIN = "magic/fan4_noloop.wav";
		XSOUND_SUMMON = "magic/volcano_start.wav";
		Precache(XSOUND_LEVITATE);
		Precache(XSOUND_SPIN);
		Precache(XSOUND_SUMMON);
		Precache("monsters/skeleton_boss2.mdl");
	}

	void skeleton_spawn()
	{
		SetModelBody(0, 7);
		SetModelBody(1, 3);
		if (!(SLEEPER))
		{
			animate_stone();
		}
		if ((SLEEPER))
		{
			SetInvincible(true);
			WAS_SLEEPING = 1;
			npcatk_suspend_ai();
			SetIdleAnim(ANIM_IDLE);
			SetMoveAnim(ANIM_IDLE);
			SetAnimFrameRate(0.0);
		}
	}

	void animate_stone()
	{
		SetName("Greater Stone Mason");
		SetRoam(true);
		SetBloodType("none");
		SetDamageResistance("all", ".6");
		SetHearingSensitivity(3);
		if ((WAS_SLEEPING))
		{
			SetMoveAnim(ANIM_WALK);
			SetAnimFrameRate(1.0);
			npcatk_resume_ai();
		}
	}

	void attack_1()
	{
		STUN_ATTACK = 0;
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 100, 10);
		if (!(RandomInt(1, 100) < STUN_ATK_CHANCE)) return;
		ANIM_ATTACK = "attack2";
	}

	void npc_targetsighted()
	{
		if ((IS_FLEEING)) return;
		if (!(ROCK_ON)) return;
		if ((ROCK_DELAY)) return;
		ScheduleDelayedEvent(0.1, "summon_rock");
	}

	void rock_delay_reset()
	{
		ROCK_DELAY = 0;
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
		if (!(param1)) return;
		AddVelocity(m_hLastStruckByMe, PUSH_VEL);
		if (!(STUN_ATTACK)) return;
		EmitSound(GetOwner(), 0, SOUND_STUN, 10);
		ApplyEffect(param2, "effects/debuff_stun", Random(5, 10), GetEntityIndex(GetOwner()));
		STUN_ATTACK = 0;
	}

	void cycle_up()
	{
		ROCK_ON = 1;
	}

	void summon_rock()
	{
		if ((G_SUMMING_ROCKS))
		{
			if (!(ROCK_DELAY))
			{
			}
			Random(10, 20)("summon_rock");
			ROCK_DELAY = 1;
		}
		if ((G_SUMMING_ROCKS)) return;
		SetGlobalVar("G_SUMMING_ROCKS", 1);
		ScheduleDelayedEvent(5.0, "reset_summoning");
		ROCK_DELAY = 1;
		ROCK_FREQ("rock_delay_reset");
		EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
		PlayAnim("once", "break");
		AS_ATTACKING = GetGameTime();
		npcatk_suspend_ai();
		PlayAnim("critical", "castspell");
		int NUM_ROCKS = 4;
		if (GetPlayerCount() >= 1)
		{
			string NUM_ROCKS = GetPlayerCount();
			if (NUM_ROCKS > 4)
			{
				int NUM_RUCKS = 4;
			}
		}
		int NUM_ROCKS = 4;
		if (((MY_ROCK_STORM !is null))) return;
		SpawnNPC("monsters/summon/rock_storm", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), NUM_ROCKS, ROCK_DAMAGE, 64, 200
		MY_ROCK_STORM = GetEntityIndex(m_hLastCreated);
	}

	void reset_summoning()
	{
		G_SUMMING_ROCKS = 0;
		if (!(SUSPEND_AI)) return;
		npcatk_resume_ai();
	}

	void castspell()
	{
		SetGlobalVar("G_SUMMING_ROCKS", 0);
		if (!(SUSPEND_AI)) return;
		npcatk_resume_ai();
	}

	void walk_step1()
	{
		EmitSound(GetOwner(), 0, SOUND_WALK1, 8);
	}

	void walk_step2()
	{
		EmitSound(GetOwner(), 0, SOUND_WALK2, 8);
	}

	void run_step1()
	{
		SetMoveSpeed(BASE_MOVESPEED);
		EmitSound(GetOwner(), 0, SOUND_RUN1, 8);
	}

	void run_step2()
	{
		SetMoveSpeed(BASE_MOVESPEED);
		EmitSound(GetOwner(), 0, SOUND_RUN2, 8);
	}

}

}
