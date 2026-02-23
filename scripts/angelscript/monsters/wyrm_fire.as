#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_struck.as"

namespace MS
{

class WyrmFire : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CANT_TURN;
	int CAN_SPIT;
	int CUR_PASSIVE;
	int DID_BITE;
	string DID_FLEE1;
	string DID_FLEE2;
	string DID_FLEE3;
	string DID_INTRO;
	int DO_QUAKE;
	string FIRE_BOMB_POS;
	float GAME_PUSH_RATIO;
	int INTRO_STAGE;
	int LAVA_VOLUME;
	string MOVE_TO_PIT;
	string MOVE_TO_PIT_IDX;
	string NEXT_GIVEUP;
	string NEXT_LIGHT_REFRESH;
	string NEXT_LOOP_LAVA;
	string NEXT_MODE_SWITCH;
	string NEXT_PASSIVE;
	string NEXT_PITHUNT;
	string NEXT_PIT_SEARCH;
	string NEXT_SPIT;
	string NEXT_SWIPE_CHECK;
	string NEXT_WORM_HIDE;
	int NO_QUAKES;
	int NO_STUCK_CHECKS;
	string NPCATK_TARGET;
	int NPC_FLINCH_DISABLE;
	int NPC_GIVE_EXP;
	int NPC_NO_ATTACK;
	string N_EDGE_POINTS;
	string N_PIT_POINTS;
	string PROJ_LOOP_SOUND;
	string PROJ_TARGET;
	string REPELL_POS;
	string T_LEAST_DIST;
	string T_NEAREST;
	string T_SPHERE;
	int WYRM_COMBAT_INITIATED;
	string WYRM_CUR_PIT;
	int WYRM_CUR_PIT_IDX;
	string WYRM_EDGE_PREFIX;
	int WYRM_FINALIZED;
	string WYRM_GOT_ALL_EDGE_POINTS;
	string WYRM_GOT_ALL_PIT_POINTS;
	int WYRM_HIDE_MODE;
	string WYRM_LIGHT_ACTIVE;
	string WYRM_LIGHT_CLIDX;
	string WYRM_MMODE;
	string WYRM_MOVEDEST;
	string WYRM_NEXT_EDGE_IDX;
	string WYRM_NO_TELEPORT_FLAG;
	string WYRM_OLD_TARGET;
	int WYRM_PITHUNTER;
	string WYRM_PIT_PREFIX;
	string WYRM_PORTING_TO;
	int WYRM_SPEED;
	int WYRM_SUBMERGE_GOT_ENDFRAME;
	int WYRM_SUBMERGING;
	int WYRM_TELEPORTING;
	int WYRM_TELE_STAGE2;
	int WYRM_UNHIDE_RANGE;
	string WYRM_UNHIDE_TIME;
	string WYRM_USE_BOTH;
	string WYRM_USE_EDGES;
	string WYRM_USE_PITS;

	WyrmFire()
	{
		WYRM_EDGE_PREFIX = "wyrm_edge";
		WYRM_PIT_PREFIX = "wyrm_pit";
		const string WYRM_TYPE = "fire";
		const int WYRM_SKIN = 0;
		const int WYRM_SIZE = 1;
		const string MONSTER_MODEL = "monsters/wyrms_medium.mdl";
		WYRM_SPEED = 100;
		WYRM_MOVEDEST = "unset";
		const string ANIM_APPEAR = "anim_appear";
		const string ANIM_RETRACT = "anim_retract";
		const string ANIM_RAWR = "anim_blong";
		const string ANIM_BITE1 = "anim_bite1";
		const string ANIM_BITE2 = "anim_bite2";
		const string ANIM_SPIT = "anim_spit";
		const string ANIM_SWIPE = "anim_swipe";
		const string ANIM_HEADBUTT = "anim_hbutt";
		const string ANIM_FLINCH1 = "anim_flinch1";
		const string ANIM_FLINCH2 = "anim_flinch2";
		const string ANIM_HIDDEN = "anim_hidden";
		const int ATTACK_RANGE_BITE = 245;
		const int ATTACK_RANGE_SPIT = 4096;
		NPC_NO_ATTACK = 1;
		const string FREQ_SWIPE = Random(3.0, 5.0);
		const string FREQ_MODE_SWITCH = Random(20.0, 30.0);
		const string FREQ_PIT_SEARCH = Random(10.0, 20.0);
		const int PROJ_SPEED = 300;
		const int PROJ_DMG = 50;
		const int PROJ_COF = 5;
		const string PROJ_SCRIPT = "proj_fire_bomb_sm";
		PROJ_LOOP_SOUND = "ambient/animals/rattle_long.wav";
		const string FREQ_SPIT = Random(2.0, 3.0);
		const int ATT_MOUTH = 0;
		const string SOUND_SPIT_PREP = "magic/fireball_large.wav";
		const string SOUND_SPIT_STRIKE = "weapons/rocketfire1.wav";
		const string SOUND_ALERT1 = "monsters/wyrm/c_x0stgwar_bat1.wav";
		const string SOUND_ALERT2 = "monsters/wyrm/c_x0stgwar_bat2.wav";
		const string SOUND_BITE = "monsters/wyrm/8bit/c_x0stgwar_atk1.wav";
		const string SOUND_HBUTT = "monsters/wyrm/c_x0stgwar_atk2.wav";
		const string SOUND_SWIPE = "monsters/wyrm/c_x0stgwar_atk3.wav";
		const string SOUND_SWIPE_LARGE = "weapons/swinghuge.wav";
		const string SOUND_SPLASH_DOWN = "monsters/wyrm/lava_splash_rev.wav";
		const string SOUND_SPLASH_UP = "amb/lava_splash.wav";
		const string SOUND_LAVA_LOOP = "amb/lava_loop.wav";
		const string SOUND_PASSIVE1 = "monsters/wyrm/idle1.wav";
		const string SOUND_PASSIVE2 = "monsters/wyrm/idle2.wav";
		const string SOUND_PASSIVE3 = "monsters/wyrm/idle3.wav";
		const string SOUND_PASSIVE4 = "monsters/wyrm/idle4.wav";
		const string FREQ_PASSIVE = Random(7.0, 10.0);
		CUR_PASSIVE = 0;
		const float DUR_QUAKE = 7.0;
		const int AOE_HBUTT = 80;
		const int AOE_SWIPE = 128;
		const int DMG_HBUTT = 75;
		const int DMG_BITE = 65;
		const int DMG_FROCK = 100;
		const int DMG_SWIPE = 50;
		const float FREQ_SWIPE = 20.0;
		const string DOT_SCRIPT = "effects/dot_fire";
		const string DOT_EFFECTNAME = "DOT_fire";
		const int DOT_DMG = 25;
		const float DOT_DUR = 5.0;
		const string DOT_SCRIPT2 = "effects/dot_fire";
		const string DOT_EFFECTNAME2 = "DOT_fire";
		const int DOT_DMG2 = 25;
		const float DOT_DUR2 = 5.0;
		const Vector3 WYRM_GLOW_COLOR = Vector3(64, 32, 0);
		WYRM_CUR_PIT_IDX = 0;
		ANIM_IDLE = "anim_idle";
		ANIM_WALK = "anim_idle";
		ANIM_RUN = "anim_idle";
		ANIM_ATTACK = ANIM_BITE1;
		ANIM_DEATH = "anim_death";
		const int NPC_NO_MOVE = 1;
		CANT_TURN = 1;
		const int CANT_FLEE = 1;
		NPC_GIVE_EXP = 1000;
		NO_STUCK_CHECKS = 1;
		ATTACK_RANGE = 256;
		ATTACK_HITRANGE = 256;
		const string SOUND_DEATH = "monsters/wyrm/c_x0stgwar_dead.wav";
		const int NPC_USE_FLINCH = 1;
		const int NPC_USE_PAIN = 1;
		const int NPC_USE_IDLE = 0;
		const float NPC_FLINCH_HEALTH_RATIO = 0.5;
		ANIM_FLINCH = "anim_flinch1";
		const string NPC_MATERIAL_TYPE = "carapace";
		const string SOUND_PAIN1 = "monsters/wyrm/c_x0stgwar_hit1.wav";
		const string SOUND_PAIN2 = "monsters/wyrm/c_x0stgwar_hit2.wav";
		const string SOUND_PAIN3 = "monsters/wyrm/c_x0stgwar_hit2.wav";
		const string SOUND_FLINCH1 = "monsters/wyrm/c_x0stgwar_hit1.wav";
		const string SOUND_FLINCH2 = "monsters/wyrm/c_x0stgwar_hit2.wav";
		const string SOUND_FLINCH3 = "monsters/wyrm/c_x0stgwar_hit2.wav";
	}

	void fake_precache()
	{
		// svplaysound: svplaysound 0 0 ambient/animals/rattle_long.wav
		EmitSound(0, 0, "ambient/animals/rattle_long.wav");
		// svplaysound: svplaysound 0 0 monsters/wyrm/idle1.wav
		EmitSound(0, 0, "monsters/wyrm/idle1.wav");
		// svplaysound: svplaysound 0 0 monsters/wyrm/idle2.wav
		EmitSound(0, 0, "monsters/wyrm/idle2.wav");
		// svplaysound: svplaysound 0 0 monsters/wyrm/idle3.wav
		EmitSound(0, 0, "monsters/wyrm/idle3.wav");
		// svplaysound: svplaysound 0 0 monsters/wyrm/idle4.wav
		EmitSound(0, 0, "monsters/wyrm/idle4.wav");
		// svplaysound: svplaysound 0 0 amb/lava_loop.wav
		EmitSound(0, 0, "amb/lava_loop.wav");
	}

	void game_precache()
	{
		Precache("xfire.spr");
		Precache("rockgibs.mdl");
		Precache("xfireball3.spr");
	}

	void OnSpawn() override
	{
		wyrm_spawn();
		if (!(true)) return;
		ScheduleDelayedEvent(2.0, "wyrm_finalize");
	}

	void wyrm_spawn()
	{
		SetName("Lava Wyrm");
		SetModel(MONSTER_MODEL);
		GAME_PUSH_RATIO = 0.1;
		if (WYRM_SIZE == 1)
		{
			SetWidth(80);
			SetHeight(256);
		}
		if (!(true)) return;
		SetRace("demon");
		SetBloodType("red");
		SetProp(GetOwner(), "skin", WYRM_SKIN);
		SetHealth(5000);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.5);
		SetHearingSensitivity(11);
		CAN_SPIT = 1;
		SetIdleAnim(ANIM_HIDDEN);
		SetMoveAnim(ANIM_HIDDEN);
		WYRM_UNHIDE_RANGE = 384;
		ScheduleDelayedEvent(0.1, "wyrm_hide");
		NEXT_PITHUNT = GetGameTime();
		NEXT_PITHUNT += 20.0;
	}

	void wyrm_finalize()
	{
		if ((WYRM_FINALIZED)) return;
		WYRM_FINALIZED = 1;
		array<string> ARRAY_EDGE_POINTS;
		array<string> ARRAY_PIT_POINTS;
		string L_EDGE1_NAME = WYRM_EDGE_PREFIX;
		L_EDGE1_NAME += 1;
		string L_EDGE1 = FindEntityByName(L_EDGE1_NAME);
		if (((L_EDGE1 !is null)))
		{
			LogDebug("wyrm_finalize found edge1");
			WYRM_USE_EDGES = 1;
			N_EDGE_POINTS = 0;
			for (int i = 0; i < 20; i++)
			{
				wyrm_get_edges_loop();
			}
		}
		string L_PIT1_NAME = WYRM_PIT_PREFIX;
		L_PIT1_NAME += 1;
		string L_PIT1 = FindEntityByName(L_PIT1_NAME);
		if (((L_PIT1 !is null)))
		{
			LogDebug("wyrm_finalize found pit1");
			WYRM_USE_PITS = 1;
			N_PIT_POINTS = 0;
			for (int i = 0; i < 20; i++)
			{
				wyrm_get_pits_loop();
			}
		}
		if ((WYRM_USE_EDGES))
		{
			WYRM_CUR_PIT_IDX = 0;
			WYRM_CUR_PIT = /* TODO: $get_array */ $get_array(ARRAY_PIT_POINTS, WYRM_CUR_PIT_IDX);
			if ((WYRM_USE_PITS))
			{
			}
			if (WYRM_MMODE == "WYRM_MMODE")
			{
				WYRM_MMODE = "pits";
			}
			WYRM_USE_BOTH = 1;
		}
		if (!(WYRM_USE_EDGES))
		{
			if (!(WYRM_USE_PITS))
			{
			}
			WYRM_MMODE = "none";
		}
		LogDebug("wyrm_finalize");
		if (WYRM_MMODE != "none")
		{
			wyrm_pick_movement_mode("init");
		}
		else
		{
			string L_XP = GetXP(GetOwner());
			L_XP *= 0.5;
			SetSkillLevel(L_XP);
		}
	}

	void wyrm_get_edges_loop()
	{
		if ((WYRM_GOT_ALL_EDGE_POINTS)) return;
		N_EDGE_POINTS += 1;
		string L_EDGE_NAME = WYRM_EDGE_PREFIX;
		L_EDGE_NAME += int(N_EDGE_POINTS);
		string L_EDGE_ID = FindEntityByName(L_EDGE_NAME);
		if (((L_EDGE_ID !is null)))
		{
			ARRAY_EDGE_POINTS.insertLast(L_EDGE_ID);
			LogDebug("added edge @ GetEntityOrigin(L_EDGE_ID)");
		}
		else
		{
			WYRM_GOT_ALL_EDGE_POINTS = 1;
		}
	}

	void wyrm_get_pits_loop()
	{
		if ((WYRM_GOT_ALL_PIT_POINTS)) return;
		N_PIT_POINTS += 1;
		string L_PIT_NAME = WYRM_PIT_PREFIX;
		L_PIT_NAME += int(N_PIT_POINTS);
		string L_PIT_ID = FindEntityByName(L_PIT_NAME);
		if (((L_PIT_ID !is null)))
		{
			ARRAY_PIT_POINTS.insertLast(L_PIT_ID);
			LogDebug("added pit @ GetEntityOrigin(L_PIT_ID)");
		}
		else
		{
			WYRM_GOT_ALL_PIT_POINTS = 1;
		}
	}

	void wyrm_hide()
	{
		glow_toggle(0);
		NPCATK_TARGET = "unset";
		WYRM_OLD_TARGET = m_hAttackTarget;
		WYRM_HIDE_MODE = 1;
		WYRM_UNHIDE_TIME = GetGameTime();
		WYRM_UNHIDE_TIME += 5.0;
		SetInvincible(true);
		NPC_FLINCH_DISABLE = 1;
		npcatk_suspend_movement(ANIM_HIDDEN);
		if (!(SUSPEND_AI))
		{
			npcatk_suspend_ai();
		}
		WYRM_MOVEDEST = "unset";
		// TODO: UNCONVERTED: removefx
		LAVA_VOLUME = 3;
		ScheduleDelayedEvent(0.1, "loop_lava");
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (!(WYRM_HIDE_MODE)) return;
		if (!(GetGameTime() > WYRM_UNHIDE_TIME)) return;
		if ((WYRM_TELEPORTING)) return;
		if ((WYRM_SUBMERGING)) return;
		string L_HEARD_ID = GetEntityIndex("ent_lastheard");
		if (!(GetRelationship(L_HEARD_ID) == "enemy")) return;
		if (!(GetEntityRange(L_HEARD_ID) < WYRM_UNHIDE_RANGE)) return;
		wyrm_appear(L_HEARD_ID, "heard_sound");
	}

	void wyrm_appear()
	{
		LogDebug("wyrm_appear PARAM2");
		string L_GAME_TIME = GetGameTime();
		NEXT_GIVEUP = L_GAME_TIME;
		NEXT_GIVEUP += 20.0;
		WYRM_TELEPORTING = 0;
		WYRM_SUBMERGING = 0;
		LAVA_VOLUME = 10;
		ScheduleDelayedEvent(0.1, "loop_lava");
		glow_toggle(1);
		WYRM_HIDE_MODE = 0;
		WYRM_UNHIDE_TIME = L_GAME_TIME;
		WYRM_UNHIDE_TIME += 5.0;
		SetInvincible(false);
		NPC_FLINCH_DISABLE = 0;
		npcatk_resume_movement();
		npcatk_resume_ai();
		wyrm_appear_fx();
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		PlayAnim("critical", ANIM_APPEAR);
		NEXT_SWIPE_CHECK = L_GAME_TIME;
		NEXT_SWIPE_CHECK += FREQ_SWIPE;
		NEXT_MODE_SWITCH = L_GAME_TIME;
		NEXT_MODE_SWITCH += FREQ_MODE_SWITCH;
		NEXT_PIT_SEARCH = L_GAME_TIME;
		NEXT_PIT_SEARCH += FREQ_PIT_SEARCH;
		if ((IsEntityAlive(WYRM_OLD_TARGET)))
		{
			if (GetEntityRange(WYRM_OLD_TARGET) < GetEntityRange(param1))
			{
				npcatk_settarget(WYRM_OLD_TARGET);
			}
			else
			{
				npcatk_settarget(GetEntityIndex(param1));
			}
		}
		else
		{
			npcatk_settarget(GetEntityIndex(param1));
		}
	}

	void intro_done()
	{
		INTRO_STAGE = 2;
		if ((WYRM_HIDE_MODE)) return;
		NPC_FLINCH_DISABLE = 0;
	}

	void npc_found_new_target()
	{
		WYRM_COMBAT_INITIATED = 1;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		string L_GAME_TIME = GetGameTime();
		if (L_GAME_TIME > NEXT_PASSIVE)
		{
			CUR_PASSIVE += 1;
			if (CUR_PASSIVE == 1)
			{
				// svplaysound: if ( CUR_PASSIVE == 1 ) svplaysound 2 10 SOUND_PASSIVE1
				EmitSound(2, 10, SOUND_PASSIVE1);
			}
			if (CUR_PASSIVE == 2)
			{
				// svplaysound: if ( CUR_PASSIVE == 2 ) svplaysound 2 10 SOUND_PASSIVE2
				EmitSound(2, 10, SOUND_PASSIVE2);
			}
			if (CUR_PASSIVE == 3)
			{
				// svplaysound: if ( CUR_PASSIVE == 3 ) svplaysound 2 10 SOUND_PASSIVE3
				EmitSound(2, 10, SOUND_PASSIVE3);
			}
			if (CUR_PASSIVE == 4)
			{
				// svplaysound: svplaysound 2 10 SOUND_PASSIVE4
				EmitSound(2, 10, SOUND_PASSIVE4);
				CUR_PASSIVE = 0;
			}
			NEXT_PASSIVE = L_GAME_TIME;
			NEXT_PASSIVE += FREQ_PASSIVE;
		}
		if (L_GAME_TIME > NEXT_LOOP_LAVA)
		{
			if ((WYRM_HIDE_MODE))
			{
				LAVA_VOLUME = 3;
				loop_lava();
			}
			else
			{
				LAVA_VOLUME = 10;
				loop_lava();
			}
		}
		if (m_hAttackTarget == "unset")
		{
			if (!(WYRM_HIDE_MODE))
			{
				if (L_GAME_TIME > NEXT_WORM_HIDE)
				{
				}
				NEXT_WORM_HIDE = 99999;
				do_submerge(1, "lack_of_target");
				LogDebug("hiding from lack of target");
			}
			else
			{
				if (L_GAME_TIME > NEXT_LOCAL_SCAN)
				{
					if (L_GAME_TIME > WYRM_UNHIDE_TIME)
					{
					}
					NEXT_LOCAL_SCAN = L_GAME_TIME;
					NEXT_LOCAL_SCAN += 0.5;
					string L_SPHERE = FindEntitiesInSphere("enemy", 512);
					if (L_SPHERE != "none")
					{
					}
					wyrm_appear(GetToken(L_SPHERE, 0, ";"), "local_scan");
					return;
				}
				if ((WYRM_PITHUNTER))
				{
				}
				if (L_GAME_TIME > NEXT_PITHUNT)
				{
				}
				NEXT_PITHUNT = L_GAME_TIME;
				NEXT_PITHUNT += 10.0;
				WYRM_PORTING_TO = "pit";
				find_next_pit("randomtarg");
				wyrm_teleport("pit_hunt");
			}
		}
		if ((WYRM_LIGHT_ACTIVE))
		{
			if (L_GAME_TIME > NEXT_LIGHT_REFRESH)
			{
			}
			glow_toggle(1);
		}
		if (!(WYRM_HIDE_MODE))
		{
			if (WYRM_MOVEDEST != "unset")
			{
			}
			string L_MY_ORG = GetEntityOrigin(GetOwner());
			string L_YAW = /* TODO: $angles */ $angles(L_MY_ORG, WYRM_MOVEDEST);
			string L_YAW = /* TODO: $vec.yaw */ $vec.yaw(L_YAW);
			SetVelocity(GetOwner(), /* TODO: $relvel */ $relvel(Vector3(0, L_YAW, 0), Vector3(0, WYRM_SPEED, 0)));
		}
		if ((WYRM_HIDE_MODE)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (L_GAME_TIME > NEXT_GIVEUP)
		{
			LogDebug("idle too long , giving up target...");
			NPCATK_TARGET = "unset";
		}
		SetMoveDest(m_hAttackTarget);
		string L_GAME_TIME = L_GAME_TIME;
		NEXT_WORM_HIDE = L_GAME_TIME;
		NEXT_WORM_HIDE += 20.0;
		if ((WYRM_USE_BOTH))
		{
			if (L_GAME_TIME > NEXT_MODE_SWITCH)
			{
			}
			NEXT_MODE_SWITCH = FREQ_MODE_SWITCH;
			NEXT_MODE_SWITCH += L_GAME_TIME;
			if (!(WYRM_HIDE_MODE))
			{
			}
			LogDebug("picking new movement mode");
			wyrm_pick_movement_mode("npcatk_hunt");
		}
		if (WYRM_MMODE == "edges")
		{
			string L_EDGE_ORG = /* TODO: $get_array */ $get_array(ARRAY_EDGE_POINTS, WYRM_NEXT_EDGE_IDX);
			WYRM_MOVEDEST = GetEntityOrigin(L_EDGE_ORG);
			string L_MY_POS = GetEntityOrigin(GetOwner());
			if (Distance(L_MY_POS, WYRM_MOVEDEST) < 16)
			{
				find_next_edge();
			}
		}
		if (WYRM_MMODE == "pits")
		{
			string L_PIT_ORG = /* TODO: $get_array */ $get_array(ARRAY_PIT_POINTS, WYRM_CUR_PIT);
			WYRM_MOVEDEST = GetEntityOrigin(L_PIT_ORG);
		}
		if (WYRM_MMODE == "none")
		{
			if (L_GAME_TIME > NEXT_WYRM_FLOAT)
			{
				NEXT_WYRM_FLOAT = L_GAME_TIME;
				NEXT_WYRM_FLOAT += Random(3.0, 7.0);
				string L_MOVE_YAW = Random(0, 359.99);
				string L_MOVE_TO = GetEntityOrigin(GetOwner());
				L_MOVE_TO += /* TODO: $relpos */ $relpos(Vector3(0, L_MOVE_YAW, 0), Vector3(0, 256, 0));
				WYRM_SPEED = 20;
				WYRM_MOVEDEST = L_MOVE_TO;
			}
		}
	}

	void bs_global_command()
	{
		LogDebug("bs_global_command GetEntityName(param1) PARAM2 PARAM3");
		if (!(param1 == m_hAttackTarget)) return;
		NPCATK_TARGET = "unset";
		if (!(param3 == "death")) return;
		ScheduleDelayedEvent(3.0, "anger_sated");
	}

	void anger_sated()
	{
		LogDebug("anger_sated");
		if (!(m_hAttackTarget == "unset")) return;
		if ((WYRM_HIDE_MODE)) return;
		if ((WYRM_TELEPORTING)) return;
		if (!(WYRM_MMODE != "edges")) return;
		do_submerge(1, "anger_sated");
	}

	void npc_targetsighted()
	{
		if (!(DID_INTRO))
		{
			DID_INTRO = 1;
			NPC_FLINCH_DISABLE = 1;
			INTRO_STAGE = 1;
			PlayAnim("critical", ANIM_RAWR);
			ScheduleDelayedEvent(3.0, "intro_done");
		}
		if (!(INTRO_STAGE > 1)) return;
		string L_GAME_TIME = GetGameTime();
		if (GetEntityRange(m_hAttackTarget) <= ATTACK_RANGE_BITE)
		{
			PlayAnim("once", ANIM_ATTACK);
		}
		else
		{
			if (L_GAME_TIME > NEXT_SPIT)
			{
			}
			NEXT_SPIT = GetGameTime();
			NEXT_SPIT += FREQ_SPIT;
			WYRM_SPIT_COUNT += 1;
			if (WYRM_SPIT_COUNT >= 5)
			{
				NEXT_SPIT += 10.0;
				WYRM_SPIT_COUNT = 0;
				DO_QUAKE = 1;
				PlayAnim("critical", ANIM_RAWR);
				return;
			}
			PlayAnim("once", ANIM_SPIT);
		}
	}

	void wyrm_pick_movement_mode()
	{
		LogDebug("wyrm_pick_movement_mode was WYRM_MMODE PARAM1");
		if (WYRM_MMODE == "pits")
		{
			if ((WYRM_USE_EDGES))
			{
			}
			WYRM_MMODE = "edges";
			find_next_edge();
			WYRM_PORTING_TO = "edge";
			wyrm_teleport("switch_modes_to_edge");
		}
		else
		{
			if ((WYRM_USE_PITS))
			{
			}
			WYRM_MMODE = "pits";
			find_next_pit();
			WYRM_PORTING_TO = "pit";
			wyrm_teleport("switch_modes_to_pits");
		}
		LogDebug("wyrm_pick_movement_mode is WYRM_MMODE PARAM1");
	}

	void find_next_edge()
	{
		if (!(WYRM_EDGE_INIT))
		{
			WYRM_EDGE_INIT += 1;
			T_NEAREST = 9999;
			for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_EDGE_POINTS); i++)
			{
				find_nearest_edge();
			}
			LogDebug("nearest edge WYRM_NEXT_EDGE_IDX");
			string L_EDGE_ORG = /* TODO: $get_array */ $get_array(ARRAY_EDGE_POINTS, WYRM_NEXT_EDGE_IDX);
			string L_EDGE_ORG = GetEntityOrigin(L_EDGE_ORG);
			LogDebug("find_next_edge init");
			SetEntityOrigin(GetOwner(), L_EDGE_ORG);
		}
		else
		{
			WYRM_NEXT_EDGE_IDX += 1;
			if (WYRM_NEXT_EDGE_IDX >= /* TODO: $math(subtract) */ /* TODO: $get_array_amt */ $get_array_amt(ARRAY_EDGE_POINTS))
			{
				LogDebug("find_next_edge hit last edge");
				WYRM_NEXT_EDGE_IDX = 0;
			}
		}
	}

	void find_nearest_edge()
	{
		string L_CUR_EDGE = /* TODO: $get_array */ $get_array(ARRAY_EDGE_POINTS, i);
		string L_CUR_EDGE_ORG = GetEntityOrigin(L_CUR_EDGE);
		string L_MY_POS = GetEntityOrigin(GetOwner());
		string L_DIST = Distance(L_MY_POS, L_CUR_EDGE_ORG);
		LogDebug("find_nearest_edge # game.script.iteration @ L_DIST vs T_NEAREST");
		if (!(L_DIST < T_NEAREST)) return;
		WYRM_NEXT_EDGE_IDX = i;
		T_NEAREST = L_DIST;
	}

	void find_next_pit()
	{
		LogDebug("find_next_pit PARAM1");
		if (param1 != "flee")
		{
			if (m_hAttackTarget == "unset")
			{
				LogDebug("find_next_pit no target , choosing...");
				if (GetPlayerCount() > 0)
				{
					LogDebug("find_next_pit getplayers...");
					GetAllPlayers(PIT_TARGET);
					LogDebug("find_next_pit sort by range...");
					PIT_TARGET = /* TODO: $sort_entlist */ $sort_entlist(PIT_TARGET, "range");
					LogDebug("find_next_pit survived sort by range...");
					if (param2 == "randomtarg")
					{
						LogDebug("find_next_pit PARAM2 picking random...");
						PIT_TARGET = GetToken(PIT_TARGET, RandomInt(0, /* TODO: $math(subtract) */ GetTokenCount(PIT_TARGET, ";")), ";");
					}
					else
					{
						LogDebug("find_next_pit picking nearest...");
						PIT_TARGET = GetToken(PIT_TARGET, 0, ";");
					}
					if (RandomInt(1, 5) == 1)
					{
						if (!(WYRM_PITHUNTER))
						{
						}
						int L_PICK_RANDOM = 1;
					}
					LogDebug("find_next_pit target GetEntityName(PIT_TARGET) rnd L_PICK_RANDOM typ PARAM2");
				}
				else
				{
					LogDebug("find_next_pit Ain t no one here,");
					int L_PICK_RANDOM = 1;
				}
			}
			else
			{
				PIT_TARGET = m_hAttackTarget;
				if (RandomInt(1, 5) == 1)
				{
					int L_PICK_RANDOM = 1;
				}
				LogDebug("find_next_pit curtarget GetEntityName(PIT_TARGET) rnd L_PICK_RANDOM");
			}
		}
		else
		{
			int L_PICK_RANDOM = 1;
		}
		if ((L_PICK_RANDOM))
		{
			LogDebug("find_next_pit picking random...");
			MOVE_TO_PIT_IDX = RandomInt(0, /* TODO: $math(subtract) */ /* TODO: $get_array_amt */ $get_array_amt(ARRAY_PIT_POINTS));
			MOVE_TO_PIT = /* TODO: $get_array */ $get_array(ARRAY_PIT_POINTS, MOVE_TO_PIT_IDX);
			if (MOVE_TO_PIT_IDX == WYRM_CUR_PIT_IDX)
			{
				MOVE_TO_PIT_IDX += 1;
				if (MOVE_TO_PIT_IDX >= /* TODO: $math(subtract) */ /* TODO: $get_array_amt */ $get_array_amt(ARRAY_PIT_POINTS))
				{
					MOVE_TO_PIT_IDX = 0;
				}
				MOVE_TO_PIT = /* TODO: $get_array */ $get_array(ARRAY_PIT_POINTS, MOVE_TO_PIT_IDX);
			}
			WYRM_CUR_PIT_IDX = MOVE_TO_PIT_IDX;
			LogDebug("find_next_pit random WYRM_CUR_PIT_IDX [ MOVE_TO_PIT ]");
		}
		else
		{
			T_LEAST_DIST = 9999;
			for (int i = 0; i < /* TODO: $get_array_amt */ $get_array_amt(ARRAY_PIT_POINTS); i++)
			{
				find_pit_nearest_target();
			}
			LogDebug("find_next_pit nearest2targ to GetEntityName(PIT_TARGET) GetEntityOrigin(PIT_TARGET) MOVE_TO_PIT_IDX [ MOVE_TO_PIT ]");
		}
	}

	void find_pit_nearest_target()
	{
		string L_CUR_PIT = /* TODO: $get_array */ $get_array(ARRAY_PIT_POINTS, i);
		string L_CUT_PIT_ORG = GetEntityOrigin(L_CUR_PIT);
		string L_PIT_TARG_ORG = GetEntityOrigin(PIT_TARGET);
		string L_PIT_DIST_FROM_TARG = Distance(L_CUT_PIT_ORG, L_PIT_TARG_ORG);
		LogDebug("find_pit_nearest_target # game.script.iteration dist L_PIT_DIST_FROM_TARG");
		if (!(L_PIT_DIST_FROM_TARG < T_LEAST_DIST)) return;
		T_LEAST_DIST = L_PIT_DIST_FROM_TARG;
		MOVE_TO_PIT_IDX = i;
		MOVE_TO_PIT = /* TODO: $get_array */ $get_array(ARRAY_PIT_POINTS, MOVE_TO_PIT_IDX);
	}

	void wyrm_teleport()
	{
		LogDebug("wyrm_teleport PARAM1");
		WYRM_TELEPORTING = 1;
		WYRM_TELE_STAGE2 = 1;
		if (!(WYRM_HIDE_MODE))
		{
			do_submerge(0, "teleporting");
		}
		else
		{
			wyrm_teleport2();
		}
	}

	void wyrm_teleport2()
	{
		if (!(WYRM_TELE_STAGE2)) return;
		WYRM_TELE_STAGE2 = 0;
		LogDebug("wyrm_teleport2 WYRM_TELEPORTING WYRM_PORTING_TO");
		string L_WIDTH = GetEntityWidth(GetOwner());
		L_WIDTH *= 1.5;
		LogDebug("wyrm_teleport2 width L_WIDTH");
		if (WYRM_PORTING_TO == "pit")
		{
			REPELL_POS = GetEntityOrigin(MOVE_TO_PIT);
		}
		if (WYRM_PORTING_TO == "edge")
		{
			string L_EDGE_ORG = /* TODO: $get_array */ $get_array(ARRAY_EDGE_POINTS, WYRM_NEXT_EDGE_IDX);
			REPELL_POS = GetEntityOrigin(L_EDGE_ORG);
		}
		LogDebug("wyrm_teleport2 repellpos REPELL_POS");
		REPELL_POS += "z";
		T_SPHERE = FindEntitiesInSphere("any", L_WIDTH);
		if (T_SPHERE != "none")
		{
			for (int i = 0; i < GetTokenCount(T_SPHERE, ";"); i++)
			{
				pitrepell_affect_targets();
			}
		}
		LogDebug("wyrm_teleport2 nextstage...");
		ScheduleDelayedEvent(0.5, "wyrm_teleport3");
	}

	void pitrepell_affect_targets()
	{
		string L_CUR_TARG = GetToken(T_SPHERE, i, ";");
		string L_TARG_ORG = GetEntityOrigin(L_CUR_TARG);
		string L_MY_ORG = GetEntityOrigin(REPELL_POS);
		string L_REPEL_YAW = /* TODO: $angles */ $angles(L_MY_ORG, L_TARG_ORG);
		SetVelocity(L_CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, L_REPEL_YAW, 0), Vector3(200, 1000, 200)));
	}

	void wyrm_teleport3()
	{
		LogDebug("wyrm_teleport3 WYRM_PORTING_TO");
		WYRM_TELEPORTING = 0;
		if (WYRM_PORTING_TO == "pit")
		{
			SetEntityOrigin(GetOwner(), GetEntityOrigin(MOVE_TO_PIT));
			WYRM_CUR_PIT = MOVE_TO_PIT;
			WYRM_CUR_PIT_IDX = MOVE_TO_PIT_IDX;
			if ((WYRM_PITHUNTER))
			{
			}
			GetAllPlayers(TARGET_LIST);
			string L_TARGET = /* TODO: $sort_entlist */ $sort_entlist(TARGET_LIST, "range");
			string L_TARGET = GetToken(L_TARGET, 0, ";");
			wyrm_appear(L_TARGET, "teleport2pit");
		}
		if (WYRM_PORTING_TO == "edge")
		{
			string L_EDGE_ORG = /* TODO: $get_array */ $get_array(ARRAY_EDGE_POINTS, WYRM_NEXT_EDGE_IDX);
			string L_EDGE_ORG = GetEntityOrigin(L_EDGE_ORG);
			LogDebug("wyrm_teleport3 WYRM_PORTING_TO WYRM_NEXT_EDGE_IDX L_EDGE_ORG");
			SetEntityOrigin(GetOwner(), L_EDGE_ORG);
			GetAllPlayers(TARGET_LIST);
			string L_TARGET = /* TODO: $sort_entlist */ $sort_entlist(TARGET_LIST, "range");
			string L_TARGET = GetToken(L_TARGET, 0, ";");
			wyrm_appear(L_TARGET, "teleport2edge");
		}
	}

	void frame_spit_start()
	{
		EmitSound(GetOwner(), 1, SOUND_SPIT_PREP, 10);
		EmitSound(GetOwner(), 2, "monsters/wyrm/8bit/c_x0stgwar_hit2.wav", 10);
	}

	void frame_spit_strike()
	{
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		EmitSound(GetOwner(), 0, SOUND_SPIT_STRIKE, 10);
		string L_TARG_ORG = GetEntityOrigin(m_hAttackTarget);
		L_TARG_ORG = "z";
		if (RandomInt(1, 2) == 1)
		{
			PROJ_TARGET = m_hAttackTarget;
		}
		else
		{
			PROJ_TARGET = "unset";
		}
		TossProjectile(PROJ_SCRIPT, GetEntityProperty(GetOwner(), "attachpos"), L_TARG_ORG, PROJ_SPEED, PROJ_DMG, PROJ_COF, "none");
	}

	void frame_blong_start()
	{
		if (!(DO_QUAKE))
		{
			// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2
			array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		else
		{
			EmitSound(GetOwner(), 0, "monsters/wyrm/quake_rawr.wav", 10);
		}
		if (!(DO_QUAKE)) return;
		start_quake();
	}

	void frame_blong_end()
	{
		if (INTRO_STAGE < 2)
		{
			intro_done();
			return;
		}
	}

	void frame_hbutt_start()
	{
		EmitSound(GetOwner(), 0, SOUND_HBUTT, 10);
	}

	void frame_hbutt_strike()
	{
		ANIM_ATTACK = ANIM_BITE1;
		DID_BITE = 0;
		EmitSound(GetOwner(), 0, SOUND_SWIPE_LARGE, 10);
		string L_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		string L_BURST_POS = GetEntityOrigin(GetOwner());
		L_BURST_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_YAW, 0), Vector3(0, /* TODO: $math(multiply) */ AOE_HBUTT, 0));
		L_BURST_POS = "z";
		L_BURST_POS += "z";
		XDoDamage(L_BURST_POS, AOE_HBUTT, DMG_HBUTT, 0.1, GetOwner(), GetOwner(), "none", "blunt_effect", "dmgevent:hbutt");
		LogDebug("frame_hbutt_strike yaw L_YAW org L_BURST_POS");
	}

	void frame_swipe_start()
	{
		EmitSound(GetOwner(), 0, SOUND_SWIPE, 10);
	}

	void frame_swipe_strike()
	{
		ANIM_ATTACK = ANIM_BITE2;
		DID_BITE = 0;
		EmitSound(GetOwner(), 0, SOUND_SWIPE_LARGE, 10);
		string L_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		string L_BURST_POS = GetEntityOrigin(GetOwner());
		L_BURST_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_YAW, 0), Vector3(0, /* TODO: $math(multiply) */ AOE_SWIPE, 0));
		L_BURST_POS = "z";
		L_BURST_POS += "z";
		XDoDamage(L_BURST_POS, AOE_SWIPE, DMG_SWIPE, 0.1, GetOwner(), GetOwner(), "none", "blunt_effect", "dmgevent:bigswipe");
		LogDebug("frame_swipe_strike yaw L_YAW org L_BURST_POS");
	}

	void frame_retract_start()
	{
		EmitSound(GetOwner(), 0, SOUND_SPLASH_DOWN, 10);
	}

	void submerge_failsafe()
	{
		if ((WYRM_SUBMERGE_GOT_ENDFRAME)) return;
		LogDebug("submerge_failsafe");
		frame_retract_end();
	}

	void frame_retract_end()
	{
		LogDebug("frame_retract_end notep WYRM_NO_TELEPORT_FLAG");
		WYRM_SUBMERGE_GOT_ENDFRAME = 1;
		WYRM_SUBMERGING = 0;
		wyrm_hide();
		if ((WYRM_NO_TELEPORT_FLAG))
		{
			WYRM_NO_TELEPORT_FLAG = 0;
			return;
		}
		wyrm_teleport2();
	}

	void frame_bite1_start()
	{
		EmitSound(GetOwner(), 0, SOUND_BITE, 10);
	}

	void frame_bite2_start()
	{
		EmitSound(GetOwner(), 0, SOUND_BITE, 10);
	}

	void frame_bite1_strike()
	{
		string L_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		string L_BURST_POS = GetEntityOrigin(GetOwner());
		L_BURST_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_YAW, 0), Vector3(0, /* TODO: $math(multiply) */ AOE_HBUTT, 0));
		L_BURST_POS = "z";
		L_BURST_POS += "z";
		XDoDamage(L_BURST_POS, AOE_HBUTT, DMG_BITE, 0.1, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:bite1");
		select_melee();
	}

	void frame_bite2_strike()
	{
		string L_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		string L_BURST_POS = GetEntityOrigin(GetOwner());
		L_BURST_POS += /* TODO: $relpos */ $relpos(Vector3(0, L_YAW, 0), Vector3(0, /* TODO: $math(multiply) */ AOE_HBUTT, 0));
		L_BURST_POS = "z";
		L_BURST_POS += "z";
		XDoDamage(L_BURST_POS, AOE_HBUTT, DMG_BITE, 0.1, GetOwner(), GetOwner(), "none", "pierce", "dmgevent:bite2");
		select_melee();
	}

	void select_melee()
	{
		DID_BITE += 1;
		if (DID_BITE > RandomInt(3, 4))
		{
			if (RandomInt(1, 3) == 1)
			{
				ANIM_ATTACK = ANIM_SWIPE;
			}
			else
			{
				ANIM_ATTACK = ANIM_HBUTT;
			}
		}
	}

	void frame_appear_start()
	{
		EmitSound(GetOwner(), 0, SOUND_SPLASH_UP, 10);
	}

	void hbutt_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(400, 0, 300));
		ApplyEffect(param2, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
	}

	void bite1_dodamage()
	{
		AddVelocity(param2, /* TODO: $relvel */ $relvel(100, 0, 200));
	}

	void bite2_dodamage()
	{
		AddVelocity(param2, /* TODO: $relvel */ $relvel(-100, 0, 200));
	}

	void hbutt_damaged_other()
	{
		LogDebug("hbutt_damaged_other GetEntityName(param1)");
	}

	void bigswipe_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		string L_TARG_ORG = GetEntityOrigin(param2);
		string L_MY_ORG = GetEntityOrigin(GetOwner());
		string L_REPEL_YAW = /* TODO: $angles */ $angles(L_MY_ORG, L_TARG_ORG);
		SetVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, L_REPEL_YAW, 0), Vector3(-800, 1000, 200)));
	}

	void swipe_damaged_other()
	{
		LogDebug("swipe_damaged_other GetEntityName(param1)");
	}

	void ext_fire_bomb()
	{
		LogDebug("ext_fire_bomb PARAM1");
		FIRE_BOMB_POS = param1;
		XDoDamage(FIRE_BOMB_POS, 128, DMG_PROJ_RAPID, 0.1, GetOwner(), GetOwner(), "none", "blunt_effect", "dmgevent:spit");
	}

	void spit_dodamage()
	{
		if (!(GetRelationship(param2) == "enemy")) return;
		if ((IsValidPlayer(param2)))
		{
			if (!(IsOnGround(param2)))
			{
			}
			return;
		}
		apply_dot1(GetEntityIndex(param2));
		string L_TARG_ORG = GetEntityOrigin(L_TARG_ORG);
		string L_MY_ORG = FIRE_BOMB_POS;
		string L_REPEL_YAW = /* TODO: $angles */ $angles(L_MY_ORG, L_TARG_ORG);
		AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, L_REPEL_YAW, 0), Vector3(0, 500, 100)));
	}

	void apply_dot1()
	{
		if ((GetEntityProperty(param1, "haseffect"))) return;
		ApplyEffect(param1, DOT_SCRIPT, DOT_DUR, GetEntityIndex(GetOwner()), DOT_DMG);
	}

	void apply_dot2()
	{
		if ((GetEntityProperty(param1, "haseffect"))) return;
		ApplyEffect(param1, DOT_SCRIPT2, DOT_DUR2, GetEntityIndex(GetOwner()), DOT_DMG2);
	}

	void frock_dodamage()
	{
		if (!(param1)) return;
		if (!(GetRelationship(param2) == "enemy")) return;
		apply_dot1(GetEntityIndex(param2));
		LogDebug("frock_dodamage GetEntityName(param2)");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		NEXT_GIVEUP = GetGameTime();
		NEXT_GIVEUP += 20.0;
		if ((GetEntityProperty(param1, "nopush")))
		{
			int L_INC_DMG = 1;
		}
		if ((L_INC_DMG))
		{
			string L_FIN_DMG = param2;
			L_FIN_DMG *= 4.0;
			SetDamage("dmg");
			return;
			if ((IsValidPlayer(param1)))
			{
				NEXT_PUSH_ALERT = 10.0;
				NEXT_PUSH_ALERT += GetGameTime();
				SendColoredMessage(param1, "Your push immunity causes you to absorb the GetEntityName(GetOwner()) 's sheer strength as extra damage!");
			}
		}
	}

	void OnDamage(int damage) override
	{
		if ((WYRM_PITHUNTER))
		{
			if (GetEntityHealth(GetOwner()) >= /* TODO: $math(multiply) */ GetEntityMaxHealth(GetOwner()))
			{
				DID_FLEE1 = 0;
			}
			if (GetEntityHealth(GetOwner()) >= /* TODO: $math(multiply) */ GetEntityMaxHealth(GetOwner()))
			{
				DID_FLEE2 = 0;
			}
			if (GetEntityHealth(GetOwner()) >= /* TODO: $math(multiply) */ GetEntityMaxHealth(GetOwner()))
			{
				DID_FLEE3 = 0;
			}
		}
		if (GetEntityHealth(GetOwner()) < /* TODO: $math(multiply) */ GetEntityMaxHealth(GetOwner()))
		{
			if (!(DID_FLEE1))
			{
			}
			DID_FLEE1 = 1;
			NEXT_PITHUNT = GetGameTime();
			NEXT_PITHUNT += 20.0;
			do_flee();
		}
		if (GetEntityHealth(GetOwner()) < /* TODO: $math(multiply) */ GetEntityMaxHealth(GetOwner()))
		{
			if (!(DID_FLEE2))
			{
			}
			DID_FLEE2 = 1;
			NEXT_PITHUNT = GetGameTime();
			NEXT_PITHUNT += 20.0;
			do_flee();
		}
		if (GetEntityHealth(GetOwner()) < /* TODO: $math(multiply) */ GetEntityMaxHealth(GetOwner()))
		{
			if (!(DID_FLEE3))
			{
			}
			DID_FLEE3 = 1;
			NEXT_PITHUNT = GetGameTime();
			NEXT_PITHUNT += 20.0;
			do_flee();
		}
	}

	void wyrm_appear_fx()
	{
		if (WYRM_TYPE == "fire")
		{
			ClientEvent("new", "all", "effects/sfx_sprite", GetEntityOrigin(GetOwner()), "xfire.spr", "0;5.0;100;add;(255,255,255);20;20", "once");
			Bleed(GetOwner(), "yellow", RandomInt(100, 10000));
			Bleed(GetOwner(), "yellow", RandomInt(100, 10000));
			Bleed(GetOwner(), "yellow", RandomInt(100, 10000));
			Bleed(GetOwner(), "yellow", RandomInt(100, 10000));
			Bleed(GetOwner(), "yellow", RandomInt(100, 10000));
			Bleed(GetOwner(), "yellow", RandomInt(100, 10000));
		}
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void loop_lava()
	{
		// svplaysound: svplaysound 3 0 SOUND_LAVA_LOOP
		EmitSound(3, 0, SOUND_LAVA_LOOP);
		ScheduleDelayedEvent(0.1, "loop_lava_act");
		NEXT_LOOP_LAVA = GetGameTime();
		NEXT_LOOP_LAVA += RandomInt(20, 75.0);
	}

	void loop_lava_act()
	{
		// svplaysound: svplaysound 3 LAVA_VOLUME SOUND_LAVA_LOOP
		EmitSound(3, LAVA_VOLUME, SOUND_LAVA_LOOP);
	}

	void start_quake()
	{
		Effect("glow", GetOwner(), Vector3(255, 128, 64), 128, DUR_QUAKE, DUR_QUAKE);
		DO_QUAKE = 0;
		GetAllPlayers(TARGET_LIST);
		for (int i = 0; i < GetTokenCount(TARGET_LIST, ";"); i++)
		{
			quake_filter_range();
		}
		LogDebug("start_quake targetlist TARGET_LIST");
		for (int i = 0; i < GetTokenCount(TARGET_LIST, ";"); i++)
		{
			quake_apply();
		}
	}

	void quake_filter_range()
	{
		string L_CUR_PLR = GetToken(TARGET_LIST, i, ";");
		string L_PLR_ORG = GetEntityOrigin(L_CUR_PLR);
		string L_MY_ORG = GetEntityOrigin(GetOwner());
		if (!(Distance(L_MY_ORG, L_PLR_ORG) > 1024)) return;
		SetToken(TARGET_LIST, i, 0, ";");
	}

	void quake_apply()
	{
		string L_CUR_PLR = GetToken(TARGET_LIST, i, ";");
		if (!(L_CUR_PLR != 0)) return;
		LogDebug("quake_apply GetEntityName(L_CUR_PLR)");
		CallExternal(L_CUR_PLR, "ext_quake_fx_volc", DUR_QUAKE, GetEntityIndex(GetOwner()));
	}

	void ext_frock_hit()
	{
		string L_PLR = /* TODO: $get_by_idx */ $get_by_idx(param1, "id");
		LogDebug("ext_frock_hit PARAM1 GetEntityName(L_PLR)");
		XDoDamage(L_PLR, "direct", DMG_FROCK, 1.0, GetOwner(), GetOwner(), "none", "blunt_effect", "dmgevent:frock");
	}

	void glow_toggle()
	{
		if ((param1))
		{
			if (WYRM_LIGHT_CLIDX != "WYRM_LIGHT_CLIDX")
			{
				ClientEvent("update", "all", WYRM_LIGHT_CLIDX, "remove_light");
			}
			ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), WYRM_GLOW_COLOR, 32, 30.0);
			WYRM_LIGHT_CLIDX = "game.script.last_sent_id";
			NEXT_LIGHT_REFRESH = GetGameTime();
			NEXT_LIGHT_REFRESH += 30.0;
			WYRM_LIGHT_ACTIVE = 1;
		}
		else
		{
			if (WYRM_LIGHT_CLIDX != "WYRM_LIGHT_CLIDX")
			{
				ClientEvent("update", "all", WYRM_LIGHT_CLIDX, "remove_light");
				WYRM_LIGHT_CLIDX = "WYRM_LIGHT_CLIDX";
				WYRM_LIGHT_ACTIVE = 0;
			}
		}
	}

	void mmode_switch()
	{
		NEXT_MODE_SWITCH = 0;
	}

	void do_flee()
	{
		NPCATK_TARGET = "unset";
		if (!(SUSPEND_AI))
		{
			npcatk_suspend_ai();
		}
		LogDebug("do_flee WYRM_MMODE");
		if ((WYRM_USE_BOTH))
		{
			NEXT_MODE_SWITCH = FREQ_MODE_SWITCH;
			NEXT_MODE_SWITCH += GetGameTime();
			wyrm_pick_movement_mode("flee");
			return;
		}
		if (WYRM_MMODE == "pits")
		{
			PlayAnim("once", "break");
			WYRM_PORTING_TO = "pit";
			find_next_pit("flee");
			wyrm_teleport("pitflee");
		}
		if (WYRM_MMODE == "edges")
		{
			WYRM_NEXT_EDGE_IDX = RandomInt(0, /* TODO: $math(subtract) */ /* TODO: $get_array_amt */ $get_array_amt(ARRAY_EDGE_POINTS));
			WYRM_PORTING_TO = "edge";
			do_submerge(0, "flee");
		}
	}

	void set_mmode()
	{
		if (!((param1).findFirst(PARAM) == 0)) return;
		LogDebug("set_mmode PARAM1");
		WYRM_MMODE = param1;
		if (WYRM_MMODE == "pits")
		{
			int L_PARAM_CORRECT = 1;
			find_next_pit();
		}
		if (WYRM_MMODE == "edges")
		{
			int L_PARAM_CORRECT = 1;
			find_next_edge();
		}
		if (WYRM_MMODE == "none")
		{
			int L_PARAM_CORRECT = 1;
			if (NPC_HOME_LOC != "NPC_HOME_LOC")
			{
				SetEntityOrigin(GetOwner(), NPC_HOME_LOC);
			}
		}
		ScheduleDelayedEvent(0.1, "wyrm_hide");
		LogDebug("set_mmode WYRM_MMODE");
		if ((L_PARAM_CORRECT)) return;
		string L_OUTSG = GetEntityProperty(GetOwner(), "itemname");
		L_OUTSG += ": addparam set_mmode - must be pits, edges, or none";
		SendInfoMsg("all", "MAP ERROR L_OUTSG");
		// TODO: chatlog GetTimestamp() MAP ERROR: L_OUTSG
	}

	void set_noquakes()
	{
		NO_QUAKES = 1;
	}

	void set_pithunt()
	{
		WYRM_PITHUNTER = 1;
	}

	void set_endpithunt()
	{
		WYRM_PITHUNTER = 0;
	}

	void set_edge_prefix()
	{
		if (!((param1).findFirst(PARAM) == 0)) return;
		WYRM_EDGE_PREFIX = param1;
	}

	void set_pit_prefix()
	{
		if (!((param1).findFirst(PARAM) == 0)) return;
		WYRM_PIT_PREFIX = param1;
	}

	void npc_targetvalidate()
	{
		if ((WYRM_TELEPORTING))
		{
			NPCATK_TARGET = "unset";
		}
		if ((WYRM_SUBMERGING))
		{
			NPCATK_TARGET = "unset";
		}
		if (m_hAttackTarget == "unset")
		{
			LogDebug("targetinvalidcuz: tele WYRM_TELEPORTING sub WYRM_SUBMERGING");
		}
		if (!(WYRM_HIDE_MODE)) return;
		if (!(GetEntityRange(m_hAttackTarget) > 256)) return;
		NPCATK_TARGET = "unset";
	}

	void do_submerge()
	{
		LogDebug("do_submerge PARAM1 PARAM2");
		WYRM_SUBMERGING = 1;
		WYRM_SUBMERGE_GOT_ENDFRAME = 0;
		NPC_FLINCH_DISABLE = 1;
		WYRM_NO_TELEPORT_FLAG = param1;
		SetInvincible(true);
		if ((WYRM_HIDE_MODE)) return;
		NPCATK_TARGET = "unset";
		if (!(SUSPEND_AI))
		{
			npcatk_suspend_ai();
		}
		PlayAnim("critical", ANIM_RETRACT);
		ScheduleDelayedEvent(3.0, "submerge_failsafe");
	}

}

}
