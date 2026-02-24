#pragma context server

#include "monsters/skeleton_base.as"

namespace MS
{

class SkeletonStone2 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_RUN;
	string AS_ATTACKING;
	int ATTACK_DAMAGE_HIGH;
	int ATTACK_DAMAGE_LOW;
	float ATTACK_HITCHANCE;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	string MY_ROCK;
	int NPC_GIVE_EXP;
	int ROCK_DAMAGE;
	string ROCK_DELAY;
	float ROCK_FREQ;
	int ROCK_ON;
	string ROCK_POS;
	int ROCK_RAISE_COUNT;
	string ROCK_TARGET;
	string ROCK_X;
	string ROCK_Y;
	string ROCK_Z;
	string SET_GREEK;
	int SKEL_HP;
	float SKEL_RESPAWN_CHANCE;
	int SKEL_RESPAWN_LIVES;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_STUN;
	string SOUND_SUMMON;
	int STONE_SKELETON;
	int STUN_ATK_CHANCE;
	int STUN_ATTACK;
	string WAS_SLEEPING;

	SkeletonStone2()
	{
		ANIM_RUN = "run";
		SKEL_HP = 1000;
		ATTACK_HITCHANCE = 0.85;
		ATTACK_DAMAGE_LOW = 16;
		ATTACK_DAMAGE_HIGH = 26;
		NPC_GIVE_EXP = 150;
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 25;
		DROP_GOLD_MAX = 55;
		SKEL_RESPAWN_CHANCE = 0.0;
		SKEL_RESPAWN_LIVES = 0;
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STRUCK3 = "debris/concrete1.wav";
		SOUND_STUN = "zombie/claw_strike2.wav";
		SOUND_SUMMON = "monsters/skeleton/calrain3.wav";
		ROCK_DAMAGE = RandomInt(200, 400);
		STUN_ATK_CHANCE = 10;
		STONE_SKELETON = 1;
		ROCK_FREQ = 15.0;
		Precache("monsters/skeleton_boss1.mdl");
	}

	void skeleton_spawn()
	{
		SetModel("monsters/skeleton_boss1.mdl");
		SetModelBody(0, 7);
		SetModelBody(1, 3);
		SetWidth(32);
		SetHeight(80);
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
		if (StringToLower(GetMapName()) == "thanatos")
		{
			SET_GREEK = 1;
		}
		if ((SET_GREEK))
		{
			SetModelBody(0, 10);
		}
	}

	void animate_stone()
	{
		SetName("Lesser Stone Mason");
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
		if (!(RandomInt(1, 100) < STUN_ATK_CHANCE)) return;
		ANIM_ATTACK = "attack2";
	}

	void npc_targetsighted()
	{
		if ((IS_FLEEING)) return;
		if ((ROCK_ON))
		{
			if (!(ROCK_DELAY))
			{
			}
			ROCK_DELAY = 1;
			ROCK_FREQ("rock_delay_reset");
			PlayAnim("once", "break");
			ScheduleDelayedEvent(0.1, "summon_rock");
		}
	}

	void rock_delay_reset()
	{
		ROCK_DELAY = 0;
	}

	void attack_2()
	{
		STUN_ATTACK = 1;
		attack_snd();
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, Random(ATTACK_DAMAGE_LOW, ATTACK_DAMAGE_HIGH), ATTACK_HITCHANCE, "slash");
		ANIM_ATTACK = "attack1";
	}

	void game_dodamage()
	{
		if (!(param1)) return;
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
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 20.0;
		EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
		ROCK_TARGET = HUNT_LASTTARGET;
		npcatk_suspend_ai();
		PlayAnim("critical", "castspell");
		SpawnNPC("monsters/summon/rock", /* TODO: $relpos */ $relpos(0, 30, -64), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		MY_ROCK = m_hLastCreated;
		ROCK_POS = GetEntityOrigin(MY_ROCK);
		ROCK_X = (ROCK_POS).x;
		ROCK_Y = (ROCK_POS).y;
		ROCK_Z = (ROCK_POS).z;
		ROCK_RAISE_COUNT = 0;
		SetMoveDest(ROCK_TARGET);
		ScheduleDelayedEvent(0.1, "raise_rock");
	}

	void raise_rock()
	{
		ROCK_RAISE_COUNT += 1;
		ROCK_Z += 4;
		SetEntityOrigin(MY_ROCK, Vector3(ROCK_X, ROCK_Y, ROCK_Z));
		if (ROCK_RAISE_COUNT >= 15)
		{
			throw_rock();
		}
		if (!(ROCK_RAISE_COUNT < 15)) return;
		ScheduleDelayedEvent(0.1, "raise_rock");
	}

	void throw_rock()
	{
		DeleteEntity(MY_ROCK);
		TossProjectile("proj_troll_rock", /* TODO: $relpos */ $relpos(0, 30, 8), "none", 800, ROCK_DAMAGE, 0.75, "none");
		CallExternal("ent_lastprojectile", "ext_lighten", 0);
		ScheduleDelayedEvent(0.1, "npcatk_resume_ai");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (((MY_ROCK !is null)))
		{
			CallExternal(MY_ROCK, "toss_rock", GetEntityIndex(m_hLastStruck), ROCK_DAMAGE);
		}
	}

}

}
