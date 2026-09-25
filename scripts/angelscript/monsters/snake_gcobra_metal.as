#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class SnakeGcobraMetal : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_BREATH;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_IDLE_NORM;
	string ANIM_RUN;
	string ANIM_SLEEP;
	string ANIM_WALK;
	float ATTACK_DAMAGE;
	int ATTACK_DELAY;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int BITE_SOUND;
	int CLOUD_COUNT;
	string CLOUD_TARGS;
	string CL_IDX;
	string CL_SCRIPT;
	string CUR_ANG;
	int DID_ALERT;
	int DOING_SPECIAL;
	int GAS_AMMO;
	int GAS_RANGE;
	int IS_UNHOLY;
	string MONSTER_MODEL;
	string NEXT_SCAN;
	int NO_STUCK_CHECKS;
	int NPC_GIVE_EXP;
	float POISON_DAMAGE;
	int POISON_DURATION;
	int SLEEP_MODE;
	string SOUND_ALERT;
	string SOUND_ATTACK;
	string SOUND_DEATH;
	string SOUND_IDLE;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_POISON;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	SnakeGcobraMetal()
	{
		ANIM_BREATH = "breath";
		GAS_RANGE = 200;
		ANIM_WALK = "walk";
		ANIM_RUN = "walk";
		ANIM_DEATH = "diesimple";
		ANIM_IDLE = ANIM_SLEEP;
		ANIM_IDLE_NORM = "idle1";
		ANIM_SLEEP = "idle2";
		ANIM_ATTACK = "attack1";
		ATTACK_RANGE = 120;
		ATTACK_HITRANGE = 150;
		ATTACK_MOVERANGE = 60;
		ATTACK_HITCHANCE = 0.8;
		ATTACK_DAMAGE = "$randf(20,50)";
		POISON_DAMAGE = "$randf(10,20)";
		POISON_DURATION = "$rand(10,20)";
		NPC_GIVE_EXP = 200;
		SOUND_ALERT = "monsters/gsnake_idle1.wav";
		SOUND_IDLE = "monsters/gsnake_idle1.wav";
		SOUND_ATTACK = "agrunt/ag_attack2.wav";
		SOUND_POISON = "monsters/snakeman/sm_alert1.wav";
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STRUCK3 = "doors/doorstop5.wav";
		SOUND_PAIN1 = "agrunt/ag_attack3.wav";
		SOUND_PAIN2 = "agrunt/ag_idle2.wav";
		SOUND_DEATH = "agrunt/ag_die2.wav";
		CL_SCRIPT = "monsters/snake_gcobra_cl";
		MONSTER_MODEL = "monsters/gcobra.mdl";
	}

	void OnSpawn() override
	{
		SetName("Giant Metallic Cobra");
		SetHealth(800);
		SetWidth(64);
		SetHeight(32);
		SetIdleAnim(ANIM_SLEEP);
		SetRoam(false);
		SetRace("demon");
		SetModel(MONSTER_MODEL);
		SetHearingSensitivity(0);
		sleep_mode();
		ScheduleDelayedEvent(0.2, "post_spawn_props");
		ScheduleDelayedEvent(1.0, "idle_sounds");
		SetProp(GetOwner(), "skin", 1);
		SetDamageResistance("all", 0.25);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("lightning", 4.0);
		SetDamageResistance("holy", 1.0);
		ClientEvent("new", "all", CL_SCRIPT);
		CL_IDX = "game.script.last_sent_id";
		GAS_AMMO = 1;
	}

	void OnPostSpawn() override
	{
		IS_UNHOLY = 1;
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		ClientEvent("remove", "all", CL_IDX);
		// svplaysound: svplaysound 1 0 ambience/steamjet1.wav
		EmitSound(1, 0, "ambience/steamjet1.wav");
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
		BITE_SOUND = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK_DAMAGE, ATTACK_HITCHANCE, GetOwner());
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(BITE_SOUND)) return;
		BITE_SOUND = 0;
		if (!(RandomInt(1, 2) == 1)) return;
		EmitSound(GetOwner(), 0, SOUND_POISON, 10);
		ApplyEffect(param1, "effects/dot_poison", POISON_DURATION, GetEntityIndex(GetOwner()), POISON_DAMAGE);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_PAIN1, SOUND_PAIN2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3
		array<string> sounds = {SOUND_PAIN1, SOUND_PAIN2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3};
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
		GAS_AMMO = 1;
		SetMoveDest(NPC_SPAWN_LOC);
		idle_sounds();
		DID_ALERT = 0;
		LogDebug("my_target_died");
		ScheduleDelayedEvent(1.0, "npcatk_go_home");
	}

	void npc_made_it_home()
	{
		sleep_mode();
	}

	void reset_attack_delay()
	{
		ATTACK_DELAY = 0;
	}

	void sleep_mode()
	{
		SLEEP_MODE = 1;
		NO_STUCK_CHECKS = 1;
		SetRoam(false);
		SetIdleAnim(ANIM_SLEEP);
		SetMoveAnim(ANIM_SLEEP);
		ANIM_IDLE = ANIM_SLEEP;
		SetHearingSensitivity(0);
	}

	void wake_up()
	{
		SLEEP_MODE = 0;
		NO_STUCK_CHECKS = 0;
		SetIdleAnim(ANIM_IDLE_NORM);
		SetMoveAnim(ANIM_WALK);
		ANIM_IDLE = ANIM_IDLE_NORM;
		SetRoam(true);
		SetHearingSensitivity(4);
	}

	void npc_targetsighted()
	{
		if (!(GAS_AMMO > 0)) return;
		if (!(GetEntityRange(m_hAttackTarget) < GAS_RANGE)) return;
		GAS_AMMO = 0;
		do_cloud();
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
		SetMoveDest(m_hAttackTarget);
		CUR_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		CLOUD_COUNT = 0;
		ScheduleDelayedEvent(0.01, "adj_angles");
	}

	void adj_angles()
	{
		CUR_ANG -= 45;
		if (CUR_ANG < 0)
		{
			CUR_ANG += 359;
		}
		string FACE_POS = GetMonsterProperty("origin");
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, CUR_ANG, 0), Vector3(0, 1000, 0));
		SetMoveDest(FACE_POS);
		ScheduleDelayedEvent(0.01, "do_cloud_loop");
	}

	void do_cloud_loop()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (CLOUD_COUNT == 45)
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
		if (!(CLOUD_COUNT < 45)) return;
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
		NEXT_SCAN += 0.5;
		string SCAN_POINT = /* TODO: $relpos */ $relpos(0, 96, 0);
		CLOUD_TARGS = /* TODO: $get_tbox */ $get_tbox("enemy", 96, SCAN_POINT);
		// svplaysound: svplaysound 1 10 ambience/steamjet1.wav
		EmitSound(1, 10, "ambience/steamjet1.wav");
	}

	void poison_targets()
	{
		string CUR_TARGET = GetToken(CLOUD_TARGS, i, ";");
		if (!(IsEntityAlive(CUR_TARGET))) return;
		string TARG_ORG = GetEntityOrigin(CUR_TARGET);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		if (!(GetEntityRange(CUR_TARGET) < 256)) return;
		// TODO: UNCONVERTED: ]
		ApplyEffect(CUR_TARGET, "effects/dot_poison_blind", POISON_DURATION, GetEntityIndex(GetOwner()), POISON_DAMAGE);
	}

}

}
