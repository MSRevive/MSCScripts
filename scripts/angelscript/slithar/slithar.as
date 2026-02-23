#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Slithar : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK_CROUCH;
	string ANIM_ATTACK_STAND;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_IDLE_CROUCH;
	string ANIM_IDLE_NORM;
	string ANIM_RUN;
	string ANIM_RUNFAST;
	string ANIM_WALK;
	string ANIM_WALKSLOW;
	int BEAM_STAGE;
	string CKN_MY_OLD_POS;
	string CYCLE_TIME;
	string DID_ESCAPE;
	int DID_INTRO;
	int ESCAPE_SCENE;
	string ESCAPE_START;
	int FADE_COUNT;
	int FADE_OUT_COUNT;
	string FIRST_VICTIM;
	string FLEE_DIR;
	int IS_UNHOLY;
	int LOOKING_FOR_PLAYERS;
	string LURE_ANG;
	string LURE_ID;
	string LURE_JUMP_DELAY;
	string LURE_NAME;
	string LURE_YAW;
	string MY_SKELETON;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	string SAID_ESCAPE;
	int SNAKE_SLOT;
	int STAFF_STRIKE;
	string STRIKE_STUN;
	string SUMMONING;
	int SUMMON_SKELETON;
	int SUMMON_SNAKE;
	float SUMMON_SNAKE_FREQ;
	int SUSPEND_AI;
	int TELED_OUT;

	Slithar()
	{
		IS_UNHOLY = 1;
		if (StringToLower(GetMapName()) == "bloodrose")
		{
			NPC_GIVE_EXP = 1500;
			NPC_IS_BOSS = 1;
		}
		else
		{
			NPC_GIVE_EXP = 400;
		}
		const float NPC_BOSS_RESTORATION = 1.0;
		precache_summons();
		const float JUMP_FREQ = 3.0;
		ANIM_IDLE = "deep_idle";
		ANIM_IDLE_NORM = "deep_idle";
		const string ANIM_CRAWL = "crawl";
		ANIM_IDLE_CROUCH = "crouch_aim_serpentstaff";
		const string ANIM_SEARCH = "looK_idle";
		const string ANIM_HOP = "jump";
		const string ANIM_JUMP = "long_jump";
		const int JUMP_AWAY_RANGE = 160;
		ANIM_DEATH = "headshot";
		const int ANIM_MOVERANGE = 30;
		const int ANIM_HITRANGE = 120;
		const int ANIM_RANGE = 80;
		ANIM_WALK = "walk2handed";
		ANIM_RUN = "walk2handed";
		ANIM_WALKSLOW = "walk2handed";
		ANIM_RUNFAST = "run2";
		const float ATTACK_HITCHANCE = 0.8;
		ANIM_ATTACK = "ref_shoot_serpentstaff";
		ANIM_ATTACK_STAND = "ref_shoot_serpentstaff";
		ANIM_ATTACK_CROUCH = "crouch_shoot_serpentstaff";
		const string ANIM_SUMMON = "cast_serpentstaff";
		const string STAFF_DAMAGE = "$rand(10,30)";
		const string POISON_DAMAGE = "$randf(20,30)";
		const string POISON_DURATION = "$randf(3,8)";
		const string SKELETON_SCRIPT = "monsters/skeleton_poison_random";
		const string SNAKE_SCRIPT = "monsters/snake_cursed";
		const string SOUND_ALERT = "monsters/snakeman/sm_alert2.wav";
		const string SOUND_ATTACK1 = "monsters/snakeman/sm_attack1.wav";
		const string SOUND_ATTACK2 = "monsters/snakeman/sm_attack2.wav";
		const string SOUND_ATTACK3 = "monsters/snakeman/sm_attack3.wav";
		const string SOUND_IDLE1 = "monsters/snakeman/sm_idle1.wav";
		const string SOUND_IDLE2 = "monsters/snakeman/sm_idle2.wav";
		const string SOUND_IDLE3 = "monsters/snakeman/sm_idle3.wav";
		const string SOUND_IDLE4 = "monsters/snakeman/sm_alert3.wav";
		const string SOUND_PAIN1 = "monsters/snakeman/sm_pain1.wav";
		const string SOUND_PAIN2 = "monsters/snakeman/sm_pain2.wav";
		const string SOUND_PAIN_WEAK1 = "monsters/snakeman/sm_pain3.wav";
		const string SOUND_PAIN_WEAK2 = "monsters/snakeman/sm_die2.wav";
		const string SOUND_CHANT = "monsters/snakeman/sm_summon.wav";
		const string SOUND_DEATH = "monsters/snakeman/sm_die1.wav";
		Precache(SOUND_DEATH);
		const string SOUND_SUMMON = "magic/spawn.wav";
		const string SOUND_STRUCK1 = "debris/flesh1.wav";
		const string SOUND_STRUCK2 = "debris/flesh2.wav";
		const string SOUND_STAFF_MISS = "zombie/claw_miss1.wav";
		const string SOUND_STAFF_HIT = "zombie/claw_strike1.wav";
		const float SUMMON_SKEL_FREQ = 90.0;
		SUMMON_SNAKE_FREQ = 7.0;
		const int I_AM_TURNABLE = 0;
		const string MONSTER_MODEL = "monsters/snakeman.mdl";
		Precache(MONSTER_MODEL);
	}

	void OnSpawn() override
	{
		if ((GENERIC_LORD)) return;
		SetName("snake_lord");
		SetName("Slithar , the Snake Lord");
		SetRace("demon");
		SetHealth(3000);
		if (GetMapName() == "slithar_test")
		{
			SetHealth(1501);
		}
		SetWidth(32);
		SetHeight(84);
		SetRoam(false);
		Precache(MONSTER_MODEL);
		SetModel(MONSTER_MODEL);
		SetIdleAnim(ANIM_IDLE_CROUCH);
		SetHearingSensitivity(10);
		SetInvincible(true);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("cold", 1.25);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("holy", 1.5);
		if (GetMapName() != "slithar_test")
		{
			GiveItem(GetOwner(), "blunt_snake_staff");
		}
		npcatk_suspend_ai(param1, "start");
		LOOKING_FOR_PLAYERS = 1;
		look_for_players();
		SNAKE_SLOT = 0;
	}

	void look_for_players()
	{
		if (!(LOOKING_FOR_PLAYERS)) return;
		if (!(DID_INTRO))
		{
			if ((CanSee("enemy", 300)))
			{
			}
			me_pouncie(GetEntityIndex(m_hLastSeen));
			int EXIT_SUB = 1;
		}
		ScheduleDelayedEvent(1.0, "look_for_players");
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if ((GENERIC_LORD)) return;
		if (!(LOOKING_FOR_PLAYERS)) return;
		string LASTHEARD_ID = GetEntityIndex("ent_lastheard");
		if (!(IsValidPlayer(LASTHEARD_ID))) return;
		if (!(GetEntityRange(LASTHEARD_ID) < 300)) return;
		me_pouncie(LASTHEARD_ID);
	}

	void me_pouncie()
	{
		if (!(LOOKING_FOR_PLAYERS)) return;
		LOOKING_FOR_PLAYERS = 0;
		SetMoveDest(param1);
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
		SetSayTextRange(2048);
		SayText("Ahhhh my childrensss you have come to die, yessss?");
		ScheduleDelayedEvent(3.0, "intro_jump_down");
		FIRST_VICTIM = param1;
	}

	void intro_jump_down()
	{
		SetMoveAnim(ANIM_HOP);
		SetIdleAnim(ANIM_IDLE);
		EmitSound(GetOwner(), 0, SOUND_IDLE2, 10);
		SetMoveDest(/* TODO: $relpos */ $relpos(0, 128, 0));
		ScheduleDelayedEvent(0.1, "hop_boost");
		PlayAnim("critical", ANIM_HOP);
	}

	void hop_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 300, 40));
	}

	void jump_done()
	{
		if ((DID_INTRO)) return;
		go_stand();
		ANIM_RUN = ANIM_RUNFAST;
		SetMoveAnim(ANIM_RUNFAST);
		DID_INTRO = 1;
		SetSayTextRange(2048);
		SayText("Thissss can be arranged. Yessss....");
		SetInvincible(false);
		SetRoam(true);
		CYCLE_TIME = CYCLE_TIME_BATTLE;
		npcatk_resume_ai(param1, "intro_jump_done");
		npcatk_settarget(FIRST_VICTIM);
		SUMMON_SNAKE_FREQ = 2.0;
		ScheduleDelayedEvent(25.0, "snake_slowdown");
		ScheduleDelayedEvent(30.0, "summon_skeleton");
		ScheduleDelayedEvent(5.0, "summon_snake");
		idle_sounds();
	}

	void snake_slowdown()
	{
		ANIM_WALK = ANIM_WALKSLOW;
		ANIM_RUN = ANIM_WALKSLOW;
		if (!(ESCAPE_SCENE))
		{
			SetMoveAnim(ANIM_WALK);
		}
		SUMMON_SNAKE_FREQ = 5.0;
	}

	void idle_sounds()
	{
		Random(5, 10)("idle_sounds");
		if (!(false))
		{
			// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE1, SOUND_IDLE3, SOUND_IDLE4
			array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3, SOUND_IDLE4, SOUND_IDLE1, SOUND_IDLE3, SOUND_IDLE4};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void summon_snake()
	{
		go_stand();
		if ((CanSee("enemy", JUMP_AWAY_RANGE)))
		{
			if (!(SUMMON_SKELETON))
			{
			}
			jump_away();
			STRIKE_STUN = 1;
			ScheduleDelayedEvent(1.0, "summon_snake");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		STRIKE_STUN = 0;
		SUMMON_SNAKE_FREQ("summon_snake");
		if (m_hAttackTarget == "unset")
		{
			int TOTAL_SNAKES = 0;
			if ((IsEntityAlive(SNAKE_SLOT1)))
			{
				TOTAL_SNAKES += 1;
			}
			if ((IsEntityAlive(SNAKE_SLOT2)))
			{
				TOTAL_SNAKES += 1;
			}
			if ((IsEntityAlive(SNAKE_SLOT3)))
			{
				TOTAL_SNAKES += 1;
			}
			if ((IsEntityAlive(SNAKE_SLOT4)))
			{
				TOTAL_SNAKES += 1;
			}
			if ((IsEntityAlive(SNAKE_SLOT5)))
			{
				TOTAL_SNAKES += 1;
			}
			if (TOTAL_SNAKES >= 5)
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if ((SUMMON_SKELETON)) return;
		if ((SUMMONING)) return;
		if ((ESCAPE_SCENE)) return;
		SUMMON_SNAKE = 1;
		EmitSound(GetOwner(), 0, SOUND_CHANT, 10);
		PlayAnim("critical", ANIM_SUMMON);
	}

	void summon_skeleton()
	{
		go_stand();
		if ((CanSee("enemy", JUMP_AWAY_RANGE)))
		{
			jump_away();
			STRIKE_STUN = 1;
			ScheduleDelayedEvent(1.0, "summon_skeleton");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		STRIKE_STUN = 0;
		SUMMON_SKEL_FREQ("summon_skeleton");
		SUMMON_SNAKE = 0;
		SUMMON_SKELETON = 1;
		if ((ESCAPE_SCENE)) return;
		EmitSound(GetOwner(), 0, SOUND_CHANT, 10);
		PlayAnim("critical", ANIM_SUMMON);
	}

	void spell_strike()
	{
		if ((ESCAPE_SCENE)) return;
		if ((SUMMON_SKELETON))
		{
			SUMMON_SKELETON = 0;
			SUMMONING = 1;
			ScheduleDelayedEvent(3.0, "reset_summoning");
			EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
			if ((IsEntityAlive(MY_SKELETON)))
			{
				CallExternal(MY_SKELETON, "npc_fade_away");
			}
			SpawnNPC(SKELETON_SCRIPT, /* TODO: $relpos */ $relpos(0, 48, 5), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
			Effect("glow", m_hLastCreated, Vector3(0, 255, 0), 200, 2, 2);
			MY_SKELETON = GetEntityIndex(m_hLastCreated);
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if ((SUMMON_SNAKE))
		{
			SUMMON_SNAKE = 0;
			SUMMONING = 1;
			ScheduleDelayedEvent(3.0, "reset_summoning");
			EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
			SNAKE_SLOT += 1;
			if (SNAKE_SLOT > 5)
			{
				SNAKE_SLOT = 1;
			}
			if (SNAKE_SLOT == 1)
			{
				if ((IsEntityAlive(SNAKE_SLOT1)))
				{
					CallExternal(SNAKE_SLOT1, "npc_fade_away");
				}
			}
			if (SNAKE_SLOT == 2)
			{
				if ((IsEntityAlive(SNAKE_SLOT2)))
				{
					CallExternal(SNAKE_SLOT2, "npc_fade_away");
				}
			}
			if (SNAKE_SLOT == 3)
			{
				if ((IsEntityAlive(SNAKE_SLOT3)))
				{
					CallExternal(SNAKE_SLOT3, "npc_fade_away");
				}
			}
			if (SNAKE_SLOT == 4)
			{
				if ((IsEntityAlive(SNAKE_SLOT4)))
				{
					CallExternal(SNAKE_SLOT4, "npc_fade_away");
				}
			}
			if (SNAKE_SLOT == 5)
			{
				if ((IsEntityAlive(SNAKE_SLOT5)))
				{
					CallExternal(SNAKE_SLOT5, "npc_fade_away");
				}
			}
			SpawnNPC(SNAKE_SCRIPT, /* TODO: $relpos */ $relpos(0, 64, 5), ScriptMode::Legacy);
			Effect("glow", m_hLastCreated, Vector3(0, 255, 0), 100, 1, 1);
			CallExternal(m_hLastCreated, "npcatk_settarget", m_hAttackTarget, "my_master");
			if (SNAKE_SLOT == 1)
			{
				SNAKE_SLOT1 = GetEntityIndex(m_hLastCreated);
			}
			if (SNAKE_SLOT == 2)
			{
				SNAKE_SLOT2 = GetEntityIndex(m_hLastCreated);
			}
			if (SNAKE_SLOT == 3)
			{
				SNAKE_SLOT3 = GetEntityIndex(m_hLastCreated);
			}
			if (SNAKE_SLOT == 4)
			{
				SNAKE_SLOT4 = GetEntityIndex(m_hLastCreated);
			}
			if (SNAKE_SLOT == 5)
			{
				SNAKE_SLOT5 = GetEntityIndex(m_hLastCreated);
			}
		}
		if (RandomInt(1, 2) == 1)
		{
			go_crawl();
		}
	}

	void reset_summoning()
	{
		SUMMONING = 0;
	}

	void jump_away()
	{
		if ((ESCAPE_SCENE)) return;
		go_stand();
		SetMoveAnim(ANIM_JUMP);
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		SetMoveDest(GetEntityIndex(m_hAttackTarget));
		ScheduleDelayedEvent(0.1, "long_jump_boost");
		npcatk_suspend_ai(1.5, "jump_away");
	}

	void long_jump_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 400, 50));
	}

	void long_jump_done()
	{
		npcatk_resume_ai(param1, "long_jump_done");
		npcatk_settarget(m_hAttackTarget);
	}

	void skeleton_died()
	{
		EmitSound(GetOwner(), 0, "monsters/snakeman/sm_alert4.wav", 10);
		SetSayTextRange(2048);
		SayText("Curse you!");
	}

	void skeleton_stuck()
	{
		summon_skeleton();
	}

	void staff_strike()
	{
		npcatk_dodamage(NPCATK_ATARGET, ATTACK_HITRANGE, STAFF_DAMAGE, ATTACK_HITCHANCE, GetOwner());
		STAFF_STRIKE = 1;
		if (RandomInt(1, 10) == 1)
		{
			go_crawl();
		}
	}

	void crouch_strike()
	{
		npcatk_dodamage(NPCATK_ATARGET, ATTACK_HITRANGE, STAFF_DAMAGE, ATTACK_HITCHANCE, GetOwner());
		STAFF_STRIKE = 1;
		if (RandomInt(1, 5) == 1)
		{
			go_stand();
		}
	}

	void game_dodamage()
	{
		if (!(STAFF_STRIKE)) return;
		if ((param1))
		{
			EmitSound(GetOwner(), 0, SOUND_STAFF_HIT, 10);
			if (!(STRIKE_STUN))
			{
				ApplyEffect(m_hAttackTarget, "effects/dot_poison", POISON_DURATION, GetEntityIndex(GetOwner()), POISON_DAMAGE);
			}
			if ((STRIKE_STUN))
			{
				ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
			}
		}
		if (!(param1))
		{
			EmitSound(GetOwner(), 0, SOUND_STAFF_MISS, 10);
		}
		STAFF_STRIKE = 0;
	}

	void go_crawl()
	{
		ANIM_ATTACK = ANIM_ATTACK_CROUCH;
		ANIM_WALK = ANIM_WALKSLOW;
		ANIM_RUN = ANIM_CRAWL;
		ANIM_IDLE = ANIM_IDLE_CROUCH;
		if (!(ESCAPE_SCENE))
		{
			SetMoveAnim(ANIM_WALK);
		}
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
	}

	void go_stand()
	{
		ANIM_ATTACK = ANIM_ATTACK_STAND;
		ANIM_WALK = ANIM_WALKSLOW;
		ANIM_RUN = ANIM_WALKSLOW;
		if (GetMonsterHP() < 2000)
		{
			ANIM_RUN = ANIM_RUNFAST;
		}
		ANIM_IDLE = ANIM_IDLE_NORM;
		if (!(ESCAPE_SCENE))
		{
			SetMoveAnim(ANIM_WALK);
		}
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
	}

	void npc_pre_flee()
	{
		go_stand();
		ANIM_RUN = ANIM_RUNFAST;
	}

	void npcatk_stopflee()
	{
		ANIM_RUN = ANIM_WALKSLOW;
		if (!(ESCAPE_SCENE))
		{
			SetMoveAnim(ANIM_WALK);
		}
		go_stand();
	}

	void chicken_run_end()
	{
		ANIM_RUN = ANIM_WALKSLOW;
		if (!(ESCAPE_SCENE))
		{
			SetMoveAnim(ANIM_WALK);
		}
		go_stand();
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (GetMonsterHP() < 1500)
		{
			if (!(GENERIC_LORD))
			{
			}
			if (!(DID_ESCAPE))
			{
			}
			DID_ESCAPE = 1;
			SetInvincible(true);
			if (!(GENERIC_LORD))
			{
				UseTrigger("slithar_half");
			}
		}
		if (!(param1 > 30)) return;
		if (param1 < 100)
		{
			// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_STRUCK1, SOUND_STRUCK2
			array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_STRUCK1, SOUND_STRUCK2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (param1 >= 100)
		{
			// PlayRandomSound from: SOUND_PAIN_WEAK1, SOUND_PAIN_WEAK2
			array<string> sounds = {SOUND_PAIN_WEAK1, SOUND_PAIN_WEAK2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			ScheduleDelayedEvent(1.0, "jump_away");
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetSayTextRange(2048);
		if (!(GENERIC_LORD))
		{
			UseTrigger("flesheater_door");
		}
		string FINDLE = FindEntityByName("npc_findlebind");
		if (((FINDLE !is null)))
		{
			CallExternal(FINDLE, "slithar_died");
		}
		CallExternal(SNAKE_SLOT1, "npc_fade_away");
		CallExternal(SNAKE_SLOT2, "npc_fade_away");
		CallExternal(SNAKE_SLOT3, "npc_fade_away");
		CallExternal(SNAKE_SLOT4, "npc_fade_away");
		CallExternal(SNAKE_SLOT5, "npc_fade_away");
		CallExternal(MY_SKELETON, "npc_fade_away");
	}

	void precache_summons()
	{
		Precache("debris/bustflesh1.wav");
		Precache("monsters/snake_idle1.wav");
		Precache("monsters/snake_idle2.wav");
		Precache("bullchicken/bc_bite2.wav");
		Precache("monsters/snake_pain1.wav");
		Precache("monsters/snake_pain2.wav");
		Precache("monsters/snakeman/sm_alert1.wav");
		Precache("debris/flesh2.wav");
		Precache("monsters/csnake.mdl");
		Precache("body/armour1.wav");
		Precache("body/armour2.wav");
		Precache("body/armour3.wav");
		Precache("bullchicken/bc_attack1.wav");
		Precache("bullchicken/bc_attack2.wav");
		Precache("bullchicken/bc_attack3.wav");
		Precache("ambience/steamburst1.wav");
		Precache("player/heartbeat_noloop.wav");
		Precache("monsters/skeleton_enraged.mdl");
		Precache("monsters/skeleton.mdl");
		Precache("poison_cloud.spr");
		Precache("cactusgibs.mdl");
		Precache("weapons/cbar_hitbod1.wav");
		Precache("weapons/cbar_hitbod2.wav");
		Precache("weapons/cbar_hitbod3.wav");
		Precache("zombie/zo_pain2.wav");
		Precache("zombie/zo_pain2.wav");
		Precache("zombie/claw_miss1.wav");
		Precache("zombie/claw_miss2.wav");
		Precache("zombie/zo_pain1.wav");
		Precache("ambience/the_horror1.wav");
		Precache("ambience/the_horror2.wav");
		Precache("ambience/the_horror3.wav");
		Precache("ambience/the_horror4.wav");
		Precache("doors/aliendoor1.wav");
	}

	void slithar_escape()
	{
		TELED_OUT = 1;
		LURE_NAME = FindEntityByName("slithar_lure");
		LURE_ID = GetEntityIndex(LURE_NAME);
		LURE_ANG = GetEntityAngles(LURE_ID);
		LURE_YAW = /* TODO: $vec.yaw */ $vec.yaw(LURE_ANG);
		if (!(SAID_ESCAPE))
		{
			SAID_ESCAPE = 1;
			SayText("I'll not make it that eassssy for you...");
		}
		npcatk_suspend_ai(param1, "escape1");
		ESCAPE_SCENE = 1;
		SetInvincible(true);
		FADE_OUT_COUNT = 200;
		slithar_fade_out();
		SetMoveAnim(ANIM_IDLE_NORM);
		SetIdleAnim(ANIM_IDLE_NORM);
		ANIM_RUN = ANIM_IDLE_NORM;
		ANIM_WALK = ANIM_IDLE_NORM;
		ANIM_IDLE = ANIM_IDLE_NORM;
		PlayAnim("once", "break");
		PlayAnim("critical", ANIM_SUMMON);
		BEAM_STAGE = 0;
		ESCAPE_START = GetMonsterProperty("origin");
		slithar_beam_cycle();
		EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
		SetMoveAnim(ANIM_SUMMON);
		SetIdleAnim(ANIM_SUMMON);
		SetMoveDest(LURE_ID);
		ScheduleDelayedEvent(0.25, "slithar_beams");
	}

	void slithar_beams()
	{
		string BEAM_SPRITE = "lgtning.spr";
		string START_X = (ESCAPE_START).x;
		string START_Y = (ESCAPE_START).y;
		string START_Z = (ESCAPE_START).z;
		START_Z -= 64;
		int BEAM_WIDTH = 200;
		Vector3 BEAM_START = Vector3(START_X, START_Y, START_Z);
		string BEAM_END = BEAM_START;
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 256));
		Vector3 BEAM_COLOR = Vector3(255, 255, 255);
		int BEAM_BRIGHTNESS = 200;
		int BEAM_NOISE = 30;
		float BEAM_DURATION = 4.0;
		Effect("beam", "point", BEAM_SPRITE, BEAM_WIDTH, BEAM_START, BEAM_END, BEAM_COLOR, BEAM_BRIGHTNESS, BEAM_NOISE, BEAM_DURATION);
		string END_POS = GetEntityOrigin(LURE_ID);
		string START_X = (END_POS).x;
		string START_Y = (END_POS).y;
		string START_Z = (END_POS).z;
		START_Z -= 64;
		int BEAM_WIDTH = 200;
		Vector3 BEAM_START = Vector3(START_X, START_Y, START_Z);
		string BEAM_END = BEAM_START;
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 256));
		Vector3 BEAM_COLOR = Vector3(255, 255, 255);
		int BEAM_BRIGHTNESS = 200;
		int BEAM_NOISE = 30;
		float BEAM_DURATION = 4.0;
		Effect("beam", "point", BEAM_SPRITE, BEAM_WIDTH, BEAM_START, BEAM_END, BEAM_COLOR, BEAM_BRIGHTNESS, BEAM_NOISE, BEAM_DURATION);
	}

	void slithar_beam_cycle()
	{
		if (!(BEAM_STAGE < 6)) return;
		BEAM_STAGE += 1;
		ScheduleDelayedEvent(0.4, "slithar_beam_cycle");
		string BEAM_SPRITE = "lgtning.spr";
		int BEAM_WIDTH = 200;
		string BEAM_START = ESCAPE_START;
		string BEAM_END = GetEntityOrigin(LURE_ID);
		BEAM_END += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 32));
		Vector3 BEAM_COLOR = Vector3(0, 255, 0);
		if (BEAM_STAGE == 1)
		{
			int BEAM_BRIGHTNESS = 20;
		}
		if (BEAM_STAGE == 2)
		{
			int BEAM_BRIGHTNESS = 100;
		}
		if (BEAM_STAGE == 3)
		{
			int BEAM_BRIGHTNESS = 255;
		}
		if (BEAM_STAGE == 4)
		{
			int BEAM_BRIGHTNESS = 100;
		}
		if (BEAM_STAGE == 5)
		{
			int BEAM_BRIGHTNESS = 50;
		}
		int BEAM_NOISE = 5;
		float BEAM_DURATION = 0.5;
		Effect("beam", "point", BEAM_SPRITE, BEAM_WIDTH, BEAM_START, BEAM_END, BEAM_COLOR, BEAM_BRIGHTNESS, BEAM_NOISE, BEAM_DURATION);
		Effect("tempent", "trail", "poison.spr", /* TODO: $relpos */ $relpos(0, 0, 64), /* TODO: $relpos */ $relpos(0, 0, 96), 20, 1, 1, 20, 5);
	}

	void slithar_fade_out()
	{
		if (FADE_OUT_COUNT <= 0)
		{
			SetMoveAnim(ANIM_IDLE_NORM);
			SetIdleAnim(ANIM_IDLE_NORM);
			slithar_escape_tele();
		}
		if (!(FADE_OUT_COUNT > 0)) return;
		ScheduleDelayedEvent(0.1, "slithar_fade_out");
		FADE_OUT_COUNT -= 10;
		SetProp(GetOwner(), "rendermode", 2);
		SetProp(GetOwner(), "renderamt", FADE_OUT_COUNT);
	}

	void slithar_escape_tele()
	{
		SetMoveAnim(ANIM_IDLE_NORM);
		SetIdleAnim(ANIM_IDLE_NORM);
		ANIM_RUN = ANIM_IDLE_NORM;
		ANIM_WALK = ANIM_IDLE_NORM;
		ANIM_IDLE = ANIM_IDLE_NORM;
		PlayAnim("once", "break");
		PlayAnim("once", ANIM_IDLE_NORM);
		stop_moving_damnit();
		SetMoveSpeed(0.0);
		SetRoam(false);
		SetEntityOrigin(GetOwner(), GetEntityOrigin(LURE_ID));
		SetAngles("face");
		FADE_COUNT = 0;
		EmitSound(GetOwner(), 0, SOUND_SUMMON, 10);
		slithar_fade_in();
		string SPLUGE_START = GetEntityOrigin(LURE_ID);
		string SPLUGE_DEST = SPLUGE_START;
		SPLUGE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, 0, 0), Vector3(0, 0, 200));
		Effect("tempent", "trail", "poison.spr", SPLUGE_START, SPLUGE_DEST, 20, 1, 5, 20, 5);
		UseTrigger("slithar_escaped");
		DeleteEntity(LURE_ID);
	}

	void stop_moving_damnit()
	{
		if (!(ESCAPE_SCENE)) return;
		SetAngles("face");
		ScheduleDelayedEvent(1.0, "stop_moving_damnit");
		SetMoveAnim(ANIM_IDLE_NORM);
		SetIdleAnim(ANIM_IDLE_NORM);
		ANIM_RUN = ANIM_IDLE_NORM;
		ANIM_WALK = ANIM_IDLE_NORM;
		ANIM_IDLE = ANIM_IDLE_NORM;
		PlayAnim("once", ANIM_IDLE_NORM);
	}

	void slithar_fade_in()
	{
		if (FADE_COUNT >= 250)
		{
			SetProp(GetOwner(), "rendermode", 0);
			SetProp(GetOwner(), "renderamt", 0);
		}
		if (!(FADE_COUNT < 250)) return;
		ScheduleDelayedEvent(0.1, "slithar_fade_in");
		FADE_COUNT += 10;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", FADE_COUNT);
	}

	void slithar_resume()
	{
		SetInvincible(false);
		ESCAPE_SCENE = 0;
		npcatk_resume_ai();
		SetMoveAnim(ANIM_RUNFAST);
		SetIdleAnim(ANIM_IDLE_NORM);
		SetMoveSpeed(1.0);
		SetRoam(true);
		ANIM_RUN = ANIM_RUNFAST;
		ANIM_WALK = ANIM_WALKSLOW;
		ANIM_IDLE = ANIM_IDLE_NORM;
		SUMMON_SKELETON = 0;
		SUMMON_SNAKE = 0;
		SUMMONING = 0;
		ScheduleDelayedEvent(3.0, "reset_summoning");
	}

	void OnSuspendAI()
	{
	}

	void npcatk_resume_ai()
	{
		if ((ESCAPE_SCENE)) return;
		if (!(SUSPEND_AI)) return;
		if (NPC_STORE_TARGET != "unset")
		{
			npcatk_restore_target();
		}
		SUSPEND_AI = 0;
	}

	void slithar_to_me()
	{
		if ((TELED_OUT)) return;
		if (!(SUSPEND_AI))
		{
			npcatk_suspend_ai();
		}
		if (!(ESCAPE_SCENE))
		{
			CKN_MY_OLD_POS = GetEntityOrigin(GetOwner());
			ESCAPE_SCENE = 1;
			ScheduleDelayedEvent(0.1, "lure_stuck_check");
		}
		SetMoveAnim(ANIM_RUNFAST);
		if (!(LURE_JUMP_DELAY))
		{
			PlayAnim("critical", ANIM_JUMP);
			LURE_JUMP_DELAY = 1;
			ScheduleDelayedEvent(0.1, "long_jump_boost");
			JUMP_FREQ("reset_lure_jump_delay");
		}
		SetMoveDest(param1);
		if (param2 < MOVE_RANGE)
		{
			int REACHED_LURE = 1;
		}
		if (Distance(param1, GetMonsterProperty("origin")) < MOVE_RANGE)
		{
			int REACHED_LURE = 1;
		}
		if (!(REACHED_LURE)) return;
		ESCAPE_SCENE = 0;
		npcatk_resume_ai();
		CallExternal(param3, "slithar_made_it");
		UseTrigger("slithar_escaped");
		slithar_resume();
	}

	void reset_lure_jump_delay()
	{
		LURE_JUMP_DELAY = 0;
	}

	void lure_stuck_check()
	{
		if ((TELED_OUT)) return;
		if (!(ESCAPE_SCENE)) return;
		string CKN_MOVE_DIST = Distance(GetMonsterProperty("origin"), CKN_MY_OLD_POS);
		if (CKN_MOVE_DIST == 0)
		{
			FLEE_DIR = RandomInt(1, 359);
			SetMoveDest(/* TODO: $relpos */ $relpos(Vector3(0, FLEE_DIR, 0), Vector3(0, 500, 0)));
			PlayAnim("loop", ANIM_RUNFAST);
		}
		CKN_MY_OLD_POS = GetMonsterProperty("origin");
		ScheduleDelayedEvent(0.25, "lure_stuck_check");
	}

	void slithar_stop()
	{
		ESCAPE_SCENE = 1;
		SetInvincible(true);
		LURE_YAW = param1;
		stop_moving_damnit();
	}

	void npc_suicide()
	{
	}

}

}
