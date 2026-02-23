#pragma context server

#include "monsters/debug.as"

namespace MS
{

class UndamaelMsc : CGameScript
{
	int AM_EATING;
	string ANIM_ATTACK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BEAM2_ON;
	string BEAM_ATT1;
	int BEAM_COUNT;
	string BEAM_ENT;
	string BEAM_EYE1;
	string BEAM_EYE1_SEC;
	string BEAM_EYE2;
	string BEAM_EYE2_SEC;
	int BEAM_SOUND_ON;
	string BEAM_TARGET;
	int BEAM_VOL;
	int BEAM_WARM_UP;
	string BREATH_ORG;
	int BREATH_VOL;
	string BURN_BOX;
	string CUR_SPEED;
	int CYCLES_STARTED;
	int DOT_NUKE;
	string EAT_TARGET;
	int FB_COUNT;
	string FIRE_ANG;
	string FIRE_VEL;
	float FREQ_SPECIAL;
	string HEAD_ID;
	int HORRORS_UP;
	string IN_PIT_EDGE;
	string LAST_SAW_TARGET;
	string LAST_TARGET_SWITCH;
	string LAST_TOUCHED_EDGE;
	int MOVE_RANGE;
	string MY_CL_IDX;
	string NO_TURN;
	int NPC_CAN_ATTACK;
	string NPC_FWD_SPEED;
	int NPC_HACKED_MOVE_SPEED;
	string NPC_HOME_LOC;
	int NPC_IS_BOSS;
	string NPC_START_Z;
	int RAISED_LEVEL;
	string SOUND_BITE_HIT1;
	string SOUND_BITE_HIT2;
	string SOUND_HITEDGE1;
	string SOUND_HITEDGE2;
	string SOUND_HITEDGE3;
	string UNDI_ATTACK_TARGET;
	int UNDI_MAX_HEIGHT;
	string UNDI_MOVE_DEST;

	UndamaelMsc()
	{
		NPC_IS_BOSS = 1;
		const int DMG_NUKE = 800;
		const int DOT_BREATH = 40;
		DOT_NUKE = 80;
		const int DMG_BEAM1 = 1000;
		const int DMG_BEAM2 = 100;
		const int DMG_BITE = 80;
		const int SPEED_NORMAL = 10;
		FREQ_SPECIAL = 20.0;
		const string SMOKE_SPRITE = "bigsmoke.spr";
		const string ANIM_BREATH = "Floor_Fidget_Pissed";
		const int DETECT_RANGE = 1024;
		ATTACK_RANGE = 360;
		const int ATTACK_ZRANGE = 80;
		ATTACK_HITRANGE = 390;
		MOVE_RANGE = 300;
		ANIM_ATTACK = "Floor_Strike";
		SOUND_HITEDGE1 = "doors/doorstop5.wav";
		SOUND_HITEDGE2 = "doors/doorstop5.wav";
		SOUND_HITEDGE3 = "doors/doorstop5.wav";
		SOUND_BITE_HIT1 = "tentacle/te_strike1.wav";
		SOUND_BITE_HIT2 = "tentacle/te_strike2.wav";
		const string SOUND_BEAM1_WARMUP = "ambience/alienfazzle1.wav";
		const string SOUND_BEAM2_WARMUP = "x/x_teleattack1.wav";
		const string SOUND_PRE_BITE1 = "x/x_recharge1.wav";
		const string SOUND_PRE_BITE2 = "x/x_recharge2.wav";
		const string SOUND_IDLE1 = "tentacle/te_move1.wav";
		const string SOUND_IDLE2 = "tentacle/te_move2.wav";
		const string SOUND_BEAM1_FIRE = "x/x_ballattack1.wav";
		const string SOUND_BEAM2_FIRE = "debris/beamstart1.wav";
		const string SOUND_NUKE_WARMUP = "magic/spookie1.wav";
		const string SOUND_BREATH_LOOP = "magic/flame_loop.wav";
		const string SOUND_BREATH_START = "magic/flame_loop_start.wav";
		Precache("debris/pushbox1.wav");
		Precache("debris/pushbox2.wav");
		Precache("debris/pushbox3.wav");
		Precache("doors/doorstop5.wav");
		Precache("tentacle/te_strike1.wav");
		Precache("tentacle/te_strike2.wav");
		NPC_CAN_ATTACK = 0;
		UNDI_MAX_HEIGHT = 600;
		NPC_HACKED_MOVE_SPEED = 50;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(0.1);
		if (!(NO_TURN))
		{
		}
		if (BEAM_WARM_UP == 1)
		{
			ClientEvent("update", "all", MY_CL_IDX, "eye_beam_prep_cl", GetEntityProperty(GetOwner(), "attachpos"), GetEntityProperty(GetOwner(), "attachpos"));
		}
		if (BEAM_WARM_UP == 2)
		{
			ClientEvent("update", "all", MY_CL_IDX, "eye_beam_prep_cl2", GetEntityProperty(GetOwner(), "attachpos"), GetEntityProperty(GetOwner(), "attachpos"));
		}
		if (BEAM_ENT != "BEAM_ENT")
		{
			Effect("beam", "update", BEAM_ENT, "color", Vector3(RandomInt(0, 255), RandomInt(0, 255), RandomInt(0, 255)));
		}
		if (UNDI_ATTACK_TARGET == "unset")
		{
			if (!(BEAM2_ON))
			{
			}
			string BOX_SCAN = /* TODO: $get_tbox */ $get_tbox("enemy", 1024, GetMonsterProperty("origin"));
			LogDebug("scan_targets: BOX_SCAN");
			if (BOX_SCAN != "none")
			{
				string BOX_SCAN = /* TODO: $sort_entlist */ $sort_entlist(BOX_SCAN, "range");
				npcatk_settarget(GetToken(BOX_SCAN, 0, ";"), "scanned");
			}
			if (UNDI_ATTACK_TARGET == "unset")
			{
			}
			GetAllPlayers(PLAYER_LIST);
			ScrambleTokens(PLAYER_LIST, ";");
			string TARG_ID = GetToken(PLAYER_LIST, 0, ";");
			string TARG_ORG = GetEntityOrigin(TARG_ID);
			string TRACE_START = GetEntityProperty(GetOwner(), "attachpos");
			string TRACE_ORG = TraceLine(TRACE_START, TARG_ORG);
			if (TRACE_ORG == TARG_ORG)
			{
			}
			npcatk_settarget(TARG_ID, "scanned");
		}
		if (UNDI_ATTACK_TARGET != "unset")
		{
		}
		if (!(IsEntityAlive(UNDI_ATTACK_TARGET)))
		{
			my_target_died();
		}
		string TARG_RANGE = GetEntityRange(UNDI_ATTACK_TARGET);
		if (TARG_RANGE > DETECT_RANGE)
		{
			my_target_died();
		}
		string CAN_SEE_TARG = CanSee(UNDI_ATTACK_TARGET, 1024);
		if ((CAN_SET_TARG))
		{
			LAST_SAW_TARGET = GetGameTime();
			LAST_SAW_TARGET += 10.0;
		}
		if (!(CAN_SEE_TARG))
		{
			if (!(BEAM2_ON))
			{
			}
			string BOX_SCAN = /* TODO: $get_tbox */ $get_tbox("enemy", 1024);
			if (BOX_SCAN != "none")
			{
			}
			ScrambleTokens(BOX_SCAN, ";");
			npcatk_settarget(GetToken(BOX_SCAN, 0, ";"), "cant see");
		}
		if (UNDI_ATTACK_TARGET != "unset")
		{
		}
		string MY_ORG = GetMonsterProperty("origin");
		if (UNDI_MOVE_DEST == "unset")
		{
			string TARGET_ORG = GetEntityOrigin(UNDI_ATTACK_TARGET);
		}
		else
		{
			string TARGET_ORG = UNDI_MOVE_DEST;
		}
		string ANGLE_TO = /* TODO: $angles */ $angles(MY_ORG, TARGET_ORG);
		if (UNDI_MOVE_DEST == "unset")
		{
			SetAngles("face");
		}
		else
		{
			if (!(BEAM2_ON))
			{
			}
			string ATKTARGET_ORG = GetEntityOrigin(UNDI_ATTACK_TARGET);
			string F_ANGLE = /* TODO: $angles */ $angles(MY_ORG, ATKTARGET_ORG);
			SetAngles("face");
		}
		string DEST_DIR = (TARGET_ORG - MY_ORG).Normalize();
		string V_SPEED = (DEST_DIR).z;
		V_SPEED *= 8;
		if ((BEAM2_ON))
		{
			int V_SPEED = 0;
		}
		string DEST_LOC = MY_ORG;
		string MY_FOOT_ORG = MY_ORG;
		MY_FOOT_ORG = "z";
		string MY_DIST_2D = Distance(MY_FOOT_ORG, NPC_HOME_LOC);
		string MY_YAW = GetMonsterProperty("angles.yaw");
		if ((MY_ORG).z > UNDI_MAX_HEIGHT)
		{
			if (V_SPEED > 0)
			{
			}
			LogDebug("Too high!");
			int V_SPEED = -1;
		}
		if (!(IN_PIT_EDGE))
		{
			DEST_LOC += /* TODO: $relpos */ $relpos(Vector3(0, ANGLE_TO, 0), Vector3(0, NPC_FWD_SPEED, V_SPEED));
		}
		if ((IN_PIT_EDGE))
		{
			string ANGLE_TO = /* TODO: $angles */ $angles(MY_FOOT_ORG, NPC_HOME_LOC);
			DEST_LOC += /* TODO: $relpos */ $relpos(Vector3(0, ANGLE_TO, 0), Vector3(0, 5, V_SPEED));
		}
		string TARGET_ORG_XY = TARGET_ORG;
		TARGET_ORG_XY = "z";
		string TARG_DIST = Distance(MY_FOOT_ORG, TARGET_ORG_XY);
		if (TARG_DIST > MOVE_RANGE)
		{
			NPC_FWD_SPEED = CUR_SPEED;
		}
		else
		{
			NPC_FWD_SPEED = -1;
		}
		if (GetGameTime() > LAST_TOUCHED_EDGE)
		{
			IN_PIT_EDGE = 0;
		}
		SetEntityOrigin(GetOwner(), DEST_LOC);
		if ((NPC_CAN_ATTACK))
		{
		}
		if (GetEntityRange(UNDI_ATTACK_TARGET) < ATTACK_RANGE)
		{
			if (UNDI_MOVE_DEST == "unset")
			{
			}
			string Z_DIFF = GetMonsterProperty("origin.z");
			string TARG_Z = GetEntityProperty(UNDI_ATTACK_TARGET, "origin.z");
			TARG_Z -= 38;
			if (Z_DIFF >= TARG_Z)
			{
			}
			Z_DIFF -= TARG_Z;
			if (Z_DIFF < ATTACK_ZRANGE)
			{
			}
			PlayAnim("once", ANIM_ATTACK);
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(Random(1, 2));
		if (!(BEAM_SOUND_ON))
		{
		}
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_precache()
	{
		Precache("sfor/undamael_head");
		Precache("monsters/horror_fire");
	}

	void OnSpawn() override
	{
		SetName("undamael");
		SetName("Undamael");
		SetRace("undead");
		SetHealth(20000);
		SetModel("monsters/undamael.mdl");
		SetIdleAnim("Pit_Idle");
		SetHearingSensitivity(11);
		SetWidth(64);
		SetHeight(64);
		SetTurnRate(0.01);
		SetSolid("trigger");
		SetRoam(false);
		SetFly(true);
		SetInvincible(true);
		SetNoPush(true);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 3.0);
		HORRORS_UP = 0;
		ScheduleDelayedEvent(0.1, "init_beams");
		ClientEvent("new", "all", currentscript);
		MY_CL_IDX = "game.script.last_sent_id";
		UNDI_ATTACK_TARGET = "unset";
		UNDI_MOVE_DEST = "unset";
		CUR_SPEED = SPEED_NORMAL;
		ScheduleDelayedEvent(0.1, "npc_post_spawn");
	}

	void OnPostSpawn() override
	{
		adjust_footprint();
		CallExternal("all", "undamael_spawn");
	}

	void adjust_footprint()
	{
		string START_LOC = GetMonsterProperty("origin");
		START_LOC += "z";
		SetEntityOrigin(GetOwner(), START_LOC);
		NPC_HOME_LOC = START_LOC;
		NPC_START_Z = (NPC_HOME_LOC).z;
		UNDI_MAX_HEIGHT += NPC_START_Z;
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if (UNDI_ATTACK_TARGET == "unset")
		{
			string LAST_HEARD = GetEntityIndex("ent_lastheard");
			if (!(IsEntityAlive(UNDI_ATTACK_TARGET)))
			{
				npcatk_settarget(GetEntityIndex(LAST_HEARD), "heard");
			}
		}
		if (!(RAISED_LEVEL == 0)) return;
		RAISED_LEVEL = 1;
		ScheduleDelayedEvent(2.0, "raise_to_one");
	}

	void raise_to_one()
	{
		PlayAnim("critical", "rise_to_Temp1");
	}

	void mdl_rising()
	{
		if (!(RAISED_LEVEL == 1)) return;
		PlayAnim("critical", "Temp1_to_Floor");
		SetIdleAnim("Floor_Idle");
	}

	void my_target_died()
	{
		EmitSound(GetOwner(), 0, "x/x_attack1.wav", 10);
		UNDI_ATTACK_TARGET = "unset";
	}

	void mdl_pre_attack()
	{
		// PlayRandomSound from: SOUND_PRE_BITE1, SOUND_PRE_BITE2
		array<string> sounds = {SOUND_PRE_BITE1, SOUND_PRE_BITE2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void mdl_attack()
	{
		if (GetEntityRange(UNDI_ATTACK_TARGET) < ATTACK_HITRANGE)
		{
			string TARG_ORG = GetEntityOrigin(UNDI_ATTACK_TARGET);
			if ((IsValidPlayer(UNDI_ATTACK_TARGET)))
			{
				TARG_ORG += "z";
			}
			string TRACE_START = GetEntityProperty(GetOwner(), "attachpos");
			string TRACE_TARG = TraceLine(TRACE_START, TARG_ORG);
			DoDamage(TRACE_TARG, 384, DMG_BITE, 0.9, 0.5);
		}
		Effect("screenshake", GetEntityOrigin(GetOwner()), 256, 10, 1, 384);
		// PlayRandomSound from: SOUND_BITE_HIT1, SOUND_BITE_HIT2, SOUND_BITE_HIT2, SOUND_BITE_HIT2, SOUND_BITE_HIT2
		array<string> sounds = {SOUND_BITE_HIT1, SOUND_BITE_HIT2, SOUND_BITE_HIT2, SOUND_BITE_HIT2, SOUND_BITE_HIT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		CallExternal(HEAD_ID, "ext_unsolid", 1.0);
		if (!(EAT_ENABLED)) return;
		if (!(GetGameTime() > NEXT_EAT)) return;
		do_eat();
	}

	void ext_pitedge_touch()
	{
		LAST_TOUCHED_EDGE = GetGameTime();
		LAST_TOUCHED_EDGE += 1;
		if (!(IN_PIT_EDGE))
		{
			// PlayRandomSound from: SOUND_HITEDGE1, SOUND_HITEDGE2, SOUND_HITEDGE3
			array<string> sounds = {SOUND_HITEDGE1, SOUND_HITEDGE2, SOUND_HITEDGE3};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		IN_PIT_EDGE = 1;
		LogDebug("pitedge_set_topuch game.time");
	}

	void mdl_raise_done()
	{
		NPC_CAN_ATTACK = 1;
	}

	void npcatk_settarget()
	{
		LogDebug("npcatk_settarget GetEntityName(param1) PARAM2");
		if (!((HEAD_ID !is null)))
		{
			SpawnNPC("sfor/undamael_head", /* TODO: $relpos */ $relpos(0, 0, 64), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
			HEAD_ID = GetEntityIndex(m_hLastCreated);
			start_cycles();
		}
		if ((IsEntityAlive(UNDI_ATTACK_TARGET)))
		{
			if (param2 != "struck")
			{
			}
			if (GetGameTime() < LAST_SAW_TARGET)
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (UNDI_ATTACK_TARGET != "unset")
		{
			int EXIT_SUB = 1;
			if (GetGameTime() > LAST_TARGET_SWITCH)
			{
			}
			LAST_TARGET_SWITCH = GetGameTime();
			LAST_TARGET_SWITCH += 10.0;
			int EXIT_SUB = 0;
		}
		if ((EXIT_SUB)) return;
		if ((GetEntityProperty(param1, "scriptvar"))) return;
		if (!(GetRelationship(param1) != "ally")) return;
		if (!(IsEntityAlive(param1))) return;
		if (!(GetRelationship(param1) == "enemy")) return;
		if (!(GetEntityIndex(param1) != GetEntityIndex(GetOwner()))) return;
		if (!(GetEntityIndex(param1) != HEAD_ID)) return;
		if (!(GetEntityProperty(param1, "origin.z") > (NPC_HOME_LOC).z)) return;
		UNDI_ATTACK_TARGET = param1;
	}

	void ext_playanim()
	{
		PlayAnim("critical", param1);
		SetIdleAnim(param1);
	}

	void ext_noturn()
	{
		LogDebug("no_turn_set");
		if (!(NO_TURN))
		{
			NO_TURN = 1;
		}
		else
		{
			NO_TURN = 0;
		}
	}

	void ext_test()
	{
		string Z_DIFF = GetMonsterProperty("origin.z");
		Z_DIFF -= GetEntityProperty(UNDI_ATTACK_TARGET, "origin.z");
		LogDebug("targz GetEntityProperty(UNDI_ATTACK_TARGET, "origin.z") vs. game.monster.origin.z = Z_DIFF");
		string Z_LEVEL = NPC_HOME_LOC;
		string Z_DIFF = NPC_HOME_LOC;
		Z_DIFF = "z";
		LogDebug("ver_height_from_home Distance(Z_LEVEL, Z_DIFF)");
	}

	void ext_beam_relink()
	{
		string NEAR_FOLK = FindEntitiesInSphere("enemy", 2048);
		string N_FOLK = GetTokenCount(NEAR_FOLK, ";");
		N_FOLK -= 1;
		string RND_TARG = RandomInt(0, N_FOLK);
		string NEW_TARG = GetToken(NEAR_FOLK, RND_TARG, ";");
		Effect("beam", "update", BEAM_ENT, "start_target", NEW_TARG);
	}

	void ext_beam_att()
	{
		BEAM_TARGET = param1;
		BEAM_ATT1 = RandomInt(1, 3);
		Effect("beam", "update", BEAM_EYE1, "brightness", 200);
		Effect("beam", "update", BEAM_EYE1, "start_target", GetOwner(), BEAM_ATT1);
		Effect("beam", "update", BEAM_EYE1, "end_target", BEAM_TARGET, 0);
		ScheduleDelayedEvent(0.1, "ext_beam_att2");
	}

	void ext_beam_att2()
	{
		string BEAM_ATT2 = RandomInt(1, 3);
		LogMessage("BEAM_TARGET ext_beam_att BEAM_ATT1 BEAM_ATT2");
		Effect("beam", "update", BEAM_EYE2, "brightness", 200);
		Effect("beam", "update", BEAM_EYE2, "start_target", GetOwner(), BEAM_ATT2);
		Effect("beam", "update", BEAM_EYE2, "end_target", BEAM_TARGET, 0);
	}

	void ext_beam_remove()
	{
		Effect("beam", "update", BEAM_ENT, "remove", 0);
	}

	void ext_beam_new()
	{
		Effect("beam", "ents", "blueflare1.spr", 10, UNDI_ATTACK_TARGET, 0, GetEntityIndex(GetOwner()), 2, Vector3(0, 0, 255), 200, 0, 1000);
		BEAM_ENT = GetEntityIndex(m_hLastCreated);
	}

	void start_cycles()
	{
		if ((CYCLES_STARTED)) return;
		CYCLES_STARTED = 1;
		FREQ_SPECIAL("do_special");
	}

	void do_beam1()
	{
		if (GetEntityRange(UNDI_ATTACK_TARGET) < ATTACK_HITRANGE)
		{
			string TARGET_ORG = GetEntityOrigin(UNDI_ATTACK_TARGET);
			UNDI_MOVE_DEST = /* TODO: $relpos */ $relpos(Vector3(0, TARG_ANG, 0), Vector3(0, 1000, 0));
			ScheduleDelayedEvent(5.0, "do_beam1_2");
		}
		else
		{
			do_beam1_2();
		}
	}

	void do_beam1_2()
	{
		UNDI_MOVE_DEST = "unset";
		CUR_SPEED = 1;
		Effect("beam", "update", BEAM_EYE1, "noise", 60);
		Effect("beam", "update", BEAM_EYE1, "color", Vector3(255, 255, 255));
		Effect("beam", "update", BEAM_EYE2, "noise", 60);
		Effect("beam", "update", BEAM_EYE2, "color", Vector3(255, 255, 255));
		PlayAnim("critical", "Floor_Fidget_SmallRise");
		BEAM_WARM_UP = 1;
		BEAM_SOUND_ON = 1;
		EmitSound(GetOwner(), 1, SOUND_BEAM1_WARMUP, 10);
		ScheduleDelayedEvent(2.0, "do_beam1_3");
	}

	void do_beam1_3()
	{
		BEAM_WARM_UP = 0;
		BEAM_VOL = 10;
		beam_sound_fade();
		string TARG_ORG = GetEntityOrigin(UNDI_ATTACK_TARGET);
		string EYE_POS1 = GetEntityProperty(GetOwner(), "attachpos");
		string TRACE_TARG = TraceLine(EYE_POS1, TARG_ORG);
		if (TRACE_TARG == TARG_ORG)
		{
			EmitSound(GetOwner(), 0, SOUND_BEAM1_FIRE, 10);
			Effect("beam", "update", BEAM_EYE1, "end_target", UNDI_ATTACK_TARGET, 0);
			Effect("beam", "update", BEAM_EYE2, "end_target", UNDI_ATTACK_TARGET, 0);
			Effect("beam", "update", BEAM_EYE1, "brightness", 200);
			Effect("beam", "update", BEAM_EYE2, "brightness", 200);
			DoDamage(UNDI_ATTACK_TARGET, "direct", DMG_BEAM1, 1.0, GetOwner());
			AddVelocity(UNDI_ATTACK_TARGET, /* TODO: $relvel */ $relvel(-20, 800, 150));
			ScheduleDelayedEvent(2.0, "beams_off");
		}
		CUR_SPEED = SPEED_NORMAL;
	}

	void beam_sound_fade()
	{
		BEAM_VOL -= 1;
		if (BEAM_VOL == 0)
		{
			BEAM_SOUND_ON = 0;
		}
		EmitSound(GetOwner(), 1, SOUND_BEAM1_WARMUP, BEAM_VOL);
		if (BEAM_VOL > 0)
		{
			ScheduleDelayedEvent(0.2, "beam_sound_fade");
		}
	}

	void beams_off()
	{
		Effect("beam", "update", BEAM_EYE1, "brightness", 0);
		Effect("beam", "update", BEAM_EYE2, "brightness", 0);
	}

	void init_beams()
	{
		Effect("beam", "ents", "blueflare1.spr", 100, GetOwner(), 2, GetOwner(), 2, Vector3(255, 255, 255), 0, 60, -1);
		BEAM_EYE1 = GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(1.0, "init_beam2");
	}

	void init_beam2()
	{
		Effect("beam", "ents", "blueflare1.spr", 100, GetOwner(), 3, GetOwner(), 3, Vector3(255, 255, 255), 0, 60, -1);
		BEAM_EYE2 = GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(1.0, "init_beam3");
	}

	void init_beam3()
	{
		Effect("beam", "vector", "laserbeam.spr", 30, GetEntityOrigin(GetOwner()), GetEntityOrigin(GetOwner()), Vector3(255, 0, 255), 0, 10, -1);
		BEAM_EYE1_SEC = GetEntityIndex(m_hLastCreated);
		ScheduleDelayedEvent(1.0, "init_beam4");
	}

	void init_beam4()
	{
		Effect("beam", "vector", "laserbeam.spr", 30, GetEntityOrigin(GetOwner()), GetEntityOrigin(GetOwner()), Vector3(255, 0, 255), 0, 10, -1);
		BEAM_EYE2_SEC = GetEntityIndex(m_hLastCreated);
	}

	void client_activate()
	{
		int DO_NADDA = 1;
	}

	void eye_beam_prep_cl()
	{
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param1, "setup_eye_sprite");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param2, "setup_eye_sprite");
	}

	void eye_beam_prep_cl2()
	{
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param1, "setup_eye_sprite2");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param2, "setup_eye_sprite2");
	}

	void eye_beam_fire()
	{
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param1, "setup_eye_fire");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param2, "setup_eye_fire");
	}

	void eye_beam_green()
	{
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param1, "setup_eye_green");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param2, "setup_eye_green");
	}

	void eye_breath_fire()
	{
		FIRE_ANG = param2;
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param1, "setup_fire_breath");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param1, "setup_fire_breath");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param1, "setup_fire_breath");
		ClientEffect("tempent", "sprite", "3dmflaora.spr", param1, "setup_fire_breath");
	}

	void setup_eye_sprite()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0.1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 255, 255));
		ClientEffect("tempent", "set_current_prop", "gravity", Random(0.2, 0.1));
		ClientEffect("tempent", "set_current_prop", "collide", "world|die");
	}

	void setup_eye_sprite2()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 3);
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0.1);
		ClientEffect("tempent", "set_current_prop", "scale", 0.5);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 255));
		ClientEffect("tempent", "set_current_prop", "gravity", Random(0.2, 0.1));
		ClientEffect("tempent", "set_current_prop", "collide", "world|die");
	}

	void setup_eye_fire()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0.1);
		ClientEffect("tempent", "set_current_prop", "scale", 3);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(255, 0, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 0.01);
		ClientEffect("tempent", "set_current_prop", "collide", "world|die");
	}

	void setup_eye_green()
	{
		ClientEffect("tempent", "set_current_prop", "death_delay", 1);
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0.1);
		ClientEffect("tempent", "set_current_prop", "scale", 3);
		ClientEffect("tempent", "set_current_prop", "rendercolor", Vector3(0, 255, 0));
		ClientEffect("tempent", "set_current_prop", "gravity", 0.01);
		ClientEffect("tempent", "set_current_prop", "collide", "world|die");
	}

	void setup_fire_breath()
	{
		FIRE_VEL = Random(100, 500);
		if (FIRE_ANG < 0)
		{
			if (FIRE_VEL > -179)
			{
			}
			FIRE_VEL = Random(-500, -100);
		}
		ClientEffect("tempent", "set_current_prop", "death_delay", 2);
		ClientEffect("tempent", "set_current_prop", "angles", Vector3(0, FIRE_ANG, 0));
		ClientEffect("tempent", "set_current_prop", "velocity", Vector3(Random(-100, 100), FIRE_VEL, Random(-200, 200)));
		ClientEffect("tempent", "set_current_prop", "fadeout", "lifetime");
		ClientEffect("tempent", "set_current_prop", "bouncefactor", 0.1);
		ClientEffect("tempent", "set_current_prop", "scale", 3);
		ClientEffect("tempent", "set_current_prop", "gravity", 0.01);
		ClientEffect("tempent", "set_current_prop", "collide", "world|die");
	}

	void do_special()
	{
		string RND_SPECIAL = RandomInt(2, 6);
		if (UNDI_ATTACK_TARGET == "unset")
		{
			int RND_SPECIAL = 0;
			FREQ_SPECIAL = 10.0;
		}
		if ((AM_EATING))
		{
			int RND_SPECIAL = 1;
			FREQ_SPECIAL = 40.0;
		}
		if (RND_SPECIAL == 2)
		{
			if (HORRORS_UP >= 4)
			{
				FREQ_SPECIAL = 1.0;
			}
			if (HORRORS_UP < 4)
			{
			}
			HORRORS_UP += 2;
			FREQ_SPECIAL = 20.0;
			do_horrors();
		}
		if (RND_SPECIAL == 3)
		{
			do_beam1();
			FREQ_SPECIAL = 20.0;
		}
		if (RND_SPECIAL == 4)
		{
			do_beam2();
			FREQ_SPECIAL = 40.0;
		}
		if (RND_SPECIAL == 5)
		{
			do_nuke();
			FREQ_SPECIAL = 20.0;
		}
		if (RND_SPECIAL == 6)
		{
			do_breath_fire();
			FREQ_SPECIAL = 20.0;
		}
		FREQ_SPECIAL("do_special");
	}

	void do_beam2()
	{
		if (GetEntityRange(UNDI_ATTACK_TARGET) < 512)
		{
			string TARGET_ORG = GetEntityOrigin(UNDI_ATTACK_TARGET);
			string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
			UNDI_MOVE_DEST = /* TODO: $relpos */ $relpos(Vector3(0, TARG_ANG, 0), Vector3(0, -1000, -256));
			ScheduleDelayedEvent(5.0, "do_beam2_2");
		}
		else
		{
			do_beam2_2();
		}
	}

	void do_beam2_2()
	{
		UNDI_MOVE_DEST = GetEntityOrigin(GetOwner());
		CUR_SPEED = 1;
		PlayAnim("critical", "Floor_Fidget_SmallRise");
		BEAM_WARM_UP = 2;
		BEAM_SOUND_ON = 1;
		// svplaysound: svplaysound 1 10 SOUND_BEAM2_WARMUP
		EmitSound(1, 10, SOUND_BEAM2_WARMUP);
		ScheduleDelayedEvent(2.0, "do_beam2_init");
	}

	void do_beam2_init()
	{
		BEAM_WARM_UP = 0;
		BEAM_COUNT = 0;
		EmitSound(GetOwner(), 0, SOUND_BEAM2_FIRE, 10);
		Effect("beam", "update", BEAM_EYE1_SEC, "brightness", 128);
		Effect("beam", "update", BEAM_EYE2_SEC, "brightness", 128);
		string MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		MY_YAW -= 35;
		if (MY_YAW < 0)
		{
			MY_YAW += 359.99;
		}
		SetAngles("face");
		BEAM2_ON = 1;
		ScheduleDelayedEvent(0.01, "do_beam2_cycle");
	}

	void do_beam2_cycle()
	{
		string MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		MY_YAW += 0.5;
		if (MY_YAW > 359.99)
		{
			MY_YAW -= 359.99;
		}
		SetAngles("face");
		string MY_Z = GetEntityProperty(GetOwner(), "origin.z");
		MY_Z += 64;
		string HIS_Z = GetEntityProperty(UNDI_ATTACK_TARGET, "origin.z");
		string MY_ORG = GetEntityOrigin(GetOwner());
		if (MY_Z >= HIS_Z)
		{
			MY_ORG += "z";
			SetEntityOrigin(GetOwner(), MY_ORG);
		}
		else
		{
			if ((MY_ORG).z < UNDI_MAX_HEIGHT)
			{
			}
			MY_ORG += "z";
			SetEntityOrigin(GetOwner(), MY_ORG);
		}
		string BEAM1_START = GetEntityProperty(GetOwner(), "attachpos");
		string BEAM2_START = GetEntityProperty(GetOwner(), "attachpos");
		string BEAM1_END = BEAM1_START;
		string BEAM2_END = BEAM2_START;
		BEAM1_END += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 1000, 0));
		BEAM2_END += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 1000, 0));
		string BEAM1_END = TraceLine(BEAM1_START, BEAM1_END);
		string BEAM2_END = TraceLine(BEAM2_START, BEAM2_END);
		Effect("beam", "update", BEAM_EYE1_SEC, "points", BEAM1_START, BEAM1_END);
		Effect("beam", "update", BEAM_EYE2_SEC, "points", BEAM2_START, BEAM2_END);
		XDoDamage(BEAM1_START, BEAM1_END, DMG_BEAM2, 1.0, GetOwner(), GetOwner(), "none", "dark");
		XDoDamage(BEAM2_START, BEAM2_END, DMG_BEAM2, 1.0, GetOwner(), GetOwner(), "none", "dark");
		BEAM_COUNT += 1;
		if (BEAM_COUNT == 120)
		{
			do_beam2_end();
		}
		else
		{
			ScheduleDelayedEvent(0.1, "do_beam2_cycle");
		}
	}

	void do_beam2_end()
	{
		BEAM2_ON = 0;
		UNDI_MOVE_DEST = "unset";
		CUR_SPEED = SPEED_NORMAL;
		Effect("beam", "update", BEAM_EYE1_SEC, "brightness", 0);
		Effect("beam", "update", BEAM_EYE2_SEC, "brightness", 0);
		// svplaysound: svplaysound 1 0 SOUND_BEAM2_WARMUP
		EmitSound(1, 0, SOUND_BEAM2_WARMUP);
	}

	void do_nuke()
	{
		if (GetEntityRange(UNDI_ATTACK_TARGET) < 512)
		{
			string TARGET_ORG = GetEntityOrigin(UNDI_ATTACK_TARGET);
			string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
			UNDI_MOVE_DEST = /* TODO: $relpos */ $relpos(Vector3(0, TARG_ANG, 0), Vector3(0, -1000, -256));
			ScheduleDelayedEvent(5.0, "do_nuke_warmup");
			EmitSound(GetOwner(), 0, SOUND_NUKE_WARMUP, 10);
		}
		else
		{
			do_nuke_warmup();
		}
	}

	void do_nuke_warmup()
	{
		UNDI_MOVE_DEST = GetEntityOrigin(GetOwner());
		PlayAnim("critical", "Floor_Fidget_SmallRise");
		ClientEvent("update", "all", MY_CL_IDX, "eye_beam_fire", GetEntityProperty(GetOwner(), "attachpos"), GetEntityProperty(GetOwner(), "attachpos"));
		EmitSound(GetOwner(), 0, SOUND_NUKE_WARMUP, 10);
		ScheduleDelayedEvent(2.0, "do_nuke_fire");
	}

	void do_nuke_fire()
	{
		UNDI_MOVE_DEST = "unset";
		CallExternal(FindEntityByName("head_undi"), "do_nuke", UNDI_ATTACK_TARGET, DMG_NUKE);
	}

	void do_breath_fire()
	{
		UNDI_MOVE_DEST = GetEntityOrigin(GetOwner());
		PlayAnim("critical", ANIM_BREATH);
		FB_COUNT = 0;
		ScheduleDelayedEvent(0.1, "do_breath_fire_loop");
		BREATH_VOL = 10;
		EmitSound(GetOwner(), 1, SOUND_BREATH_LOOP, 10);
		EmitSound(GetOwner(), 0, SOUND_BREATH_START, 10);
	}

	void do_breath_fire_loop()
	{
		FB_COUNT += 1;
		if (FB_COUNT == 60)
		{
			breath_sound_fade();
			UNDI_MOVE_DEST = "unset";
		}
		if (!(FB_COUNT < 60)) return;
		ScheduleDelayedEvent(0.1, "do_breath_fire_loop");
		PlayAnim("once", ANIM_BREATH);
		BREATH_ORG = GetEntityProperty(GetOwner(), "attachpos");
		ClientEvent("update", "all", MY_CL_IDX, "eye_breath_fire", BREATH_ORG, GetEntityProperty(GetOwner(), "angles.yaw"));
		if (FB_COUNT == 5)
		{
			burn_inbox();
		}
		if (FB_COUNT == 25)
		{
			burn_inbox();
		}
		if (FB_COUNT == 45)
		{
			burn_inbox();
		}
		if (FB_COUNT == 55)
		{
			burn_inbox();
		}
	}

	void burn_inbox()
	{
		BURN_BOX = /* TODO: $get_tbox */ $get_tbox("enemy", 512, BREATH_ORG);
		LogDebug("burn_inbox BURN_BOX");
		if (!(BURN_BOX != "none")) return;
		for (int i = 0; i < GetTokenCount(BURN_BOX, ";"); i++)
		{
			burn_targets_in_cone();
		}
	}

	void burn_targets_in_cone()
	{
		string BURN_TARG = GetToken(BURN_BOX, i, ";");
		string TARG_ORG = GetEntityOrigin(BURN_TARG);
		string MY_ANG = GetEntityAngles(GetOwner());
		string IN_CONE = /* TODO: $within_cone */ $within_cone(TARG_ORG, BREATH_ORG, MY_ANG, 45);
		if (!(IN_CONE)) return;
		if (!(Distance(BREATH_ORG, TARG_ORG) < 512)) return;
		if (!(TraceLine(BREATH_ORG, TARG_ORG) == TARG_ORG)) return;
		ApplyEffect(BURN_TARG, "effects/dot_fire", 10, GetEntityIndex(GetOwner()), DOT_BREATH);
	}

	void breath_sound_fade()
	{
		BREATH_VOL -= 1;
		EmitSound(GetOwner(), 1, SOUND_BREATH_LOOP, BREATH_VOL);
		if (BREATH_VOL > 0)
		{
			ScheduleDelayedEvent(0.2, "breath_sound_fade");
		}
	}

	void horror_died()
	{
		HORRORS_UP -= 1;
		LogDebug("horror_died HORRORS_UP");
	}

	void do_horrors()
	{
		if (GetEntityRange(UNDI_ATTACK_TARGET) < 512)
		{
			string TARGET_ORG = GetEntityOrigin(UNDI_ATTACK_TARGET);
			string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
			UNDI_MOVE_DEST = /* TODO: $relpos */ $relpos(Vector3(0, TARG_ANG, 0), Vector3(0, -1000, -256));
			ScheduleDelayedEvent(5.0, "do_horrors_summon");
		}
		else
		{
			do_horrors_summon();
		}
	}

	void do_horrors_summon()
	{
		PlayAnim("critical", "Engine_Idle");
		EmitSound(GetOwner(), 0, SOUND_PRE_SUMMON, 10);
		ClientEvent("update", "all", MY_CL_IDX, "eye_beam_green", GetEntityProperty(GetOwner(), "attachpos"), GetEntityProperty(GetOwner(), "attachpos"));
		ScheduleDelayedEvent(1.0, "make_horror1");
		ScheduleDelayedEvent(1.1, "make_horror2");
	}

	void make_horror1()
	{
		SpawnNPC("monsters/horror_fire", /* TODO: $relpos */ $relpos(-100, 0, 64), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
	}

	void make_horror2()
	{
		UNDI_MOVE_DEST = "unset";
		SpawnNPC("monsters/horror_fire", /* TODO: $relpos */ $relpos(100, 0, 64), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
	}

	void do_eat()
	{
		UNDI_MOVE_DEST = START_LOC;
		PlayAnim("critical", "tentacle_grab");
		EAT_TARGET = UNDI_ATTACK_TARGET;
		AM_EATING = 1;
		EmitSound(GetOwner(), 0, "barnacle/bcl_chew1.wav", 10);
		ScheduleDelayedEvent(0.1, "eat_loop");
		ScheduleDelayedEvent(3.0, "eat_sound");
		ScheduleDelayedEvent(6.0, "eat_done");
	}

	void eat_sound()
	{
		EmitSound(GetOwner(), 0, "barnacle/bcl_chew2.wav", 10);
	}

	void eat_loop()
	{
		if (!(AM_EATING)) return;
		SetEntityOrigin(EAT_TARGET, GetEntityProperty(GetOwner(), "attachpos"));
		PlayAnim("once", "tentacle_grab");
		ScheduleDelayedEvent(0.1, "eat_loop");
	}

	void eat_done()
	{
		UNDI_MOVE_DEST = "unset";
		AM_EATING = 0;
		PlayAnim("critical", "rise_to_Temp1");
	}

	void death_sequence()
	{
		SetIdleAnim("Engine_death2");
		PlayAnim("critical", "Engine_death2");
		EmitSound(GetOwner(), 0, SOUND_DEATH, 10);
		Effect("screenshake", GetEntityOrigin(GetOwner()), 256, 10, 20.0, 1024);
		ScheduleDelayedEvent(1.0, "reward_victor");
		ScheduleDelayedEvent(5.0, "remove_me");
	}

	void reward_victor()
	{
		if (!(StringToLower(GetMapName()) == "sfor")) return;
		string SWORD_ORIGIN = GetEntityOrigin(GetOwner());
		z += SWORD_ORIGIN;
		CallExternal(GAME_MASTER, "undamael_reward_victor", SWORD_ORIGIN);
	}

	void remove_me()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
