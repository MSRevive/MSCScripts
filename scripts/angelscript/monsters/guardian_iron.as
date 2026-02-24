#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class GuardianIron : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK1;
	string ANIM_ATTACK1_READY;
	string ANIM_ATTACK2;
	string ANIM_ATTACK2_READY;
	string ANIM_DEATH;
	string ANIM_DRAW_SWORD;
	string ANIM_IDLE;
	float ANIM_RATE;
	string ANIM_RAWR;
	string ANIM_REACH;
	string ANIM_RECHARGE;
	string ANIM_RUN;
	string ANIM_SMASH;
	string ANIM_STOMP;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int ATTEMPTING_RECHARGE;
	string BASE_FRAMERATE;
	float BATTERY_LIFE;
	int CAN_FLEE;
	string CHARGER_ORG;
	float CHARGE_DROP_RATE;
	string CHARGE_LEVEL;
	string CL_SCRIPT_IDX;
	int DID_FIRST_CHARGE;
	int DID_INTRO;
	string DMG_ELEF_TYPE;
	int DMG_REACH;
	int DMG_SMASH;
	int DMG_SWING_BLADE;
	int DMG_SWING_ZAP;
	int DOING_RECHARGE;
	int DOING_STOMP;
	int DOT_REACH;
	int FLICKER_DELAY;
	int FLICKER_IN_COUNT;
	int FLICKER_MODE;
	float FREQ_CL_REFRESH;
	float FREQ_REACH;
	float FREQ_SMASH;
	float FREQ_STOMP;
	float GAME_PUSH_RATIO;
	int GUARDIAN_BEAM_SWORD;
	string GUARDIAN_CL_SCRIPT;
	int GUARDIAN_TYPE;
	int IMMUNE_VAMPIRE;
	int IN_SWING;
	int IS_UNHOLY;
	int LHAND_IDX;
	int MAX_CHARGE_LEVEL;
	int MAX_RECHARGE_RANGE;
	int MELEEING;
	string NEEDS_CHARGER;
	string NEXT_CHARGE_DROP;
	string NEXT_CL_REFRESH;
	string NEXT_REACH;
	string NEXT_ROBOCOP_SOUND;
	string NEXT_SMASH;
	string NEXT_STOMP;
	int NPC_FIGHTS_NPCS;
	int NPC_FORCED_MOVEDEST;
	string NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	int NPC_NO_ATTACK;
	string NPC_NO_PLAYER_DMG;
	int NUDGE_NEAR;
	string NUDGE_POINT;
	string NUDGE_TARGETS;
	string OVERRIDE_SUSPEND_AI;
	int PITCH_SWORD_OFF;
	string REACH_TARGET;
	int RHAND_IDX;
	int ROBOCOP_IDX;
	int ROBOCOP_MODE;
	int ROBOCOP_NSOUNDS;
	int SMASH_AOE;
	int SMASH_ATTACK;
	string SMASH_POINT;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_DEATH;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PAIN3;
	string SOUND_RAWR;
	string SOUND_REACH;
	string SOUND_RECHARGE_START;
	string SOUND_STEP1_LAND;
	string SOUND_STEP1_START;
	string SOUND_STEP2_LAND;
	string SOUND_STEP2_START;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_SWING;
	string SOUND_SWORD_DRAW;
	string SOUND_SWORD_IDLE;
	string SOUND_SWORD_OFF;
	int STANCE_RANGE;
	string STOMP_POINT;
	string STOMP_TARGETS;
	int SWIPE_AOE;
	string SWORD_BEAM;
	int SWORD_HILT_IDX;
	int SWORD_STATE;
	int SWORD_TIP_IDX;

	GuardianIron()
	{
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle";
		ANIM_RUN = "run";
		ANIM_DEATH = "die";
		ANIM_ATTACK = "ready_attack1";
		ANIM_RAWR = "rawr";
		ANIM_ATTACK1 = "attack1";
		ANIM_ATTACK2 = "attack2";
		ANIM_ATTACK1_READY = "ready_attack1";
		ANIM_ATTACK2_READY = "ready_attack2";
		ANIM_DRAW_SWORD = "draw";
		ANIM_RECHARGE = "recharge";
		ANIM_REACH = "reach";
		ANIM_STOMP = "stomp";
		ANIM_SMASH = "smash";
		CAN_FLEE = 0;
		IS_UNHOLY = 1;
		NPC_NO_ATTACK = 1;
		if ((StringToLower(GetMapName())).findFirst("shad_pal") >= 0)
		{
			NPC_IS_BOSS = 1;
			NPC_GIVE_EXP = 10000;
		}
		else
		{
			NPC_GIVE_EXP = 5000;
		}
		ATTACK_MOVERANGE = 140;
		ATTACK_RANGE = 200;
		ATTACK_HITRANGE = 300;
		GUARDIAN_TYPE = 1;
		GUARDIAN_BEAM_SWORD = 1;
		DMG_ELEF_TYPE = "lightning_effect";
		PITCH_SWORD_OFF = 100;
		FREQ_CL_REFRESH = 30.0;
		GAME_PUSH_RATIO = 0.25;
		MAX_CHARGE_LEVEL = 50;
		CHARGE_DROP_RATE = 1.0;
		GUARDIAN_CL_SCRIPT = "monsters/guardian_iron_cl";
		BATTERY_LIFE = 60.0;
		STANCE_RANGE = 500;
		MAX_RECHARGE_RANGE = 400;
		DMG_SWING_ZAP = 700;
		DMG_SWING_BLADE = 400;
		DMG_REACH = 500;
		DOT_REACH = 100;
		DMG_SMASH = 400;
		SWIPE_AOE = 384;
		SMASH_AOE = 128;
		FREQ_STOMP = Random(10.0, 20.0);
		FREQ_REACH = Random(10.0, 20.0);
		FREQ_SMASH = Random(10.0, 30.0);
		SWORD_HILT_IDX = 0;
		SWORD_TIP_IDX = 1;
		RHAND_IDX = 2;
		LHAND_IDX = 3;
		SOUND_STEP1_START = "monsters/guardian/joint_move1.wav";
		SOUND_STEP2_START = "monsters/guardian/joint_move2.wav";
		SOUND_STEP1_LAND = "monsters/guardian/step1.wav";
		SOUND_STEP2_LAND = "monsters/guardian/step2.wav";
		SOUND_ATTACK1 = "monsters/guardian/swing1.wav";
		SOUND_ATTACK2 = "monsters/guardian/swing2.wav";
		SOUND_SWING = "weapons/swinghuge.wav";
		SOUND_PAIN1 = "monsters/guardian/pain1.wav";
		SOUND_PAIN2 = "monsters/guardian/pain2.wav";
		SOUND_PAIN3 = "monsters/guardian/pain3.wav";
		SOUND_STRUCK1 = "monsters/guardian/struck1.wav";
		SOUND_STRUCK2 = "monsters/guardian/struck2.wav";
		SOUND_RAWR = "monsters/guardian/rawr.wav";
		SOUND_REACH = "monsters/guardian/sca_dragelec.wav";
		SOUND_RECHARGE_START = "monsters/guardian/sca_dragelec.wav";
		SOUND_SWORD_IDLE = "magic/bolt_loop.wav";
		SOUND_SWORD_DRAW = "magic/elecidlepop.wav";
		SOUND_SWORD_OFF = "magic/elecidle.wav";
		SOUND_DEATH = "monsters/guardian/death.wav";
		IMMUNE_VAMPIRE = 1;
		Precache(SOUND_DEATH);
		Precache("c-tele1.spr");
		Precache("flare1.spr");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(CHARGE_DROP_RATE);
		if ((NEEDS_CHARGER))
		{
		}
		if ((DID_FIRST_CHARGE))
		{
		}
		if (!(ATTEMPTING_RECHARGE))
		{
		}
		if (GetGameTime() > NEXT_CHARGE_DROP)
		{
		}
		CHARGE_LEVEL -= 1;
		if (ANIM_RATE > 0.3)
		{
			update_anim_speed();
			LogDebug("losing_charge CHARGE_LEVEL ANIM_RATE");
		}
		else
		{
			sword_off();
			do_recharge();
		}
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(5.0);
		if ((SUSPEND_AI))
		{
		}
		if (GetGameTime() > OVERRIDE_SUSPEND_AI)
		{
		}
		npcatk_resume_ai();
	}

	void game_precache()
	{
		Precache(GUARDIAN_CL_SCRIPT);
	}

	void OnSpawn() override
	{
		guardian_spawn();
		CatchSpeech("say_robocop", "robocop");
	}

	void guardian_spawn()
	{
		SetName("Iron Guardian");
		SetHealth(10000);
		SetModel("monsters/guardian.mdl");
		SetWidth(75);
		SetHeight(200);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 1.25);
		SetDamageResistance("stun", 0);
		SetModelBody(0, 0);
		SetRace("demon");
		SetBloodType("none");
		SetHearingSensitivity(1);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetRoam(true);
		if (!(true)) return;
		if (G_GUARDIAN_CHARGER != "G_GUARDIAN_CHARGER")
		{
			CHARGER_ORG = G_GUARDIAN_CHARGER;
			NEEDS_CHARGER = 1;
		}
		CHARGE_LEVEL = MAX_CHARGE_LEVEL;
		ANIM_RATE = 1.0;
		refresh_fx();
		ScheduleDelayedEvent(0.01, "beam_init");
	}

	void beam_init()
	{
		Effect("beam", "ents", "lgtning.spr", 10, GetOwner(), 1, GetOwner(), 2, Vector3(196, 196, 255), 0, 30, -1);
		SWORD_BEAM = GetEntityIndex(m_hLastCreated);
	}

	void frame_step1_start()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1_START, 10);
	}

	void frame_step2_start()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP2_START, 10);
	}

	void frame_step1_land()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP1_LAND, 10);
	}

	void frame_step2_land()
	{
		EmitSound(GetOwner(), 0, SOUND_STEP2_LAND, 10);
	}

	void frame_attack1_start()
	{
		IN_SWING = 1;
		EmitSound(GetOwner(), 0, SOUND_ATTACK1, 10);
	}

	void frame_attack2_start()
	{
		IN_SWING = 1;
		EmitSound(GetOwner(), 0, SOUND_ATTACK1, 10);
	}

	void frame_draw_flicker()
	{
		sword_on();
	}

	void frame_smash()
	{
		ANIM_ATTACK = "ready_attack2";
		SMASH_POINT = GetEntityProperty(GetOwner(), "attachpos");
		SMASH_POINT = "z";
		SMASH_POINT += /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(0, 96, 0));
		LogDebug("frame_smash SMASH_POINT distfromme Distance(SMASH_POINT, GetMonsterProperty("origin"))");
		ClientEvent("update", "all", CL_SCRIPT_IDX, "smash_fx", SMASH_POINT);
		SMASH_ATTACK = 1;
		DoDamage(SMASH_POINT, SMASH_AOE, DMG_SMASH, 1.0, 0);
	}

	void frame_attack1_go()
	{
		if ((NPC_NO_ATTACK)) return;
		string TARGS_IN_RANGE = FindEntitiesInSphere("enemy", ATTACK_HITRANGE);
		if (!(TARGS_IN_RANGE != "none")) return;
		PlayAnim("critical", ANIM_ATTACK1);
	}

	void frame_attack2_go()
	{
		if ((NPC_NO_ATTACK)) return;
		string TARGS_IN_RANGE = FindEntitiesInSphere("enemy", ATTACK_HITRANGE);
		if (!(TARGS_IN_RANGE != "none")) return;
		PlayAnim("critical", ANIM_ATTACK2);
	}

	void frame_attack1_strike()
	{
		melee_attack();
		ANIM_ATTACK = ANIM_ATTACK2_READY;
		SetIdleAnim(ANIM_ATTACK);
		if (!(RandomInt(1, 3) == 1)) return;
		ANIM_ATTACK = ANIM_ATTACK2;
	}

	void frame_attack2_strike()
	{
		melee_attack();
		ANIM_ATTACK = ANIM_ATTACK1_READY;
		SetIdleAnim(ANIM_ATTACK);
		if (!(RandomInt(1, 3) == 1)) return;
		ANIM_ATTACK = ANIM_ATTACK1;
	}

	void frame_rawr_done()
	{
		RAWR_EVENT();
	}

	void frame_reach_start()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
	}

	void frame_reach_strike()
	{
		npcatk_resume_ai();
		if ((ATTEMPTING_RECHARGE)) return;
		EmitSound(GetOwner(), 0, SOUND_REACH, 10);
		ClientEvent("update", "all", CL_SCRIPT_IDX, "grab_fx", GetEntityIndex(REACH_TARGET));
		ANIM_ATTACK = ANIM_ATTACK1;
		DoDamage(REACH_TARGET, 1024, DMG_REACH, 1.0, DMG_ELEF_TYPE);
		if (!(/* TODO: $get_takedmg */ $get_takedmg(REACH_TARGET, "lightning") < 0.9)) return;
		ApplyEffect(REACH_TARGET, "effects/dot_lightning", 5.0, GetEntityIndex(GetOwner()), DOT_REACH);
		AddVelocity(REACH_TARGET, /* TODO: $relvel */ $relvel(0, -3000, 110));
	}

	void frame_stomp_start()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 10.0;
		EmitSound(GetOwner(), 0, SOUND_STEP1_START, 10);
		DOING_STOMP = 1;
		NEXT_STOMP = GetGameTime();
		NEXT_STOMP += FREQ_STOMP;
		NUDGE_NEAR = 1;
		nudge_loop();
		ScheduleDelayedEvent(4.0, "end_nudge_loop");
	}

	void nudge_loop()
	{
		if (!(NUDGE_NEAR)) return;
		ScheduleDelayedEvent(0.5, "nudge_loop");
		NUDGE_POINT = GetEntityProperty(GetOwner(), "svbonepos");
		NUDGE_POINT = "z";
		NUDGE_TARGETS = FindEntitiesInSphere("enemy", 64);
		if (!(NUDGE_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(NUDGE_TARGETS, ";"); i++)
		{
			affect_nudge_targets();
		}
	}

	void end_nudge_loop()
	{
		NUDGE_NEAR = 0;
		DOING_STOMP = 0;
		ANIM_ATTACK = "ready_attack1";
	}

	void affect_nudge_targets()
	{
		string CUR_TARG = GetToken(NUDGE_TARGETS, i, ";");
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(0, 200, 110));
	}

	void frame_stomp()
	{
		ANIM_ATTACK = "ready_attack1";
		DOING_STOMP = 0;
		NUDGE_NEAR = 0;
		STOMP_POINT = GetEntityProperty(GetOwner(), "svbonepos");
		STOMP_POINT = "z";
		STOMP_TARGETS = FindEntitiesInSphere("enemy", 256);
		ClientEvent("update", "all", CL_SCRIPT_IDX, "stomp_fx", STOMP_POINT);
		if (!(STOMP_TARGETS != "none")) return;
		for (int i = 0; i < GetTokenCount(STOMP_TARGETS, ";"); i++)
		{
			affect_stomp_targets();
		}
	}

	void affect_stomp_targets()
	{
		string CUR_TARGET = GetToken(STOMP_TARGETS, i, ";");
		float STUN_DUR = 5.0;
		if ((ATTEMPTING_RECHARGE))
		{
			float STUN_DUR = 10.0;
		}
		ApplyEffect(CUR_TARGET, "effects/debuff_stun", STUN_DUR, GetEntityIndex(GetOwner()));
		string TARG_ORG = GetEntityOrigin(CUR_TARGET);
		string TARG_ANG = /* TODO: $angles */ $angles(STOMP_POINT, TARG_ORG);
		string NEW_YAW = TARG_ANG;
		SetVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 1000, 0)));
	}

	void melee_attack()
	{
		IN_SWING = 0;
		EmitSound(GetOwner(), 0, SOUND_SWING, 10);
		MELEEING = 1;
		DoDamage(GetEntityProperty(GetOwner(), "attachpos"), SWIPE_AOE, DMG_SWING_ZAP, 1.0, 0);
		DoDamage(GetEntityProperty(GetOwner(), "attachpos"), SWIPE_AOE, DMG_SWING_BLADE, 1.0, 0);
		MELEEING = 0;
	}

	void OnDamage(int damage) override
	{
		if ((param3).findFirst("lightning") >= 0)
		{
			Effect("glow", GetOwner(), Vector3(0, 255, 0), 64, 1, 1);
			if (GetEntityHealth(GetOwner()) < GetEntityMaxHealth(GetOwner()))
			{
				HealEntity(GetOwner(), param2);
			}
			SetDamage("dmg");
			return;
			CHARGE_LEVEL = MAX_CHARGE_LEVEL;
			NEXT_CHARGE_DROP = GetGameTime();
			NEXT_CHARGE_DROP += BATTERY_LIFE;
			if ((ATTEMPTING_RECHARGE))
			{
			}
			recharge_done();
		}
		else
		{
			if ((param3).findFirst("effect") >= 0)
			{
				int EXIT_SUB = 1;
			}
			if (!(EXIT_SUB))
			{
			}
			EmitSound(GetOwner(), 0, SOUND_STRUCK1, 10);
		}
	}

	void cycle_up()
	{
		SetRoam(false);
		refresh_fx();
		float GAME_TIME = GetGameTime();
		NEXT_SMASH = GAME_TIME;
		NEXT_SMASH += FREQ_SMASH;
		NEXT_STOMP = GAME_TIME;
		NEXT_STOMP += FREQ_STOMP;
		NEXT_REACH = GAME_TIME;
		NEXT_REACH += FREQ_REACH;
		if ((DID_INTRO)) return;
		DID_INTRO = 1;
		AS_ATTACKING = GAME_TIME;
		AS_ATTACKING += 5.0;
		SetMoveDest(m_hAttackTarget);
		do_intro();
		if (CL_SCRIPT_IDX > -1)
		{
			refresh_fx();
		}
	}

	void cycle_down()
	{
		SetRoam(true);
	}

	void npc_selectattack()
	{
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 3.0;
		if (ANIM_RATE < 1.0)
		{
			AS_ATTACKING += 5.0;
		}
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((IsEntityAlive(GetOwner())))
		{
			if (GetGameTime() > NEXT_CL_REFRESH)
			{
				refresh_fx();
			}
			if ((ROBOCOP_MODE))
			{
			}
			if (GetGameTime() > NEXT_ROBOCOP_SOUND)
			{
			}
			NEXT_ROBOCOP_SOUND = GetGameTime();
			NEXT_ROBOCOP_SOUND += Random(3.0, 10.0);
			if (ROBOCOP_IDX > ROBOCOP_NSOUNDS)
			{
				ROBOCOP_IDX = 0;
			}
			EmitSound(GetOwner(), 0, ROBOCOP_ARRAY[int(ROBOCOP_IDX)], 10);
			ROBOCOP_IDX += 1;
		}
		if ((SUSPEND_AI)) return;
		if ((ATTEMPTING_RECHARGE)) return;
		if ((DOING_RECHARGE)) return;
		if ((DOING_STOMP)) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
			if (!(IN_SWING))
			{
			}
			if ((SWORD_STATE))
			{
			}
			if (GetGameTime() > NEXT_REACH)
			{
			}
			string TARG_ORG = GetEntityOrigin(m_hAttackTarget);
			string HAND_ORG = GetEntityProperty(GetOwner(), "attachpos");
			string TRACE_LINE = TraceLine(HAND_ORG, TARG_ORG);
			if (TRACE_LINE == TARG_ORG)
			{
			}
			NEXT_REACH = GetGameTime();
			NEXT_REACH += FREQ_REACH;
			REACH_TARGET = m_hAttackTarget;
			do_reach();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetGameTime() > NEXT_STOMP)
		{
			ANIM_ATTACK = ANIM_STOMP;
			NEXT_STOMP = GetGameTime();
			NEXT_STOMP += FREQ_STOMP;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetGameTime() > NEXT_SMASH)
		{
			ANIM_ATTACK = ANIM_SMASH;
			NEXT_SMASH = GetGameTime();
			NEXT_SMASH += FREQ_STOMP;
		}
	}

	void do_intro()
	{
		PlayAnim("critical", ANIM_RAWR);
		EmitSound(GetOwner(), 0, SOUND_RAWR, 10);
		if ((NEEDS_CHARGER))
		{
			ScheduleDelayedEvent(1.5, "do_recharge");
			ScheduleDelayedEvent(0.1, "intro_musak");
		}
		else
		{
			ScheduleDelayedEvent(1.5, "draw_sword");
		}
	}

	void intro_musak()
	{
		CallExternal("players", "ext_play_music", "media/Suspense07.mp3");
	}

	void do_recharge()
	{
		npcatk_suspend_ai();
		ATTEMPTING_RECHARGE = 0;
		refresh_fx();
		do_recharge_fx();
	}

	void do_recharge_fx()
	{
		ScheduleDelayedEvent(8.0, "recharge_done");
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 10.0;
		SetMoveDest(CHARGER_ORG);
		DOING_RECHARGE = 1;
		SetIdleAnim(ANIM_RECHARGE);
		SetMoveAnim(ANIM_RECHARGE);
		PlayAnim("critical", ANIM_RECHARGE);
		SetRoam(false);
		ClientEvent("update", "all", CL_SCRIPT_IDX, "recharge_fx", CHARGER_ORG);
		do_recharge_loop();
	}

	void do_recharge_loop()
	{
		if (!(DOING_RECHARGE)) return;
		ScheduleDelayedEvent(0.1, "do_recharge_loop");
		if (!(CHARGE_LEVEL < MAX_CHARGE_LEVEL)) return;
		CHARGE_LEVEL += 1;
		update_anim_speed();
	}

	void recharge_done()
	{
		npcatk_resume_ai();
		NEXT_CHARGE_DROP = GetGameTime();
		NEXT_CHARGE_DROP += BATTERY_LIFE;
		DOING_RECHARGE = 0;
		CHARGE_LEVEL = MAX_CHARGE_LEVEL;
		DID_FIRST_CHARGE = 1;
		SetAnimFrameRate(1.0);
		ANIM_RATE = 1.0;
		SetMoveDest(m_hAttackTarget);
		NPC_FORCED_MOVEDEST = 1;
		draw_sword();
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_RUN);
		float GAME_TIME = GetGameTime();
		NEXT_SMASH = GAME_TIME;
		NEXT_SMASH += FREQ_SMASH;
		NEXT_STOMP = GAME_TIME;
		NEXT_STOMP += FREQ_STOMP;
		NEXT_REACH = GAME_TIME;
	}

	void draw_sword()
	{
		string CUR_TARG = m_hAttackTarget;
		npcatk_suspend_ai(1.0);
		SetMoveDest(CUR_TARG);
		PlayAnim("critical", ANIM_DRAW_SWORD);
		ScheduleDelayedEvent(5.0, "sword_on");
	}

	void sword_on()
	{
		if ((SWORD_STATE)) return;
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 2.0;
		ClientEvent("update", "all", CL_SCRIPT_IDX, "sword_on", 1);
		FLICKER_IN_COUNT = 10;
		FLICKER_DELAY = 0;
		FLICKER_MODE = 1;
		SWORD_STATE = 1;
		sword_flicker_loop();
		EmitSound(GetOwner(), 0, SOUND_SWORD_DRAW, 10);
		if (SOUND_SWORD_IDLE != "none")
		{
			// svplaysound: if ( SOUND_SWORD_IDLE isnot none) svplaysound 1 5 SOUND_SWORD_IDLE
			EmitSound(1, 5, SOUND_SWORD_IDLE);
		}
		NPC_NO_ATTACK = 0;
	}

	void sword_flicker_loop()
	{
		if (FLICKER_IN_COUNT == 0)
		{
			SetModelBody(1, SWORD_STATE);
			if ((GUARDIAN_BEAM_SWORD))
			{
			}
			if ((SWORD_STATE))
			{
				Effect("beam", "update", SWORD_BEAM, "brightness", 200);
			}
			else
			{
				Effect("beam", "update", SWORD_BEAM, "brightness", 0);
			}
		}
		if (!(FLICKER_IN_COUNT >= 1)) return;
		SetModelBody(1, FLICKER_MODE);
		if ((FLICKER_MODE))
		{
			SetModelBody(1, 1);
			FLICKER_MODE = 0;
		}
		else
		{
			SetModelBody(1, 0);
			FLICKER_MODE = 1;
		}
		FLICKER_IN_COUNT -= 1;
		FLICKER_DELAY += 0.01;
		FLICKER_DELAY("sword_flicker_loop");
	}

	void sword_off()
	{
		NPC_NO_ATTACK = 1;
		SWORD_STATE = 0;
		FLICKER_IN_COUNT = 10;
		FLICKER_DELAY = 0;
		FLICKER_MODE = 1;
		sword_flicker_loop();
		EmitSound(GetOwner(), 0, SOUND_SWORD_OFF, 10);
		if (SOUND_SWORD_IDLE != "none")
		{
			// svplaysound: if ( SOUND_SWORD_IDLE isnot none ) svplaysound 1 0 SOUND_SWORD_IDLE
			EmitSound(1, 0, SOUND_SWORD_IDLE);
		}
		ClientEvent("update", "all", CL_SCRIPT_IDX, "sword_flicker_out");
	}

	void sword_off_instant()
	{
		ClientEvent("update", "all", CL_SCRIPT_IDX, "sword_flicker_out");
		if ((GUARDIAN_BEAM_SWORD))
		{
			Effect("beam", "update", SWORD_BEAM, "brightness", 0);
			Effect("beam", "update", SWORD_BEAM, "remove", 0.1);
		}
		if (SOUND_SWORD_IDLE != "none")
		{
			// svplaysound: if ( SOUND_SWORD_IDLE isnot none ) svplaysound 1 0 SOUND_SWORD_IDLE
			EmitSound(1, 0, SOUND_SWORD_IDLE);
		}
		SetModelBody(1, 0);
		SWORD_STATE = 0;
	}

	void update_anim_speed()
	{
		ANIM_RATE = CHARGE_LEVEL;
		ANIM_RATE /= MAX_CHARGE_LEVEL;
		BASE_FRAMERATE = ANIM_RATE;
		SetAnimFrameRate(ANIM_RATE);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		sword_off_instant();
		ClientEvent("update", "all", CL_SCRIPT_IDX, "remove_fx");
		if (StringToLower(GetMapName()) == "shad_palace")
		{
			CallExternal("players", "ext_set_map", "shad_palace", "from_aluhandra2", "from_shad_palace");
		}
	}

	void refresh_fx()
	{
		NEXT_CL_REFRESH = GetGameTime();
		NEXT_CL_REFRESH += FREQ_CL_REFRESH;
		ClientEvent("update", "all", CL_SCRIPT_IDX, "end_fx");
		ClientEvent("new", "all", GUARDIAN_CL_SCRIPT, GetEntityIndex(GetOwner()), 1, SWORD_STATE, FREQ_CL_REFRESH);
		CL_SCRIPT_IDX = "game.script.last_sent_id";
	}

	void do_reach()
	{
		npcatk_suspend_ai(2.0);
		PlayAnim("critical", ANIM_REACH);
		EmitSound(GetOwner(), 0, SOUND_SWING, 10);
		ClientEvent("update", "all", CL_SCRIPT_IDX, "grab_sprite_on");
	}

	void game_dodamage()
	{
		if ((SMASH_ATTACK))
		{
			if ((IsEntityAlive(param2)))
			{
			}
			if (GetEntityRange(param2) < ATTACK_HITRANGE)
			{
			}
			ApplyEffect(param2, "effects/debuff_stun", 10.0, GetEntityIndex(GetOwner()));
		}
		SMASH_ATTACK = 0;
	}

	void OnSuspendAI()
	{
		OVERRIDE_SUSPEND_AI = GetGameTime();
		OVERRIDE_SUSPEND_AI += 45.0;
	}

	void say_robocop()
	{
		if ((ROBOCOP_MODE)) return;
		ROBOCOP_MODE = 1;
		array<string> ROBOCOP_ARRAY;
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_comequietortrouble.wav");
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_deadoralive.wav");
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_robocop_arrest.wav");
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_dropit.wav");
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_intro.wav");
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_lookingforme.wav");
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_miranda.wav");
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_drop_arrest.wav");
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_stayoutoftrouble.wav");
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_thankyou_gnight.wav");
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_youareunderarrest1.wav");
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_youarewantedformurder.wav");
		ROBOCOP_ARRAY.insertLast("monsters/guardian/robocop_yourmovecreep.wav");
		ROBOCOP_NSOUNDS = int(ROBOCOP_ARRAY.length());
		ROBOCOP_IDX = 0;
		ROBOCOP_NSOUNDS -= 1;
		NPC_FIGHTS_NPCS = 1;
		if ((G_DEVELOPER_MODE))
		{
			SetRace("human");
			NPC_NO_PLAYER_DMG = 1;
		}
	}

}

}
