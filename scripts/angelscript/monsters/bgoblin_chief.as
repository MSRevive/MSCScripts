#pragma context server

#include "monsters/bgoblin.as"

namespace MS
{

class BgoblinChief : CGameScript
{
	string ANIM_ATTACK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int AXE_SWING;
	string BREATH_ANG;
	int BREATH_COUNT;
	int CAN_STUN;
	string CLOUD_TARGS;
	string CL_IDX;
	int DMG_AXE;
	int DMG_CHARGE;
	int DOT_FIRE;
	int DROP_GOLD;
	int FIRE_BREATH_ON;
	string FIRE_BREATH_SCRIPT;
	float FREQ_BREATH;
	int MOVE_RANGE;
	int NEW_MODEL;
	string NEXT_SCAN;
	int NPC_BASE_EXP;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_BREATH;
	string SOUND_REPEL;
	int STARTED_CYCLES;
	int STEP_SIZE_NORM;
	string STUN_BURST_DMG;
	string STUN_BURST_POS;
	string STUN_BURST_RAD;
	string STUN_BURST_REPEL;
	string STUN_LIST;

	BgoblinChief()
	{
		NEW_MODEL = 1;
		NPC_BASE_EXP = 3000;
		SOUND_ATTACK1 = "monsters/goblin/c_gargoyle_atk1.wav";
		SOUND_ATTACK2 = "monsters/goblin/c_gargoyle_atk2.wav";
		SOUND_ATTACK3 = "monsters/goblin/c_gargoyle_atk3.wav";
		SOUND_BREATH = "monsters/goblin/sps_fogfire.wav";
		STEP_SIZE_NORM = 36;
		CAN_STUN = 1;
		DROP_GOLD = 0;
		ANIM_ATTACK = "battleaxe_swing1_L";
		DMG_AXE = RandomInt(100, 300);
		DOT_FIRE = 75;
		DMG_CHARGE = 50;
		FREQ_BREATH = Random(10.0, 30.0);
		FIRE_BREATH_SCRIPT = "monsters/bgoblin_chief_cl";
		SOUND_REPEL = "ambience/alien_humongo.wav";
		ATTACK_HITCHANCE = 0.9;
	}

	void game_precache()
	{
		Precache(FIRE_BREATH_SCRIPT);
	}

	void goblin_spawn()
	{
		SetName("Blood Goblin Chieftain");
		SetRace("goblin");
		SetBloodType("red");
		SetHealth(5000);
		SetRoam(true);
		SetAnimFrameRate(1.5);
		SetHearingSensitivity(4);
		if (!(NEW_MODEL))
		{
			SetModel("monsters/goblin2_boss.mdl");
			SetWidth(32);
			SetHeight(72);
			SetModelBody(0, 2);
			SetModelBody(1, 3);
			SetModelBody(2, 2);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 2);
		}
		else
		{
			SetModel("monsters/goblin_new_boss.mdl");
			SetWidth(32);
			SetHeight(72);
			SetModelBody(0, 0);
			SetModelBody(1, 3);
			SetModelBody(2, 2);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 1);
		}
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.25);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(GAME_MASTER, "bgoblin_chief_died", GetEntityOrigin(GetOwner()));
		if ((FIRE_BREATH_ON))
		{
			ClientEvent("update", "all", CL_IDX, "end_fx");
		}
	}

	void swing_axe()
	{
		AXE_SWING = 1;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE, ATTACK_HITCHANCE, "slash");
	}

	void cycle_up()
	{
		if ((STARTED_CYCLES)) return;
		STARTED_CYCLES = 1;
		cl_effect_loop();
		FREQ_BREATH("do_fire_breath");
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if ((AXE_SWING))
			{
			}
			ApplyEffect(param2, "effects/dot_fire", 10.0, GetEntityIndex(GetOwner()), DOT_FIRE);
			AXE_SWING = 0;
		}
	}

	void do_fire_breath()
	{
		FREQ_BREATH("do_fire_breath");
		if (!(m_hAttackTarget != "unset")) return;
		npcatk_suspend_ai();
		BREATH_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		BREATH_ANG -= 30;
		if (BREATH_ANG < 0)
		{
			BREATH_ANG += 359;
		}
		BREATH_COUNT = 0;
		SetMoveAnim(ANIM_WARCRY);
		SetIdleAnim(ANIM_WARCRY);
		PlayAnim("critical", ANIM_WARCRY);
		ScheduleDelayedEvent(0.01, "fire_breath_loop");
		FIRE_BREATH_ON = 1;
		// svplaysound: svplaysound 1 10 SOUND_BREATH
		EmitSound(1, 10, SOUND_BREATH);
		ClientEvent("new", "all", "monsters/bgoblin_chief_cl", GetEntityIndex(GetOwner()));
		CL_IDX = "game.script.last_sent_id";
	}

	void fire_breath_loop()
	{
		BREATH_COUNT += 1;
		if (BREATH_COUNT == 60)
		{
			end_fire_breath();
		}
		if (!(BREATH_COUNT < 60)) return;
		ScheduleDelayedEvent(0.05, "fire_breath_loop");
		BREATH_ANG += 1;
		if (BREATH_ANG > 359)
		{
			BREATH_ANG -= 359;
		}
		string FACE_POS = GetMonsterProperty("origin");
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, BREATH_ANG, 0), Vector3(0, 500, 0));
		SetMoveDest(FACE_POS);
		string CLOUD_START = GetEntityProperty(GetOwner(), "svbonepos");
		CLOUD_START += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 16, 0));
		if (CLOUD_TARGS != "none")
		{
			for (int i = 0; i < GetTokenCount(CLOUD_TARGS, ";"); i++)
			{
				burn_targets();
			}
		}
		if (!(GetGameTime() > NEXT_SCAN)) return;
		NEXT_SCAN = GetGameTime();
		NEXT_SCAN += 0.5;
		string SCAN_POINT = /* TODO: $relpos */ $relpos(0, 128, 0);
		CLOUD_TARGS = /* TODO: $get_tbox */ $get_tbox("enemy", 128, SCAN_POINT);
		PlayAnim("once", ANIM_WARCRY);
	}

	void burn_targets()
	{
		string CUR_TARGET = GetToken(CLOUD_TARGS, i, ";");
		if (!(IsEntityAlive(CUR_TARGET))) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARGET);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		if (!(GetEntityRange(CUR_TARGET) < 256)) return;
		ApplyEffect(CUR_TARGET, "effects/dot_fire", 10.0, GetEntityIndex(GetOwner()), DOT_FIRE);
		AddVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(0, 300, 120));
	}

	void end_fire_breath()
	{
		ClientEvent("update", "all", CL_IDX, "end_fx");
		npcatk_resume_ai();
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		// svplaysound: svplaysound 1 0 SOUND_BREATH
		EmitSound(1, 0, SOUND_BREATH);
		FIRE_BREATH_ON = 0;
	}

	void leap_stun()
	{
		string BURST_POS = /* TODO: $relpos */ $relpos(0, 64, 0);
		stunburst_go(BURST_POS, 64, 0, DMG_CHARGE);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if ((FIRE_BREATH_ON))
		{
			if (GetEntityRange(m_hLastStruck) < 128)
			{
			}
			string TARGET_ORG = GetEntityOrigin(m_hLastStruck);
			string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARGET_ORG);
			SetVelocity(m_hLastStruck, /* TODO: $relvel */ $relvel(Vector3(0, TARG_ANG, 0), Vector3(10, 1000, 0)));
			EmitSound(GetOwner(), 0, SOUND_REPEL, 10);
			Effect("glow", GetOwner(), Vector3(255, 0, 0), 60, 2.0, 2.0);
		}
	}

	void gob_jump_check()
	{
		if (!(GOB_JUMPER)) return;
		if (!(GOB_JUMP_SCANNING)) return;
		float GOB_HOP_DELAY = Random(2, 4);
		GOB_HOP_DELAY("gob_jump_check");
		if (!(m_hAttackTarget != "unset")) return;
		if ((IS_FLEEING)) return;
		if ((SUSPEND_AI)) return;
		if (!(GetEntityRange(m_hAttackTarget) < GOBLIN_JUMPRANGE)) return;
		string ME_Z = GetMonsterProperty("origin.z");
		string TARG_Z = GetEntityProperty(m_hAttackTarget, "origin.z");
		if ((IsValidPlayer(m_hAttackTarget)))
		{
			TARG_Z -= 38;
		}
		if (ME_Z > TARG_Z)
		{
			string Z_DIFF = ME_Z;
			ME_Z -= TARG_Z;
		}
		else
		{
			string Z_DIFF = TARG_Z;
			Z_DIFF -= ME_Z;
		}
		if (Z_DIFF > ATTACK_RANGE)
		{
			PlayAnim("critical", ANIM_SMASH);
			ScheduleDelayedEvent(0.1, "do_jump");
		}
	}

	void do_jump()
	{
		SetStepSize(1000);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, -200, 800));
		ScheduleDelayedEvent(0.5, "push_forward");
		ScheduleDelayedEvent(1.0, "jump_done");
	}

	void push_forward()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 400, 100));
	}

	void jump_done()
	{
		SetStepSize(STEP_SIZE_NORM);
		SetMoveAnim(ANIM_RUN);
	}

	void my_target_died()
	{
		ScheduleDelayedEvent(1.0, "npcatk_go_home");
	}

	void stunburst_go()
	{
		STUN_BURST_POS = param1;
		STUN_BURST_RAD = param2;
		STUN_BURST_REPEL = param3;
		STUN_BURST_DMG = param4;
		LogDebug("stunburst_go pos: STUN_BURST_POS rad: STUN_BURST_RAD repel: STUN_BURST_REPEL dmg: STUN_BURST_DMG");
		ClientEvent("new", "all", "effects/sfx_stun_burst", STUN_BURST_POS, STUN_BURST_RAD, 0);
		EmitSound(GetOwner(), 0, "magic/boom.wav", 10);
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

	void goblin_pre_spawn()
	{
		ATTACK_RANGE = 96;
		ATTACK_HITRANGE = 128;
		ATTACK_MOVERANGE = 48;
		MOVE_RANGE = 48;
	}

}

}
