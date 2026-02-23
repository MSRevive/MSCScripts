#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class DjinnIce : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CUR_SUMMON_POS;
	int DID_ROAR_INTRO;
	int I_ATTACKED;
	int LOOP_COUNT;
	int MELEE_ATTACK;
	int MOVE_RANGE;
	string MY_ICE_TROLL;
	string MY_PET_CLOC_NEW;
	int NO_STEP_ADJ;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int N_SUMMON_POS;
	string PUSH_VEL;
	string SUMMON_NEXT_CHECK;
	string SUMMON_POS;
	string SUMMON_POS1;
	string SUMMON_POS2;
	string SUMMON_POS3;
	string SUMMON_POS4;
	string SUMMON_POS5;
	string WIN_PRIZE;

	DjinnIce()
	{
		const int TOO_CLOSE = 100;
		if ((StringToLower(GetMapName())).findFirst("keledrosprelude") == 0)
		{
			NPC_IS_BOSS = 1;
			NPC_GIVE_EXP = 1000;
			if ((G_DEVELOPER_MODE))
			{
				// TODO: chatlog Djinn Ji-ax set BOSS MODE
			}
		}
		else
		{
			NPC_GIVE_EXP = 500;
		}
		const float NPC_BOSS_REGEN_RATE = 0.1;
		const float NPC_BOSS_RESTORATION = 1.0;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "monsters/troll/trollpain.wav";
		const string SOUND_ATTACK1 = "monsters/troll/trollattack.wav";
		const string SOUND_ATTACK2 = "monsters/troll/trollattack.wav";
		const string SOUND_DEATH = "monsters/troll/trolldeath.wav";
		const string SOUND_WALK = "monsters/troll/walk.wav";
		const string SOUND_SUMMON = "ambience/particle_suck2.wav";
		const string SOUND_ROAR = "monsters/troll/trollidle2.wav";
		Precache(SOUND_STRUCK1);
		Precache(SOUND_STRUCK2);
		Precache(SOUND_ATTACK1);
		Precache(SOUND_ATTACK2);
		Precache(SOUND_WALK);
		Precache(SOUND_DEATH);
		Precache(SOUND_SUMMON);
		Precache(SOUND_ROAR);
		const string ANIM_SUMMON = "throw_rock";
		ANIM_IDLE = "idle0";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_ATTACK = "double_punch";
		ANIM_DEATH = "die_fall";
		ATTACK_RANGE = 90;
		ATTACK_HITRANGE = 200;
		CAN_FLINCH = 0;
		MOVE_RANGE = 70;
		CAN_FLEE = 1;
		const int FLEE_HEALTH = 1;
		NO_STEP_ADJ = 1;
		const string TORCH_LIGHT_SCRIPT = "items/item_djinn_light";
		Precache("weapons/cbar_hitbod1.wav");
		Precache("monsters/troll/trollpain.wav");
		Precache("monsters/troll/trollpain.wav");
		Precache("monsters/troll/trollpain.wav");
		Precache("monsters/troll/trollattack.wav");
		Precache("monsters/troll/trollattack.wav");
		Precache("monsters/troll/trolldeath.wav");
		Precache("monsters/troll/trollidle.wav");
		Precache("monsters/troll/step1.wav");
		Precache("monsters/troll/step2.wav");
		Precache("monsters/troll/trollidle.wav");
		Precache("monsters/icetroll.mdl");
		Precache("doors/aliendoor3.wav");
		CUR_SUMMON_POS = 0;
		N_SUMMON_POS = 0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(10.0);
		if ((CYCLED_UP))
		{
		}
		if (STUCK_COUNT == 0)
		{
		}
		CUR_SUMMON_POS += 1;
		if (CUR_SUMMON_POS > 5)
		{
			CUR_SUMMON_POS = 0;
		}
		if (CUR_SUMMON_POS == 1)
		{
			SUMMON_POS1 = GetMonsterProperty("origin");
		}
		if (CUR_SUMMON_POS == 2)
		{
			SUMMON_POS2 = GetMonsterProperty("origin");
		}
		if (CUR_SUMMON_POS == 3)
		{
			SUMMON_POS3 = GetMonsterProperty("origin");
		}
		if (CUR_SUMMON_POS == 4)
		{
			SUMMON_POS4 = GetMonsterProperty("origin");
		}
		if (CUR_SUMMON_POS == 5)
		{
			SUMMON_POS5 = GetMonsterProperty("origin");
		}
		if (CUR_SUMMON_POS > N_SUMMON_POS)
		{
			N_SUMMON_POS += 1;
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(1.0);
		if ((IsEntityAlive(MY_ICE_TROLL)))
		{
		}
		if (Distance(MY_ICE_TROLL, GetMonsterProperty("origin")) < TOO_CLOSE)
		{
			AddVelocity(MY_ICE_TROLL, /* TODO: $relvel */ $relvel(0, 800, 10));
		}
		if (Distance(MY_ICE_TROLL, GetMonsterProperty("origin")) > TOO_CLOSE)
		{
			if ((IsEntityAlive(HUNT_LASTTARGET)))
			{
			}
			CallExternal(MY_ICE_TROLL, "ext_attack_master_target", HUNT_LASTTARGET);
		}
	}

	void game_precache()
	{
		Precache("items/item_djinn_light");
	}

	void OnSpawn() override
	{
		SetHealth(3000);
		SetWidth(60);
		SetHeight(100);
		SetRace("orc");
		SetName("Ice Djinn");
		SetRoam(true);
		SetDamageResistance("all", 0.7);
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("lightning", 1.5);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("holy", 0.2);
		SetModel("monsters/troll.mdl");
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		SetActionAnim(ANIM_ATTACK);
		ScheduleDelayedEvent(20, "summon_icetroll");
		SetHearingSensitivity(10);
		SetGlobalVar("ICE_TROLL_DEAD", 1);
		Precache("monsters/troll_ice");
		if (RandomInt(1, 8) == 1)
		{
			WIN_PRIZE = 1;
		}
		troll_spawn();
		ClientEvent("persist", "all", TORCH_LIGHT_SCRIPT, GetEntityIndex(GetOwner()), 1);
		Effect("glow", GetOwner(), Vector3(4, 50, 128), 64, -1, 0);
	}

	void attack_1()
	{
		I_ATTACKED = 1;
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 30, 10);
		DoDamage(m_hLastSeen, ATTACK_RANGE, Random(4.5, 6.0), ATTACK_HITCHANCE, "slash");
		MELEE_ATTACK = 1;
		if (RandomInt(1, 4) == 1)
		{
			ANIM_ATTACK = "hit_down";
		}
		attack_sound();
	}

	void attack_2()
	{
		I_ATTACKED = 1;
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, Random(40, 70), 0.75, "slash");
		MELEE_ATTACK = 1;
		ANIM_ATTACK = "double_punch";
		if (RandomInt(1, 10) == 1)
		{
			ScheduleDelayedEvent(0.1, "rawr");
			if (GetEntityIndex(m_hLastStruckByMe) != GetEntityIndex(GetOwner()))
			{
			}
			if (GetEntityRange(ENTITY_ENEMY) < ATTACK_HITRANGE)
			{
			}
			ApplyEffect(ENTITY_ENEMY, "effects/effect_push", 3, /* TODO: $relvel */ $relvel(0, 400, 400), 0);
		}
		attack_sound();
	}

	void bite1()
	{
		I_ATTACKED = 1;
		DoDamage(m_hLastSeen, ATTACK_RANGE, Random(4.5, 6.0), ATTACK_HITCHANCE, "slash");
		MELEE_ATTACK = 1;
	}

	void struck()
	{
		SetVolume(10);
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK2};
		EmitSound(GetOwner(), CHAN_VOICE, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void attack_sound()
	{
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_ATTACK1);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (MY_ICE_TROLL != "MY_ICE_TROLL")
		{
			DeleteEntity(MY_ICE_TROLL, true); // fade out
		}
		ClientEvent("remove", "all", SCRIPT_ID);
		bm_gold_spew(10, 4, 100, 1, 20);
	}

	void summon_icetroll()
	{
		ScheduleDelayedEvent(15, "summon_icetroll");
		if ((IsEntityAlive(MY_ICE_TROLL))) return;
		int EXIT_SUB = 0;
		if (!(SUMMON_NEXT_CHECK))
		{
			SUMMON_NEXT_CHECK = 1;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (!(false)) return;
		if (MY_ICE_TROLL != "MY_ICE_TROLL")
		{
			DeleteEntity(MY_ICE_TROLL, true); // fade out
		}
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SUMMON);
		npcatk_suspend_ai(1.0);
		PlayAnim("once", "break");
		PlayAnim("critical", ANIM_SUMMON);
		SetSolid("none");
		find_summon_pos();
		SpawnNPC("monsters/summon/ibarrier", SUMMON_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 96, 1
		SpawnNPC("monsters/summon/ibarrier", GetMonsterProperty("origin"), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 60, 1
		ScheduleDelayedEvent(0.25, "act_make_summon");
		ScheduleDelayedEvent(1, "solidify_djinn");
		SUMMON_NEXT_CHECK = 0;
		if (!(IS_FLEEING))
		{
			if (SUMMON_POS == GetMonsterProperty("origin"))
			{
			}
			npcatk_flee(MY_ICE_TROLL, 275, 3);
		}
	}

	void solidify_djinn()
	{
		string MY_LOC = GetEntityOrigin(GetOwner());
		string MY_PET_LOC = GetEntityOrigin(MY_ICE_TROLL);
		string PET_DISTANCE = Distance(MY_LOC, MY_PET_LOC);
		if (PET_DISTANCE > 80)
		{
			SetSolid("box");
		}
		if (PET_DISTANCE <= 80)
		{
			ScheduleDelayedEvent(0.25, "solidify_djinn");
		}
	}

	void npc_targetsighted()
	{
		if ((DID_ROAR_INTRO)) return;
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_ROAR);
		DID_ROAR_INTRO = 1;
		ScheduleDelayedEvent(0.5, "walker_go");
	}

	void walker_go()
	{
		SetRepeatDelay(2.0);
		int DID_ATTACK = 0;
		if ((I_ATTACKED))
		{
			int DID_ATTACK = 1;
		}
		if ((DID_ATTACK))
		{
			I_ATTACKED = 0;
		}
		MY_PET_CLOC_NEW = GetEntityOrigin(MY_ICE_TROLL);
		if ((DID_ATTACK)) return;
		if (!(HUNT_LASTTARGET != �NONE�)) return;
		if (GetEntityDist(HUNT_LASTTARGET) > MOVE_RANGE)
		{
			SetVolume(10);
			EmitSound(GetOwner(), SOUND_WALK);
		}
	}

	void rawr()
	{
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_ROAR);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		if (!(MELEE_ATTACK)) return;
		if (RandomInt(1, 4) == 1)
		{
			ApplyEffect(GetEntityIndex(m_hLastStruckByMe), "effects/dot_cold", 5, GetOwner(), RandomInt(13, 25), "none");
		}
		MELEE_ATTACK = 0;
	}

	void my_pet_stuck()
	{
		DeleteEntity(MY_ICE_TROLL, true); // fade out
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_SUMMON);
		npcatk_suspend_ai(1.0);
		PlayAnim("once", "break");
		PlayAnim("critical", ANIM_SUMMON);
		SetSolid("none");
		SetEntityOrigin(MY_ICE_TROLL, GetMonsterProperty("origin"));
		AddVelocity(MY_ICE_TROLL, /* TODO: $relpos */ $relpos(0, 800, 10));
		SpawnNPC("monsters/summon/ibarrier", GetMonsterProperty("origin"), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 60, 1
		CallExternal(MY_ICE_TROLL, "npcatk_flee", GetEntityIndex(GetOwner()), 100, 10.0, "master_told_me_to");
		ScheduleDelayedEvent(1, "solidify_djinn");
		SUMMON_NEXT_CHECK = 0;
	}

	void find_summon_pos()
	{
		LOOP_COUNT = 0;
		SUMMON_POS = GetMonsterProperty("origin");
		for (int i = 0; i < N_SUMMON_POS; i++)
		{
			find_summon_pos_loop();
		}
	}

	void find_summon_pos_loop()
	{
		LOOP_COUNT += 1;
		if (LOOP_COUNT == 1)
		{
			string CHECK_POS = SUMMON_POS1;
		}
		if (LOOP_COUNT == 2)
		{
			string CHECK_POS = SUMMON_POS2;
		}
		if (LOOP_COUNT == 3)
		{
			string CHECK_POS = SUMMON_POS3;
		}
		if (LOOP_COUNT == 4)
		{
			string CHECK_POS = SUMMON_POS4;
		}
		if (LOOP_COUNT == 5)
		{
			string CHECK_POS = SUMMON_POS5;
		}
		if (Distance(GetMonsterProperty("origin"), CHECK_POS) > TOO_CLOSE)
		{
			SUMMON_POS = CHECK_POS;
		}
		if (Distance(GetMonsterProperty("origin"), CHECK_POS) > Distance(GetMonsterProperty("origin"), SUMMON_POS))
		{
			SUMMON_POS = CHECK_POS;
		}
	}

	void act_make_summon()
	{
		SpawnNPC("monsters/troll_ice", SUMMON_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		MY_ICE_TROLL = GetEntityIndex(m_hLastCreated);
	}

}

}
