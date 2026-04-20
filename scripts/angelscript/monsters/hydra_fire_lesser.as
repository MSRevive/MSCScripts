#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_propelled.as"
#include "monsters/base_struck.as"

namespace MS
{

class HydraFireLesser : CGameScript
{
	int AM_BREATHING;
	string ANIM_ALERT;
	string ANIM_ATTACK;
	string ANIM_BITE1;
	string ANIM_BITE2;
	string ANIM_BITE3;
	string ANIM_BREATH_CONE;
	string ANIM_BREATH_GUIDED;
	string ANIM_BREATH_RAPID;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_FLINCH1;
	string ANIM_FLINCH2;
	string ANIM_HEADWHIP;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_TAILWHIP;
	string ANIM_WALK;
	int AOE_TAIL;
	string AS_ATTACKING;
	int ATTACH_HEAD_LEFT;
	int ATTACH_HEAD_LEFT1;
	int ATTACH_HEAD_MID;
	int ATTACH_HEAD_MID1;
	int ATTACH_HEAD_RIGHT;
	int ATTACH_HEAD_RIGHT1;
	int ATTACH_TAIL;
	int ATTACH_TAIL1;
	string ATTACK_HITRANGE;
	string ATTACK_RANGE;
	string AURA_CL_SCRIPT;
	string AURA_ELEMENT;
	string AURA_SIZE;
	int BREATH_CONE_ACTIVE;
	int BREATH_CONE_AOE;
	int BREATH_CONE_ON;
	int BREATH_CONE_RANGE;
	string BREATH_CONE_YAW;
	string BREATH_TARGS;
	int BREATH_TYPE;
	string COL_BEAM1;
	string COL_BEAM2;
	string CONE_TARGS;
	string CUR_BREATH_ANIM;
	string CUR_BREATH_ORG;
	string CUR_BREATH_TARG;
	string DID_INTRO;
	string DID_TAIL;
	int DMG_BITE1;
	int DMG_BITE2;
	int DMG_BITE3;
	int DMG_BREATH_CONE;
	int DMG_PROJ_GUIDED;
	int DMG_PROJ_RAPID;
	int DMG_TAIL;
	int DOTALT_DMG;
	float DOTALT_DUR;
	string DOTALT_EFFECTNAME;
	string DOTALT_SCRIPT;
	int DOT_DMG;
	float DOT_DUR;
	string DOT_EFFECTNAME;
	string DOT_SCRIPT;
	string FIRE_BOMB_POS;
	float FREQ_BREATH;
	float FREQ_CL_REFRESH;
	float FREQ_TAIL_CHECK;
	float GAME_PUSH_RATIO;
	string HAD_TARGET;
	int HYDRA_ATTACK_HITRANGE;
	int HYDRA_ATTACK_RANGE;
	int HYDRA_DID_INIT;
	int HYDRA_RUN_SPEED;
	int HYDRA_SIZE;
	string HYDRA_TYPE;
	int HYDRA_WALK_SPEED;
	string MOVE_SUSPEND_UNTIL;
	string MY_CL_IDX;
	string NEXT_AURA_SCAN;
	string NEXT_BREATH;
	string NEXT_CL_REFRESH;
	string NEXT_CONE_SCAN;
	string NEXT_TAIL_CHECK;
	int NPC_FLINCH_DISABLE;
	float NPC_FLINCH_THRESH;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	int NPC_USE_FLINCH;
	int NPC_USE_IDLE;
	int NPC_USE_PAIN;
	float PROJ_ELEMENT_MAX_DURATION;
	int PROJ_ELEMENT_SPEED;
	string PROJ_ELEMENT_TARGET;
	string PROJ_ELEMENT_TYPE;
	int PROJ_FIRE_BOMB_AOE;
	float PROJ_FIRE_BOMB_SCALE;
	string PROJ_GUIDED_ELEMENT;
	string PROJ_GUIDED_SCRIPT;
	string PROJ_RAPID_SCRIPT;
	int RAPID_BREATH_COUNT;
	string RESET_CYCLES;
	int SHOT_GUIDED;
	string SOUND_ALERT;
	string SOUND_ATTACK_HEAD1;
	string SOUND_ATTACK_HEAD2;
	string SOUND_ATTACK_HEAD3;
	string SOUND_BREATH1_START;
	string SOUND_BREATH1_STRIKE;
	string SOUND_BREATH2_LOOP;
	string SOUND_BREATH2_START;
	string SOUND_BREATH2_STRIKE;
	string SOUND_COMBAT1;
	string SOUND_COMBAT2;
	string SOUND_COMBAT3;
	string SOUND_DEATH;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PAIN3;
	string SOUND_TAIL;
	string TAIL_TARGS;

	HydraFireLesser()
	{
		ANIM_IDLE = "anim_idle";
		ANIM_WALK = "anim_walk";
		ANIM_RUN = "anim_walk";
		ANIM_FLINCH = "anim_flinch1";
		ANIM_DEATH = "anim_death";
		ANIM_ATTACK = "anim_bite1";
		ANIM_ALERT = "anim_alert";
		ANIM_BITE1 = "anim_bite1";
		ANIM_BITE2 = "anim_bite2";
		ANIM_BITE3 = "anim_bite3";
		ANIM_BREATH_RAPID = "anim_breath1";
		ANIM_BREATH_CONE = "anim_breath2";
		ANIM_BREATH_GUIDED = "anim_breath3";
		ANIM_HEADWHIP = "anim_whip_head";
		ANIM_TAILWHIP = "anim_whip_tail";
		ANIM_FLINCH1 = "anim_flinch1";
		ANIM_FLINCH2 = "anim_flinch2";
		ATTACH_HEAD_LEFT = 0;
		ATTACH_HEAD_MID = 1;
		ATTACH_HEAD_RIGHT = 2;
		ATTACH_TAIL = 3;
		ATTACH_HEAD_LEFT1 = 1;
		ATTACH_HEAD_MID1 = 2;
		ATTACH_HEAD_RIGHT1 = 3;
		ATTACH_TAIL1 = 4;
		GAME_PUSH_RATIO = 0.1;
		HYDRA_ATTACK_RANGE = 246;
		HYDRA_ATTACK_HITRANGE = 280;
		ATTACK_RANGE = HYDRA_ATTACK_RANGE;
		ATTACK_HITRANGE = HYDRA_ATTACK_HITRANGE;
		NPC_GIVE_EXP = 750;
		SOUND_DEATH = "monsters/hydra/death_final.wav";
		NPC_HACKED_MOVE_SPEED = 50;
		NPC_USE_PAIN = 1;
		NPC_USE_FLINCH = 1;
		NPC_FLINCH_THRESH = 0.01;
		NPC_USE_IDLE = 1;
		SOUND_IDLE1 = "monsters/hydra/c_bulette_slct.wav";
		SOUND_IDLE2 = "monsters/hydra/c_bulette_dead1.wav";
		SOUND_IDLE3 = "monsters/hydra/c_bulette_dead2.wav";
		SOUND_PAIN1 = "monsters/hydra/c_bulette_hit1.wav";
		SOUND_PAIN2 = "monsters/hydra/c_bulette_hit2.wav";
		SOUND_PAIN3 = "monsters/hydra/c_bulette_hit3.wav";
		HYDRA_TYPE = "fire";
		HYDRA_SIZE = 1;
		HYDRA_RUN_SPEED = 150;
		HYDRA_WALK_SPEED = 50;
		AURA_CL_SCRIPT = "monsters/hydra_fire_lesser_cl";
		AURA_ELEMENT = "fire_effect";
		FREQ_CL_REFRESH = 30.0;
		COL_BEAM1 = Vector3(255, 0, 0);
		COL_BEAM2 = Vector3(255, 128, 0);
		DOT_DMG = 50;
		DOT_DUR = 5.0;
		DOT_SCRIPT = "effects/dot_fire";
		DOT_EFFECTNAME = "DOT_fire";
		DOTALT_DMG = 100;
		DOTALT_DUR = 5.0;
		DOTALT_SCRIPT = "effects/dot_fire";
		DOTALT_EFFECTNAME = "DOT_fire";
		DMG_BITE1 = 150;
		DMG_BITE2 = 175;
		DMG_BITE3 = 200;
		DMG_TAIL = 600;
		AOE_TAIL = 164;
		FREQ_BREATH = 20.0;
		FREQ_TAIL_CHECK = 10.0;
		DMG_PROJ_RAPID = 200;
		PROJ_RAPID_SCRIPT = "proj_fire_bomb";
		DMG_BREATH_CONE = 100;
		BREATH_CONE_RANGE = 256;
		BREATH_CONE_AOE = 256;
		DMG_PROJ_GUIDED = 1000;
		PROJ_GUIDED_SCRIPT = "proj_elemental_guided";
		PROJ_GUIDED_ELEMENT = "fire";
		SOUND_COMBAT1 = "monsters/hydra/c_bulette_bat1.wav";
		SOUND_COMBAT2 = "monsters/hydra/c_bulette_bat2.wav";
		SOUND_COMBAT3 = "monsters/hydra/c_bulette_dead3.wav";
		SOUND_ATTACK_HEAD1 = "monsters/hydra/c_bulette_atk1.wav";
		SOUND_ATTACK_HEAD2 = "monsters/hydra/c_bulette_atk2.wav";
		SOUND_ATTACK_HEAD3 = "monsters/hydra/c_bulette_atk3.wav";
		SOUND_TAIL = "weapons/swing_huge.wav";
		SOUND_ALERT = "monsters/hydra/rawr.wav";
		SOUND_BREATH1_START = "monsters/hydra/c_bulette_bat1.wav";
		SOUND_BREATH1_STRIKE = "magic/fireball_large.wav";
		SOUND_BREATH2_START = "monsters/hydra/c_bulette_bat2.wav";
		SOUND_BREATH2_STRIKE = "magic/flame_loop_start.wav";
		SOUND_BREATH2_LOOP = "magic/flame_loop.wav";
		PROJ_FIRE_BOMB_AOE = 128;
		PROJ_FIRE_BOMB_SCALE = 0.25;
		PROJ_ELEMENT_TYPE = PROJ_GUIDED_ELEMENT;
		PROJ_ELEMENT_SPEED = 50;
		PROJ_ELEMENT_MAX_DURATION = 30.0;
	}

	void game_precache()
	{
		Precache("explode1.spr");
		Precache("3dmflagry.spr");
		Precache("xfireball3.spr");
		// svplaysound: svplaysound 0 0 magic/sps_fogfire.wav
		EmitSound(0, 0, "magic/sps_fogfire.wav");
		// svplaysound: svplaysound 0 0 magic/cold_breath.wav
		EmitSound(0, 0, "magic/cold_breath.wav");
		// svplaysound: svplaysound 0 0 magic/bolt_loop.wav
		EmitSound(0, 0, "magic/bolt_loop.wav");
		// svplaysound: svplaysound 0 0 magic/flame_loop.wav
		EmitSound(0, 0, "magic/flame_loop.wav");
	}

	void OnSpawn() override
	{
		hydra_spawn();
	}

	void hydra_spawn()
	{
		SetName("Lesser Fire Hydra");
		SetModel("monsters/hydra_small.mdl");
		SetHealth(5000);
		SetWidth(96);
		SetHeight(96);
		SetRace("demon");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetRoam(true);
		SetHearingSensitivity(4);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.5);
		SetDamageResistance("holy", 1.5);
		SetDamageResistance("stun", 0);
		BREATH_TYPE = 0;
		ScheduleDelayedEvent(2.0, "hydra_finalize");
	}

	void hydra_finalize()
	{
		string L_GOLD = GetEntityMaxHealth(GetOwner());
		float L_GOLD_MULTI = 0.5;
		if (("game.central"))
		{
			string L_PLAYERS = "game.playersnb";
			if (L_PLAYERS > 1)
			{
			}
			L_PLAYERS *= 0.5;
			L_GOLD_MULTI += L_PLAYERS;
		}
		L_GOLD *= L_GOLD_MULTI;
		SetGold(L_GOLD);
	}

	void npc_targetsighted()
	{
		if (!(DID_INTRO))
		{
			DID_INTRO = 1;
			PlayAnim("critical", ANIM_ALERT);
			EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
			hydra_init_combat();
			MOVE_SUSPEND_UNTIL = GetGameTime();
			MOVE_SUSPEND_UNTIL += 3.0;
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 5.0;
		}
	}

	void hydra_init_combat()
	{
		HYDRA_DID_INIT = 1;
		if (HYDRA_SIZE == 1)
		{
			AURA_SIZE = 128;
		}
		refresh_cl_effects();
		NEXT_TAIL_CHECK = GetGameTime();
		NEXT_TAIL_CHECK += FREQ_TAIL_CHECK;
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += FREQ_BREATH;
	}

	void refresh_cl_effects()
	{
		if (MY_CL_IDX == "MY_CL_IDX")
		{
			int L_REFRESH = 1;
		}
		if (GetGameTime() > NEXT_CL_REFRESH)
		{
			int L_REFRESH = 1;
		}
		if (!(L_REFRESH)) return;
		NEXT_CL_REFRESH = GetGameTime();
		NEXT_CL_REFRESH += FREQ_CL_REFRESH;
		LogDebug("refresh_cl_effects");
		ClientEvent("new", "all", AURA_CL_SCRIPT, GetEntityIndex(GetOwner()), 30.0, AURA_SIZE, "fire", BREATH_CONE_ON, BREATH_CONE_RANGE, BREATH_CONE_AOE);
		MY_CL_IDX = "game.script.last_sent_id";
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("update", "all", MY_CL_IDX, "end_fx");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		float L_GAME_TIME = GetGameTime();
		if (m_hAttackTarget != "unset")
		{
			RESET_CYCLES = L_GAME_TIME;
			RESET_CYCLES += 20.0;
			HAD_TARGET = 1;
			NPC_HACKED_MOVE_SPEED = HYDRA_RUN_SPEED;
		}
		else
		{
			NPC_HACKED_MOVE_SPEED = HYDRA_WALK_SPEED;
			if ((HYDRA_DID_INIT))
			{
			}
			if ((HAD_TARGET))
			{
			}
			if (L_GAME_TIME > RESET_CYCLES)
			{
			}
			hydra_init_combat();
			DID_INTRO = 0;
			HAD_TARGET = 0;
		}
		if (L_GAME_TIME < MOVE_SUSPEND_UNTIL)
		{
			NPC_HACKED_MOVE_SPEED = 0;
		}
		if (L_GAME_TIME > NEXT_CL_REFRESH)
		{
			if ((HYDRA_DID_INIT))
			{
			}
			refresh_cl_effects();
		}
		if (L_GAME_TIME > NEXT_AURA_SCAN)
		{
			NEXT_AURA_SCAN = L_GAME_TIME;
			NEXT_AURA_SCAN += 1.0;
			aura_checktargets();
		}
		if ((AM_BREATHING))
		{
			PlayAnim("once", CUR_BREATH_ANIM);
		}
		if (!(m_hAttackTarget != "unset")) return;
		if ((SUSPEND_AI)) return;
		if ((AM_BREATHING)) return;
		if (L_GAME_TIME > NEXT_TAIL_CHECK)
		{
			NEXT_TAIL_CHECK = L_GAME_TIME;
			NEXT_TAIL_CHECK += FREQ_TAIL_CHECK;
			do_tail_check();
			if ((DID_TAIL))
			{
			}
			DID_TAIL = 0;
			return;
		}
		if (L_GAME_TIME > NEXT_BREATH)
		{
			NEXT_BREATH = L_GAME_TIME;
			NEXT_BREATH += FREQ_BREATH;
			do_breath();
		}
	}

	void do_breath()
	{
		BREATH_TYPE += 1;
		string L_SCAN_POINT = /* TODO: $relpos */ $relpos(0, 512, 32);
		BREATH_TARGS = FindEntitiesInSphere("enemy", 512);
		if (BREATH_TARGS == "none")
		{
			BREATH_TYPE -= 1;
			NEXT_BREATH = GetGameTime();
			NEXT_BREATH += 3.0;
		}
		if (BREATH_TYPE == 1)
		{
			breath_rapid_start();
		}
		if (BREATH_TYPE == 2)
		{
			breath_cone_start();
		}
		if (BREATH_TYPE == 3)
		{
			breath_guided_start();
			BREATH_TYPE = 0;
		}
	}

	void breath_end()
	{
		AM_BREATHING = 0;
		npcatk_resume_movement();
		npcatk_resume_ai();
		NPC_FLINCH_DISABLE = 0;
		MOVE_SUSPEND_UNTIL = 0;
		NEXT_BREATH = GetGameTime();
		NEXT_BREATH += FREQ_BREATH;
	}

	void breath_guided_start()
	{
		AM_BREATHING = 1;
		SHOT_GUIDED = 0;
		CUR_BREATH_ANIM = ANIM_BREATH_GUIDED;
		npcatk_suspend_movement(ANIM_BREATH_GUIDED);
		npcatk_suspend_ai();
		NPC_FLINCH_DISABLE = 1;
		MOVE_SUSPEND_UNTIL = GetGameTime();
		MOVE_SUSPEND_UNTIL += 30.0;
	}

	void frame_breath3_begin()
	{
		EmitSound(GetOwner(), 0, SOUND_BREATH3_START, 10);
		ScrambleTokens(BREATH_TARGS, ";");
		CUR_BREATH_TARG = GetToken(BREATH_TARGS, 0, ";");
		CUR_BREATH_ORG = GetEntityOrigin(CUR_BREATH_TARG);
		SetMoveDest(CUR_BREATH_TARG);
	}

	void frame_breath3_strike()
	{
		SHOT_GUIDED = 1;
		EmitSound(GetOwner(), 0, SOUND_BREATH1_STRIKE, 10);
		PROJ_ELEMENT_TARGET = CUR_BREATH_TARG;
		TossProjectile(CUR_BREATH_TARG, PROJ_ELEMENT_SPEED, DMG_PROJ_GUIDED, 1, PROJ_GUIDED_SCRIPT, GetEntityProperty(GetOwner(), "attachpos"), "notoffset");
		if (HYDRA_TYPE == "fire")
		{
			CallExternal("ent_lastprojectile", "ext_set_target", CUR_BREATH_TARG);
		}
	}

	void frame_breath3_done()
	{
		if (!(SHOT_GUIDED))
		{
			PlayAnim("once", ANIM_BREATH_GUIDED);
		}
		else
		{
			SHOT_GUIDED = 0;
			breath_end();
			PlayAnim("critical", ANIM_IDLE);
		}
	}

	void breath_rapid_start()
	{
		AM_BREATHING = 1;
		RAPID_BREATH_COUNT = 0;
		CUR_BREATH_ANIM = ANIM_BREATH_RAPID;
		npcatk_suspend_movement(ANIM_BREATH_RAPID);
		npcatk_suspend_ai();
		NPC_FLINCH_DISABLE = 1;
		MOVE_SUSPEND_UNTIL = GetGameTime();
		MOVE_SUSPEND_UNTIL += 30.0;
	}

	void frame_breath1_begin()
	{
		EmitSound(GetOwner(), 0, SOUND_BREATH1_START, 10);
		ScrambleTokens(BREATH_TARGS, ";");
		CUR_BREATH_TARG = GetToken(BREATH_TARGS, 0, ";");
		CUR_BREATH_ORG = GetEntityOrigin(CUR_BREATH_TARG);
		SetMoveDest(CUR_BREATH_TARG);
	}

	void frame_breath1_strike()
	{
		EmitSound(GetOwner(), 0, SOUND_BREATH1_STRIKE, 10);
		TossProjectile(CUR_BREATH_ORG, 200, DMG_PROJ_RAPID, 1, PROJ_RAPID_SCRIPT, GetEntityProperty(GetOwner(), "attachpos"), "notoffset");
		if (HYDRA_TYPE == "fire")
		{
			CallExternal("ent_lastprojectile", "ext_lighten", 0);
			CallExternal("ent_lastprojectile", "ext_scale", 0.5);
		}
	}

	void frame_breath1_done()
	{
		RAPID_BREATH_COUNT += 1;
		if (RAPID_BREATH_COUNT > 3)
		{
			breath_rapid_end();
		}
		else
		{
			PlayAnim("once", ANIM_BREATH_RAPID);
		}
	}

	void breath_rapid_end()
	{
		breath_end();
	}

	void ext_fire_bomb()
	{
		FIRE_BOMB_POS = param1;
		XDoDamage(FIRE_BOMB_POS, 128, DMG_PROJ_RAPID, 0.1, GetOwner(), GetOwner(), "none", "blunt_effect", "dmgevent:rapid");
	}

	void rapid_dodamage()
	{
		if (!(GetRelationship(param2) == "enemy")) return;
		apply_dot(GetEntityIndex(param2));
		string TARG_ORG = GetEntityOrigin(param2);
		string MY_ORG = FIRE_BOMB_POS;
		string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		AddVelocity(param2, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 200)));
	}

	void frame_breath2_begin()
	{
		EmitSound(GetOwner(), 0, SOUND_BREATH2_START, 10);
	}

	void breath_cone_start()
	{
		AM_BREATHING = 1;
		CUR_BREATH_ANIM = ANIM_BREATH_CONE;
		npcatk_suspend_movement(ANIM_BREATH_CONE);
		npcatk_suspend_ai();
		NPC_FLINCH_DISABLE = 1;
		MOVE_SUSPEND_UNTIL = GetGameTime();
		MOVE_SUSPEND_UNTIL += 30.0;
		BREATH_CONE_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		string L_BREATH_POS = GetEntityOrigin(GetOwner());
		L_BREATH_POS += /* TODO: $relpos */ $relpos(Vector3(0, BREATH_CONE_YAW, 0), Vector3(0, BREATH_CONE_RANGE, 0));
		SetMoveDest(L_BREATH_POS);
		BREATH_CONE_ACTIVE = 1;
		BREATH_CONE_ON = 0;
		breath_cone_loop();
	}

	void breath_cone_loop()
	{
		if (!(BREATH_CONE_ACTIVE)) return;
		ScheduleDelayedEvent(0.1, "breath_cone_loop");
		string L_BREATH_POS = GetEntityOrigin(GetOwner());
		L_BREATH_POS += /* TODO: $relpos */ $relpos(Vector3(0, BREATH_CONE_YAW, 0), Vector3(0, BREATH_CONE_RANGE, 0));
		SetMoveDest(L_BREATH_POS);
		if (!(BREATH_CONE_ON))
		{
			BREATH_CONE_YAW -= 0.5;
			if (BREATH_CONE_YAW < 0)
			{
				BREATH_CONE_YAW += 359.99;
			}
		}
		else
		{
			BREATH_CONE_YAW += 1;
			if (BREATH_CONE_YAW > 359.99)
			{
				BREATH_CONE_YAW -= 359.99;
			}
			if (GetGameTime() > NEXT_CONE_SCAN)
			{
			}
			NEXT_CONE_SCAN = GetGameTime();
			NEXT_CONE_SCAN += 0.5;
			L_BREATH_POS += "z";
			CONE_TARGS = FindEntitiesInSphere("enemy", BREATH_CONE_AOE);
			if (CONE_TARGS != "none")
			{
			}
			for (int i = 0; i < GetTokenCount(CONE_TARGS, ";"); i++)
			{
				breath_cone_affect_targets();
			}
		}
	}

	void breath_cone_affect_targets()
	{
		string CUR_IDX = i;
		string CUR_TARG = GetToken(CONE_TARGS, CUR_IDX, ";");
		XDoDamage(CUR_TARG, "direct", DMG_BREATH_CONE, 1.0, GetOwner(), GetOwner(), "none", AURA_ELEMENT, "dmgevent:cone");
	}

	void cone_dodamage()
	{
		apply_dot2(GetEntityIndex(param2));
	}

	void frame_breath2_start()
	{
		BREATH_CONE_ON = 1;
		EmitSound(GetOwner(), 1, SOUND_BREATH2_STRIKE, 10);
		EmitSound(GetOwner(), 4, SOUND_BREATH2_LOOP, 10);
		ClientEvent("update", "all", MY_CL_IDX, "cone_breath_on", BREATH_CONE_RANGE, BREATH_CONE_AOE);
	}

	void frame_breath2_end()
	{
		BREATH_CONE_ON = 0;
		EmitSound(GetOwner(), 4, SOUND_BREATH2_LOOP, 0);
		ClientEvent("update", "all", MY_CL_IDX, "cone_breath_off");
	}

	void frame_breath2_done()
	{
		breath_cone_end();
	}

	void breath_cone_end()
	{
		BREATH_CONE_ACTIVE = 0;
		breath_end();
		PlayAnim("critical", ANIM_IDLE);
	}

	void frame_bite1_start()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK_HEAD1, 10);
	}

	void frame_bite2_start()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK_HEAD2, 10);
	}

	void frame_bite3_start()
	{
		EmitSound(GetOwner(), 0, SOUND_ATTACK_HEAD3, 10);
	}

	void frame_attack_bite1()
	{
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE1, 0.85, GetOwner(), GetOwner(), "none", "slash", "dmgevent:bite1");
		ANIM_ATTACK = ANIM_BITE2;
	}

	void frame_attack_bite2()
	{
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE2, 0.95, GetOwner(), GetOwner(), "none", "slash", "dmgevent:bite2");
		ANIM_ATTACK = ANIM_BITE3;
	}

	void frame_attack_bite3()
	{
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE3, 0.85, GetOwner(), GetOwner(), "none", "slash", "dmgevent:bite3");
		ANIM_ATTACK = ANIM_BITE1;
	}

	void bite1_dodamage()
	{
		if (!(GetRelationship(param2) == "enemy")) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(-200, 400, 110));
		if (!(param1)) return;
		apply_dot1(GetEntityIndex(param2));
	}

	void bite2_dodamage()
	{
		if (!(GetRelationship(param2) == "enemy")) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 800, 110));
		if (!(param1)) return;
		apply_dot1(GetEntityIndex(param2));
	}

	void bite3_dodamage()
	{
		if (!(GetRelationship(param2) == "enemy")) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(200, 300, 110));
		if (!(param1)) return;
		apply_dot1(GetEntityIndex(param2));
	}

	void aura_checktargets()
	{
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), AURA_SIZE, DMG_AURA, 0, GetOwner(), GetOwner(), "none", AURA_ELEMENT, "dmgevent:aura");
	}

	void aura_dodamage()
	{
		if (!(param1)) return;
		apply_dot2(GetEntityIndex(param2));
	}

	void apply_dot1()
	{
		if ((GetEntityProperty(param1, "haseffect"))) return;
		ApplyEffect(param1, DOT_SCRIPT, DOT_DUR, GetEntityIndex(GetOwner()), DOT_DMG);
	}

	void apply_dot2()
	{
		if ((GetEntityProperty(param1, "haseffect"))) return;
		ApplyEffect(param1, DOTALT_SCRIPT, DOTALT_DUR, GetEntityIndex(GetOwner()), DOTALT_DMG);
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (HYDRA_TYPE == "fire")
		{
			if ((param3).findFirst("fire") >= 0)
			{
				if (/* TODO: $get_takedmg */ $get_takedmg(param1, "fire") == 0)
				{
				}
				int L_INC_DMG = 1;
			}
			if ((GetEntityProperty(param1, "nopush")))
			{
				int L_INC_DMG = 1;
			}
			if ((L_INC_DMG))
			{
				string L_FIN_DMG = param2;
				L_FIN_DMG *= 3.0;
				SetDamage("dmg");
				ReturnData(3.0);
			}
		}
	}

	void do_tail_check()
	{
		string L_BACK = AOE_TAIL;
		string L_BACK = /* TODO: $neg */ $neg(L_BACK);
		string L_SCAN_POINT = /* TODO: $relpos */ $relpos(0, L_BACK, 32);
		TAIL_TARGS = FindEntitiesInSphere("enemy", AOE_TAIL);
		if (!(TAIL_TARGS != "none")) return;
		DID_TAIL = 1;
		PlayAnim("critical", ANIM_TAILWHIP);
	}

	void frame_tailwhip_start()
	{
		EmitSound(GetOwner(), 0, SOUND_TAIL, 10);
		ClientEvent("update", "all", MY_CL_IDX, "add_beam", 2.0, ATTACH_TAIL, COL_BEAM1, COL_BEAM2);
	}

	void frame_attack_tailwhip()
	{
		string L_BACK = AOE_TAIL;
		string L_BACK = /* TODO: $neg */ $neg(L_BACK);
		string L_SCAN_POINT = /* TODO: $relpos */ $relpos(0, L_BACK, 32);
		XDoDamage(L_SCAN_POINT, AOE_TAIL, DMG_TAIL, 1.0, GetOwner(), GetOwner(), "none", "slash", "dmgevent:tail");
	}

	void tail_dodamage()
	{
		if (!(GetRelationship(param2) == "enemy")) return;
		AddVelocity(param2, /* TODO: $relvel */ $relvel(300, -600, 220));
		if (!(param1)) return;
		apply_dot2(GetEntityIndex(param2));
	}

	void ext_beam_test()
	{
		ClientEvent("update", "all", MY_CL_IDX, "add_beam", 30.0, ATTACH_HEAD_MID, /* TODO: $clcol */ $clcol(COL_BEAM1), /* TODO: $clcol */ $clcol(COL_BEAM2));
	}

}

}
