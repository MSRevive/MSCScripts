#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Titan : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string BALL_TARGETS;
	int CAN_RETALIATE;
	int CHANCE_STOMP;
	string CL_IDX;
	int DO_GRAB;
	string END_SQEEEZE_DMG_LOOP;
	string FLINCH_ANIM;
	int FLINCH_HEALTH;
	string GRAB_MODE;
	int GRAB_TARG;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	int LAST_BIRD;
	int METEOR_COUNT;
	int MOVE_RANGE;
	int M_BIRD_ROT;
	int M_SUMMON_BIRDS;
	int M_SUMMON_COUNT;
	string M_SUMMON_POINT1;
	string M_SUMMON_POINT2;
	string M_SUMMON_POINT3;
	string M_SUMMON_POINT4;
	int M_SUMMON_POINTS;
	string NEXT_GRAB;
	string NEXT_KICK;
	string NEXT_SMASH;
	string NEXT_STOMP;
	int NO_STEP_ADJ;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int NPC_MUST_SEE_TARGET;
	int N_BIRDS;
	int N_SCORPS;
	string ROT_ANG;
	string SCORP_SCRIPT;
	string SMASH_SCAN_POINT;
	string SMASH_TARGET;
	string STUN_BURST_DMG;
	string STUN_BURST_POS;
	string STUN_BURST_RAD;
	string STUN_BURST_REPEL;
	string STUN_LIST;
	string SUM_POINT;
	int TITAN_RNDAMT;
	int T_SUM_ANG;
	int WALK_COUNT;

	Titan()
	{
		const int CANT_FLEE = 1;
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle";
		ANIM_RUN = "walk";
		ANIM_ATTACK = "swipe2";
		ANIM_DEATH = "death";
		FLINCH_ANIM = "flinchheavy";
		FLINCH_HEALTH = 2000;
		const int FLINCH_DAMAGE_THRESHOLD = 50;
		const float FLINCH_DELAY = 20.0;
		NPC_MUST_SEE_TARGET = 0;
		const string ANIM_SWIPE = "swipe2";
		const string ANIM_METEOR = "roar2";
		const string ANIM_STOMP = "stomp";
		const string ANIM_SNAP = "bitehead";
		const string ANIM_GRAB = "throw1";
		const string ANIM_SQUEEZE = "throw2";
		const string ANIM_THROW = "throw3";
		const string ANIM_SMASH = "punch";
		const string ANIM_KICK = "kick";
		const string ANIM_CAST = "summon";
		IS_UNHOLY = 1;
		NO_STEP_ADJ = 1;
		ATTACK_RANGE = 300;
		ATTACK_HITRANGE = 350;
		ATTACK_MOVERANGE = 250;
		MOVE_RANGE = 250;
		CAN_RETALIATE = 0;
		IMMUNE_VAMPIRE = 1;
		const string MONSTER_MODEL = "monsters/titan.mdl";
		const int SCORP_SPAWN_VADJ = 650;
		const int SCORP_RAD = 300;
		const string SCORP_SCRIPT1 = "monsters/scorpion5_stone";
		const string SCORP_SCRIPT2 = "monsters/scorpion6_stone";
		const int CHANCE_KICK = 25;
		const float FREQ_GRAB = 60.0;
		const int DMG_THROW = 800;
		const int SUM_RAD = 300;
		const int SUM_VADJ = 650;
		const int DMG_SWIPE = 150;
		const int DMG_METEOR = 300;
		const int DMG_KICK = 250;
		const int DMG_STOMP = 100;
		const int DMG_BALL = 200;
		const int DMG_SQUEEZE = 30;
		const string BIRD_SCRIPT = "monsters/eagle_stone";
		const int BIRD_COOLDOWN = 55;
		LAST_BIRD = 0;
		const string SMASH_OFS = /* TODO: $relpos */ $relpos(0, 230, -300);
		const int SMASH_RANGE = 128;
		const string SWIPE_OFS = /* TODO: $relpos */ $relpos(0, 230, -280);
		const int SWIPE_RAD = 200;
		const int R_ARM_ATT_IDX = 2;
		const int L_ARM_ATT_IDX = 3;
		const float FREQ_KICK = 10.0;
		const float FREQ_STOMP = 10.0;
		const float FREQ_SMASH = 5.0;
		const string SOUND_SUMMON = "debris/beamstart1.wav";
		const string SOUND_YAWN1 = "garg/gar_breathe1.wav";
		const string SOUND_YAWN2 = "garg/gar_breathe2.wav";
		const string SOUND_YAWN3 = "garg/gar_breathe3.wav";
		const string SOUND_RAWR = "garg/gar_alert2.wav";
		const string SOUND_STEP1 = "garg/gar_step1.wav";
		const string SOUND_STEP2 = "garg/gar_step2.wav";
		const string SOUND_SWIPE = "weapons/swinghuge.wav";
		const string SOUND_KICK = "weapons/swinghuge.wav";
		const string SOUND_THROW = "weapons/swinghuge.wav";
		const string SOUND_DEATH = "garg/gar_die1.wav";
		const string SOUND_GRAB = "garg/gar_attack2.wav";
		const string SOUND_SQUEEZE = "garg/gar_alert1.wav";
		Precache(SOUND_DEATH);
		const string CL_GLOW_SPR = "3dmflaora.spr";
		const string CL_TELE_SPR = "c-tele1.spr";
		Precache(CL_GLOW_SPR);
		Precache(CL_TELE_SPR);
		if ((true))
		{
		}
		if ((StringToLower(GetMapName())).findFirst("thanatos") >= 0)
		{
			NPC_IS_BOSS = 1;
			NPC_GIVE_EXP = 16000;
		}
		else
		{
			NPC_GIVE_EXP = 1000;
		}
	}

	void game_precache()
	{
		Precache(SCORP_SCRIPT1);
		Precache(SCORP_SCRIPT2);
		Precache("monsters/summon/lightning_ball_guided");
		Precache(BIRD_SCRIPT);
		Precache("chests/olympus");
	}

	void OnSpawn() override
	{
		if (StringToLower(GetMapName()) == "thanatos")
		{
			SetName("Titan");
		}
		else
		{
			SetName("Elder Earth Elemental");
		}
		SetModel(MONSTER_MODEL);
		SetHealth(18000);
		SetWidth(200);
		SetHeight(600);
		SetRace("demon");
		SetRoam(false);
		SetHearingSensitivity(11);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("holy", 0.5);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("stun", 0);
		SetBloodType("none");
		SetStepSize(32);
		SetIdleAnim("bust");
		SetMoveAnim("bust");
		PlayAnim("critical", "bust");
		if (!(true)) return;
		TITAN_RNDAMT = 0;
		SetProp(GetOwner(), "rendermode", 2);
		SetProp(GetOwner(), "renderamt", 0);
		titan_fade_in();
		npcatk_suspend_ai();
		ScheduleDelayedEvent(5.0, "do_special");
		ScheduleDelayedEvent(0.1, "smash_scanner");
		N_SCORPS = 0;
		T_SUM_ANG = 0;
		WALK_COUNT = 0;
		DO_GRAB = 0;
		CL_IDX = "const.localplayer.scriptID";
		ClientEvent("update", "all", CL_IDX, "titan_setup", GetEntityIndex(GetOwner()), CL_TELE_SPR, CL_GLOW_SPR);
		ScheduleDelayedEvent(0.5, "get_map_summon_points");
	}

	void get_map_summon_points()
	{
		M_SUMMON_POINT1 = FindEntityByName("titan_summon_point1");
		M_SUMMON_POINT2 = FindEntityByName("titan_summon_point2");
		M_SUMMON_POINT3 = FindEntityByName("titan_summon_point3");
		M_SUMMON_POINT4 = FindEntityByName("titan_summon_point4");
		M_SUMMON_POINT1 = GetEntityOrigin(M_SUMMON_POINT1);
		M_SUMMON_POINT2 = GetEntityOrigin(M_SUMMON_POINT2);
		M_SUMMON_POINT3 = GetEntityOrigin(M_SUMMON_POINT3);
		M_SUMMON_POINT4 = GetEntityOrigin(M_SUMMON_POINT4);
		M_BIRD_ROT = 0;
		M_SUMMON_COUNT = 0;
		M_SUMMON_POINTS = 1;
		if (!((M_SUMMON_POINT1).x == 0)) return;
		if (!((M_SUMMON_POINT2).y == 0)) return;
		if (!((M_SUMMON_POINT3).z == 0)) return;
		M_SUMMON_POINTS = 0;
	}

	void frame_spawn_done()
	{
		npcatk_resume_ai();
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void do_special()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if ((SUSPEND_AI))
		{
			float NEXT_SPECIAL = 1.0;
			NEXT_SPECIAL("do_special");
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		float NEXT_SPECIAL = 20.0;
		if ((IsEntityAlive(m_hAttackTarget)))
		{
			int N_SPECIALS = 4;
			string RND_SPECIAL = RandomInt(1, N_SPECIALS);
			if (RND_SPECIAL == 1)
			{
				if (N_SCORPS < 2)
				{
					do_scorps();
					float NEXT_SPECIAL = 20.0;
				}
				else
				{
					string RND_SPECIAL = RandomInt(2, N_SPECIALS);
				}
			}
			if (RND_SPECIAL == 2)
			{
				do_birds();
			}
			if (RND_SPECIAL == 3)
			{
			}
			if (RND_SPECIAL == 4)
			{
				N_BALLS = 0;
				do_lballs();
			}
		}
		NEXT_SPECIAL("do_special");
	}

	void do_scorps()
	{
		PlayAnim("critical", ANIM_CAST);
		ScheduleDelayedEvent(1.0, "do_scorps2");
	}

	void do_scorps2()
	{
		SCORP_SCRIPT = SCORP_SCRIPT1;
		if ("game.players.totalhp" > 4000)
		{
			SCORP_SCRIPT = SCORP_SCRIPT2;
		}
		N_SCORPS += 1;
		M_SUMMON_BIRDS = 0;
		get_summon_point();
		SpawnNPC(SCORP_SCRIPT, SUM_POINT, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		CallExternal(m_hLastCreated, "ext_delay_target", 3.0, "enemy");
		if (!(N_SCORPS < 2)) return;
		if (!("game.players.totalhp" <= 4000)) return;
		ScheduleDelayedEvent(0.1, "do_scorps3");
	}

	void do_scorps3()
	{
		N_SCORPS += 1;
		M_SUMMON_BIRDS = 0;
		get_summon_point();
		SpawnNPC(SCORP_SCRIPT, SUM_POINT, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		CallExternal(m_hLastCreated, "ext_delay_target", 3.0, "enemy");
	}

	void scorpion_died()
	{
		N_SCORPS -= 1;
	}

	void do_meteors()
	{
		npcatk_suspend_ai();
		SetMoveAnim(ANIM_METEOR);
		SetIdleAnim(ANIM_METEOR);
		PlayAnim("once", ANIM_METEOR);
		ROT_ANG = GetMonsterProperty("angles.yaw");
		METEOR_COUNT = 0;
		EmitSound(GetOwner(), 0, SOUND_RAWR, 10);
		do_meteors_loop();
	}

	void do_meteors_loop()
	{
		if (METEOR_COUNT < 18)
		{
			ROT_ANG += 20;
			if (ROT_ANG > 359)
			{
				ROT_ANG -= 359;
			}
			string MOVE_DEST = GetMonsterProperty("origin");
			MOVE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, ROT_ANG, 0), Vector3(0, 1000, 0));
			SetMoveDest(MOVE_DEST);
			METEOR_COUNT += 1;
			ScheduleDelayedEvent(0.1, "do_meteors_loop");
		}
		else
		{
			npcatk_resume_ai();
			SetMoveAnim(ANIM_WALK);
			SetIdleAnim(ANIM_IDLE);
			PlayAnim("once", "break");
		}
	}

	void frame_kick()
	{
		ANIM_ATTACK = ANIM_SWIPE;
		NEXT_KICK = GetGameTime();
		NEXT_KICK += FREQ_KICK;
		EmitSound(GetOwner(), 0, SOUND_KICK, 10);
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		AddVelocity(m_hAttackTarget, /* TODO: $relvel */ $relvel(0, 1000, 200));
		ApplyEffect(m_hAttackTarget, "effects/debuff_stun", 2.0, GetEntityIndex(GetOwner()));
		DoDamage(m_hAttackTarget, "direct", DMG_KICK, 1.0, GetOwner());
	}

	void frame_stomp()
	{
		ANIM_ATTACK = ANIM_SWIPE;
		string BURST_POS = /* TODO: $relpos */ $relpos(50, 50, 0);
		string GRND_BURST = /* TODO: $get_ground_height */ $get_ground_height(BURST_POS);
		BURST_POS = "z";
		stunburst_go(BURST_POS, 512, 1, DMG_STOMP);
		NEXT_STOMP = GetGameTime();
		NEXT_STOMP += FREQ_STOMP;
	}

	void frame_swipe()
	{
		EmitSound(GetOwner(), 0, SOUND_SWIPE, 10);
		string SWIPE_POINT = SWIPE_OFS;
		XDoDamage(SWIPE_POINT, SWIPE_RAD, DMG_SWIPE, 0.0, GetOwner(), GetOwner(), "none", "blunt");
		if (RandomInt(1, 100) < CHANCE_KICK)
		{
			if (GetGameTime() > NEXT_KICK)
			{
			}
			ANIM_ATTACK = ANIM_KICK;
		}
		CHANCE_STOMP = 10;
		GetAllPlayers(PLAYER_LIST);
		for (int i = 0; i < GetTokenCount(PLAYER_LIST, ";"); i++)
		{
			stomp_check();
		}
		if (CHANCE_STOMP > 50)
		{
			CHANCE_STOMP = 50;
		}
		if (!(RandomInt(1, 100) < CHANCE_STOMP)) return;
		if (!(GetGameTime() > NEXT_STOMP)) return;
		ANIM_ATTACK = ANIM_STOMP;
	}

	void stomp_check()
	{
		string CUR_PLAYER = GetToken(PLAYER_LIST, i, ";");
		if (!(GetEntityRange(CUR_PLAYER) < ATTACK_HITRANGE)) return;
		CHANCE_STOMP += 10;
	}

	void do_lballs()
	{
		if (N_BALLS == 0)
		{
			PlayAnim("critical", ANIM_CAST);
		}
		BALL_TARGETS = FindEntitiesInSphere("enemy", 2048);
		ScrambleTokens(BALL_TARGETS, ";");
		get_summon_point();
		SpawnNPC("monsters/summon/lightning_ball_guided", SUM_POINT, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_BALL, 30.0, 192, GetToken(BALL_TARGETS, 0, ";")
		N_BALLS += 1;
		string N_BALL_TARGS = GetTokenCount(BALL_TARGETS, ";");
		if (!(N_BALLS < 2)) return;
		ScheduleDelayedEvent(0.1, "do_lballs");
		if (!(N_BALL_TARGS > 1)) return;
		string N_BALLS_SANS2 = N_BALLS;
		N_BALLS_SANS2 -= 2;
		if (N_BALLS_SANS2 < N_BALL_TARGS)
		{
			string N_BALLS_F10 = N_BALLS;
			N_BALLS_F10 *= 0.1;
			N_BALLS_F10("do_lballs");
		}
	}

	void do_birds()
	{
		string L_DIFF = /* TODO: $math(subtract) */ LAST_BIRD;
		if (!(L_DIFF > BIRD_COOLDOWN)) return;
		PlayAnim("critical", ANIM_CAST);
		CallExternal("all", "summon_eagle_vanish");
		N_BIRDS = 0;
		do_birds_loop();
	}

	void do_birds_loop()
	{
		M_SUMMON_BIRDS = 1;
		get_summon_point();
		SpawnNPC(BIRD_SCRIPT, SUM_POINT, ScriptMode::Legacy);
		CallExternal(m_hLastCreated, "ext_delay_target", 3.0, "enemy");
		N_BIRDS += 1;
		if (!(N_BIRDS < 12)) return;
		string DBL_NPLAYERS = GetPlayerCount();
		DBL_NPLAYERS *= 2;
		if (!(N_BIRDS < DBL_NPLAYERS)) return;
		ScheduleDelayedEvent(0.1, "do_birds_loop");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		string L_TITAN_ID = GetEntityIndex(GetOwner());
		string L_TITAN_DEATH_POS = GetEntityOrigin(GetOwner());
		string L_TITAN_STUN_POS = /* TODO: $relpos */ $relpos(0, 400, 0);
		SpawnNPC("chests/olympus", NPC_HOME_LOC, ScriptMode::Legacy);
		CallExternal(GAME_MASTER, "gm_createnpc", 4.0, "monsters/summon/stun_burst", L_TITAN_STUN_POS, L_TITAN_ID, 512, 1, 100);
		CallExternal(GAME_MASTER, "gold_spew", 500, 2, 256, 4, 16, L_TITAN_DEATH_POS);
	}

	void smash_scanner()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		ScheduleDelayedEvent(0.5, "smash_scanner");
		if (!(GetGameTime() > NEXT_SMASH)) return;
		SMASH_SCAN_POINT = SMASH_OFS;
		SMASH_TARGET = "unset";
		GetAllPlayers(SMASH_PLAYER_LIST);
		for (int i = 0; i < GetTokenCount(SMASH_PLAYER_LIST, ";"); i++)
		{
			check_for_smash();
		}
		if (!(SMASH_TARGET != "unset")) return;
		ANIM_ATTACK = ANIM_SMASH;
		DO_GRAB = 0;
		if (!(GetGameTime() > NEXT_GRAB)) return;
		if (!(RandomInt(1, 2) == 1)) return;
		DO_GRAB = 1;
		ANIM_ATTACK = ANIM_GRAB;
	}

	void check_for_smash()
	{
		string CUR_PLAYER = GetToken(SMASH_PLAYER_LIST, i, ";");
		string CUR_PLAYER_ORG = GetEntityOrigin(CUR_PLAYER);
		if (Distance(CUR_PLAYER_ORG, SMASH_SCAN_POINT) < SMASH_RANGE)
		{
			SMASH_TARGET = CUR_PLAYER;
		}
	}

	void frame_smash()
	{
		NEXT_SMASH = GetGameTime();
		NEXT_SMASH += FREQ_SMASH;
		ANIM_ATTACK = ANIM_SWIPE;
		string SMASH_POINT = SMASH_OFS;
		SMASH_POINT += "z";
		string BURST_POS = SMASH_POINT;
		stunburst_go(BURST_POS, 128, 0, DMG_STOMP);
	}

	void get_summon_point()
	{
		if (!(M_SUMMON_POINTS))
		{
			if (ALTERNATE_SUM_POINT == 0)
			{
				T_SUM_ANG += 20;
				if (T_SUM_ANG > 359)
				{
					T_SUM_ANG -= 359;
				}
				SUM_ANG = T_SUM_ANG;
				ALTERNATE_SUM_POINT = 1;
			}
			else
			{
				SUM_ANG = T_SUM_ANG;
				SUM_ANG += 180;
				if (SUM_ANG > 359)
				{
					SUM_ANG -= 359;
				}
				ALTERNATE_SUM_POINT = 0;
			}
			SUM_POINT = NPC_HOME_LOC;
			SUM_POINT += /* TODO: $relpos */ $relpos(Vector3(0, SUM_ANG, 0), Vector3(0, SUM_RAD, SUM_VADJ));
			if ((ALTERNATE_SUM_POINT))
			{
				Effect("beam", "end", "lgtning.spr", 120, SUM_POINT, GetOwner(), R_ARM_ATT_IDX, Vector3(64, 64, 255), 200, 30, 1.0);
				ClientEvent("update", "all", CL_IDX, "titan_summon_sprite", SUM_POINT);
			}
			else
			{
				Effect("beam", "end", "lgtning.spr", 120, SUM_POINT, GetOwner(), L_ARM_ATT_IDX, Vector3(64, 64, 255), 200, 30, 1.0);
				ClientEvent("update", "all", CL_IDX, "titan_summon_sprite", SUM_POINT);
			}
		}
		else
		{
			M_SUMMON_COUNT += 1;
			if (M_SUMMON_COUNT == 1)
			{
				SUM_POINT = M_SUMMON_POINT1;
				string L_ARM_IDX = R_ARM_ATT_IDX;
			}
			else
			{
				if (M_SUMMON_COUNT == 2)
				{
					SUM_POINT = M_SUMMON_POINT2;
					string L_ARM_IDX = L_ARM_ATT_IDX;
				}
				else
				{
					if (M_SUMMON_COUNT == 3)
					{
						SUM_POINT = M_SUMMON_POINT3;
						string L_ARM_IDX = R_ARM_ATT_IDX;
					}
					else
					{
						if (M_SUMMON_COUNT == 4)
						{
							SUM_POINT = M_SUMMON_POINT4;
							string L_ARM_IDX = L_ARM_ATT_IDX;
							M_SUMMON_COUNT = 0;
						}
					}
				}
			}
			if ((M_SUMMON_BIRDS))
			{
				M_BIRD_ROT += 90;
				if (M_BIRD_ROT > 359.99)
				{
					M_BIRD_ROT = 0;
				}
				SUM_POINT += /* TODO: $relpos */ $relpos(Vector3(0, M_BIRD_ROT, 0), Vector3(0, 96, 0));
			}
			LogDebug("get_summon_point - using map points SUM_POINT");
			Effect("beam", "end", "lgtning.spr", 120, SUM_POINT, GetOwner(), L_ARM_ATT_IDX, Vector3(64, 64, 255), 200, 30, 1.0);
			ClientEvent("update", "all", CL_IDX, "titan_summon_sprite", SUM_POINT);
		}
		EmitSound(GetOwner(), 2, SOUND_SUMMON, 10);
	}

	void frame_walk_step1()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1, 5);
	}

	void frame_walk_step2()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP2, 5);
	}

	void frame_idle_breath()
	{
		// PlayRandomSound from: SOUND_YAWN1, SOUND_YAWN2, SOUND_YAWN3
		array<string> sounds = {SOUND_YAWN1, SOUND_YAWN2, SOUND_YAWN3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void frame_idle_yawn()
	{
		// PlayRandomSound from: SOUND_YAWN1, SOUND_YAWN2, SOUND_YAWN3
		array<string> sounds = {SOUND_YAWN1, SOUND_YAWN2, SOUND_YAWN3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void frame_grab_player()
	{
		GRAB_TARG = 0;
		if ((IsEntityAlive(SMASH_TARGET)))
		{
			EmitSound(GetOwner(), 0, SOUND_GRAB, 10);
			string GRAB_TARG_ORG = GetEntityOrigin(SMASH_TARGET);
			string FIST_ORG = GetEntityProperty(GetOwner(), "attachpos");
			LogDebug("frame_grab_body FIST_ORG vs GRAB_TARG_ORG");
			if (Distance(FIST_ORG, GRAB_TARG_ORG) < 128)
			{
				GRAB_TARG = SMASH_TARGET;
				GRAB_MODE = 1;
				ScheduleDelayedEvent(0.01, "lock_player_to_hand");
				npcatk_suspend_ai();
				ScheduleDelayedEvent(0.5, "face_home");
			}
			else
			{
				NEXT_GRAB = GetGameTime();
				NEXT_GRAB += FREQ_GRAB;
				ANIM_ATTACK = ANIM_SWIPE;
			}
		}
		else
		{
			NEXT_GRAB = GetGameTime();
			NEXT_GRAB += 10.0;
			ANIM_ATTACK = ANIM_SWIPE;
		}
	}

	void frame_start_squeeze()
	{
		if (!(IsEntityAlive(GRAB_TARG))) return;
		PlayAnim("critical", ANIM_SQUEEZE);
	}

	void frame_squeeze_player()
	{
		EmitSound(GetOwner(), 0, SOUND_SQUEEZE, 10);
		END_SQEEEZE_DMG_LOOP = GetGameTime();
		END_SQEEEZE_DMG_LOOP += 2.0;
		squeeze_dmg_loop();
		Effect("screenshake", GetEntityProperty(GRAB_TARG, "org"), 190, 20, 3, 32);
	}

	void squeeze_dmg_loop()
	{
		if (!(GetGameTime() < END_SQEEEZE_DMG_LOOP)) return;
		if (!(IsEntityAlive(GRAB_TARG)))
		{
			GRAB_MODE = 0;
		}
		if (!(IsEntityAlive(GRAB_TARG))) return;
		if (!(GetEntityRange(GRAB_TARG) < 1024)) return;
		ScheduleDelayedEvent(0.1, "squeeze_dmg_loop");
		DoDamage(GRAB_TARG, "direct", DMG_SQUEEZE, 1.0, GetOwner());
	}

	void frame_squeeze_done()
	{
		if (!(IsEntityAlive(GRAB_TARG)))
		{
			npcatk_resume_ai();
			GRAB_MODE = 0;
		}
		else
		{
			PlayAnim("critical", ANIM_THROW);
		}
	}

	void face_home()
	{
		SetMoveDest(NPC_HOME_LOC);
	}

	void lock_player_to_hand()
	{
		if (!(GRAB_MODE)) return;
		ScheduleDelayedEvent(0.01, "lock_player_to_hand");
		SetEntityOrigin(GRAB_TARG, GetEntityProperty(GetOwner(), "attachpos"));
		SetVelocity(GRAB_TARG, Vector3(0, 0, 0));
	}

	void frame_toss_player()
	{
		npcatk_resume_ai();
		GRAB_MODE = 0;
		NEXT_GRAB = GetGameTime();
		NEXT_GRAB += FREQ_GRAB;
		string SHIFT_ORG = GetEntityProperty(GetOwner(), "attachpos");
		SHIFT_ORG += "z";
		SetEntityOrigin(GRAB_TARG, SHIFT_ORG);
		SetProp(GRAB_TARG, "movetype", "const.movetype.bouncemissle");
		AddVelocity(GRAB_TARG, /* TODO: $relvel */ $relvel(0, 2000, 200));
		DoDamage(GRAB_TARG, "direct", DMG_THROW, 1.0, "blunt");
		ApplyEffect(GRAB_TARG, "effects/debuff_stun", 10.0, GetEntityIndex(GetOwner()));
		EmitSound(GetOwner(), 0, SOUND_THROW, 10);
	}

	void ext_popup()
	{
		string MY_Z = GetMonsterProperty("origin");
		MY_Z += "z";
		SetEntityOrigin(GetOwner(), MY_Z);
	}

	void titan_fade_in()
	{
		if (TITAN_RNDAMT == 255)
		{
			SetProp(GetOwner(), "rendermode", 0);
			SetRoam(true);
		}
		if (!(TITAN_RNDAMT < 255)) return;
		TITAN_RNDAMT += 5;
		SetProp(GetOwner(), "renderamt", TITAN_RNDAMT);
		ScheduleDelayedEvent(0.1, "titan_fade_in");
	}

	void stunburst_go()
	{
		STUN_BURST_POS = param1;
		STUN_BURST_RAD = param2;
		STUN_BURST_REPEL = param3;
		STUN_BURST_DMG = param4;
		LogDebug("stunburst_go pos: STUN_BURST_POS rad: STUN_BURST_RAD repel: STUN_BURST_REPEL dmg: STUN_BURST_DMG");
		ClientEvent("update", "all", CL_IDX, "fx_stunburst_go_cl", STUN_BURST_POS, STUN_BURST_RAD);
		ScheduleDelayedEvent(0.25, "stun_targets");
	}

	void stun_targets()
	{
		STUN_LIST = FindEntitiesInSphere("enemy", STUN_BURST_RAD);
		LogDebug("stun_targets STUN_LIST");
		if (!(STUN_LIST != "none")) return;
		if (!(GetTokenCount(STUN_LIST, ";") > 0)) return;
		for (int i = 0; i < GetTokenCount(STUN_LIST, ";"); i++)
		{
			stunburst_affect_targets();
		}
	}

	void stunburst_affect_targets()
	{
		string CHECK_ENT = GetToken(STUN_LIST, i, ";");
		if (!(IsOnGround(CHECK_ENT))) return;
		ApplyEffect(CHECK_ENT, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		if (STUN_BURST_DMG > 0)
		{
			DoDamage(CHECK_ENT, "direct", STUN_BURST_DMG, 1.0, GetOwner());
		}
		if (!(STUN_BURST_REPEL)) return;
		string TARGET_ORG = GetEntityOrigin(CHECK_ENT);
		string TARG_ANG = /* TODO: $angles */ $angles(STUN_BURST_POS, TARGET_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(CHECK_ENT, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
	}

}

}
