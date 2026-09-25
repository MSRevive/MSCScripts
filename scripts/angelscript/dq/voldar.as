#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class Voldar : CGameScript
{
	int ACTIVE_HORRORS;
	int AM_LEAPING;
	string ANIM_ATTACK;
	string ANIM_ATTACK2;
	string ANIM_FLINCH;
	string ANIM_HOP;
	string ANIM_KICK;
	string ANIM_WARCRY;
	string AS_ATTACKING;
	float ATTACK_ACCURACY;
	int ATTACK_SPEED;
	int CLOUD_FREQ;
	int DID_INTRO;
	float DMG_KICK;
	int DMG_SLASH;
	int DMG_SPIT;
	int DO_STUN;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int EGG_FREQ;
	float FLINCH_CHANCE;
	int FLINCH_HEALTH;
	int HORNET_FREQ;
	int MAKE_ACLOUD;
	string MALDORA_ID;
	int MOVE_RANGE;
	int NO_SPAWN_STUCK_CHECK;
	float NPC_BOSS_REGEN_RATE;
	float NPC_BOSS_RESTORATION;
	int NPC_FORCED_MOVEDEST;
	int NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string NPC_PROXACT_EVENT;
	int NPC_PROXACT_IFSEEN;
	int NPC_PROXACT_RANGE;
	string NPC_PROX_ACTIVATE;
	string OLD_Z;
	int ORC_JUMPER;
	string SOUND_DEATH;
	string SOUND_WARCRY;
	int SPIT_DELAY;
	float SPIT_FREQ;
	int SUMMON_HORROR;

	Voldar()
	{
		NPC_BOSS_REGEN_RATE = 0.05;
		NPC_BOSS_RESTORATION = 0.25;
		NO_SPAWN_STUCK_CHECK = 1;
		NPC_GIVE_EXP = 2000;
		if (StringToLower(GetMapName()) == "ms_wicardoven")
		{
			NPC_IS_BOSS = 1;
		}
		else
		{
			if (StringToLower(GetMapName()) != "orc_for")
			{
				NPC_GIVE_EXP = 1000;
			}
		}
		ANIM_HOP = "battleaxe_swing1_L";
		ANIM_ATTACK2 = "battleaxe_swing1_L";
		ANIM_WARCRY = "warcry";
		ANIM_FLINCH = "flinch";
		SPIT_FREQ = 3.0;
		CLOUD_FREQ = RandomInt(20, 60);
		HORNET_FREQ = RandomInt(10, 30);
		EGG_FREQ = RandomInt(20, 40);
		ATTACK_SPEED = 300;
		MOVE_RANGE = 300;
		ANIM_KICK = "kick";
		DMG_SPIT = RandomInt(200, 300);
		DMG_KICK = Random(20, 50);
		DMG_SLASH = RandomInt(20, 60);
		SOUND_WARCRY = "monsters/orc/zo_alert10.wav";
		SOUND_DEATH = "voices/orc/die2.wav";
		Precache(SOUND_DEATH);
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(100, 300);
		ANIM_ATTACK = "swordswing1_L";
		FLINCH_CHANCE = 0.35;
		FLINCH_HEALTH = 1000;
		ATTACK_ACCURACY = 0.9;
		Precache("controller/con_idle1.wav");
		Precache("controller/con_idle2.wav");
		Precache("controller/con_idle3.wav");
		Precache("controller/con_attack1.wav");
		Precache("controller/con_attack2.wav");
		Precache("controller/con_attack3.wav");
		Precache("controller/con_die1.wav");
		Precache("debris/bustflesh2.wav");
		Precache("controller/con_pain1.wav");
		Precache("controller/con_die2.wav");
		Precache("bullchicken/bc_attack3.wav");
		Precache("bullchicken/bc_attack2.wav");
		Precache("ambience/steamburst1.wav");
		Precache("monsters/bat/flap_big1.wav");
		Precache("monsters/bat/flap_big2.wav");
		Precache("player/pl_fallpain1.wav");
		Precache("monsters/edwardgorey.mdl");
		Precache("ambience/the_horror1.wav");
		Precache("ambience/the_horror2.wav");
		Precache("ambience/the_horror3.wav");
		Precache("ambience/the_horror4.wav");
		Precache("monsters/egg.mdl");
		Precache("debris/bustflesh1.wav");
		Precache("weapons/g_bounce1.wav");
		Precache("monsters/maldora.mdl");
		Precache("monsters/skeleton/cal_laugh.wav");
		Precache("doors/aliendoor3.wav");
		Precache("magic/spawn.wav");
		Precache("magic/boom.wav");
		Precache("misc/gold.wav");
		NPC_PROXACT_RANGE = 640;
		NPC_PROXACT_IFSEEN = 1;
		NPC_PROXACT_EVENT = "start_intro";
	}

	void orc_spawn()
	{
		SetHealth(2500);
		SetWidth(32);
		SetHeight(60);
		SetName("Voldar , former head of the Black Hand");
		SetHearingSensitivity(11);
		SetStat("parry", 50);
		SetDamageResistance("all", 0.4);
		SetRoam(false);
		SetProp(GetOwner(), "skin", 3);
		ACTIVE_HORRORS = 0;
		SetModelBody(0, 2);
		SetModelBody(1, 3);
		SetModelBody(2, 6);
		SetSayTextRange(2048);
		CatchSpeech("debug_params", "debug");
		string L_MAP_NAME = StringToLower(GetMapName());
		int EXIT_SUB = 1;
		if (L_MAP_NAME == "ms_wicardoven")
		{
			int EXIT_SUB = 0;
		}
		if (L_MAP_NAME == "voldar_test")
		{
			int EXIT_SUB = 0;
		}
		if ((EXIT_SUB))
		{
			SetName("Orc Poisoner");
			NPC_PROX_ACTIVATE = 0;
			ScheduleDelayedEvent(0.1, "combat_go");
		}
		if ((EXIT_SUB)) return;
		NPC_PROX_ACTIVATE = 1;
		npcatk_suspend_ai();
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		SetInvincible(true);
		SpawnNPC("ms_wicardoven/maldora_dead", /* TODO: $relpos */ $relpos(0, 64, 0), ScriptMode::Legacy); // params: "valdor"
		ScheduleDelayedEvent(0.25, "get_maldora_id");
	}

	void get_maldora_id()
	{
		string MALDORA_NAME = FindEntityByName("dead_maldora");
		MALDORA_ID = GetEntityIndex(MALDORA_NAME);
		ScheduleDelayedEvent(0.1, "face_maldora");
	}

	void face_maldora()
	{
		ScheduleDelayedEvent(0.1, "scan_for_players");
	}

	void start_intro()
	{
		PlayAnim("critical", "flinch");
		SayText("You were supposed to help me take back my tribe! But now look what's happened!");
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/voldor_2fmaldora1.wav", 10);
		ScheduleDelayedEvent(3.6, "do_intro1");
	}

	void do_intro1()
	{
		CallExternal(MALDORA_ID, "say_gaveyou1");
		ScheduleDelayedEvent(6.22, "do_intro2");
	}

	void do_intro2()
	{
		CallExternal(MALDORA_ID, "say_gaveyou2");
		ScheduleDelayedEvent(4.2, "do_intro3");
	}

	void do_intro3()
	{
		CallExternal(MALDORA_ID, "say_gaveyou3");
		ScheduleDelayedEvent(5.8, "do_intro4");
	}

	void do_intro4()
	{
		CallExternal(MALDORA_ID, "say_gaveyou4");
		ScheduleDelayedEvent(3.3, "do_intro5");
	}

	void do_intro5()
	{
		CallExternal(MALDORA_ID, "fly_out");
		SayText(WAAAIIIT!!!!!);
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/voldor_2fmaldora2.wav", 10);
		PlayAnim("critical", ANIM_WARCRY);
		ScheduleDelayedEvent(1.8, "do_intro6");
	}

	void do_intro6()
	{
		PlayAnim("critical", ANIM_ATTACK);
		SayText("Fine! Have to prove my worth , do " + I?);
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/voldor_2fmaldora3.wav", 10);
		SetMoveDest(FIRST_TARGET);
		AS_ATTACKING = GetGameTime();
		ScheduleDelayedEvent(2.0, "combat_go");
	}

	void debug_params()
	{
		SayText("horrors " + ACTIVE_HORRORS + "leaping " + AM_LEAPING);
	}

	void combat_go()
	{
		DID_INTRO = 1;
		SetInvincible(false);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		npcatk_resume_ai();
		cycle_up("voldar_forced");
		CLOUD_FREQ("make_cloud");
		EGG_FREQ("lay_egg");
		UseTrigger("voldar_go");
		ScheduleDelayedEvent(0.1, "set_first_targ");
	}

	void set_first_targ()
	{
		npcatk_settarget(FIRST_TARGET, "voldar_forced");
	}

	void OnPostSpawn() override
	{
		ORC_JUMPER = 1;
	}

	void run_away()
	{
		npcatk_flee(GetEntityIndex(param1), 400, 2.0);
	}

	void leap_away()
	{
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(1.0);
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "leap_away2");
	}

	void leap_away2()
	{
		// PlayRandomSound from: "voices/orc/hit.wav", "voices/orc/hit2.wav", "voices/orc/hit3.wav"
		array<string> sounds = {"voices/orc/hit.wav", "voices/orc/hit2.wav", "voices/orc/hit3.wav"};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		PlayAnim("critical", ANIM_HOP);
		ScheduleDelayedEvent(0.1, "orc_hop");
		ScheduleDelayedEvent(1.0, "reset_leaping");
	}

	void leap_at()
	{
		if ((AM_LEAPING)) return;
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(1.0);
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "leap_at2");
	}

	void leap_at2()
	{
		// PlayRandomSound from: "voices/orc/hit.wav", "voices/orc/hit2.wav", "voices/orc/hit3.wav"
		array<string> sounds = {"voices/orc/hit.wav", "voices/orc/hit2.wav", "voices/orc/hit3.wav"};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		PlayAnim("critical", ANIM_HOP);
		ScheduleDelayedEvent(0.1, "orc_hop");
		ScheduleDelayedEvent(1.0, "reset_leaping");
		OLD_Z = (GetMonsterProperty("origin")).z;
		DO_STUN = 1;
		ScheduleDelayedEvent(0.5, "ground_scan");
	}

	void ground_scan()
	{
		if (!(DO_STUN)) return;
		ScheduleDelayedEvent(0.2, "ground_scan");
		string MY_GROUND = /* TODO: $get_ground_height */ $get_ground_height(GetMonsterProperty("origin"));
		string MY_Z = (GetMonsterProperty("origin")).z;
		string DIFF = MY_Z;
		DIFF -= MY_GROUND;
		if (DIFF < 5)
		{
			DO_STUN = 0;
		}
		if ((DO_STUN)) return;
		SpawnNPC("monsters/summon/stun_burst", /* TODO: $relpos */ $relpos(0, 30, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 128
	}

	void game_hitground()
	{
	}

	void reset_leaping()
	{
		AM_LEAPING = 0;
	}

	void npc_targetsighted()
	{
		if ((SPIT_DELAY)) return;
		if (!(GetEntityRange(param1) > ATTACK_RANGE)) return;
		if ((AM_LEAPING)) return;
		if ((IS_FLEEING)) return;
		SPIT_DELAY = 1;
		SPIT_FREQ("reset_spit_delay");
		AS_ATTACKING = GetGameTime();
		PlayAnim("once", ANIM_ATTACK2);
	}

	void reset_spit_delay()
	{
		SPIT_DELAY = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (GetMonsterHP() >= 1000)
		{
			int THRESH = 50;
		}
		if (GetMonsterHP() < 1000)
		{
			int THRESH = 25;
		}
		int ESCAPE_CHANCE = RandomInt(THRESH, 100);
		if (param1 > ESCAPE_CHANCE)
		{
			int ESCAPE_CHOICE = RandomInt(1, 2);
			if (ESCAPE_CHOICE == 1)
			{
				leap_away(GetEntityIndex(m_hLastStruck), "struck_hard");
			}
			if (ESCAPE_CHOICE == 2)
			{
				do_kick();
			}
		}
	}

	void do_kick()
	{
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_KICK);
		ScheduleDelayedEvent(1.0, "kick_damage");
	}

	void kick_damage()
	{
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, KICK_DAMAGE, 1.0, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:kick");
	}

	void kick_dodamage()
	{
		if (!(param1)) return;
		ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 150, 20));
		run_away(GetEntityIndex(param2));
	}

	void make_cloud()
	{
		CLOUD_FREQ("make_cloud");
		if (!(false)) return;
		MAKE_ACLOUD = 1;
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_WARCRY);
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		ScheduleDelayedEvent(2.0, "make_cloud2");
	}

	void make_cloud2()
	{
		if ((MAKE_ACLOUD))
		{
			MAKE_ACLOUD = 0;
			ScheduleDelayedEvent(0.1, "magic_fx");
			string CLOUD_ORG = GetEntityOrigin(m_hAttackTarget);
			if (!(IsEntityAlive(m_hAttackTarget)))
			{
				string CLOUD_ORG = /* TODO: $relpos */ $relpos(0, 0, 0);
			}
			if (GetEntityRange(m_hAttackTarget) > 3000)
			{
				string CLOUD_ORG = /* TODO: $relpos */ $relpos(0, 0, 0);
			}
			SpawnNPC("monsters/summon/npc_poison_cloud2", CLOUD_ORG, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 100, 20.0, 3
			int EXIT_SUB = 1;
		}
	}

	void OnFlinch()
	{
		MAKE_ACLOUD = 0;
	}

	void lay_egg()
	{
		EGG_FREQ("lay_egg");
		if (!(ACTIVE_HORRORS < 2)) return;
		SUMMON_HORROR = 1;
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_ATTACK2);
		EmitSound(GetOwner(), 0, "voices/orc/attack2.wav", 10);
	}

	void horror_died()
	{
		ACTIVE_HORRORS -= 1;
	}

	void swing_axe()
	{
		if ((SUMMON_HORROR))
		{
			SUMMON_HORROR = 0;
			ACTIVE_HORRORS += 1;
			ScheduleDelayedEvent(0.1, "magic_fx");
			EmitSound(GetOwner(), 0, "magic/frost_reverse.wav", 10);
			SpawnNPC("monsters/summon/horror_egg", /* TODO: $relpos */ $relpos(0, 30, 50), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
			AddVelocity(m_hLastCreated, /* TODO: $relvel */ $relvel(0, 100, 20));
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((IS_FLEEING)) return;
		EmitSound(GetOwner(), 0, "bullchicken/bc_attack3.wav", 10);
		TossProjectile("proj_poison", /* TODO: $relpos */ $relpos(0, 48, 18), m_hAttackTarget, ATTACK_SPEED, DMG_SPIT, 0, "none");
		Effect("glow", "ent_lastprojectile", Vector3(0, 255, 0), 64, -1, 0);
		if (GetEntityRange(m_hAttackTarget) > 200)
		{
			if (RandomInt(1, 100) > 50)
			{
			}
			leap_at(m_hAttackTarget, ",", "id");
		}
	}

	void swing_sword()
	{
		if (!(DID_INTRO)) return;
		baseorc_yell();
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SLASH, ATTACK_ACCURACY, GetOwner(), GetOwner(), "none", "slash", "dmgevent:swing");
	}

	void swing_dodamage()
	{
		if (!(param1)) return;
		ApplyEffect(param2, "effects/dot_poison", RandomInt(3, 5), GetEntityIndex(GetOwner()), 40);
		if (RandomInt(1, 20) == 1)
		{
			leap_away(GetEntityIndex(param2), "slash_random");
		}
	}

	void magic_fx()
	{
		Effect("glow", GetOwner(), Vector3(255, 0, 0), 64, 2, 2);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string L_MAP_NAME = StringToLower(GetMapName());
		if (L_MAP_NAME == "voldar_test")
		{
			int TREASURE_MAP = 1;
		}
		if (L_MAP_NAME == "ms_wicardoven")
		{
			int TREASURE_MAP = 1;
		}
		if ((TREASURE_MAP))
		{
			bm_gold_spew(25, 2, 75, 4, 30);
		}
	}

}

}
