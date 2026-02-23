#pragma context server

#include "monsters/base_flyer.as"
#include "monsters/base_propelled.as"
#include "monsters/base_monster.as"

namespace MS
{

class EagleBase : CGameScript
{
	int AM_PERCHED;
	int AM_SUMMONED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int COUNT_ATK;
	string DIVE_POS;
	string DIVE_START;
	string FLIGHT_STUCK;
	int IN_DIVE;
	string LAST_POS;
	string LAST_PROG;
	int MELEE_ATTACK;
	int MOVE_RANGE;
	int NPC_HACKED_MOVE_SPEED;
	int NPC_PROXACT_CONE;
	string NPC_PROXACT_EVENT;
	int NPC_PROXACT_FOV;
	string NPC_PROXACT_PLAYERID;
	int NPC_PROXACT_RANGE;
	string NPC_PROXACT_TRIPPED;
	int NPC_PROX_ACTIVATE;

	EagleBase()
	{
		ANIM_IDLE = "flapping";
		ANIM_ATTACK = "attack";
		ANIM_DEATH = "fall";
		ANIM_WALK = "flapping";
		ANIM_RUN = "flapping";
		MOVE_RANGE = 20;
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 72;
		NPC_HACKED_MOVE_SPEED = 200;
		const string ANIM_PERCH1 = "idle";
		const string ANIM_FIGIT = "idle2";
		const string ANIM_IDLE_FLIGHT = "flapping";
		const string ANIM_DIVE = "dive";
		const int NPC_NO_END_FLY = 1;
		const string DMG_ATTACK = Random(5, 20);
		const string DMG_DIVE = RandomInt(30, 100);
		const string FREQ_DIVE = RandomInt(20, 30);
		const int SPEED_STANDARD = 200;
		const int SPEED_DIVE = 400;
		const int FLEE_COUNT = 10;
		const int ATTACK_RANGE_STANDARD = 64;
		const string SOUND_FLAP = "monsters/birds/hawkidle.wav";
		const string SOUND_WARCRY = "monsters/birds/bird.wav";
		const string SOUND_DEATH = "monsters/birds/hawk.wav";
		const string SOUND_ATTACK = "monsters/birds/flutter.wav";
		const string SOUND_STRUCK = "debris/flesh2.wav";
		const string SOUND_PAIN = "monsters/birds/vulture.wav";
		const string SOUND_PAIN2 = "monsters/birds/cry.wav";
		const string SOUND_VICTORY = "monsters/birds/hawkcaw.wav";
		Precache(SOUND_DEATH);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.5);
		if (!(I_R_FROZEN))
		{
		}
		if ((AM_PERCHED))
		{
			if (RandomInt(1, 50) == 1)
			{
				PlayAnim("once", ANIM_FIGIT);
			}
			int EXIT_SUB = 1;
		}
		if (!(EXIT_SUB))
		{
		}
		if (!(SUSPEND_AI))
		{
		}
		string MY_GROUND = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
		string MY_ALTI = GetMonsterProperty("origin.z");
		MY_ALTI -= MY_GROUND;
		if (MY_ALTI < 32)
		{
			SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 300));
			int EXIT_SUB = 1;
		}
		if (!(EXIT_SUB))
		{
		}
		if ((IS_HUNTING))
		{
		}
		if (!(SUSPEND_AI))
		{
		}
		npcatk_faceattacker();
		if (GetEntityRange(HUNT_LASTTARGET) > MOVE_RANGE)
		{
			SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 200, 0));
		}
		if (GetEntityRange(HUNT_LASTTARGET) <= MOVE_RANGE)
		{
			SetVelocity(GetOwner(), Vector3(0, 0, 0));
		}
		if (FLIGHT_STUCK > 2)
		{
			PlayAnim("once", ANIM_DIVE);
			do_rand_tweedee();
			npcatk_suspend_ai(Random(0.3, 0.9));
			SetMoveDest(NEW_DEST);
			ScheduleDelayedEvent(0.1, "horror_boost");
			FLIGHT_STUCK = 0;
		}
		string TARG_POS = GetEntityOrigin(m_hAttackTarget);
		if (!(SUSPEND_AI))
		{
			SetAngles("face_origin");
		}
		if (!(IS_FLEEING))
		{
		}
		if (!(SPITTING))
		{
		}
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
		}
		string CUR_PROG = Distance(GetMonsterProperty("origin"), TARG_POS);
		if (LAST_PROG >= CUR_PROG)
		{
			FLIGHT_STUCK += 1;
		}
		LAST_PROG = Distance(GetMonsterProperty("origin"), TARG_POS);
		LAST_POS = GetMonsterProperty("origin");
	}

	void OnSpawn() override
	{
		SetName("Eagle");
		SetRace("wildanimal");
		SetHealth(300);
		SetWidth(32);
		SetHeight(32);
		SetModel("monsters/eagle.mdl");
		SetIdleAnim("flapping");
		SetMoveAnim("flapping");
		SetHearingSensitivity(11);
		SetRoam(true);
		SetFly(true);
		SetDamageResistance("poison", 2.0);
		if (!(true)) return;
		if (StringToLower(GetMapName()) == "thanatos")
		{
			int KEEP_CLIP = 1;
		}
		if (StringToLower(GetMapName()) == "the_wall")
		{
			int KEEP_CLIP = 1;
		}
		if (!(KEEP_CLIP))
		{
			SetMonsterClip(0);
		}
		COUNT_ATK = 0;
	}

	void npc_targetsighted()
	{
		if (!(IsValidPlayer(HUNT_LASTTARGET)))
		{
			ATTACK_RANGE = GetEntityHeight(HUNT_LASTTARGET);
			if (!(CYCLED_UP))
			{
				cycle_up();
			}
		}
		else
		{
			ATTACK_RANGE = ATTACK_RANGE_STANDARD;
		}
	}

	void start_perched()
	{
		SetIdleAnim("idle");
		SetMoveAnim("idle");
		SetRoam(false);
		AM_PERCHED = 1;
		SetHearingSensitivity(0);
		npcatk_suspend_ai();
		NPC_PROX_ACTIVATE = 1;
		NPC_PROXACT_RANGE = 384;
		NPC_PROXACT_EVENT = "un_perch";
		NPC_PROXACT_FOV = 1;
		NPC_PROXACT_CONE = 90;
		ScheduleDelayedEvent(0.1, "npcatk_proxact_scan");
	}

	void un_perch()
	{
		SetHearingSensitivity(8);
		AM_PERCHED = 0;
		SetIdleAnim(ANIM_WALK);
		SetMoveAnim(ANIM_WALK);
		npcatk_suspend_ai();
		NPC_HACKED_MOVE_SPEED = SPEED_STANDARD;
		PlayAnim("critical", "divestart");
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 100));
		SetMoveDest(DIVE_START);
		ScheduleDelayedEvent(1.0, "npcatk_resume_ai");
		ScheduleDelayedEvent(1.1, "target_invader");
	}

	void target_invader()
	{
		npcatk_target(NPC_PROXACT_PLAYERID);
	}

	void cycle_up()
	{
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		ScheduleDelayedEvent(1.0, "dive_check");
	}

	void dive_check()
	{
		if ((NO_DIVE)) return;
		FREQ_DIVE("dive_check");
		if (!(IsEntityAlive(HUNT_LASTTARGET))) return;
		if (!(false)) return;
		DIVE_POS = GetEntityOrigin(HUNT_LASTTARGET);
		DIVE_START = GetMonsterProperty("origin");
		IN_DIVE = 1;
		NPC_HACKED_MOVE_SPEED = SPEED_DIVE;
		npcatk_suspend_ai();
		PlayAnim("critical", "divestart");
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, -200));
		ScheduleDelayedEvent(1.0, "dive_go");
	}

	void dive_go()
	{
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		SetMoveAnim("dive");
		SetIdleAnim("dive");
		SetMoveDest(DIVE_POS);
		dive_dmg_loop();
	}

	void dive_dmg_loop()
	{
		if (!(IN_DIVE)) return;
		ScheduleDelayedEvent(0.1, "dive_dmg_loop");
		SetMoveDest(DIVE_POS);
		DoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 64, DMG_DIVE, 1.0, 0);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string GRND_LEVEL = /* TODO: $get_ground_height */ $get_ground_height(MY_ORG);
		if (GRND_LEVEL <= 32)
		{
			dive_end();
		}
		if (!(Distance(MY_ORG, DIVE_POS) < 32)) return;
		dive_end();
	}

	void dive_end()
	{
		IN_DIVE = 0;
		SetIdleAnim(ANIM_WALK);
		SetMoveAnim(ANIM_WALK);
		NPC_HACKED_MOVE_SPEED = SPEED_STANDARD;
		PlayAnim("critical", "divestart");
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -400, -200));
		SetMoveDest(DIVE_START);
		ScheduleDelayedEvent(1.0, "npcatk_resume_ai");
	}

	void game_dodamage()
	{
		if (!(IN_DIVE)) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(Random(-20, 20), 200, 10));
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((AM_PERCHED))
		{
			NPC_PROXACT_PLAYERID = GetEntityIndex(m_hLastStruck);
			NPC_PROXACT_TRIPPED = 1;
			un_perch();
		}
		// PlayRandomSound from: SOUND_STRUCK, SOUND_STRUCK, SOUND_STRUCK, SOUND_STRUCK, SOUND_STRUCK, SOUND_PAIN, SOUND_PAIN2
		array<string> sounds = {SOUND_STRUCK, SOUND_STRUCK, SOUND_STRUCK, SOUND_STRUCK, SOUND_STRUCK, SOUND_PAIN, SOUND_PAIN2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(param1 > 30)) return;
		string RND_RL = Random(-40, 40);
		string RND_FB = Random(-40, 40);
		string RND_UD = Random(-40, 40);
		AddVelocity(GetOwner(), Vector3(RND_RL, RND_FB, RND_UD));
	}

	void attack1()
	{
		MELEE_ATTACK = 1;
		EmitSound(GetOwner(), 0, SOUND_ATTACK, 5);
		DoDamage(HUNT_LASTTARGET, ATTACK_HITRANGE, DMG_ATTACK, 0.9, "slash");
	}

	void attack2()
	{
		MELEE_ATTACK = 1;
		EmitSound(GetOwner(), 0, SOUND_ATTACK, 5);
		DoDamage(HUNT_LASTTARGET, ATTACK_HITRANGE, DMG_ATTACK, 0.9, "slash");
		COUNT_ATK += 1;
		if (COUNT_ATK > FLEE_COUNT)
		{
			COUNT_ATK = 0;
			npcatk_suspend_ai(3.0);
			SetMoveDest(HUNT_LASTTARGET);
		}
	}

	void flap_sound()
	{
		EmitSound(GetOwner(), 0, SOUND_FLAP, 5);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, -200));
	}

	void chicken_run()
	{
		ScheduleDelayedEvent(0.1, "horror_boost");
	}

	void horror_boost()
	{
		SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 500, 0));
	}

	void my_target_died()
	{
		EmitSound(GetOwner(), 0, SOUND_VICTORY, 10);
	}

	void summon_eagle_vanish()
	{
		if (!(AM_SUMMONED)) return;
		npc_fade_away();
	}

	void game_dynamically_created()
	{
		AM_SUMMONED = 1;
	}

}

}
