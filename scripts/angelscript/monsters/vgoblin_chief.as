#pragma context server

#include "monsters/bgoblin.as"

namespace MS
{

class VgoblinChief : CGameScript
{
	string ANIM_ATTACK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int AXE_SWING;
	int CAN_STUN;
	int DROP_GOLD;
	int MOVE_RANGE;
	string MY_CL_SCRIPT_IDX;
	string POISON_LIST;
	string RND_SPECIAL;
	int STARTED_CYCLES;
	string STUN_BURST_DMG;
	string STUN_BURST_POS;
	string STUN_BURST_RAD;
	string STUN_BURST_REPEL;
	string STUN_LIST;
	string SUM_POS;

	VgoblinChief()
	{
		const int NEW_MODEL = 1;
		const int NPC_BASE_EXP = 3000;
		const string SOUND_ATTACK1 = "monsters/goblin/c_gargoyle_atk1.wav";
		const string SOUND_ATTACK2 = "monsters/goblin/c_gargoyle_atk2.wav";
		const string SOUND_ATTACK3 = "monsters/goblin/c_gargoyle_atk3.wav";
		const int STEP_SIZE_NORM = 36;
		const float FREQ_CLOUD = 1.5;
		const int DMG_CLOUD = 20;
		const string CL_SCRIPT = "monsters/vgoblin_chief_cl";
		const string FREQ_SPECIAL = Random(10.0, 30.0);
		CAN_STUN = 1;
		DROP_GOLD = 0;
		ANIM_ATTACK = "battleaxe_swing1_L";
		const string DMG_AXE = RandomInt(100, 300);
		const int DOT_POISON = 50;
		const int DMG_CHARGE = 50;
		ATTACK_HITCHANCE = 0.9;
		const string PLANT_SCRIPT = "monsters/summon/doom_plant";
		const string CHEW_SKULL_SCRIPT = "monsters/lost_soul";
		const string SPLODIE_SKULL_SCRIPT = "traps/splodie_skull";
		const float SPLODIE_SKULL_STR = 1.0;
		const float CHEW_SKULL_STR = 1.0;
		const int PLANT_STR = 30;
		const string SKULL_DURATION = Random(60.0, 120.0);
	}

	void game_precache()
	{
		Precache(PLANT_SCRIPT);
		Precache(CHEW_SKULL_SCRIPT);
		Precache(SPLODIE_SKULL_SCRIPT);
		Precache(CL_SCRIPT);
	}

	void goblin_spawn()
	{
		SetName("Vile Goblin Chieftain");
		SetRace("goblin");
		SetBloodType("green");
		SetHealth(5000);
		if (!(NEW_MODEL))
		{
			SetModel("monsters/goblin2_boss.mdl");
			SetWidth(32);
			SetHeight(72);
			SetModelBody(0, 0);
			SetModelBody(1, 3);
			SetModelBody(2, 1);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 3);
		}
		else
		{
			SetModel("monsters/goblin_new_boss.mdl");
			SetWidth(32);
			SetHeight(72);
			SetModelBody(0, 0);
			SetModelBody(1, 3);
			SetModelBody(2, 1);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 2);
		}
		SetRoam(true);
		SetAnimFrameRate(1.5);
		SetHearingSensitivity(4);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("lightning", 1.25);
		ClientEvent("persist", "all", CL_SCRIPT, GetEntityIndex(GetOwner()));
		MY_CL_SCRIPT_IDX = "game.script.last_sent_id";
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", MY_CL_SCRIPT_IDX);
		CallExternal(GAME_MASTER, "vgoblin_chief_died", GetEntityOrigin(GetOwner()));
	}

	void swing_axe()
	{
		AXE_SWING = 1;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE, ATTACK_HITCHANCE, "blunt");
		AXE_SWING = 1;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE, ATTACK_HITCHANCE, "slash");
		if (!(RND_SPECIAL > 0)) return;
		string BURST_POS = /* TODO: $relpos */ $relpos(0, 64, -16);
		stunburst_go(BURST_POS, 256, 1, DMG_CHARGE);
		if (RND_SPECIAL == 1)
		{
			ScheduleDelayedEvent(0.2, "summon_chew_skulls");
		}
		if (RND_SPECIAL == 2)
		{
			ScheduleDelayedEvent(0.2, "summon_splodie_skulls");
		}
		if (RND_SPECIAL == 3)
		{
			ScheduleDelayedEvent(0.2, "summon_dewm");
		}
		RND_SPECIAL = 0;
	}

	void swing_dodamage()
	{
		if ((param1))
		{
			if ((AXE_SWING))
			{
			}
			ApplyEffect(param2, "effects/dot_poison", 10.0, GetEntityIndex(GetOwner()), DOT_POISON);
		}
		AXE_SWING = 0;
	}

	void leap_stun()
	{
		string BURST_POS = /* TODO: $relpos */ $relpos(0, 64, 0);
		stunburst_go(BURST_POS, 64, 0, DMG_CHARGE);
	}

	void gob_jump_check()
	{
		if (!(GOB_JUMPER)) return;
		if (!(GOB_JUMP_SCANNING)) return;
		string GOB_HOP_DELAY = Random(2, 4);
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

	void cycle_up()
	{
		if ((STARTED_CYCLES)) return;
		STARTED_CYCLES = 1;
		FREQ_SPECIAL("set_special");
		FREQ_CLOUD("update_cloud");
	}

	void set_special()
	{
		FREQ_SPECIAL("set_special");
		RND_SPECIAL = RandomInt(1, 3);
	}

	void summon_chew_skulls()
	{
		SUM_POS = /* TODO: $relpos */ $relpos(-64, 64, -16);
		summon_effect();
		SpawnNPC(CHEW_SKULL_SCRIPT, SUM_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), CHEW_SKULL_STR, SKULL_DURATION
		ScheduleDelayedEvent(0.01, "summon_chew_skulls2");
	}

	void summon_chew_skulls2()
	{
		SUM_POS = /* TODO: $relpos */ $relpos(64, 64, -16);
		summon_effect();
		SpawnNPC(CHEW_SKULL_SCRIPT, SUM_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), CHEW_SKULL_STR, SKULL_DURATION
	}

	void summon_splodie_skulls()
	{
		SUM_POS = /* TODO: $relpos */ $relpos(-64, 64, 32);
		summon_effect();
		SpawnNPC(SPLODIE_SKULL_SCRIPT, SUM_POS, ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SPLODIE_SKULL_STR, SKULL_DURATION
		ScheduleDelayedEvent(0.01, "summon_splodie_skulls2");
	}

	void summon_splodie_skulls2()
	{
		SUM_POS = /* TODO: $relpos */ $relpos(64, 64, 32);
		summon_effect();
		SpawnNPC(SPLODIE_SKULL_SCRIPT, /* TODO: $relpos */ $relpos(64, 64, 32), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SPLODIE_SKULL_STR, SKULL_DURATION
		ScheduleDelayedEvent(0.01, "summon_splodie_skulls3");
	}

	void summon_splodie_skulls3()
	{
		SUM_POS = /* TODO: $relpos */ $relpos(64, 64, -16);
		summon_effect();
		SpawnNPC(SPLODIE_SKULL_SCRIPT, /* TODO: $relpos */ $relpos(64, 64, -16), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SPLODIE_SKULL_STR, SKULL_DURATION
		ScheduleDelayedEvent(0.01, "summon_splodie_skulls4");
	}

	void summon_splodie_skulls4()
	{
		SUM_POS = /* TODO: $relpos */ $relpos(-64, 64, -16);
		summon_effect();
		SpawnNPC(SPLODIE_SKULL_SCRIPT, /* TODO: $relpos */ $relpos(-64, 64, -16), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), SPLODIE_SKULL_STR, SKULL_DURATION
	}

	void summon_dewm()
	{
		summon_plant_effect();
		string PLANT_POS = /* TODO: $relpos */ $relpos(0, 64, -32);
		ClientEvent("update", "all", MY_CL_SCRIPT_IDX, "dewm_plant_fx", PLANT_POS);
		SpawnNPC(PLANT_SCRIPT, PLANT_POS, ScriptMode::Legacy); // params: PLANT_STR
	}

	void summon_effect()
	{
		string START_POS = GetEntityProperty(GetOwner(), "svbonepos");
		Effect("beam", "point", "lgtning.spr", 30, START_POS, SUM_POS, Vector3(0, 255, 0), 200, 30, 0.5);
	}

	void update_cloud()
	{
		FREQ_CLOUD("update_cloud");
		if (!(GOB_JUMP_SCANNING)) return;
		POISON_LIST = /* TODO: $get_tbox */ $get_tbox("enemy", 128, /* TODO: $relpos */ $relpos(0, 0, -32));
		if (!(POISON_LIST != "none")) return;
		ScrambleTokens(POISON_LIST, ";");
		ApplyEffect(GetToken(POISON_LIST, 0, ";"), "effects/dot_poison", 5.0, GetEntityIndex(GetOwner()), DOT_POISON);
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
		ClientEvent("update", "all", MY_CL_SCRIPT_IDX, "stunburst_go_cl", STUN_BURST_POS, STUN_BURST_RAD);
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
		ATTACK_MOVERANGE = 58;
		MOVE_RANGE = 58;
	}

}

}
