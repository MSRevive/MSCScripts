#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class DjinnLightningTroll : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
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
	int LAUNCH_GUIDED_COUNT;
	int MELEE_STIKE;
	int MELEE_STRIKE;
	int MOVE_RANGE;
	string NEXT_GUIDED;
	int NPC_GIVE_EXP;
	int PROJ_SHOCK_DMG;
	int PROJ_SHOCK_DOT;
	string PUSH_VEL;
	string SPOT_SPEECH;

	DjinnLightningTroll()
	{
		const string FREQ_GUIDED = Random(15.0, 30.0);
		const int DMG_GUIDED = 300;
		const int DOT_PUNCH = 100;
		const int DMG_PUNCH = 200;
		const int DMG_DBL_PUNCH = 100;
		NPC_GIVE_EXP = 3000;
		const int LEFT_FIST_INDEX = 0;
		const int RIGHT_FIST_INDEX = 1;
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
		DROP_GOLD_MIN = 500;
		DROP_GOLD_MAX = 600;
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
		ATTACK_RANGE = 800;
		ATTACK_HITRANGE = 200;
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
		const string ROCK_DAMAGE = "$rand(400,600)";
		PROJ_SHOCK_DOT = 100;
		PROJ_SHOCK_DMG = 400;
		const string BALL_SCRIPT = "monsters/summon/guided_lball_alt";
		const float BALL_DURATION = 10.0;
		const string ANIM_WARCRY = "idle2";
		const int MELEE_RANGE = 200;
		const int DMG_BALL = 400;
		Precache(SOUND_DEATH);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(15.0);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 255, 0), 128, 14.9);
	}

	void game_precache()
	{
		Precache(BALL_SCRIPT);
	}

	void OnSpawn() override
	{
		SetHealth(6000);
		SetWidth(100);
		SetHeight(125);
		SetRace("orc");
		SetName("Shadahar Lightning Djinn");
		SetRoam(true);
		SetDamageResistance("all", ".7");
		SetDamageResistance("poison", 1.2);
		SetDamageResistance("acid", 2.0);
		SetDamageResistance("lightning", 0);
		SetModel("monsters/troll_shad.mdl");
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(10);
		COMBAT_REPOS = 0;
		ScheduleDelayedEvent(10.0, "random_idle");
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 255, 0), 128, 15.0);
	}

	void npc_selectattack()
	{
		if (GetEntityRange(m_hAttackTarget) > MELEE_RANGE)
		{
			ANIM_ATTACK = "rock_throw";
		}
		else
		{
			string RND_MELEE = RandomInt(1, 2);
			if (RND_MELEE == 1)
			{
				ANIM_ATTACK = "hit_down";
			}
			if (RND_MELEE == 2)
			{
				ANIM_ATTACK = "double_punch";
			}
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
		TossProjectile("proj_troll_lightning", /* TODO: $relpos */ $relpos(0, 0, 33), "none", FIN_ATTACK_SPEED, ROCK_DAMAGE, 0.75, "none");
		COMBAT_REPOS += 1;
		SetModelBody(1, 0);
		if (!(COMBAT_REPOS > 4)) return;
		COMBAT_REPOS = 0;
		chicken_run(5.0, "combat_repos");
	}

	void cycle_up()
	{
		NEXT_GUIDED = GetGameTime();
		NEXT_GUIDED += FREQ_GUIDED;
		if ((DID_WARCRY)) return;
		PlayAnim("critical", ANIM_WARCRY);
		DID_WARCRY = 1;
		if (!(SPOT_SPEECH != "SPOT_SPEECH")) return;
		SayText("SPOT_SPEECH");
		SPOT_SPEECH = "SPOT_SPEECH";
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(m_hAttackTarget != "none")) return;
		if (!(false)) return;
		if (!(GetGameTime() > NEXT_GUIDED)) return;
		if (!(false)) return;
		LAUNCH_GUIDED_COUNT = 2;
		NEXT_GUIDED = GetGameTime();
		NEXT_GUIDED += FREQ_GUIDED;
		PlayAnim("critical", "double_punch_slow");
	}

	void game_dodamage()
	{
		if ((MELEE_STRIKE))
		{
			if (((param2 !is null)))
			{
			}
			if (GetRelationship(param2) == "enemy")
			{
			}
			if (GetEntityRange(param2) < ATTACK_HITRANGE)
			{
			}
			AddVelocity(param2, PUSH_VEL);
			if (RandomInt(1, 4) == 1)
			{
			}
			ApplyEffect(param2, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_PUNCH);
			Effect("glow", GetOwner(), Vector3(255, 255, 0), 64, 1, 1);
		}
		MELEE_STRIKE = 0;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (!(false)) return;
		ANIM_ATTACK = ANIM_DBLPUNCH;
		ATTACK_RANGE = SWING_RANGE;
		if (GetEntityRange(param1) <= ROCK_RANGE)
		{
			if (GetEntityRange(param1) > ATTACK_RANGE)
			{
			}
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 10;
			PlayAnim("once", ANIM_THROW);
		}
		if (GetEntityRange(param1) < ATTACK_RANGE)
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
		if (!(param1 == HUNT_LASTTARGET)) return;
		if (!(param2 > 1)) return;
		COMBAT_REPOS = 0;
	}

	void attack_1()
	{
		MELEE_STRIKE = 1;
		SetModelBody(1, 0);
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 300, 110);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_DBL_PUNCH, 0.75, "blunt");
		EmitSound(GetOwner(), 2, SOUND_ATTACK, 10);
		if (!(LAUNCH_GUIDED_COUNT >= 1)) return;
		if (LAUNCH_GUIDED_COUNT == 1)
		{
			spawn_guided_ball1();
		}
		if (LAUNCH_GUIDED_COUNT == 2)
		{
			spawn_guided_ball2();
		}
		LAUNCH_GUIDED_COUNT -= 1;
	}

	void attack_2()
	{
		MELEE_STIKE = 1;
		SetModelBody(1, 0);
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 600, 110);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_PUNCH, 0.75, "blunt");
		EmitSound(GetOwner(), 2, SOUND_ATTACK, 10);
	}

	void spawn_guided_ball1()
	{
		SpawnNPC(BALL_SCRIPT, GetEntityProperty(GetOwner(), "attachpos"), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_BALL, 256, 20.0
	}

	void spawn_guided_ball2()
	{
		SpawnNPC(BALL_SCRIPT, GetEntityProperty(GetOwner(), "attachpos"), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_BALL, 256, 20.0
	}

	void set_sorcpal_djinn1()
	{
		SetSayTextRange(2048);
		SPOT_SPEECH = "You say smash? ME SMASH!!";
	}

}

}
