#pragma context server

#include "monsters/base_monster.as"
#include "monsters/base_race_cold.as"

namespace MS
{

class TrollIceLobber : CGameScript
{
	int AIM_RATIO;
	string ANIM_ATTACK;
	string ANIM_DBLPUNCH;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_PUNCH;
	string ANIM_RUN;
	string ANIM_THROW;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	string ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int ATTACK_SPEED;
	int CAN_FLINCH;
	int CAN_HUNT;
	int COMBAT_REPOS;
	int DID_WARCRY;
	int DO_THROW;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	string FLINCH_ANIM;
	int FLINCH_CHANCE;
	float FLINCH_DELAY;
	int HUNT_AGRO;
	int MELE_HITRANGE;
	int MELE_RANGE;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	string PUSH_VEL;
	int ROCK_DAMAGE;
	int ROCK_RANGE;
	string SOUND_ATTACK;
	string SOUND_DEATH;
	string SOUND_IDLE;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_WALK1;
	string SOUND_WALK2;
	int SWING_RANGE;

	TrollIceLobber()
	{
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod1.wav";
		SOUND_PAIN = "monsters/troll/trollpain.wav";
		SOUND_ATTACK = "monsters/troll/trollattack.wav";
		SOUND_DEATH = "monsters/troll/trolldeath.wav";
		SOUND_WALK1 = "monsters/troll/step1.wav";
		SOUND_WALK2 = "monsters/troll/step2.wav";
		SOUND_IDLE = "monsters/troll/trollidle2.wav";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 20;
		DROP_GOLD_MAX = 40;
		ANIM_IDLE = "idle0";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_DEATH = "die_fall";
		ANIM_ATTACK = "double_punch";
		ANIM_PUNCH = "hit_down";
		ANIM_DBLPUNCH = "double_punch";
		ANIM_THROW = "throw_rock";
		ROCK_RANGE = 9999;
		SWING_RANGE = 130;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 300;
		MOVE_RANGE = 400;
		MELE_RANGE = 128;
		MELE_HITRANGE = 164;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 33;
		FLINCH_ANIM = "flinch2";
		FLINCH_DELAY = 2.0;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		AIM_RATIO = 25;
		ATTACK_SPEED = 500;
		ROCK_DAMAGE = "$rand(400,800)";
		Precache(SOUND_DEATH);
		Precache("misc/glassgibs_huge.mdl");
		Precache("magic/freeze.wav");
	}

	void OnSpawn() override
	{
		SetHealth(2000);
		SetWidth(100);
		SetHeight(125);
		SetRace("demon");
		SetName("Ice Troll Lobber");
		SetRoam(true);
		NPC_GIVE_EXP = 150;
		SetDamageResistance("all", ".7");
		SetModel("monsters/troll_ice_lobber.mdl");
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
		SayText(I + "is hunting " + IS_HUNTING + "my target " + GetEntityName(HUNT_LASTTARGET));
	}

	void npc_targetsighted()
	{
		if (!(false)) return;
		ATTACK_RANGE = SWING_RANGE;
		if (GetEntityRange(param1) <= ROCK_RANGE)
		{
			if (GetEntityRange(param1) > ATTACK_RANGE)
			{
			}
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 20.0;
			MOVE_RANGE = 400;
			ATTACK_MOVERANGE = 400;
			PlayAnim("once", ANIM_THROW);
		}
		else
		{
			MOVE_RANGE = 100;
			ATTACK_MOVERANGE = 100;
		}
	}

	void rock_pickup()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 20.0;
		SetModelBody(1, 1);
		npcatk_suspend_ai(2.0);
		SetMoveDest(HUNT_LASTTARGET);
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
		string L_TARGET_RANGE = GetEntityRange(HUNT_LASTTARGET);
		if (L_TARGET_RANGE <= 1000)
		{
			TossProjectile("proj_snow_ball2", /* TODO: $relpos */ $relpos(0, 0, 21), "none", FIN_ATTACK_SPEED, ROCK_DAMAGE, 0.75, "none");
			CallExternal(GetEntityIndex("ent_lastprojectile"), "set_dmg", 200, 100, 20, 0.4);
		}
		if (L_TARGET_RANGE > 1000)
		{
			TossProjectile("proj_snow_ball2", /* TODO: $relpos */ $relpos(0, 0, 21), HUNT_LASTTARGET, FIN_ATTACK_SPEED, ROCK_DAMAGE, 0.75, "none");
			CallExternal(GetEntityIndex("ent_lastprojectile"), "set_dmg", 200, 100, 20, 0.01);
		}
		COMBAT_REPOS += 1;
		SetModelBody(1, 0);
		npcatk_resume_ai();
		if (!(COMBAT_REPOS > 4)) return;
		COMBAT_REPOS = 0;
		chicken_run(5.0, "combat_repos");
	}

	void attack_1()
	{
		DO_THROW = 0;
		SetModelBody(1, 0);
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 200, 10);
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, Random(20, 30), 0.75, "slash");
		if (RandomInt(1, 4) == 1)
		{
			ANIM_ATTACK = ANIM_PUNCH;
		}
		EmitSound(GetOwner(), 2, SOUND_ATTACK, 10);
	}

	void attack_2()
	{
		SetModelBody(1, 0);
		DO_THROW = 1;
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, Random(35, 45), 0.75, "slash");
		ANIM_ATTACK = "double_punch";
		EmitSound(GetOwner(), 2, SOUND_ATTACK, 10);
		if (RandomInt(1, 4) == 1)
		{
			ANIM_ATTACK = ANIM_DBLPUNCH;
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
		int ANIM_SELECT = RandomInt(0, 3);
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

	void game_dodamage()
	{
		if ((param1))
		{
			if ((DO_THROW))
			{
				ApplyEffect(param2, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 400, 400), 0);
			}
			if (PUSH_VEL != 0)
			{
				AddVelocity(param2, PUSH_VEL);
			}
		}
		PUSH_VEL = 0;
		DO_THROW = 0;
	}

}

}
