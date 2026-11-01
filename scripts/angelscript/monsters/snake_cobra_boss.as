#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SnakeCobraBoss : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_BREATH;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_IDLE_NORM;
	string ANIM_RUN;
	string ANIM_SLEEP;
	string ANIM_SPIT;
	string ANIM_WALK;
	string ATTACK_ANIMINDEX;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BITE_SOUND;
	int CAN_RETALIATE;
	int CLOUD_COUNT;
	string CLOUD_TARGS;
	string CL_IDX;
	string CL_SCRIPT;
	string CUR_ANG;
	int CYCLE_STARTED;
	int DID_ALERT;
	float DMG_BITE;
	int DMG_GAS_DOT;
	int DMG_POISON_DOT;
	int DMG_SPIT;
	int DOING_SPECIAL;
	float GAS_DURATION;
	int MONSTER_HP;
	string MONSTER_MODEL;
	string NEXT_SCAN;
	string NEXT_SPIT;
	int NO_STUCK_CHECKS;
	int NPC_GIVE_EXP;
	string NPC_IS_BOSS;
	float POISON_DURATION;
	int SLEEP_MODE;
	string SOUND_ALERT;
	string SOUND_ATTACK;
	string SOUND_DEATH;
	string SOUND_IDLE;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_POISON;
	string SOUND_SPIT;
	string SOUND_STRUCK;
	int SPIT_MODE;
	string SPIT_TARGET;

	SnakeCobraBoss()
	{
		MONSTER_HP = 12000;
		DMG_SPIT = 400;
		DMG_BITE = Random(100, 250);
		DMG_POISON_DOT = 25;
		DMG_GAS_DOT = 75;
		POISON_DURATION = 5.0;
		GAS_DURATION = 30.0;
		MONSTER_MODEL = "monsters/gcobra_boss.mdl";
		ANIM_SPIT = "spit";
		SOUND_SPIT = "agrunt/ag_attack2.wav";
		NPC_GIVE_EXP = 200;
		if (StringToLower(GetMapName()) == "gertenheld_cave")
		{
			NPC_IS_BOSS = 1;
			NPC_GIVE_EXP = 8000;
		}
		else
		{
			NPC_GIVE_EXP = 400;
		}
		CL_SCRIPT = "monsters/snake_cobra_boss_cl";
		ANIM_BREATH = "breath";
		CAN_RETALIATE = 0;
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_DEATH = "diesimple";
		ANIM_IDLE = ANIM_SLEEP;
		ANIM_IDLE_NORM = "idle1";
		ANIM_SLEEP = "idle2";
		ANIM_ATTACK = "attack1";
		ATTACK_RANGE = 350;
		ATTACK_HITRANGE = 400;
		ATTACK_MOVERANGE = 300;
		ATTACK_HITCHANCE = 0.8;
		SOUND_ALERT = "monsters/gsnake_idle1.wav";
		SOUND_IDLE = "monsters/gsnake_idle1.wav";
		SOUND_ATTACK = "agrunt/ag_attack2.wav";
		SOUND_POISON = "monsters/snakeman/sm_alert1.wav";
		SOUND_STRUCK = "debris/flesh3.wav";
		SOUND_PAIN1 = "agrunt/ag_attack3.wav";
		SOUND_PAIN2 = "agrunt/ag_idle2.wav";
		SOUND_DEATH = "agrunt/ag_die2.wav";
		Precache(SOUND_DEATH);
		SOUND_ATTACK = "weapons/swinghuge.wav";
	}

	void OnSpawn() override
	{
		SetName("Gargantuan Cobra");
		SetHealth(MONSTER_HP);
		SetDamageResistance("all", 0.95);
		SetWidth(300);
		SetHeight(250);
		SetRace("demon");
		SetModel(MONSTER_MODEL);
		SetHearingSensitivity(0);
		sleep_mode();
		ScheduleDelayedEvent(0.2, "post_spawn_props");
		ScheduleDelayedEvent(1.0, "idle_sounds");
		if (!(AM_TURRET)) return;
		NO_STUCK_CHECKS = 1;
		SetMoveSpeed(0.0);
		ANIM_WALK = ANIM_IDLE_NORM;
		ANIM_RUN = ANIM_IDLE_NORM;
		if (!(true)) return;
		ScheduleDelayedEvent(1.0, "setup_client");
	}

	void setup_client()
	{
		ClientEvent("new", "all", CL_SCRIPT);
		CL_IDX = "game.script.last_sent_id";
	}

	void idle_sounds()
	{
		EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
		Random(5, 10)("idle_sounds");
	}

	void post_spawn_props()
	{
		SetDamageResistance("holy", 0.0);
	}

	void attack1()
	{
		EmitSound(GetOwner(), 2, SOUND_ATTACK, 10);
		BITE_SOUND = 1;
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)) return;
		npcatk_dodamage(m_hAttackTarget, "direct", DMG_BITE, ATTACK_HITCHANCE, GetOwner(), "pierce");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(BITE_SOUND)) return;
		BITE_SOUND = 0;
		if (!(RandomInt(1, 2) == 1)) return;
		EmitSound(GetOwner(), 0, SOUND_POISON, 10);
		ApplyEffect(param1, "effects/dot_poison", POISON_DURATION, GetEntityIndex(GetOwner()), DMG_POISON_DOT);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_STRUCK, SOUND_STRUCK
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_STRUCK, SOUND_STRUCK};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if (!(IsEntityAlive(param1))) return;
		if (!(GetRelationship(param1) == "enemy")) return;
		if ((DID_ALERT)) return;
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
		wake_up();
		DID_ALERT = 1;
	}

	void my_target_died()
	{
		SetMoveDest(NPC_SPAWN_LOC);
		idle_sounds();
		DID_ALERT = 0;
		npcatk_go_home();
	}

	void npc_made_it_home()
	{
		sleep_mode();
	}

	void sleep_mode()
	{
		if (!(AM_TURRET))
		{
			NO_STUCK_CHECKS = 1;
		}
		SLEEP_MODE = 1;
		SetRoam(false);
		SetIdleAnim(ANIM_SLEEP);
		SetMoveAnim(ANIM_SLEEP);
		ANIM_IDLE = ANIM_SLEEP;
	}

	void wake_up()
	{
		if (!(AM_TURRET))
		{
			NO_STUCK_CHECKS = 0;
		}
		SLEEP_MODE = 0;
		SetIdleAnim(ANIM_IDLE_NORM);
		SetMoveAnim(ANIM_WALK);
		ANIM_IDLE = ANIM_IDLE_NORM;
		SetRoam(true);
		if ((CYCLE_STARTED)) return;
		CYCLE_STARTED = 1;
		ScheduleDelayedEvent(15.0, "do_special");
	}

	void do_special()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		float NEXT_SPECIAL = 20.0;
		if ((IsEntityAlive(m_hAttackTarget)))
		{
			if (!(SUSPEND_AI))
			{
			}
			int RND_SPECIAL = RandomInt(1, 2);
			if (RND_SPECIAL == 1)
			{
				float NEXT_SPECIAL = 40.0;
				DOING_SPECIAL = 1;
				do_spit();
			}
			if (RND_SPECIAL == 2)
			{
				float NEXT_SPECIAL = 40.0;
				do_cloud();
			}
		}
		NEXT_SPECIAL("do_special");
	}

	void do_spit()
	{
		if ((SPIT_MODE)) return;
		SPIT_LOOPS += 1;
		if (!(SPIT_LOOPS < 2)) return;
		SPIT_MODE = 1;
		if (!(AM_TURRET))
		{
			NO_STUCK_CHECKS = 1;
		}
		npcatk_suspend_ai();
		SetIdleAnim(ANIM_SPIT);
		SetMoveAnim(ANIM_SPIT);
		PlayAnim("critical", ANIM_SPIT);
		GetAllPlayers(PLAYER_LIST);
		ScrambleTokens(PLAYER_LIST, ";");
		do_spit_loop();
		ScheduleDelayedEvent(15.0, "end_spit_mode");
	}

	void do_spit_loop()
	{
		if (!(SPIT_MODE)) return;
		ScheduleDelayedEvent(0.1, "do_spit_loop");
		string CUR_TARGET = GetToken(PLAYER_LIST, 0, ";");
		string MOUTH_POS = GetEntityProperty(GetOwner(), "svbonepos");
		string TARG_POS = GetEntityOrigin(CUR_TARGET);
		string TRACE_IT = TraceLine(MOUTH_POS, TARG_POS);
		int TRACE_FAIL = 1;
		if (GetEntityRange(CUR_TARGET) < 800)
		{
			string TRACE_IT = TARG_POS;
		}
		if (TRACE_IT != TARG_POS)
		{
			new_spit_target();
		}
		else
		{
			int TRACE_FAIL = 0;
		}
		if ((TRACE_FAIL)) return;
		if (!(GetGameTime() > NEXT_SPIT)) return;
		NEXT_SPIT = GetGameTime();
		NEXT_SPIT += 0.5;
		SetMoveDest(CUR_TARGET);
		SPIT_TARGET = CUR_TARGET;
	}

	void end_spit_mode()
	{
		if (!(AM_TURRET))
		{
			NO_STUCK_CHECKS = 0;
		}
		SPIT_LOOPS -= 1;
		SPIT_MODE = 0;
		DOING_SPECIAL = 0;
		SetIdleAnim(ANIM_IDLE_NORM);
		SetMoveAnim(ANIM_WALK);
		ANIM_IDLE = ANIM_IDLE_NORM;
		if (!(AM_TURRET))
		{
			SetRoam(true);
		}
		npcatk_resume_ai();
	}

	void new_spit_target()
	{
		ScrambleTokens(PLAYER_LIST, ";");
	}

	void npcatk_attack()
	{
		if ((NPC_NO_ATTACK)) return;
		npc_selectattack();
		if (NPC_MOVEDEST_TARGET != m_hAttackTarget)
		{
			npcatk_faceattacker(m_hAttackTarget);
		}
		string MOUTH_POS = GetEntityProperty(GetOwner(), "svbonepos");
		string TARG_POS = GetEntityOrigin(m_hAttackTarget);
		string TRACE_IT = TraceLine(MOUTH_POS, TARG_POS);
		if (!(TRACE_IT == TARG_POS)) return;
		PlayAnim("once", ANIM_ATTACK);
		ATTACK_ANIMINDEX = GetEntityProperty(GetOwner(), "anim.index");
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (!(AM_TURRET)) return;
		if ((SUSPEND_AI)) return;
		if ((DOING_SPECIAL)) return;
		if ((SPIT_MODE)) return;
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if (GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)
		{
			if (!(SPIT_MODE))
			{
			}
			SPIT_TARGET = m_hAttackTarget;
			PlayAnim("once", ANIM_SPIT);
		}
	}

	void frame_spit()
	{
		TossProjectile("proj_poison_spit2", /* TODO: $relpos */ $relpos(20, 150, 100), SPIT_TARGET, 300, DMG_SPIT, 0.5, "none");
		EmitSound(GetOwner(), 0, SOUND_SPIT, 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", CL_IDX);
		// svplaysound: svplaysound 1 0 ambience/steamjet1.wav
		EmitSound(1, 0, "ambience/steamjet1.wav");
	}

	void do_cloud()
	{
		// svplaysound: svplaysound 1 10 ambience/steamjet1.wav
		EmitSound(1, 10, "ambience/steamjet1.wav");
		npcatk_suspend_ai();
		SetRoam(false);
		DOING_SPECIAL = 1;
		PlayAnim("critical", ANIM_BREATH);
		SetMoveAnim(ANIM_BREATH);
		SetIdleAnim(ANIM_BREATH);
		CUR_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		CLOUD_COUNT = 0;
		do_cloud_loop();
	}

	void do_cloud_loop()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (CLOUD_COUNT == 180)
		{
			npcatk_resume_ai();
			DOING_SPECIAL = 0;
			SetIdleAnim(ANIM_IDLE_NORM);
			SetMoveAnim(ANIM_WALK);
			if (!(AM_TURRET))
			{
				SetRoam(true);
			}
			// svplaysound: svplaysound 1 0 ambience/steamjet1.wav
			EmitSound(1, 0, "ambience/steamjet1.wav");
		}
		if (!(CLOUD_COUNT < 180)) return;
		ScheduleDelayedEvent(0.1, "do_cloud_loop");
		CLOUD_COUNT += 1;
		string CLOUD_START = GetEntityProperty(GetOwner(), "svbonepos");
		ClientEvent("update", "all", CL_IDX, "make_cloud", CLOUD_START, GetEntityProperty(GetOwner(), "angles.yaw"));
		CUR_ANG += 2;
		if (CUR_ANG > 359)
		{
			CUR_ANG -= 359;
		}
		string FACE_POS = GetMonsterProperty("origin");
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, CUR_ANG, 0), Vector3(0, 1000, 0));
		SetMoveDest(FACE_POS);
		if (CLOUD_TARGS != "none")
		{
			for (int i = 0; i < GetTokenCount(CLOUD_TARGS, ";"); i++)
			{
				poison_targets();
			}
		}
		if (!(GetGameTime() > NEXT_SCAN)) return;
		NEXT_SCAN = GetGameTime();
		NEXT_SCAN += 1.0;
		string SCAN_POINT = /* TODO: $relpos */ $relpos(0, 256, -125);
		CLOUD_TARGS = /* TODO: $get_tbox */ $get_tbox("enemy", 128, SCAN_POINT);
		// svplaysound: svplaysound 1 10 ambience/steamjet1.wav
		EmitSound(1, 10, "ambience/steamjet1.wav");
	}

	void poison_targets()
	{
		string CUR_TARGET = GetToken(CLOUD_TARGS, i, ";");
		if (!(IsEntityAlive(CUR_TARGET))) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARGET);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		if (!(GetEntityRange(CUR_TARGET) < 600)) return;
		ApplyEffect(CUR_TARGET, "effects/dot_poison_blind", 10.0, GetEntityIndex(GetOwner()), DMG_POISON_DOT);
	}

}

}
