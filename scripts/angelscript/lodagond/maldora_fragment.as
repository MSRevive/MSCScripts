#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class MaldoraFragment : CGameScript
{
	string ANIM_BOLT;
	string ANIM_CAST;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_JUMP;
	string ANIM_LEAP;
	string ANIM_LOOK;
	string ANIM_ROCK;
	string ANIM_RUN;
	string ANIM_RUN_NORM;
	string ANIM_WALK;
	string ANIM_WALK_NORM;
	string ANIM_WAND;
	string APPLIED_BEAM;
	string AS_ATTACKING;
	int AXESKIN_COLD;
	int AXESKIN_DARK;
	int AXESKIN_FIRE;
	int AXESKIN_LIGHTNING;
	int AXESKIN_NULL;
	int AXESKIN_POISON;
	int AXESKIN_WHITE;
	string BARRIER_COLOR;
	int BARRIER_DELAY;
	float BARRIER_FREQ;
	int BARRIER_ON;
	string BARRIER_TARGS;
	string BEAM_COUNT;
	string BEAM_ON;
	string BEAM_TARGET;
	string CHAIN_COUNT;
	int CHAIN_COUNT_LIMIT;
	string CHAIN_LIST;
	string CHAIN_ON;
	string CL_BEAM_IDX;
	int COMBAT_ON;
	string CUR_CHAIN_TARGET;
	string DEBUG_CALLED_COMBAT;
	int DEBUG_DID_POSTSPAWN;
	int DEBUG_START_CONVO;
	int DMG_BARRIER;
	float DMG_CHAIN;
	float DMG_PUSH_BEAM;
	int DMG_ROCKS;
	float DMG_SHOCK;
	float DMG_WAND;
	string FELLOW_FRAG_NEARBY;
	string FINGER_ADJ;
	int FIN_EXP;
	int FREQ_SPAM;
	int GAVE_WARNING;
	string G_DEVELOPER;
	int G_MALDORA_SPELLING;
	string G_MALDORA_SPELLTIME;
	int IMAGES_ALIVE;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	float LAVA_FREQ;
	string MALDORA_IDX;
	string MALDORA_LIST;
	int MINIONS_ALIVE;
	int MINION_LIMIT;
	string MINION_SCRIPT;
	string MONSTER_MODEL;
	string NEXT_MINION;
	string NME_LIST;
	int NO_INTRO;
	int NO_MOVE;
	int NO_SPAWN_STUCK_CHECK;
	int NO_STUCK_CHECKS;
	int NPC_FORCED_MOVEDEST;
	string NPC_GIVE_EXP;
	string NPC_PROXACT_EVENT;
	string NPC_PROXACT_IFSEEN;
	int NPC_PROXACT_INRANGE;
	string NPC_PROXACT_PLAYERID;
	string NPC_PROXACT_RANGE;
	int NPC_PROXACT_TRIPPED;
	string NPC_PROX_ACTIVATE;
	int NPC_PROX_LOOP;
	int NUM_SPELLS;
	string PUSH_BEAM_ID;
	string PUSH_BEAM_VISIBLE;
	string READY_TO_WAIT;
	int REPULSE_ON;
	string SHADOW_SCRIPT;
	string SOUND_BEAM;
	string SOUND_SHOCK1;
	string SOUND_SHOCK2;
	string SOUND_SHOCK3;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_STRUCK4;
	string SOUND_STRUCK5;
	int SPELL_CHOICE;
	float SPELL_FREQ;
	string SPELL_TARGET;
	string WAND_ATK;
	string WAND_COLD_EFFECT;
	string WAND_DARK_EFFECT;
	string WAND_FIRE_EFFECT;
	string WAND_LIGHTNING_EFFECT;
	string WAND_POISON_EFFECT;
	string WAND_TARGET;
	string XSOUND_LEVITATE;
	string XSOUND_SPIN;
	string XSOUND_SUMMON;

	MaldoraFragment()
	{
		CHAIN_COUNT_LIMIT = 20;
		AXESKIN_WHITE = 6;
		AXESKIN_NULL = 5;
		AXESKIN_LIGHTNING = 4;
		AXESKIN_POISON = 3;
		AXESKIN_COLD = 2;
		AXESKIN_DARK = 1;
		AXESKIN_FIRE = 0;
		WAND_LIGHTNING_EFFECT = "effects/dot_lightning";
		WAND_COLD_EFFECT = "effects/dot_cold";
		WAND_POISON_EFFECT = "effects/dot_poison";
		WAND_FIRE_EFFECT = "effects/dot_fire";
		WAND_DARK_EFFECT = "effects/debuff_stun";
		NME_LIST = "human;hguard;wildanimal;";
		FREQ_SPAM = 10;
		NO_INTRO = 1;
		IS_UNHOLY = 1;
		NUM_SPELLS = 6;
		MINION_LIMIT = 1;
		FINGER_ADJ = "$relpos($vec(0,MY_YAW,0),$vec(0,30,54))";
		SHADOW_SCRIPT = "ms_wicardoven/maldora_image";
		MINION_SCRIPT = "monsters/maldora_minion_random";
		FIN_EXP = 2000;
		ANIM_IDLE = "idle";
		ANIM_LOOK = "look_idle";
		ANIM_RUN_NORM = "run2";
		ANIM_WALK_NORM = "walk2handed";
		ANIM_JUMP = "jump";
		ANIM_LEAP = "long_jump";
		ANIM_DEATH = "look_idle";
		ANIM_RUN = "run2";
		ANIM_WALK = "walk2handed";
		ANIM_CAST = "ref_shoot_trip";
		ANIM_ROCK = "ref_shoot_squeak";
		ANIM_BOLT = "shoot_1";
		ANIM_WAND = "ref_shoot_crowbar";
		LAVA_FREQ = Random(20.0, 40.0);
		SPELL_FREQ = 9.0;
		BARRIER_FREQ = 30.0;
		DMG_PUSH_BEAM = Random(2, 6);
		DMG_CHAIN = Random(15, 25);
		DMG_SHOCK = 10.0;
		DMG_ROCKS = RandomInt(50, 200);
		DMG_WAND = Random(10, 20);
		SOUND_SHOCK1 = "debris/zap8.wav";
		SOUND_SHOCK2 = "debris/zap3.wav";
		SOUND_SHOCK3 = "debris/zap4.wav";
		SOUND_BEAM = "weather/Storm_exclamation.wav";
		SOUND_STRUCK1 = "voices/human/male_hit2.wav";
		SOUND_STRUCK2 = "voices/human/male_hit1.wav";
		SOUND_STRUCK3 = "voices/human/male_hit3.wav";
		SOUND_STRUCK4 = "weapons/cbar_hitbod2.wav";
		SOUND_STRUCK5 = "weapons/cbar_hitbod1.wav";
		NO_SPAWN_STUCK_CHECK = 1;
		IMMUNE_VAMPIRE = 1;
		MONSTER_MODEL = "monsters/maldora.mdl";
		Precache(MONSTER_MODEL);
		Precache("ambience/the_horror1.wav");
		Precache("ambience/the_horror2.wav");
		Precache("ambience/the_horror3.wav");
		Precache("ambience/the_horror4.wav");
		Precache("monsters/skeleton_boss1.mdl");
		Precache("weapons/cbar_hitbod1.wav");
		Precache("weapons/cbar_hitbod2.wav");
		Precache("weapons/cbar_hitbod3.wav");
		Precache("zombie/zo_pain2.wav");
		Precache("zombie/zo_pain2.wav");
		Precache("zombie/claw_miss1.wav");
		Precache("zombie/claw_miss2.wav");
		Precache("null.wav");
		Precache("zombie/zo_pain1.wav");
		Precache("doors/aliendoor1.wav");
		Precache("debris/bustconcrete1.wav");
		Precache("debris/bustconcrete2.wav");
		Precache("debris/concrete3.wav");
		Precache("rockgibs.mdl");
		XSOUND_LEVITATE = "fans/fan4on.wav";
		XSOUND_SPIN = "magic/fan4_noloop.wav";
		XSOUND_SUMMON = "magic/volcano_start.wav";
		Precache(XSOUND_LEVITATE);
		Precache(XSOUND_SPIN);
		Precache(XSOUND_SUMMON);
		Precache("ambience/alienvoices1.wav");
		BARRIER_COLOR = Vector3(255, 0, 0);
		DMG_BARRIER = 400;
	}

	void game_precache()
	{
		Precache("monsters/maldora_minion_random");
		Precache("ms_wicardoven/maldora_image");
		if ((AM_UBER))
		{
			Precache("monsters/maldora_gminion_random");
		}
	}

	void OnSpawn() override
	{
		if ((AM_UBER)) return;
		SetName("Fragment of Maldora");
		SetHealth(5000);
		SetRace("demon");
		SetWidth(32);
		SetHeight(86);
		SetBloodType("none");
		NPC_GIVE_EXP = FIN_EXP;
		SetRoam(false);
		WAND_TARGET = "unset";
		SetHearingSensitivity(11);
		SetInvincible(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_IDLE);
		PlayAnim("once", ANIM_IDLE);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("magic", 0.0);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("acid", 0.0);
		SetDamageResistance("stun", 0);
		SetDamageResistance("holy", 0.25);
		SetModel(MONSTER_MODEL);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
		npcatk_suspend_ai();
		IMAGES_ALIVE = 0;
		MINIONS_ALIVE = 0;
		SetSayTextRange(2048);
		if ((StringToLower(GetMapName())).findFirst("lodagond") >= 0)
		{
			if (!(G_MALDORA_PRESENT))
			{
			}
			NPC_PROX_ACTIVATE = 1;
			NPC_PROXACT_RANGE = 768;
			NPC_PROXACT_IFSEEN = 1;
			NPC_PROXACT_EVENT = "start_convo";
		}
		if (!(NPC_PROX_ACTIVATE))
		{
			combat_go();
		}
		if (!(AM_UBER))
		{
			SetProp(GetOwner(), "skin", AXESKIN_NULL);
		}
	}

	void OnPostSpawn() override
	{
		ScheduleDelayedEvent(0.1, "init_beam_push");
		ScheduleDelayedEvent(0.2, "init_beam_chain");
		DEBUG_DID_POSTSPAWN = 1;
		CallExternal(GAME_MASTER, "gm_add_maldora_fragment", GetEntityIndex(GetOwner()));
		ScheduleDelayedEvent(0.1, "get_index");
	}

	void npcatk_proxact_scan()
	{
		if (!(READY_TO_WAIT)) return;
		if ((NPC_PROXACT_TRIPPED)) return;
		GetAllPlayers(LPLAYERS);
		NPC_PROX_LOOP = 0;
		NPC_PROXACT_INRANGE = 0;
		for (int i = 0; i < GetTokenCount(LPLAYERS, ";"); i++)
		{
			npcatk_proxact_lplayers();
		}
		if ((NPC_PROXACT_INRANGE))
		{
			npcatk_prox_activated(NPC_PROXACT_SCANID, "player_scan");
		}
		if ((NPC_PROXACT_TRIPPED)) return;
		ScheduleDelayedEvent(1.0, "npcatk_proxact_scan");
	}

	void npcatk_prox_activated()
	{
		if (!(READY_TO_WAIT)) return;
		if ((NPC_PROXACT_FOV))
		{
			string TEST_ORIG = GetEntityOrigin(param1);
			if (!(WithinCone2D(TEST_ORIG, GetMonsterProperty("origin"), GetMonsterProperty("angles"))))
			{
			}
			if ((G_DEVELOPER_MODE))
			{
				SendInfoMessageToAll("green " + GetEntityName(GetOwner()) + "npcatk_prox_activated " + GetEntityName(param1) + NPC_PROXACT_CONE + WithinCone2D(TEST_ORIG, GetMonsterProperty("origin"), GetMonsterProperty("angles")));
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		NPC_PROXACT_PLAYERID = param1;
		LogDebug("GetEntityName(NPC_PROXACT_PLAYERID) activated me by PARAM1 PARAM2");
		if ((NPC_PROXACT_TRIPPED)) return;
		NPC_PROXACT_TRIPPED = 1;
		NPC_PROXACT_EVENT();
	}

	void get_index()
	{
		if ((NPC_PROX_ACTIVATE))
		{
			ScheduleDelayedEvent(1.0, "npcatk_proxact_scan");
		}
		MALDORA_IDX = GetEntityProperty(GAME_MASTER, "scriptvar");
		NPC_PROXACT_TRIPPED = 0;
		if (MALDORA_IDX > 0)
		{
			READY_TO_WAIT = 1;
		}
		if (MALDORA_IDX <= 0)
		{
			ScheduleDelayedEvent(0.1, "get_index");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
	}

	void start_convo()
	{
		DEBUG_START_CONVO = 1;
		if (MALDORA_IDX == 1)
		{
			SayText("Shall we?");
			EmitSound(GetOwner(), 0, "voices/lodagond-4/fragment_shallwe.wav", 10);
			DEBUG_CALLED_COMBAT = 1;
			ScheduleDelayedEvent(2.5, "combat_go");
		}
		if (MALDORA_IDX == 2)
		{
			DEBUG_CALLED_COMBAT = 2;
			ScheduleDelayedEvent(1.33, "start_convo2");
			ScheduleDelayedEvent(2.5, "combat_go");
		}
	}

	void start_convo2()
	{
		SayText("Lets!");
		EmitSound(GetOwner(), 0, "voices/lodagond-4/fragment_lets.wav", 10);
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if ((COMBAT_ON))
		{
			if ((IsValidPlayer("ent_lastheard")))
			{
			}
			SPELL_TARGET = GetEntityIndex("ent_lastheard");
		}
	}

	void shock_ambience()
	{
		EmitSound(GetOwner(), 0, "magic/shock_noloop.wav", 10);
	}

	void combat_go()
	{
		CL_BEAM_IDX = "game.script.last_sent_id";
		SetInvincible(false);
		SetMoveAnim(ANIM_RUN);
		COMBAT_ON = 1;
		cycle_up();
		pick_spell();
		ScheduleDelayedEvent(1.0, "movement_cycle");
	}

	void reset_barrier_delay()
	{
		BARRIER_DELAY = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(COMBAT_ON)) return;
		if (!(false)) return;
		SPELL_TARGET = GetEntityIndex(m_hLastSeen);
	}

	void movement_cycle()
	{
		ScheduleDelayedEvent(0.5, "movement_cycle");
		if ((NO_MOVE)) return;
		if ((SUSPEND_AI))
		{
			npcatk_go_movedest();
		}
		if (!(false))
		{
			SetMoveAnim(ANIM_WALK);
		}
		if ((false))
		{
			SetMoveAnim(ANIM_RUN);
		}
		if ((IsEntityAlive(WAND_TARGET)))
		{
			if (GetEntityRange(WAND_TARGET) < 1024)
			{
			}
			npcatk_setmovedest(WAND_TARGET, MOVE_RANGE);
			if (GetEntityRange(WAND_TARGET) < ATTACK_RANGE)
			{
			}
			swing_fist(WAND_TARGET);
		}
		if ((IsEntityAlive(WAND_TARGET)))
		{
			if (GetEntityRange(WAND_TARGET) >= 1024)
			{
			}
			WAND_TARGET = "unset";
		}
		if (WAND_TARGET == "unset")
		{
			if (RandomInt(1, 20) == 1)
			{
				string NEW_WAND = SPELL_TARGET;
				if (GetEntityRange(SPELL_TARGET) > 640)
				{
					if ((false))
					{
					}
					string NEW_WAND = GetEntityIndex(m_hLastSeen);
				}
				if (!(IsEntityAlive(SPELL_TARGET)))
				{
					if ((false))
					{
					}
					string NEW_WAND = GetEntityIndex(m_hLastSeen);
				}
				swing_fist(NEW_WAND);
			}
		}
		if (WAND_TARGET != "unset")
		{
			int DISENGAGE = RandomInt(1, 10);
			if (DISENGAGE == 1)
			{
				leap_away(WAND_TARGET);
				WAND_TARGET = "unset";
			}
			if (DISENGAGE > 1)
			{
				npcatk_setmovedest(WAND_TARGET, MOVE_RANGE);
			}
		}
		if (!(IsEntityAlive(WAND_TARGET)))
		{
			if (RandomInt(1, 5) == 1)
			{
			}
			int RAND_ANG = RandomInt(0, 359);
			string TRACE_START = GetMonsterProperty("origin");
			string TRACE_END = TRACE_START;
			TRACE_END += /* TODO: $relpos */ $relpos(Vector3(0, RAND_ANG, 0), Vector3(0, 1000, 0));
			string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
			npcatk_setmovedest(TRACE_LINE, MOVE_RANGE);
		}
	}

	void reset_props()
	{
		SetRepeatDelay(10.0);
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 255);
	}

	void thrash_strike()
	{
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, 0.8);
	}

	void pick_spell()
	{
		SPELL_CHOICE = RandomInt(1, NUM_SPELLS);
		if ((G_MALDORA_SPELLING))
		{
			float RND_DELAY = Random(1, 5);
			RND_DELAY("pick_spell");
			int EXIT_SUB = 1;
			string TIME_DIFF = G_MALDORA_SPELLTIME;
			TIME_DIFF += 30.0;
			if (GetGameTime() > TIME_DIFF)
			{
				BEAM_COUNT = 0;
				BEAM_ON = 1;
				CHAIN_COUNT = 0;
				CHAIN_ON = 0;
				LogDebug("wtf , no spells for 30 seconds? spell flag must be jammed happens , dunno why");
				SetGlobalVar("G_MALDORA_SPELLING", 0);
			}
		}
		if ((EXIT_SUB)) return;
		if ((BEAM_ON))
		{
			int EXIT_SUB = 1;
		}
		if ((CHAIN_ON))
		{
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB))
		{
			ScheduleDelayedEvent(0.5, "pick_spell");
		}
		if ((EXIT_SUB)) return;
		if (G_DEVELOPER > 0)
		{
			SPELL_CHOICE = G_DEVELOPER;
			G_DEVELOPER = 0;
		}
		if (GetEntityRange(SPELL_TARGET) > 2048)
		{
			SPELL_CHOICE = 0;
		}
		if (!(IsEntityAlive(SPELL_TARGET)))
		{
			SPELL_CHOICE = 0;
		}
		if (GetRelationship(SPELL_TARGET) == "ally")
		{
			SPELL_CHOICE = 0;
		}
		if (SPELL_CHOICE == 0)
		{
			if (!(BARRIER_ON))
			{
			}
			if ((NO_MOVE))
			{
				resume_moving();
			}
		}
		if (SPELL_CHOICE == 1)
		{
			if ((BARRIER_DELAY))
			{
				SPELL_CHOICE = RandomInt(2, NUM_SPELLS);
				LogDebug("barrier_no_go - barrier delay");
			}
			if (!(BARRIER_DELAY))
			{
			}
			MALDORA_LIST = GetEntityProperty(GAME_MASTER, "scriptvar");
			LogDebug("maldist MALDORA_LIST");
			FELLOW_FRAG_NEARBY = 0;
			for (int i = 0; i < GetTokenCount(MALDORA_LIST, ";"); i++)
			{
				check_nearby();
			}
			if ((FELLOW_FRAG_NEARBY))
			{
				LogDebug("barrier_no_go - fellow maldora nearby");
				SPELL_CHOICE = RandomInt(2, NUM_SPELLS);
			}
			if (!(FELLOW_FRAG_NEARBY))
			{
			}
			BARRIER_DELAY = 1;
			BARRIER_FREQ("reset_barrier_delay");
			ScheduleDelayedEvent(0.1, "raise_barrier");
		}
		if (SPELL_CHOICE == 2)
		{
			SetGlobalVar("G_MALDORA_SPELLING", 1);
			G_MALDORA_SPELLTIME = GetGameTime();
			BEAM_ON = 1;
			face_target(SPELL_TARGET);
			PlayAnim("critical", ANIM_BOLT);
			BEAM_COUNT = 0;
			APPLIED_BEAM = 0;
			BEAM_TARGET = SPELL_TARGET;
			ScheduleDelayedEvent(0.1, "beam_push");
		}
		if (SPELL_CHOICE == 3)
		{
			SetGlobalVar("G_MALDORA_SPELLING", 1);
			G_MALDORA_SPELLTIME = GetGameTime();
			CHAIN_ON = 1;
			CUR_CHAIN_TARGET = 0;
			face_target(SPELL_TARGET);
			PlayAnim("critical", ANIM_CAST);
			CHAIN_COUNT = 0;
			ScheduleDelayedEvent(0.1, "chain_lightning");
		}
		if (SPELL_CHOICE == 4)
		{
			if ((G_MAL_ROCK_STORMS))
			{
				ScheduleDelayedEvent(0.2, "pick_spell");
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			SetGlobalVar("G_MAL_ROCK_STORMS", 1);
			PlayAnim("critical", ANIM_CAST);
			string NUM_ROCKS = GetPlayerCount();
			if (NUM_ROCKS > 4)
			{
				int NUM_RUCKS = 4;
			}
			SpawnNPC("monsters/summon/rock_storm", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), NUM_ROCKS, DMG_ROCKS, 64, 90
		}
		if ((EXIT_SUB)) return;
		if (SPELL_CHOICE == 5)
		{
			if ((BARRIER_ON))
			{
				ScheduleDelayedEvent(0.2, "pick_spell");
				int EXIT_SUB = 1;
			}
			if (!(BARRIER_ON))
			{
			}
			if (IMAGES_ALIVE >= 1)
			{
				SPELL_CHOICE = RandomInt(6, NUM_SPELLS);
			}
			if (IMAGES_ALIVE == 0)
			{
			}
			if (RandomInt(1, 3) == 1)
			{
				if (!(AM_UBER))
				{
				}
				SayText("Shadows , of shadows , of shadows...");
			}
			ScheduleDelayedEvent(0.1, "laugh_it_up");
			stop_moving();
			PlayAnim("critical", ANIM_CAST);
			EmitSound(GetOwner(), 0, "magic/spawn.wav", 10);
			Effect("glow", GetOwner(), Vector3(255, 255, 255), 128, 2, 2);
			SpawnNPC(SHADOW_SCRIPT, /* TODO: $relpos */ $relpos(0, 64, -35), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SPELL_TARGET, 45, AM_UBER
			ScheduleDelayedEvent(0.1, "make_shadow2");
			if ((AM_UBER))
			{
				ScheduleDelayedEvent(0.2, "make_shadow3");
				ScheduleDelayedEvent(0.4, "make_shadow4");
			}
			IMAGES_ALIVE = 2;
			ScheduleDelayedEvent(1.0, "resume_solid");
			ScheduleDelayedEvent(3.0, "resume_moving");
		}
		if (SPELL_CHOICE == 6)
		{
			if ((BARRIER_ON))
			{
				ScheduleDelayedEvent(0.2, "pick_spell");
				int EXIT_SUB = 1;
			}
			if (MINIONS_ALIVE >= MINION_LIMIT)
			{
				SPELL_CHOICE = RandomInt(7, NUM_SPELLS);
			}
			if (GetGameTime() <= NEXT_MINION)
			{
				SPELL_CHOICE = RandomInt(7, NUM_SPELLS);
			}
			if (GetGameTime() > NEXT_MINION)
			{
			}
			NEXT_MINION = GetGameTime();
			NEXT_MINION += 5.0;
			if (MINIONS_ALIVE < MINION_LIMIT)
			{
			}
			MINIONS_ALIVE += 1;
			PlayAnim("critical", ANIM_CAST);
			EmitSound(GetOwner(), 0, "monsters/skeleton/calrain3.wav", 10);
			Effect("glow", GetOwner(), Vector3(255, 255, 255), 128, 2, 2);
			SpawnNPC(MINION_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, -64), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SPELL_TARGET
			stop_moving(0.9);
			ScheduleDelayedEvent(1.0, "leap_away");
		}
		if (SPELL_CHOICE == 1)
		{
			ScheduleDelayedEvent(2.0, "pick_spell");
			int EXIT_SUB = 1;
		}
		if (SPELL_CHOICE == 7)
		{
			ScheduleDelayedEvent(0.2, "pick_spell");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		SPELL_FREQ("pick_spell");
	}

	void make_shadow2()
	{
		SpawnNPC(SHADOW_SCRIPT, /* TODO: $relpos */ $relpos(0, -64, -35), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SPELL_TARGET, 135, AM_UBER
	}

	void make_shadow3()
	{
		SpawnNPC(SHADOW_SCRIPT, /* TODO: $relpos */ $relpos(64, -64, -35), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SPELL_TARGET, 225, AM_UBER
	}

	void make_shadow4()
	{
		SpawnNPC(SHADOW_SCRIPT, /* TODO: $relpos */ $relpos(-64, 64, -35), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SPELL_TARGET, 315, AM_UBER
	}

	void reset_repulse()
	{
		REPULSE_ON = 0;
	}

	void laugh_it_up()
	{
		EmitSound(GetOwner(), 0, "voices/ms_wicardoven/fmaldora_exit4.wav", 10);
	}

	void image_died()
	{
		IMAGES_ALIVE -= 1;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (!(NO_MOVE))
		{
			if (GetEntityRange(m_hLastStruck) < ATTACK_RANGE)
			{
			}
			swing_fist(GetEntityIndex(m_hLastStruck));
		}
		if ((IsValidPlayer(m_hLastStruck)))
		{
			if (RandomInt(1, 2) == 1)
			{
			}
			SPELL_TARGET = GetEntityIndex(m_hLastStruck);
		}
		if (!(param1 > 20)) return;
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (!(param1 > 50)) return;
		leap_away(GetEntityIndex(m_hLastStruck));
	}

	void leap_away()
	{
		if ((CHAIN_ON)) return;
		if ((BEAM_ON)) return;
		if ((BARRIER_ON)) return;
		if ((NO_MOVE)) return;
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "leap_away2");
	}

	void leap_away2()
	{
		PlayAnim("critical", ANIM_LEAP);
		ScheduleDelayedEvent(0.1, "leap_boost");
	}

	void leap_boost()
	{
		if ((BARRIER_ON)) return;
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 400, 50));
	}

	void swing_fist()
	{
		if ((CHAIN_ON)) return;
		if ((BEAM_ON)) return;
		if ((BARRIER_ON)) return;
		if ((NO_MOVE)) return;
		WAND_TARGET = param1;
		npcatk_setmovedest(WAND_TARGET, MOVE_RANGE);
		if (!(GetEntityRange(WAND_TARGET) < ATTACK_RANGE)) return;
		PlayAnim("once", ANIM_WAND);
	}

	void stop_moving()
	{
		SetRoam(false);
		NO_STUCK_CHECKS = 1;
		NO_MOVE = 1;
		SetMoveAnim(ANIM_IDLE);
		ANIM_RUN = ANIM_IDLE;
		ANIM_WALK = ANIM_IDLE;
		face_target(SPELL_TARGET);
		PARAM1("resume_moving");
	}

	void resume_solid()
	{
		SetSolid("box");
	}

	void resume_moving()
	{
		SetRoam(true);
		NO_STUCK_CHECKS = 0;
		NO_MOVE = 0;
		SetMoveAnim(ANIM_RUN);
		ANIM_RUN = ANIM_RUN_NORM;
		ANIM_WALK = ANIM_WALK_NORM;
	}

	void raise_barrier()
	{
		LogDebug("raise_barrier BARRIER_COLOR DMG_BARRIER");
		stop_moving();
		BARRIER_ON = 1;
		PlayAnim("critical", ANIM_CAST);
		ClientEvent("new", "all", "effects/sfx_barrier", GetEntityIndex(GetOwner()), 128, BARRIER_COLOR, 10.0, 1, 1);
		EmitSound(GetOwner(), 0, "magic/spawn_loud.wav", 10);
		barrier_loop();
		ScheduleDelayedEvent(10.0, "lower_barrier");
	}

	void barrier_loop()
	{
		if (!(BARRIER_ON)) return;
		ScheduleDelayedEvent(0.5, "barrier_loop");
		string SCAN_POINT = GetEntityOrigin(GetOwner());
		SCAN_POINT += "z";
		BARRIER_TARGS = FindEntitiesInSphere("enemy", 128);
		if (!(BARRIER_TARGS != "none")) return;
		EmitSound(GetOwner(), 0, "doors/aliendoor1.wav", 10);
		for (int i = 0; i < GetTokenCount(BARRIER_TARGS, ";"); i++)
		{
			barrier_affect_targets();
		}
	}

	void barrier_affect_targets()
	{
		string CUR_TARG = GetToken(BARRIER_TARGS, i, ";");
		if (DMG_BARRIER > 0)
		{
			XDoDamage(CUR_TARG, "direct", DMG_BARRIER, 1.0, GetOwner(), GetOwner(), "none", "magic");
		}
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		SetVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(0, 1000, 110)));
	}

	void lower_barrier()
	{
		BARRIER_ON = 0;
		resume_moving();
		CallExternal(BARRIER_ID, "remove_barrier");
	}

	void beam_push()
	{
		BEAM_COUNT += 1;
		if (BEAM_COUNT == 1)
		{
			init_beam_push();
			Effect("beam", "update", PUSH_BEAM_ID, "brightness", 255);
		}
		if (BEAM_COUNT < 30)
		{
			SetIdleAnim(ANIM_BOLT);
			SetMoveAnim(ANIM_WALK);
		}
		if (BEAM_COUNT == 30)
		{
			SetIdleAnim(ANIM_IDLE);
			SetMoveAnim(ANIM_RUN);
			swing_fist(GetEntityIndex(m_hLastStruck));
			BEAM_ON = 0;
			SetGlobalVar("G_MALDORA_SPELLING", 0);
			Effect("beam", "update", PUSH_BEAM_ID, "brightness", 0);
		}
		if (!(BEAM_COUNT < 30)) return;
		ScheduleDelayedEvent(0.1, "beam_push");
		if (!(IsEntityAlive(BEAM_TARGET))) return;
		face_target(BEAM_TARGET);
		string BEAM_START = GetMonsterProperty("origin");
		string SEE_BTARGET = false;
		if (!(SEE_BTARGET))
		{
			PUSH_BEAM_VISIBLE = 0;
			Effect("beam", "update", PUSH_BEAM_ID, "brightness", 0);
		}
		if (!(SEE_BTARGET)) return;
		if (!(PUSH_BEAM_VISIBLE))
		{
			Effect("beam", "update", PUSH_BEAM_ID, "brightness", 255);
		}
		PUSH_BEAM_VISIBLE = 1;
		PlayAnim("once", ANIM_BOLT);
		EmitSound(GetOwner(), 0, SOUND_BEAM, 10);
		Effect("beam", "update", PUSH_BEAM_ID, "end_target", BEAM_TARGET, 0);
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
		MY_YAW += BEAM_COUNT;
		if (MY_YAW > 359)
		{
			MY_YAW -= 359;
		}
		string VEL_SET = /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(500, 1000, 30));
		SetVelocity(BEAM_TARGET, VEL_SET);
		DoDamage(BEAM_TARGET, "direct", DMG_PUSH_BEAM, 1.0, GetEntityIndex(GetOwner()));
		if (!(APPLIED_BEAM))
		{
			if ((/* TODO: $get_takedmg */ $get_takedmg(BEAM_TARGET, "stun")))
			{
			}
			ApplyEffect(BEAM_TARGET, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DMG_SHOCK);
			APPLIED_BEAM = 1;
		}
	}

	void my_target_died()
	{
		if (param1 == WAND_TARGET)
		{
			WAND_TARGET = "unset";
		}
		SPELL_TARGET = "unset";
		if ((GAVE_WARNING)) return;
		GAVE_WARNING = 1;
		SendInfoMsg(param1, "Beware! The Fragment of Malodra is immune to magic!");
	}

	void chain_lightning()
	{
		CHAIN_COUNT += 1;
		if (CHAIN_COUNT == 1)
		{
			string SCAN_POINT = GetEntityOrigin(GetOwner());
			SCAN_POINT += "z";
			CHAIN_LIST = FindEntitiesInSphere("enemy", 1024);
		}
		if (CHAIN_COUNT < CHAIN_COUNT_LIMIT)
		{
			SetIdleAnim(ANIM_CAST);
			SetMoveAnim(ANIM_WALK);
			face_target(SPELL_TARGET);
		}
		if (CHAIN_COUNT == CHAIN_COUNT_LIMIT)
		{
			SetIdleAnim(ANIM_IDLE);
			SetMoveAnim(ANIM_RUN);
			npcatk_flee(GetEntityIndex(m_hLastStruck), 800, 3.0);
			CHAIN_ON = 0;
			SetGlobalVar("G_MALDORA_SPELLING", 0);
		}
		if (!(CHAIN_COUNT < CHAIN_COUNT_LIMIT)) return;
		ScheduleDelayedEvent(0.25, "chain_lightning");
		if (!(CHAIN_LIST != "none")) return;
		PlayAnim("once", ANIM_CAST);
		for (int i = 0; i < GetTokenCount(CHAIN_LIST, ";"); i++)
		{
			chain_affect_targets();
		}
	}

	void chain_affect_targets()
	{
		string CUR_TARG = GetToken(CHAIN_LIST, i, ";");
		string TARG_RANGE = GetEntityRange(CUR_TARG);
		TARG_RANGE *= 1.5;
		DoDamage(CUR_TARG, TARG_RANGE, DMG_CHAIN, 1.0, GetOwner());
	}

	void game_dodamage()
	{
		if (!(param1))
		{
			WAND_ATK = 0;
		}
		if ((REPULSE_ON))
		{
			if (GetEntityRange(param2) < 128)
			{
				string INC_VEL = /* TODO: $vec.yaw */ $vec.yaw(GetEntityAngles(param2));
				INC_VEL -= 180;
				if (INC_VEL < 0)
				{
					INC_VEL += 359;
				}
				string OUT_VEL = /* TODO: $relvel */ $relvel(Vector3(0, INC_VEL, 0), Vector3(0, 2000, 0));
				AddVelocity(GetEntityIndex(param2), OUT_VEL);
			}
		}
		if (!(param1)) return;
		if ((CHAIN_ON))
		{
			if (GetGameTime() > NEXT_CHAIN_SOUND)
			{
				NEXT_CHAIN_SOUND = GetGameTime();
				NEXT_CHAIN_SOUND += 0.5;
				// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
				array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
				EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			}
			string TARG_ORG = GetEntityOrigin(param2);
			string MY_ORG = GetEntityOrigin(GetOwner());
			string TARG_ANG = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
			SetVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(0, 300, 0)));
			Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 2, param2, 1, Vector3(255, 255, 255), 255, 10, 1.0);
			if (GetGameTime() > NEXT_CHAIN_SHOCK)
			{
				NEXT_CHAIN_SHOCK = GetGameTime();
				NEXT_CHAIN_SHOCK += 1.0;
				ApplyEffect(param2, "effects/dot_lightning", 3.0, GetEntityIndex(GetOwner()), DMG_SHOCK);
			}
		}
		if ((WAND_ATK))
		{
			wand_strike_dmg(GetEntityIndex(param2));
		}
	}

	void wand_strike_dmg()
	{
		WAND_ATK = 0;
		if (!(RandomInt(1, 5) == 1)) return;
		ApplyEffect(param1, "effects/debuff_stun", 3.0, GetEntityIndex(GetOwner()));
	}

	void strike_wand()
	{
		AS_ATTACKING = GetGameTime();
		if (!(GetEntityRange(WAND_TARGET) < ATTACK_HITRANGE)) return;
		WAND_ATK = 1;
		DoDamage(WAND_TARGET, ATTACK_HITRANGE, DMG_WAND, 0.8, "blunt");
	}

	void quick_spell()
	{
		AS_ATTACKING = GetGameTime();
	}

	void quick_bolt()
	{
		AS_ATTACKING = GetGameTime();
	}

	void face_target()
	{
		NPC_FORCED_MOVEDEST = 1;
		SetMoveDest(param1);
	}

	void skele_died()
	{
		MINIONS_ALIVE -= 1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		G_MALDORA_SPELLING = 0;
		Effect("beam", "update", CHAIN_BEAM_ID, "remove", 0);
		Effect("beam", "update", PUSH_BEAM_ID, "remove", 0);
		if (!(AM_UBER))
		{
			CallExternal("all", "maldoraf_died", GetEntityIndex(GetOwner()));
		}
		if ((AM_UBER))
		{
			CallExternal("all", "maldora_final_died", GetEntityIndex(GetOwner()));
		}
		SetProp(GetOwner(), "renderamt", 0);
		SpawnNPC("ms_wicardoven/maldora_dead", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: "crow"
		SetSolid("none");
		SetEntityOrigin(GetOwner(), Vector3(20000, 20000, 20000));
	}

	void check_nearby()
	{
		string CUR_MAL = GetToken(MALDORA_LIST, i, ";");
		if (!(CUR_MAL != GetEntityIndex(GetOwner()))) return;
		if (!(IsEntityAlive(CUR_MAL))) return;
		if (GetEntityRange(CUR_MAL) < 256)
		{
			FELLOW_FRAG_NEARBY = 1;
		}
	}

	void ext_rock_storm_end()
	{
		SetGlobalVar("G_MAL_ROCK_STORMS", 0);
	}

	void init_beam_push()
	{
		Effect("beam", "ents", "lgtning.spr", 200, GetEntityIndex(GetOwner()), 2, GetEntityIndex(GetOwner()), 0, Vector3(255, 255, 0), 0, 20, 30.0);
		PUSH_BEAM_ID = GetEntityIndex(m_hLastCreated);
	}

}

}
