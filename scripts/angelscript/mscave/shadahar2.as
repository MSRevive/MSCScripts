#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Shadahar2 : CGameScript
{
	int AM_MOBILE;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_MOVE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	string ATTACK_PUSH;
	int ATTACK_RANGE;
	int BEAM_COUNT;
	string BEAM_EYE1;
	string BEAM_EYE2;
	int CIRCLES_ON;
	int CIRC_PLAYER_IDX;
	int CUR_TELE_POINT;
	string CUR_TRIG;
	string DID_ORC_COMMENT;
	string DID_WARCRY;
	int DOING_SPECIAL;
	int EYE_BEAM_WARMUP;
	int IS_UNHOLY;
	string LAST_RETURN_TIME;
	int MAX_EYES;
	int MOVE_RANGE;
	string MY_CL_IDX;
	string MY_TELE_POINTS;
	string MY_TRIGGERS;
	string MY_YAW;
	int NO_STUCK_CHECKS;
	string NPC_GIVE_EXP;
	int NPC_IS_BOSS;
	string N_CIRC_PLAYERS;
	string N_TELE_POINTS;
	string PLAYER_ORGS;
	int SET_TELE_POINTS;
	string STARTED_CYCLES;
	string STAY_NEAR_HOME;
	int STUN_ATTACK;
	string SUMMON_POS;
	int SUMMON_WARMUP;
	int SWIPE_ATTACK;
	int TELEPORT_SEQUENCE;

	Shadahar2()
	{
		NPC_IS_BOSS = 1;
		ANIM_IDLE = "idle1";
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_ATTACK = "attack1";
		ANIM_DEATH = "dieheadshot";
		MOVE_RANGE = 32;
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 127;
		IS_UNHOLY = 1;
		NO_STUCK_CHECKS = 1;
		const string ANIM_SWIPE = "attack1";
		const string ANIM_SMASH = "attack3";
		const string ANIM_CAST = "castspell";
		ANIM_MOVE = "walk";
		ATTACK_HITCHANCE = 70;
		const string DMG_SWIPE = RandomInt(100, 150);
		const string DMG_SMASH = RandomInt(75, 100);
		const string DMG_FIRE_BOLT = RandomInt(50, 100);
		const int ATTACH_IDX_WAND = 0;
		const int ATTACH_IDX_EYE1 = 1;
		const int ATTACH_IDX_EYE2 = 2;
		const int DMG_BEAM = 300;
		const int WAND_UNLIT = 8;
		const int WAND_LIT = 9;
		const string SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_STRUCK2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_STRUCK3 = "weapons/cbar_hitbod3.wav";
		const string SOUND_STRUCK4 = "zombie/zo_pain2.wav";
		const string SOUND_STRUCK5 = "zombie/zo_pain2.wav";
		const string SOUND_ATTACK1 = "zombie/claw_miss1.wav";
		const string SOUND_ATTACK2 = "zombie/claw_miss2.wav";
		const string SOUND_DEATH = "zombie/zo_pain1.wav";
		const string SOUND_STUN = "debris/glass2.wav";
		const string SOUND_BEAM_FIRE = "debris/beamstart1.wav";
		const string SOUND_TURNED1 = "ambience/the_horror1.wav";
		const string SOUND_TURNED2 = "ambience/the_horror2.wav";
		const string SOUND_TURNED3 = "ambience/the_horror3.wav";
		const string SOUND_TURNED4 = "ambience/the_horror4.wav";
		const string SOUND_HOLY_STRIKE = "doors/aliendoor1.wav";
		const string SOUND_LAUGH = "monsters/skeleton/cal_laugh.wav";
		const string SOUND_WARCRY = "monsters/skeleton/calrain3.wav";
		const string FREQ_SPECIAL = Random(10, 15);
		Precache("bonegibs.mdl");
	}

	void game_precache()
	{
		Precache("monsters/summon/circle_of_death");
		Precache("monsters/eye_drainer");
	}

	void OnSpawn() override
	{
		if (StringToLower(GetMapName()) == "mscave")
		{
			NPC_GIVE_EXP = 10000;
		}
		else
		{
			DeleteEntity(GetOwner());
		}
		if ((G_SHAD_PRESENT))
		{
			DeleteEntity(GetOwner());
		}
		SetName("Remains of Shadahar");
		SetModel("monsters/skeleton_enraged.mdl");
		SetModelBody(0, 6);
		SetModelBody(1, WAND_UNLIT);
		SetWidth(32);
		SetHeight(80);
		if (!(true)) return;
		SetRace("undead");
		SetHealth(6000);
		SetRoam(true);
		SetHearingSensitivity(4);
		SetNoPush(true);
		SetDamageResistance("all", ".7");
		SetDamageResistance("slash", ".7");
		SetDamageResistance("pierce", ".5");
		SetDamageResistance("blunt", 1.2);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("cold", 0.1);
		SetDamageResistance("poison", 0.0);
		SetSayTextRange(1024);
		string MY_SKY = GetMonsterProperty("origin");
		MY_SKY += Vector3(0, 0, 4096);
		string MY_CENTER = GetEntityOrigin(GetOwner());
		MY_CENTER += Vector3(0, 0, -48);
		ClientEvent("new", "all_in_sight", "effects/sfx_lightning", MY_CENTER, MY_SKY, 1, 1);
		SetGlobalVar("G_SHAD_PRESENT", 1);
		MAX_EYES = 2;
		if (GetPlayerCount() >= 4)
		{
			MAX_EYES = 4;
		}
		ScheduleDelayedEvent(0.1, "init_beam1");
	}

	void init_beam1()
	{
		Effect("beam", "vector", "laserbeam.spr", 30, GetEntityProperty(GetOwner(), "attachpos"), GetEntityOrigin(GetOwner()), Vector3(255, 0, 255), 0, 10, -1);
		BEAM_EYE1 = GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(1.0, "init_beam2");
	}

	void init_beam2()
	{
		Effect("beam", "vector", "laserbeam.spr", 30, GetEntityProperty(GetOwner(), "attachpos"), GetEntityOrigin(GetOwner()), Vector3(255, 0, 255), 0, 10, -1);
		BEAM_EYE2 = GetEntityIndex(m_hLastCreated);
	}

	void attack_1()
	{
		ATTACK_PUSH = /* TODO: $relvel */ $relvel(-100, 130, 120);
		SWIPE_ATTACK = 1;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 5);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWIPE, ATTACK_HITCHANCE, "slash");
		if (!(RandomInt(1, 30) == 1)) return;
		ANIM_ATTACK = ANIM_SMASH;
	}

	void attack_3()
	{
		STUN_ATTACK = 1;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
		EmitSound(GetOwner(), 1, sounds[RandomInt(0, sounds.length() - 1)], 5);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWIPE, ATTACK_HITCHANCE, "slash");
		ANIM_ATTACK = ANIM_SWIPE;
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if ((SWIPE_ATTACK))
			{
				AddVelocity(m_hLastStruckByMe, ATTACK_PUSH);
			}
			SWIPE_ATTACK = 0;
			if ((STUN_ATTACK))
			{
			}
			EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
			ApplyEffect(param2, "effects/debuff_stun", Random(5, 10), GetEntityIndex(GetOwner()));
		}
		STUN_ATTACK = 0;
	}

	void OnPostSpawn() override
	{
		SetGlobalVar("global.map.weather", "fog_black;fog_black;flog_black");
		SetGlobalVar("G_WEATHER_LOCK", "fog_black");
		CallExternal("players", "ext_weather_change", G_WEATHER_LOCK);
		ScheduleDelayedEvent(8.0, "get_tele_points");
		CallExternal("all", "bo_zombie_mode");
		ClientEvent("new", "all", "mscave/shadahar_cl");
		MY_CL_IDX = "game.script.last_sent_id";
	}

	void get_tele_points()
	{
		MY_TELE_POINTS = GetEntityProperty(GAME_MASTER, "scriptvar");
		MY_TRIGGERS = GetEntityProperty(GAME_MASTER, "scriptvar");
		if (MY_TELE_POINTS.length() > 0) MY_TELE_POINTS += ";";
		MY_TELE_POINTS += NPC_HOME_LOC;
		if (MY_TRIGGERS.length() > 0) MY_TRIGGERS += ";";
		MY_TRIGGERS += "none";
		N_TELE_POINTS = GetTokenCount(MY_TELE_POINTS, ";");
		N_TELE_POINTS -= 1;
		CUR_TELE_POINT = -1;
		SET_TELE_POINTS = 1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		Effect("beam", "update", BEAM_EYE1, "brightness", 0);
		Effect("beam", "update", BEAM_EYE2, "brightness", 0);
		Effect("beam", "update", BEAM_EYE1, "remove", 0.1);
		Effect("beam", "update", BEAM_EYE2, "remove", 0.1);
		UseTrigger("door_palace");
		ClientEvent("remove", "all", MY_CL_IDX);
		bm_gold_spew(500, 1, 32, 2, 4);
		SetGlobalVar("G_WEATHER_LOCK", 0);
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (!(DID_WARCRY))
		{
			DID_WARCRY = 1;
			EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
		}
		if (!(STARTED_CYCLES))
		{
			STARTED_CYCLES = 1;
			FREQ_SPECIAL("do_special");
		}
	}

	void OnDamage(int damage) override
	{
		if ((TELEPORT_SEQUENCE)) return;
		if (CUR_TELE_POINT < N_TELE_POINTS)
		{
			if (GetEntityHealth(GetOwner()) <= 3000)
			{
			}
			teleport_next_point();
		}
		if ((TELEPORT_SEQUENCE))
		{
			SetDamage("dmg");
			SetDamage("hit");
			return;
		}
		if ((TELEPORT_SEQUENCE)) return;
		if (param3 != "holy")
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK4, SOUND_STRUCK5};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			// PlayRandomSound from: SOUND_HOLY_STRIKE
			array<string> sounds = {SOUND_HOLY_STRIKE};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
	}

	void teleport_next_point()
	{
		TELEPORT_SEQUENCE = 1;
		if (CUR_TELE_POINT == -1)
		{
			SayText("Let s see just how well you know these caves...");
		}
		if (CUR_TELE_POINT == 0)
		{
			SayText("Time for more hide and seek...");
		}
		if (CUR_TELE_POINT == 1)
		{
			SayText("You seem to know these caves pretty well.");
		}
		if (CUR_TELE_POINT == 2)
		{
			SayText("I m sure you can find me again...");
		}
		if (CUR_TELE_POINT == 3)
		{
			SayText("My my , such a persistant seeker.");
		}
		if (CUR_TELE_POINT == 4)
		{
			SayText("Such fun! But can you find me again?");
		}
		if (CUR_TELE_POINT == 5)
		{
			SayText("Come find me on the bridge of fire...");
		}
		if (CUR_TELE_POINT == 6)
		{
			SayText("My defeat shall not come about so easily as this...");
		}
		EmitSound(GetOwner(), 0, "ambience/particle_suck2.wav", 10);
		npcatk_clear_targets();
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_CAST);
		SetIdleAnim(ANIM_CAST);
		SetMoveAnim(ANIM_CAST);
		Effect("screenfade", "all", 2, 1, Vector3(255, 255, 255), 255, "fadeout");
		ScheduleDelayedEvent(2.0, "teleport_fx_fadein");
		CUR_TELE_POINT += 1;
		SetAnimFrameRate(0.5);
		SetGravity(0);
		ScheduleDelayedEvent(0.01, "float_up");
		ScheduleDelayedEvent(2.01, "teleport_next_point2");
	}

	void teleport_fx_fadein()
	{
		Effect("screenfade", "all", 2, 1, Vector3(255, 255, 255), 255, "fadein");
	}

	void float_up()
	{
		if (!(TELEPORT_SEQUENCE)) return;
		ScheduleDelayedEvent(0.1, "float_up");
		string CUR_POS = GetEntityOrigin(GetOwner());
		CUR_POS += "z";
		SetEntityOrigin(GetOwner(), CUR_POS);
	}

	void teleport_next_point2()
	{
		EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
		SetAnimFrameRate(1);
		TELEPORT_SEQUENCE = 0;
		SetEntityOrigin(GetOwner(), GetToken(MY_TELE_POINTS, CUR_TELE_POINT, ";"));
		SetHealth(6000);
		SetBlind(false);
		npcatk_resume_ai();
		npcatk_clear_targets();
		SetGravity(1);
		stay_still();
		CUR_TRIG = GetToken(MY_TRIGGERS, CUR_TELE_POINT, ";");
		UseTrigger(CUR_TRIG);
		if (CUR_TRIG == "spawn_firereaver")
		{
			do_fireballs();
			ANIM_WALK = "idle1";
			ANIM_RUN = "idle1";
			stay_still();
			SetGlobalVar("global.map.weather", "fog_red;fog_red;fog_red");
			SetGlobalVar("G_WEATHER_LOCK", "fog_red");
			CallExternal("players", "ext_weather_change", G_WEATHER_LOCK);
		}
		if (CUR_TELE_POINT == N_TELE_POINTS)
		{
			STAY_NEAR_HOME = 1;
			ANIM_MOVE = "run";
			ANIM_RUN = ANIM_MOVE;
			ANIM_WALK = "walk";
			SetGlobalVar("global.map.weather", "clear;clear;clear");
			SetGlobalVar("G_WEATHER_LOCK", 0);
			CallExternal("players", "ext_weather_change", "clear");
		}
	}

	void do_special()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		FREQ_SPECIAL("do_special");
		if ((DOING_SPECIAL)) return;
		if ((TELEPORT_SEQUENCE)) return;
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		string PICK_SPECIAL = RandomInt(1, 2);
		if (N_EYES < MAX_EYES)
		{
			string PICK_SPECIAL = RandomInt(1, 3);
		}
		if (PICK_SPECIAL == 1)
		{
			do_circles();
		}
		if (PICK_SPECIAL == 2)
		{
			do_eyebeams();
		}
		if (PICK_SPECIAL == 3)
		{
			do_summon_eye();
		}
	}

	void do_circles()
	{
		DOING_SPECIAL = 1;
		EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
		PlayAnim("critical", ANIM_CAST);
		GetAllPlayers(PLAYER_LIST);
		N_CIRC_PLAYERS = GetTokenCount(PLAYER_LIST, ";");
		PLAYER_ORGS = "";
		for (int i = 0; i < N_CIRC_PLAYERS; i++)
		{
			ids_to_pos();
		}
		N_CIRC_PLAYERS -= 1;
		CIRCLES_ON = 0;
		wand_sparkles();
		ScheduleDelayedEvent(1.0, "do_circles2");
	}

	void wand_sparkles()
	{
		if ((CIRCLES_ON)) return;
		ScheduleDelayedEvent(0.1, "wand_sparkles");
		ClientEvent("update", "all", MY_CL_IDX, "wand_prep_cl", GetEntityProperty(GetOwner(), "attachpos"), Vector3(255, 0, 0));
	}

	void do_circles2()
	{
		CIRCLES_ON = 1;
		CIRC_PLAYER_IDX = 0;
		DOING_SPECIAL = 0;
		seal_players();
	}

	void ids_to_pos()
	{
		string CUR_PLAYER = GetToken(PLAYER_LIST, i, ";");
		string CUR_PLAYER_ORG = GetEntityOrigin(CUR_PLAYER);
		if (PLAYER_ORGS.length() > 0) PLAYER_ORGS += ";";
		PLAYER_ORGS += CUR_PLAYER_ORG;
	}

	void seal_players()
	{
		string CUR_PLAYER_ORG = GetToken(PLAYER_ORGS, CIRC_PLAYER_IDX, ";");
		if (Distance(GetMonsterProperty("origin"), PLAYER_ORGS) < 800)
		{
			SpawnNPC("monsters/summon/circle_of_death", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 100, 100, 10.0
		}
		if (!(CIRC_PLAYER_IDX < N_CIRC_PLAYERS)) return;
		CIRC_PLAYER_IDX += 1;
		ScheduleDelayedEvent(0.1, "seal_players");
	}

	void do_eyebeams()
	{
		DOING_SPECIAL = 1;
		PlayAnim("critical", ANIM_CAST);
		SetMoveDest("none");
		npcatk_suspend_ai();
		SetIdleAnim(ANIM_CAST);
		SetMoveAnim(ANIM_CAST);
		NO_STUCK_CHECKS = 1;
		SetBlind(true);
		SetRoam(false);
		EYE_BEAM_WARMUP = 1;
		MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		eye_warmup_loop();
		ScheduleDelayedEvent(2.0, "do_eyebeams2");
	}

	void eye_warmup_loop()
	{
		if (!(EYE_BEAM_WARMUP)) return;
		ScheduleDelayedEvent(0.1, "eye_warmup_loop");
		MY_YAW -= 1;
		if (MY_YAW < 0)
		{
			float MY_YAW = 359.99;
		}
		SetAngles("face");
		ClientEvent("update", "all", MY_CL_IDX, "eye_beam_prep_cl", GetEntityProperty(GetOwner(), "attachpos"), GetEntityProperty(GetOwner(), "attachpos"));
	}

	void do_eyebeams2()
	{
		EYE_BEAM_WARMUP = 0;
		EmitSound(GetOwner(), 0, SOUND_BEAM_FIRE, 10);
		// svplaysound: svplaysound 1 10 ambience/zapmachine.wav
		EmitSound(1, 10, "ambience/zapmachine.wav");
		Effect("beam", "update", BEAM_EYE1, "brightness", 128);
		Effect("beam", "update", BEAM_EYE2, "brightness", 128);
		SetAnimFrameRate(0);
		BEAM_COUNT = 0;
		MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		ScheduleDelayedEvent(0.1, "do_eyebeam_cycle");
	}

	void do_eyebeam_cycle()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		MY_YAW += 1;
		if (MY_YAW > 359.99)
		{
			MY_YAW -= 359.99;
		}
		SetAngles("face");
		LogDebug("do_eyebeam_cycle MY_YAW");
		string BEAM1_START = GetEntityProperty(GetOwner(), "attachpos");
		string BEAM2_START = GetEntityProperty(GetOwner(), "attachpos");
		string BEAM1_END = BEAM1_START;
		string BEAM2_END = BEAM2_START;
		BEAM1_END += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 1000, -200));
		BEAM2_END += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 1000, -200));
		string BEAM1_END = TraceLine(BEAM1_START, BEAM1_END);
		string BEAM2_END = TraceLine(BEAM2_START, BEAM2_END);
		Effect("beam", "update", BEAM_EYE1, "points", BEAM1_START, BEAM1_END);
		Effect("beam", "update", BEAM_EYE2, "points", BEAM2_START, BEAM2_END);
		XDoDamage(BEAM1_START, BEAM1_END, DMG_BEAM, 1.0, GetOwner(), GetOwner(), "none", "dark");
		XDoDamage(BEAM2_START, BEAM2_END, DMG_BEAM, 1.0, GetOwner(), GetOwner(), "none", "dark");
		BEAM_COUNT += 1;
		if ((TELEPORT_SEQUENCE))
		{
			BEAM_COUNT = 120;
		}
		if (BEAM_COUNT == 120)
		{
			do_eyebeam_end();
		}
		else
		{
			ScheduleDelayedEvent(0.1, "do_eyebeam_cycle");
		}
	}

	void do_eyebeam_end()
	{
		if (!(TELEPORT_SEQUENCE))
		{
			SetIdleAnim(ANIM_IDLE);
			SetMoveAnim(ANIM_MOVE);
		}
		if ((AM_MOBILE))
		{
			SetRoam(true);
		}
		SetAnimFrameRate(1.0);
		// svplaysound: svplaysound 1 0 ambience/zapmachine.wav
		EmitSound(1, 0, "ambience/zapmachine.wav");
		npcatk_resume_ai();
		Effect("beam", "update", BEAM_EYE1, "brightness", 0);
		Effect("beam", "update", BEAM_EYE2, "brightness", 0);
		DOING_SPECIAL = 0;
		if ((TELEPORT_SEQUENCE))
		{
			PlayAnim("critical", ANIM_CAST);
			SetIdleAnim(ANIM_CAST);
			SetMoveAnim(ANIM_CAST);
		}
	}

	void do_summon_eye()
	{
		npcatk_suspend_ai();
		PlayAnim("critical", ANIM_CAST);
		EmitSound(GetOwner(), 0, SOUND_LAUGH, 10);
		SetModelBody(1, WAND_LIT);
		string RND_ANG = Random(0, 359);
		string SUMMON_ADJ = /* TODO: $relpos */ $relpos(Vector3(0, RND_ANG, 0), Vector3(0, 64, 32));
		SUMMON_POS = GetMonsterProperty("origin");
		SUMMON_POS += SUMMON_ADJ;
		string BEAM_TOP = SUMMON_POS;
		string BEAM_BOTTOM = SUMMON_POS;
		BEAM_BOTTOM = "z";
		BEAM_TOP += "z";
		Effect("beam", "vector", "lgtning.spr", 200, BEAM_BOTTOM, BEAM_TOP, Vector3(64, 64, 255), 200, 50, 3.0);
		ScheduleDelayedEvent(1.5, "do_summon_eye2");
		SUMMON_WARMUP = 1;
		ScheduleDelayedEvent(0.01, "summon_warmup_loop");
	}

	void summon_warmup_loop()
	{
		if (!(SUMMON_WARMUP)) return;
		ScheduleDelayedEvent(0.1, "summon_warmup_loop");
		ClientEvent("update", "all", MY_CL_IDX, "wand_prep_cl", GetEntityProperty(GetOwner(), "attachpos"), Vector3(0, 0, 255));
	}

	void do_summon_eye2()
	{
		SUMMON_WARMUP = 0;
		SetModelBody(1, WAND_UNLIT);
		npcatk_resume_ai();
		LogDebug("do_summon_eye2 SUMMON_POS");
		SpawnNPC("monsters/eye_drainer", SUMMON_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		N_EYES += 1;
	}

	void eye_died()
	{
		N_EYES -= 1;
	}

	void do_fireballs()
	{
		if (!(CUR_TRIG == "spawn_firereaver")) return;
		ScheduleDelayedEvent(1.0, "do_fireballs");
		SetMoveSpeed(0.0);
		SetMoveAnim("idle1");
		SetIdleAnim("idle1");
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if (!(GetEntityRange(m_hAttackTarget) < 800)) return;
		TossProjectile("proj_fire_xolt", /* TODO: $relpos */ $relpos(0, 8, 32), m_hAttackTarget, 400, DMG_FIRE_BOLT, 2, "none");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((STAY_NEAR_HOME))
		{
			if (!(IsEntityAlive(m_hAttackTarget)))
			{
			}
			if (GetGameTime() > LAST_RETURN_TIME)
			{
			}
			SetMoveDest(NPC_HOME_LOC);
			LAST_RETURN_TIME = GetGameTime();
			LAST_RETURN_TIME += 2.0;
		}
		if ((STAY_NEAR_HOME)) return;
		if ((IsEntityAlive(m_hAttackTarget))) return;
		if (!(AM_MOBILE)) return;
		stay_still();
	}

	void npcatk_clear_targets()
	{
		stay_still();
	}

	void npc_targetsighted()
	{
		if (!(DID_ORC_COMMENT))
		{
			if ((SET_TELE_POINTS))
			{
			}
			if (CUR_TELE_POINT == 0)
			{
			}
			if (GetEntityRange(m_hAttackTarget) < 768)
			{
			}
			DID_ORC_COMMENT = 1;
			if (GetPlayerCount() > 1)
			{
				string PRO_NOUN = "yourselves.";
			}
			if (GetPlayerCount() == 1)
			{
				string PRO_NOUN = "yourself.";
			}
			SayText("Filthy Orcs! More useful dead than alive. Much like PRO_NOUN");
		}
		if ((AM_MOBILE)) return;
		resume_movement();
	}

	void stay_still()
	{
		SetRoam(false);
		AM_MOBILE = 0;
		SetMoveAnim("idle1");
		SetIdleAnim("idle1");
		SetMoveSpeed(0.0);
	}

	void resume_movement()
	{
		SetRoam(true);
		AM_MOBILE = 1;
		SetMoveAnim(ANIM_MOVE);
		SetIdleAnim("idle1");
		SetMoveSpeed(1.0);
	}

}

}
