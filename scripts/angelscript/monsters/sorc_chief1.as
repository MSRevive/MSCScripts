#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SorcChief1 : CGameScript
{
	int AM_LEAPING;
	int AM_UNARMED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BLOOD_DRINKER_ID;
	int CAN_FLINCH;
	int CUR_SPECIAL;
	int CYCLES_STARTED;
	string DOUBLE_FOR;
	string DOUBLE_UP;
	string FIRST_PLAYER;
	string FOUND_NEAR_TARGET;
	float FREQ_LEAP;
	string HALF_HEALTH;
	string ID_LSTORM1;
	string ID_LSTORM2;
	int JUMP_FWD_DIST;
	int KICK_DELAY;
	string LAST_SWORD_HIT;
	string LAST_TELE;
	string LEAP_DELAY;
	int LOC_LSTORM1;
	int LOC_LSTORM2;
	int LSTORM_LOOPCOUNT;
	string LSTORM_TARGS;
	string MAX_AI_SUSPEND;
	int MOVE_RANGE;
	string NEW_TARGET;
	int NPC_FORCED_MOVEDEST;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int N_STORMS;
	int N_TELES;
	int ON_LODAGOND;
	int PLAYERS_INRANGE;
	int PLAYERS_NEAR;
	int PNEAR_LOOP_COUNT;
	int RENDER_COUNT;
	string SEARCH_RAD;
	int SWORD_ATTACK;
	string TELE_ANG;
	string TELE_ANGS;
	string TELE_DEST;
	string TELE_ID1;
	string TELE_ID2;
	string TELE_ID3;
	string TELE_ID4;
	string TORNADO_ID;

	SorcChief1()
	{
		const float MIN_TELEPORT_DELAY = 15.0;
		const int NPC_BOSS_REGEN_RATE = 0;
		const float NPC_BOSS_RESTORATION = 0.3;
		const int NPC_USES_LIGHTS = 1;
		if (StringToLower(GetMapName()) == "lodagond-1")
		{
			NPC_GIVE_EXP = 10000;
			NPC_IS_BOSS = 1;
		}
		else
		{
			NPC_GIVE_EXP = 3000;
		}
		const string ANIM_WARCRY = "warcry";
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_FLINCH = "flinch";
		ANIM_ATTACK = "swordswing1_L";
		const string ANIM_SWIPE = "swordswing1_L";
		const string ANIM_SMASH = "battleaxe_swing1_L";
		const string ANIM_KICK = "kick";
		const string ANIM_PARRY = "shielddeflect1";
		ANIM_DEATH = "die_fallback";
		const string ANIM_HOP = "battleaxe_swing1_L";
		CAN_FLINCH = 1;
		const float ATTACK_HITCHANCE = 0.9;
		ATTACK_MOVERANGE = 32;
		MOVE_RANGE = 32;
		ATTACK_RANGE = 60;
		ATTACK_HITRANGE = 120;
		const string DMG_SLASH = RandomInt(100, 200);
		const string DMG_SMACK = RandomInt(25, 50);
		const string DMG_SMASH = RandomInt(150, 400);
		const string DMG_KICK = Random(25, 100);
		const int DMG_LBLAST = 100;
		const int DMG_LSTORM = 100;
		const int DUR_LSTORM = 30;
		const string FREQ_TORNADO = RandomInt(15, 30);
		const string FREQ_LSTORM = RandomInt(30, 45);
		const string FREQ_LBLAST = RandomInt(15, 30);
		const string FREQ_THROW = RandomInt(10, 30);
		const string FREQ_SPECIAL = RandomInt(10, 15);
		const string FREQ_TELEPORT = RandomInt(20, 140);
		const string FREQ_TELEPORT_FAST = RandomInt(20, 40);
		const float FREQ_KICK = 10.0;
		FREQ_LEAP = 5.0;
		const string SOUND_WARCRY = "monsters/troll/trollidle.wav";
		const string SOUND_STRUCK1 = "body/armour1.wav";
		const string SOUND_STRUCK2 = "body/armour2.wav";
		const string SOUND_STRUCK3 = "body/armour3.wav";
		const string SOUND_HIT = "voices/orc/hit.wav";
		const string SOUND_HIT2 = "voices/orc/hit2.wav";
		const string SOUND_HIT3 = "voices/orc/hit3.wav";
		const string SOUND_PAIN = "monsters/orc/pain.wav";
		const string SOUND_WARCRY1 = "monsters/orc/battlecry.wav";
		const string SOUND_ATTACK1 = "voices/orc/attack.wav";
		const string SOUND_ATTACK2 = "voices/orc/attack2.wav";
		const string SOUND_ATTACK3 = "voices/orc/attack3.wav";
		const string SOUND_DEATH = "voices/orc/die.wav";
		const string SOUND_HELP = "voices/orc/help.wav";
		const string SOUND_TELE = "magic/teleport.wav";
		const float VAMPIRE_RATIO = 0.1;
		Precache(SOUND_DEATH);
		Precache("weapons/magic/tornado.mdl");
		Precache("magic/vent1.wav");
		Precache("magic/vent2.wav");
		Precache("magic/vent3.wav");
		Precache("magic/gusts1.wav");
		Precache("magic/gusts2.wav");
		Precache("weather/Storm_exclamation.wav");
		Precache("magic/lightning_strike.wav");
		Precache("doors/aliendoor3.wav");
		Precache("magic/spawn.wav");
		Precache("zombie/claw_miss2.wav");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(8, 15));
		if (!(SUSPEND_AI))
		{
		}
		if (m_hAttackTarget != "unset")
		{
		}
		string LEAP_TYPE = RandomInt(1, 4);
		if (LEAP_TYPE < 4)
		{
			leap_at(m_hAttackTarget, "random");
		}
		if (LEAP_TYPE == 4)
		{
			leap_random();
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(1.1);
		if (STUCK_COUNT > 4)
		{
		}
		do_teleport("stuck_count");
	}

	void OnRepeatTimer_2()
	{
		SetRepeatDelay(20.0);
		if (GetGameTime() > MAX_AI_SUSPEND)
		{
			MAX_AI_SUSPEND = GetGameTime();
			MAX_AI_SUSPEND += 10.0;
			npcatk_resume_ai();
		}
		if (GetEntityRange(m_hAttackTarget) > 256)
		{
		}
		string LAST_TELE_DIFF = GetGameTime();
		LAST_TELE_DIFF -= LAST_TELE;
		if (LAST_TELE_DIFF > 5.0)
		{
		}
		string LAST_HIT_DIFF = GetGameTime();
		LAST_HIT_DIFF -= LAST_SWORD_HIT;
		if (LAST_HIT_DIFF > 20.0)
		{
		}
		do_teleport("stuck_count", "no_hits");
	}

	void OnSpawn() override
	{
		SetName("Runegahr , Shadahar Orc Chieftain");
		SetRace("orc");
		SetHealth(8000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("stun", 0.25);
		SetHearingSensitivity(10);
		SetModel("monsters/sorc.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 3);
		SetModelBody(2, 8);
		SetStat("parry", 150);
		SetWidth(32);
		SetHeight(96);
		SetRoam(true);
		SetSayTextRange(1024);
		SWORD_ATTACK = 0;
		JUMP_FWD_DIST = 250;
		CUR_SPECIAL = 0;
		ScheduleDelayedEvent(1.0, "get_teleporters");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if ((SWORD_ATTACK))
		{
			SWORD_ATTACK = 0;
			AddVelocity(param1, /* TODO: $relvel */ $relvel(-100, 130, 120));
			if (GetMonsterHP() < GetMonsterMaxHP())
			{
				string HP_TO_GIVE = param2;
				HP_TO_GIVE *= VAMPIRE_RATIO;
				HealEntity(GetOwner(), VAMPIRE_RATIO);
				Effect("glow", GetOwner(), Vector3(0, 255, 0), 96, 0.5, 0.5);
				EmitSound(GetOwner(), 0, "player/heartbeat_noloop.wav", 10);
			}
		}
	}

	void cycle_up()
	{
		if ((CYCLES_STARTED)) return;
		CYCLES_STARTED = 1;
		FREQ_SPECIAL("do_special");
		ScheduleDelayedEvent(60.0, "do_teleport");
		SetRoam(true);
		string L_MAP_NAME = StringToLower(GetMapName());
		if (L_MAP_NAME == "sorc_test")
		{
			int PLOT_MAP = 1;
		}
		if ((L_MAP_NAME).findFirst("lodagond") >= 0)
		{
			int PLOT_MAP = 1;
		}
		if (!(PLOT_MAP)) return;
		GetAllPlayers(PLAYER_LIST);
		FIRST_PLAYER = GetToken(PLAYER_LIST, 0, ";");
		if (GetEntityRace(FIRST_PLAYER) == "human")
		{
			string RACE_REMARK = "human";
			string RACE_PLURAL = "humans";
		}
		if (GetEntityRace(FIRST_PLAYER) == "elf")
		{
			string RACE_REMARK = "elf";
			string RACE_PLURAL = "elves";
		}
		if (GetEntityRace(FIRST_PLAYER) == "dwarf")
		{
			string RACE_REMARK = "dwarf";
			string RACE_PLURAL = "dwarves";
		}
		SetSayTextRange(2048);
		if (GetPlayerCount() == 1)
		{
			SayText("No! I will NOT be rescued by a lowly RACE_REMARK");
		}
		if (GetPlayerCount() > 1)
		{
			SayText("No! I will NOT be rescued by a couple of puny RACE_PLURAL");
		}
		EmitSound(GetOwner(), 0, SOUND_ATTACK2, 10);
	}

	void swing_axe()
	{
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			LAST_SWORD_HIT = GetGameTime();
		}
		sorc_yell();
		SWORD_ATTACK = 1;
		if (!(AM_UNARMED))
		{
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SMASH, ATTACK_HITCHANCE, "slash");
		}
		if ((AM_UNARMED))
		{
			SWORD_ATTACK = 0;
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SMACK, ATTACK_HITCHANCE, "blunt");
		}
		ANIM_ATTACK = ANIM_SWIPE;
		check_kick();
	}

	void swing_sword()
	{
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			LAST_SWORD_HIT = GetGameTime();
		}
		sorc_yell();
		if (!(AM_UNARMED))
		{
			SWORD_ATTACK = 1;
		}
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SLASH, ATTACK_HITCHANCE, "slash");
		if ((AM_UNARMED))
		{
			SWORD_ATTACK = 0;
			npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SMACK, ATTACK_HITCHANCE, "blunt");
		}
		if (RandomInt(1, 5) == 1)
		{
			ANIM_ATTACK = ANIM_SMASH;
		}
		check_kick();
	}

	void check_kick()
	{
		if ((KICK_DELAY)) return;
		if (!(AM_UNARMED))
		{
			if (RandomInt(1, 5) != 1)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ANIM_ATTACK = ANIM_KICK;
		KICK_DELAY = 1;
		if (!(AM_UNARMED))
		{
			FREQ_KICK("reset_kick_delay");
		}
		if ((AM_UNARMED))
		{
			ScheduleDelayedEvent(1.0, "reset_kick_delay");
		}
	}

	void kick_land()
	{
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)
		{
			LAST_SWORD_HIT = GetGameTime();
		}
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_KICK, ATTACK_HITCHANCE, "slash");
		ANIM_ATTACK = ANIM_SWIPE;
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		ApplyEffect(m_hAttackTarget, "effects/debuff_stun", Random(5, 10), GetEntityIndex(GetOwner()));
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(-100, 200, 150));
	}

	void reset_kick_delay()
	{
		KICK_DELAY = 0;
	}

	void sorc_yell()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDamage(int damage) override
	{
		if (GetMonsterHP() < HALF_HEALTH)
		{
			JUMP_FWD_DIST = 500;
			FREQ_LEAP = 0.1;
		}
		string HIT_BY = GetEntityIndex(param1);
		if (param2 > 30)
		{
			if (GetEntityRange(HIT_BY) < ATTACK_HITRANGE)
			{
			}
			if (RandomInt(1, 3) == 1)
			{
			}
			if (!(LEAP_DELAY))
			{
			}
			LEAP_DELAY = 1;
			FREQ_LEAP("leap_delay_reset");
			leap_away(HIT_BY);
		}
	}

	void leap_delay_reset()
	{
		LEAP_DELAY = 0;
	}

	void orc_hop()
	{
		EmitSound(GetOwner(), 0, "monsters/orc/attack1.wav", 10);
		if (GetMonsterHP() > HALF_HEALTH)
		{
			string JUMP_HEIGHT = RandomInt(350, 450);
		}
		if (GetMonsterHP() <= HALF_HEALTH)
		{
			string JUMP_HEIGHT = RandomInt(350, 950);
		}
		string L_JUMP_FWD_DIST = JUMP_FWD_DIST;
		string L_JUMP_HEIGHT = JUMP_HEIGHT;
		if ((DOUBLE_FOR))
		{
			DOUBLE_FOR = 0;
			L_JUMP_FWD_DIST *= 2;
		}
		if ((DOUBLE_UP))
		{
			DOUBLE_UP = 0;
			L_JUMP_HEIGHT *= 2;
		}
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, L_JUMP_FWD_DIST, L_JUMP_HEIGHT));
	}

	void leap_away()
	{
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(1.0);
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "do_leap");
	}

	void leap_random()
	{
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(1.0);
		string RND_ROT = RandomInt(0, 359);
		string LEAP_DEST = GetMonsterProperty("origin");
		LEAP_DEST += /* TODO: $relpos */ $relpos(Vector3(0, RND_ROT, 0), Vector3(0, 400, 0));
		SetMoveDest(LEAP_DEST);
		ScheduleDelayedEvent(0.1, "do_leap");
	}

	void leap_at()
	{
		if ((AM_LEAPING)) return;
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		if ((IsEntityAlive(m_hAttackTarget)))
		{
			string TARGET_ORG = GetEntityOrigin(m_hAttackTarget);
			string TARGET_Z = (TARGET_ORG).z;
			string MY_Z = GetMonsterProperty("origin.z");
			if (TARGET_Z > MY_Z)
			{
				string V_DEST = GetMonsterProperty("origin");
				V_DEST = "z";
				if (Distance(GetMonsterProperty("origin"), V_DEST) > 96)
				{
				}
				DOUBLE_UP = 1;
			}
			if (GetEntityProperty(m_hAttackTarget, "range2d") > 1600)
			{
				DOUBLE_FOR = 1;
			}
		}
		npcatk_suspend_ai(1.0);
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "do_leap");
	}

	void do_leap()
	{
		// PlayRandomSound from: SOUND_HIT, SOUND_HIT2, SOUND_HIT3
		array<string> sounds = {SOUND_HIT, SOUND_HIT2, SOUND_HIT3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		PlayAnim("critical", ANIM_HOP);
		ScheduleDelayedEvent(0.1, "orc_hop");
		ScheduleDelayedEvent(1.0, "reset_leaping");
	}

	void reset_leaping()
	{
		AM_LEAPING = 0;
	}

	void do_lstorm()
	{
		CAN_FLINCH = 0;
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_WARCRY);
		EmitSound(GetOwner(), 0, SOUND_WARCRY, 10);
		npcatk_suspend_ai(2.0);
		LSTORM_TARGS = "placeholder";
		GetAllPlayers(LSTORM_TARGS);
		string N_LSTORM_TARGS = GetTokenCount(LSTORM_TARGS, ";");
		N_STORMS = 0;
		LOC_LSTORM1 = 0;
		LOC_LSTORM2 = 0;
		LSTORM_LOOPCOUNT = 0;
		if (N_LSTORM_TARGS > 0)
		{
			for (int i = 0; i < N_LSTORM_TARGS; i++)
			{
				do_lstorm_loop();
			}
		}
		if (!(N_STORMS > 0)) return;
		ScheduleDelayedEvent(0.1, "do_lstorm2");
		if (N_STORMS > 1)
		{
			ScheduleDelayedEvent(0.5, "do_lstorm3");
		}
	}

	void do_lstorm2()
	{
		SpawnNPC("monsters/summon/summon_lightning_storm", LOC_LSTORM1, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"), DMG_LSTORM, DUR_LSTORM
		ID_LSTORM1 = GetEntityIndex(m_hLastCreated);
	}

	void do_lstorm3()
	{
		SpawnNPC("monsters/summon/summon_lightning_storm", LOC_LSTORM2, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityProperty(GetOwner(), "angles.y"), DMG_LSTORM, DUR_LSTORM
		ID_LSTORM2 = GetEntityIndex(m_hLastCreated);
	}

	void do_lstorm_loop()
	{
		string CUR_PLAYER = GetToken(LSTORM_TARGS, LSTORM_LOOPCOUNT, ";");
		LSTORM_LOOPCOUNT += 1;
		if (GetEntityRange(CUR_PLAYER) < 1024)
		{
			if (N_STORMS < 2)
			{
			}
			N_STORMS += 1;
			string TARG_ORG = GetEntityOrigin(CUR_PLAYER);
			if (N_STORMS == 2)
			{
				if (Distance(TARG_ORG, LOC_LSTORM1) < 256)
				{
				}
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			string STORM_GRNDPOS = /* TODO: $get_ground_height */ $get_ground_height(TARG_ORG);
			TARG_ORG = "z";
			if (N_STORMS == 1)
			{
				LOC_LSTORM1 = TARG_ORG;
			}
			if (N_STORMS == 2)
			{
				LOC_LSTORM2 = TARG_ORG;
			}
		}
	}

	void warcry_done()
	{
		CAN_FLINCH = 1;
		if ((SUSPEND_AI))
		{
			npcatk_resume_ai();
		}
	}

	void OnParry(CBaseEntity@ attacker) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if ((SUSPEND_AI)) return;
		if (RandomInt(1, 3) == 1)
		{
			PlayAnim("critical", "shielddeflect1");
		}
	}

	void get_teleporters()
	{
		N_TELES = 0;
		TELE_ID1 = FindEntityByName("sorc_telepoint1");
		TELE_ID2 = FindEntityByName("sorc_telepoint2");
		TELE_ID3 = FindEntityByName("sorc_telepoint3");
		TELE_ID4 = FindEntityByName("sorc_telepoint4");
		if (((TELE_ID1 !is null)))
		{
			N_TELES += 1;
		}
		if (((TELE_ID2 !is null)))
		{
			N_TELES += 1;
		}
		if (((TELE_ID3 !is null)))
		{
			N_TELES += 1;
		}
		if (((TELE_ID4 !is null)))
		{
			N_TELES += 1;
		}
	}

	void do_teleport()
	{
		if (!(N_TELES > 0)) return;
		if (param1 != "stuck_count")
		{
			if (GetMonsterHP() > HALF_HEALTH)
			{
				int TELEPORT_FAST = 0;
			}
			if (GetMonsterHP() <= HALF_HEALTH)
			{
				int TELEPORT_FAST = 1;
			}
			if (!(TELEPORT_FAST))
			{
				FREQ_TELEPORT("do_teleport");
			}
			if ((TELEPORT_FAST))
			{
				FREQ_TELEPORT_FAST("do_teleport");
			}
		}
		string LAST_TELE_DIFF = GetGameTime();
		LAST_TELE_DIFF -= LAST_TELE;
		if (!(LAST_TELE_DIFF > MIN_TELEPORT_DELAY)) return;
		LogDebug("game.time secs: do_teleport PARAM1 PARAM2");
		LAST_TELE = GetGameTime();
		string TOTAL_TELES = N_TELES;
		TOTAL_TELES += 1;
		string PICK_TELE = RandomInt(1, TOTAL_TELES);
		if (param2 == "no_hits")
		{
			if ((G_DEVELOPER_MODE))
			{
				SendInfoMessageToAll("green no_hits teleport");
			}
			GetAllPlayers(PLAYER_LIST);
			ScrambleTokens(PLAYER_LIST, ";");
			FOUND_NEAR_TARGET = 0;
			SEARCH_RAD = 512;
			for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
			{
				find_near_teleporter();
			}
			if (FOUND_NEAR_TARGET > 0)
			{
				npcatk_settarget(NEW_TARGET);
				if ((G_DEVELOPER_MODE))
				{
					SendInfoMessageToAll("green SORC_CHIEF: found GetEntityName(NEW_TARGET) near FOUND_NEAR_TARGET");
				}
				string PICK_TELE = FOUND_NEAR_TARGET;
			}
		}
		if (PICK_TELE == 1)
		{
			TELE_DEST = GetEntityOrigin(TELE_ID1);
			TELE_ANG = GetEntityAngles(TELE_ID1);
			CallExternal(TELE_ID1, "tele_used");
		}
		if (PICK_TELE == 2)
		{
			TELE_DEST = GetEntityOrigin(TELE_ID2);
			TELE_ANG = GetEntityAngles(TELE_ID2);
			CallExternal(TELE_ID2, "tele_used");
		}
		if (PICK_TELE == 3)
		{
			TELE_DEST = GetEntityOrigin(TELE_ID3);
			TELE_ANG = GetEntityAngles(TELE_ID3);
			CallExternal(TELE_ID3, "tele_used");
		}
		if (PICK_TELE == 4)
		{
			TELE_DEST = GetEntityOrigin(TELE_ID4);
			TELE_ANG = GetEntityAngles(TELE_ID4);
			CallExternal(TELE_ID4, "tele_used");
		}
		if (PICK_TELE > N_TELES)
		{
			TELE_DEST = NPC_SPAWN_LOC;
			TELE_DEST += "z";
			TELE_ANGS = NPC_SPAWN_ANGLES;
		}
		SpawnNPC("monsters/summon/ibarrier", TELE_DEST, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 64, 2, 0, 0, 0, 1
		leap_tele();
	}

	void find_near_teleporter()
	{
		string CUR_PLAYER = GetToken(PLAYER_LIST, i, ";");
		string PLAYER_ORG = GetEntityOrigin(CUR_PLAYER);
		if (!(FOUND_NEAR_TARGET == 0)) return;
		if (!(N_TELES >= 1)) return;
		string TEST_TELE = GetEntityOrigin(TELE_ID1);
		TEST_TELE = "z";
		string TELE_DIST = Distance(PLAYER_ORG, TEST_TELE);
		if (TELE_DIST < SEARCH_RAD)
		{
			FOUND_NEAR_TARGET = 1;
			NEW_TARGET = CUR_PLAYER;
		}
		if (!(N_TELES >= 2)) return;
		string TEST_TELE = GetEntityOrigin(TELE_ID2);
		TEST_TELE = "z";
		string OLD_TELE_DIST = TELE_DIST;
		string TELE_DIST = Distance(PLAYER_ORG, TEST_TELE);
		if (TELE_DIST < SEARCH_RAD)
		{
			if (OLD_TELE_DIST > TELE_DIST)
			{
			}
			FOUND_NEAR_TARGET = 2;
			NEW_TARGET = CUR_PLAYER;
		}
		if (!(N_TELES >= 3)) return;
		string TEST_TELE = GetEntityOrigin(TELE_ID3);
		TEST_TELE = "z";
		string OLD_TELE_DIST = TELE_DIST;
		string TELE_DIST = Distance(PLAYER_ORG, TEST_TELE);
		if (TELE_DIST < SEARCH_RAD)
		{
			if (OLD_TELE_DIST > TELE_DIST)
			{
			}
			FOUND_NEAR_TARGET = 3;
			NEW_TARGET = CUR_PLAYER;
		}
		if (!(N_TELES >= 4)) return;
		string TEST_TELE = GetEntityOrigin(TELE_ID4);
		TEST_TELE = "z";
		string OLD_TELE_DIST = TELE_DIST;
		string TELE_DIST = Distance(PLAYER_ORG, TEST_TELE);
		if (TELE_DIST < SEARCH_RAD)
		{
			if (OLD_TELE_DIST > TELE_DIST)
			{
			}
			FOUND_NEAR_TARGET = 4;
			NEW_TARGET = CUR_PLAYER;
		}
		string TEST_TELE = NPC_SPAWN_LOC;
		TEST_TELE = "z";
		string OLD_TELE_DIST = TELE_DIST;
		string TELE_DIST = Distance(PLAYER_ORG, TEST_TELE);
		if (TELE_DIST < SEARCH_RAD)
		{
			if (OLD_TELE_DIST > TELE_DIST)
			{
			}
			FOUND_NEAR_TARGET = 5;
			NEW_TARGET = CUR_PLAYER;
		}
	}

	void leap_tele()
	{
		AM_LEAPING = 1;
		NPC_FORCED_MOVEDEST = 1;
		npcatk_suspend_ai(1.0);
		SetMoveDest(/* TODO: $relpos */ $relpos(0, 1000, 0));
		ScheduleDelayedEvent(0.1, "do_leap");
		RENDER_COUNT = 255;
		ScheduleDelayedEvent(0.25, "flicker_out");
		ScheduleDelayedEvent(0.75, "tele_out");
		ScheduleDelayedEvent(1.0, "tele_in");
	}

	void flicker_out()
	{
		RENDER_COUNT -= 50;
		if (!(RENDER_COUNT > 0)) return;
		ScheduleDelayedEvent(0.1, "flicker_out");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", RENDER_COUNT);
	}

	void tele_out()
	{
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		SetEntityOrigin(GetOwner(), Vector3(-20000, 10000, -20000));
	}

	void tele_in()
	{
		SetEntityOrigin(GetOwner(), TELE_DEST);
		SetAngles("face");
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		RENDER_COUNT = 0;
		flicker_in();
		LAST_TELE = GetGameTime();
	}

	void flicker_in()
	{
		RENDER_COUNT += 50;
		if (RENDER_COUNT >= 255)
		{
			SetProp(GetOwner(), "rendermode", 0);
			SetProp(GetOwner(), "renderamt", 255);
		}
		if (!(RENDER_COUNT < 255)) return;
		ScheduleDelayedEvent(0.1, "flicker_in");
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", RENDER_COUNT);
	}

	void OnPostSpawn() override
	{
		HALF_HEALTH = GetMonsterMaxHP();
		HALF_HEALTH /= 2;
		string L_MAP_NAME = StringToLower(GetMapName());
		if (!(L_MAP_NAME == "lodagond-1")) return;
		ON_LODAGOND = 1;
	}

	void do_tornado()
	{
		PlayAnim("critical", ANIM_SWIPE);
		SpawnNPC("monsters/summon/tornado", /* TODO: $relpos */ $relpos(0, 72, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 200, 20.0
		TORNADO_ID = m_hLastCreated;
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if ((ATTACK_PARRY))
		{
			SetDamage("hit");
			SetDamage("dmg");
		}
	}

	void do_throw()
	{
		if ((AM_UNARMED)) return;
		PLAYERS_NEAR = 0;
		PLAYERS_INRANGE = 0;
		GetAllPlayers(SORC_LPLAYERS);
		PNEAR_LOOP_COUNT = 0;
		for (int i = 0; i < GetTokenCount(SORC_LPLAYERS, ";"); i++)
		{
			any_players_near();
		}
		if ((PLAYERS_NEAR)) return;
		if (!(PLAYERS_INRANGE)) return;
		do_throw2();
	}

	void do_throw2()
	{
		SetModelBody(2, 0);
		AM_UNARMED = 1;
		PlayAnim("critical", ANIM_SWIPE);
		SpawnNPC("monsters/summon/blood_drinker", /* TODO: $relpos */ $relpos(0, 48, 48), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), GetEntityIndex(m_hLastStruck), 100, 30.0
		BLOOD_DRINKER_ID = m_hLastCreated;
	}

	void any_players_near()
	{
		string CUR_PLAYER = GetToken(SORC_LPLAYERS, PNEAR_LOOP_COUNT, ";");
		if (GetEntityRange(CUR_PLAYER) < ATTACK_RANGE)
		{
			PLAYERS_NEAR = 1;
		}
		if (GetEntityRange(CUR_PLAYER) < 2048)
		{
			PLAYERS_INRANGE = 1;
		}
		PNEAR_LOOP_COUNT += 1;
	}

	void do_special()
	{
		string NEXT_TRY = FREQ_SPECIAL;
		if ((SUSPEND_AI))
		{
			float NEXT_TRY = 5.0;
			int ABORT_SPECIAL = 1;
		}
		NEXT_TRY("do_special");
		if ((ABORT_SPECIAL)) return;
		CUR_SPECIAL += 1;
		if (CUR_SPECIAL > 3)
		{
			CUR_SPECIAL = 1;
		}
		if (CUR_SPECIAL == 1)
		{
			do_tornado();
		}
		if (CUR_SPECIAL == 2)
		{
			do_lstorm();
		}
		if (CUR_SPECIAL == 3)
		{
			do_throw();
		}
	}

	void sword_return()
	{
		SetModelBody(2, 8);
		AM_UNARMED = 0;
	}

	void do_nadda()
	{
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		UseTrigger("sorc_defeat");
		if (((BLOOD_DRINKER_ID !is null)))
		{
			CallExternal(BLOOD_DRINKER_ID, "ext_remove");
		}
		if (((TORNADO_ID !is null)))
		{
			DeleteEntity(TORNADO_ID);
		}
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
		SpawnNPC("lodagond/sorc_image_defeat", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityProperty(GetOwner(), "angles.yaw")
	}

	void OnSuspendAI()
	{
		MAX_AI_SUSPEND = GetGameTime();
		MAX_AI_SUSPEND += 10.0;
	}

}

}
