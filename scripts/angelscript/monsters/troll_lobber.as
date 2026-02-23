#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class TrollLobber : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	string ATTACK_MOVERANGE;
	string ATTACK_RANGE;
	int CAN_FLINCH;
	int CAN_HUNT;
	int COMBAT_REPOS;
	int DID_WARCRY;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	string FLINCH_ANIM;
	int FLINCH_CHANCE;
	float FLINCH_DELAY;
	int HUNT_AGRO;
	int MELEE_RANGE;
	int MOVE_RANGE;
	string NPC_GIVE_EXP;
	string PUSH_VEL;

	TrollLobber()
	{
		const int TROLL_EXP = 150;
		const string TROLL_NAME = "Troll";
		const string PROJ_SCRIPT = "proj_troll_rock";
		const string TROLL_MODEL = "monsters/troll.mdl";
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod1.wav";
		const string SOUND_PAIN = "monsters/troll/trollpain.wav";
		const string SOUND_ATTACK = "monsters/troll/trollattack.wav";
		const string SOUND_DEATH = "monsters/troll/trolldeath.wav";
		const string SOUND_WALK1 = "monsters/troll/step1.wav";
		const string SOUND_WALK2 = "monsters/troll/step2.wav";
		const string SOUND_IDLE = "monsters/troll/trollidle2.wav";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 20;
		DROP_GOLD_MAX = 40;
		ANIM_IDLE = "idle0";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_DEATH = "die_fall";
		ANIM_ATTACK = "throw_rock";
		const string ANIM_PUNCH = "hit_down";
		const string ANIM_DBLPUNCH = "double_punch";
		const string ANIM_THROW = "throw_rock";
		const int ROCK_RANGE = 800;
		const int SWING_RANGE = 130;
		MELEE_RANGE = 100;
		ATTACK_RANGE = ROCK_RANGE;
		ATTACK_HITRANGE = 300;
		MOVE_RANGE = 400;
		const int MELE_RANGE = 128;
		const int MELE_HITRANGE = 164;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 33;
		FLINCH_ANIM = "flinch2";
		FLINCH_DELAY = 2.0;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		const int AIM_RATIO = 25;
		const int ATTACK_SPEED = 500;
		const string ROCK_DAMAGE = "$rand(200,300)";
		Precache(SOUND_DEATH);
		Precache("monsters/base_monster");
		Precache("monsters/base_npc_attack");
		Precache("monsters/base_npc");
		Precache("items/proj_troll_rock");
	}

	void OnSpawn() override
	{
		SetHealth(600);
		SetWidth(100);
		SetHeight(125);
		SetRace("orc");
		SetName(TROLL_NAME);
		SetRoam(true);
		NPC_GIVE_EXP = TROLL_EXP;
		SetDamageResistance("all", ".7");
		SetDamageResistance("fire", 1.2);
		SetDamageResistance("lightning", 1.1);
		SetModel(TROLL_MODEL);
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(10);
		COMBAT_REPOS = 0;
		ScheduleDelayedEvent(10.0, "random_idle");
		CatchSpeech("debug_props", "debug");
		troll_spawn();
	}

	void debug_props()
	{
		SetSayTextRange(1024);
		SayText("I is hunting IS_HUNTING my target GetEntityName(HUNT_LASTTARGET)");
	}

	void npc_targetsighted()
	{
		if (!(false)) return;
		ANIM_ATTACK = ANIM_DBLPUNCH;
		ATTACK_RANGE = SWING_RANGE;
		if (GetEntityRange(HUNT_LASTTARGET) <= ROCK_RANGE)
		{
			if (GetEntityRange(HUNT_LASTTARGET) > SWING_RANGE)
			{
			}
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 10;
			PlayAnim("once", ANIM_THROW);
			MOVE_RANGE = ROCK_RANGE;
			ATTACK_MOVERANGE = ROCK_RANGE;
		}
		if (GetEntityRange(HUNT_LASTTARGET) <= SWING_RANGE)
		{
			ANIM_ATTACK = ANIM_DBLPUNCH;
			MOVE_RANGE = MELEE_RANGE;
			ATTACK_MOVERANGE = MELEE_RANGE;
		}
	}

	void rock_pickup()
	{
		SetModelBody(1, 1);
	}

	void rock_throw()
	{
		string ME_POS = GetEntityOrigin(GetOwner());
		string MY_Z = (ME_POS).z;
		string TARGET_POS = GetEntityOrigin(HUNT_LASTTARGET);
		string TARGET_Z = (TARGET_POS).z;
		string TARGET_Z_DIFFERENCE = TARGET_Z;
		TARGET_Z_DIFFERENCE -= MY_Z;
		string FIN_ATTACK_SPEED = ATTACK_SPEED;
		string AIM_ANGLE = GetEntityRange(HUNT_LASTTARGET);
		AIM_ANGLE /= AIM_RATIO;
		if (TARGET_Z_DIFFERENCE > 200)
		{
			TARGET_Z_DIFFERENCE /= 2;
			AIM_ANGLE /= 2;
			FIN_ATTACK_SPEED += TARGET_Z_DIFFERENCE;
		}
		SetAngles("add_view.x");
		TossProjectile("proj_troll_rock", /* TODO: $relpos */ $relpos(0, 0, 21), "none", FIN_ATTACK_SPEED, ROCK_DAMAGE, 0.75, "none");
		COMBAT_REPOS += 1;
		SetModelBody(1, 0);
		if (!(COMBAT_REPOS > 4)) return;
		COMBAT_REPOS = 0;
		chicken_run(5.0, "combat_repos");
	}

	void attack_1()
	{
		SetModelBody(1, 0);
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 200, 10);
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, Random(20, 30), 0.75, "slash");
		if (RandomInt(1, 4) == 1)
		{
			ANIM_ATTACK = ANIM_PUNCH;
		}
		if (GetEntityRange(m_hLastStruck) > MELE_RANGE)
		{
			ANIM_ATTACK = ANIM_THROW;
		}
		EmitSound(GetOwner(), 2, SOUND_ATTACK, 10);
	}

	void attack_2()
	{
		SetModelBody(1, 0);
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, Random(35, 45), 0.75, "slash");
		ANIM_ATTACK = "double_punch";
		EmitSound(GetOwner(), 2, SOUND_ATTACK, 10);
		if (RandomInt(1, 4) == 1)
		{
			ANIM_ATTACK = ANIM_DBLPUNCH;
		}
		if (GetEntityRange(m_hLastStruck) > MELE_RANGE)
		{
			ANIM_ATTACK = ANIM_THROW;
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		EmitSound(GetOwner(), 2, SOUND_PAIN, 5);
		if (GetEntityRange(m_hLastStruck) < MELE_RANGE)
		{
			ANIM_ATTACK = ANIM_DBLPUNCH;
		}
	}

	void stomp_1()
	{
		EmitSound(GetOwner(), 2, SOUND_WALK1, 8);
	}

	void stomp_2()
	{
		EmitSound(GetOwner(), 2, SOUND_WALK2, 8);
	}

	void game_hearsound()
	{
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_IDLE);
	}

	void random_idle()
	{
		ScheduleDelayedEvent(10.0, "random_idle");
		if ((IS_HUNTING)) return;
		if ((false)) return;
		if ((IS_FLEEING)) return;
		string ANIM_SELECT = RandomInt(0, 3);
		if (ANIM_SELECT == 0)
		{
			ANIM_IDLE = "idle0";
		}
		if (ANIM_SELECT == 1)
		{
			ANIM_IDLE = "idle1";
		}
		if (ANIM_SELECT == 2)
		{
			ANIM_IDLE = "idle2";
		}
		if (ANIM_SELECT == 3)
		{
			ANIM_IDLE = "idle3";
		}
		if ((ADVANCED_SEARCHING))
		{
			ANIM_IDLE = "idle0";
		}
		PlayAnim("once", ANIM_IDLE);
	}

	void warcry()
	{
		EmitSound(GetOwner(), 2, SOUND_IDLE, 10);
	}

	void my_target_died()
	{
		DID_WARCRY = 0;
		if ((false)) return;
		PlayAnim("critical", "idle2");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(param1 + "is" + HUNT_LASTTARGET)) return;
		if (!(param2 > 1)) return;
		COMBAT_REPOS = 0;
	}

}

}
