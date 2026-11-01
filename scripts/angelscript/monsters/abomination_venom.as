#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class AbominationVenom : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_ATTACK_LONG;
	string ANIM_ATTACK_SHORT;
	string ANIM_BREATH_ATTACK;
	string ANIM_CHARGE;
	string ANIM_CRAWL;
	string ANIM_DEATH;
	string ANIM_FLING;
	string ANIM_IDLE;
	string ANIM_JUMP;
	string ANIM_LIGHTNING;
	string ANIM_RAWR;
	string ANIM_RUN;
	string ANIM_WALK;
	string ANIM_WALK_ACTIVE;
	string AS_ATTACKING;
	int ATTACK_COUNTER;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_HITRANGE_LONG;
	int ATTACK_HITRANGE_SHORT;
	int ATTACK_RANGE;
	int ATTACK_RANGE_LONG;
	int ATTACK_RANGE_SHORT;
	string BREATH_ANG;
	int BREATH_ATTACK_ON;
	int BREATH_COUNT;
	string BREATH_IDX;
	string BURST_TARGS;
	string CHARGE_CL_FX;
	string CHARGE_YAW;
	string CLOUD_TARGS;
	int CUR_SPECIAL;
	int DID_WARCRY;
	int DMG_BITE_LONG;
	int DMG_BITE_SHORT;
	int DMG_CHARGE;
	int DMG_LSHIELD;
	int DOT_BREATH;
	int DOT_POISON_BURST;
	int DROP_HUNDERSWAMP_CHEST;
	float FREQ_IDLE;
	float FREQ_SPECIAL;
	int IMMUNE_VAMPIRE;
	int IN_CHARGE;
	int IS_UNHOLY;
	float LSHIELD_FREQ_UPDATE;
	int LSHIELD_PASSIVE;
	int LSHIELD_RADIUS;
	int LSHIELD_REPELL_STRENGTH;
	int MELEE_ATTACK_LONG;
	int MELEE_ATTACK_SHORT;
	int MONSTER_HP;
	string NEXT_IDLE;
	string NEXT_SCAN;
	string NEXT_SPECIAL;
	string NEXT_TOUCH_CHECK;
	int NPC_GIVE_EXP;
	string NPC_HALF_HEALTH;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK_LONG;
	string SOUND_ATTACK_SHORT;
	string SOUND_BREATH_LOOP;
	string SOUND_BREATH_START;
	string SOUND_CHARGE_START;
	string SOUND_DEATH;
	string SOUND_FBREATH;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_RAWR;
	string SOUND_STEP1;
	string SOUND_STEP2;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_ZAP_LOOP;
	string SOUND_ZAP_START;
	string STUN_TARGS;

	AbominationVenom()
	{
		ANIM_WALK = "crawl";
		ANIM_RUN = "run";
		ANIM_IDLE = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_DEATH = "death1_die";
		ANIM_ATTACK_SHORT = "attack1";
		ANIM_ATTACK_LONG = "attack2";
		ANIM_CRAWL = "crawl";
		ANIM_WALK_ACTIVE = "walk";
		ANIM_LIGHTNING = "breath_fast";
		ANIM_FLING = "grab_fling";
		ANIM_JUMP = "jump";
		ANIM_BREATH_ATTACK = "breath";
		ANIM_RAWR = "rawr";
		ANIM_CHARGE = "run";
		MONSTER_HP = 20000;
		NPC_GIVE_EXP = 8000;
		ATTACK_RANGE = 150;
		ATTACK_HITRANGE = 200;
		IS_UNHOLY = 1;
		IMMUNE_VAMPIRE = 1;
		ATTACK_RANGE_SHORT = 100;
		ATTACK_RANGE_LONG = 150;
		ATTACK_HITRANGE_SHORT = 150;
		ATTACK_HITRANGE_LONG = 200;
		ATTACK_HITCHANCE = 0.8;
		DOT_BREATH = 200;
		DMG_BITE_SHORT = 300;
		DMG_BITE_LONG = 600;
		DMG_CHARGE = 50;
		DOT_POISON_BURST = 100;
		FREQ_SPECIAL = Random(10.0, 20.0);
		FREQ_IDLE = Random(10.0, 15.0);
		SOUND_RAWR = "monsters/abombination/rawr.wav";
		SOUND_ATTACK1 = "monsters/abombination/attack1.wav";
		SOUND_ATTACK2 = "monsters/abombination/attack2.wav";
		SOUND_IDLE1 = "monsters/abombination/growl1.wav";
		SOUND_IDLE2 = "monsters/abombination/growl2.wav";
		SOUND_PAIN1 = "monsters/abombination/pain1.wav";
		SOUND_PAIN2 = "monsters/abombination/pain2.wav";
		SOUND_DEATH = "monsters/abombination/die.wav";
		SOUND_STEP1 = "monsters/abombination/step1.wav";
		SOUND_STEP2 = "monsters/abombination/step2.wav";
		SOUND_STRUCK1 = "weapons/bullet_hit1.wav";
		SOUND_STRUCK2 = "weapons/bullet_hit2.wav";
		SOUND_ATTACK_LONG = "zombie/claw_miss1.wav";
		SOUND_ATTACK_SHORT = "zombie/claw_miss2.wav";
		SOUND_BREATH_START = "ambience/steamburst1.wav";
		SOUND_BREATH_LOOP = "ambience/steamjet1.wav";
		SOUND_CHARGE_START = "monsters/abombination/rawr.wav";
		SOUND_FBREATH = "monsters/goblin/sps_fogfire.wav";
		Precache("magic/boom.wav");
		LSHIELD_PASSIVE = 0;
		LSHIELD_REPELL_STRENGTH = 300;
		LSHIELD_FREQ_UPDATE = 0.25;
		DMG_LSHIELD = 300;
		LSHIELD_RADIUS = 128;
		SOUND_ZAP_LOOP = "magic/bolt_loop.wav";
		SOUND_ZAP_START = "magic/bolt_end.wav";
		Precache(SOUND_ZAP_LOOP);
		Precache(SOUND_ZAP_START);
	}

	void OnSpawn() override
	{
		SetName("Venomous Bone Abomination");
		SetModel("monsters/abomination.mdl");
		SetProp(GetOwner(), "skin", 1);
		SetHeight(72);
		SetWidth(96);
		SetRace("demon");
		SetBloodType("green");
		SetRoam(true);
		SetHearingSensitivity(4);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		SetHealth(MONSTER_HP);
		SetDamageResistance("all", 0.5);
		SetDamageResistance("holy", 1.5);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("cold", 1.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("lightning", 2.0);
		SetDamageResistance("slash", 1.0);
		SetDamageResistance("blunt", 1.25);
		SetDamageResistance("pierce", 0.75);
		SetDamageResistance("stun", 0.5);
		if (!(true)) return;
		CUR_SPECIAL = 0;
		NEXT_IDLE = GetGameTime();
		NEXT_IDLE += FREQ_IDLE;
		ScheduleDelayedEvent(2.0, "final_adj");
	}

	void final_adj()
	{
		NPC_HALF_HEALTH = GetEntityMaxHealth(GetOwner());
		NPC_HALF_HEALTH *= 0.5;
	}

	void cycle_up()
	{
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += FREQ_SPECIAL;
		ATTACK_COUNTER = 0;
		if ((DID_WARCRY)) return;
		PlayAnim("critical", ANIM_RAWR);
		EmitSound(GetOwner(), 0, SOUND_RAWR, 10);
		DID_WARCRY = 1;
	}

	void cycle_down()
	{
		DID_WARCRY = 0;
	}

	void my_target_died()
	{
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((IN_CHARGE)) return;
		if ((I_R_FROZEN)) return;
		if (m_hAttackTarget == "unset")
		{
			if (GetGameTime() > NEXT_IDLE)
			{
			}
			NEXT_IDLE = GetGameTime();
			NEXT_IDLE += FREQ_IDLE;
			// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2
			array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
			PlayAnim("once", "breath_slow");
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE_LONG)
		{
			ANIM_ATTACK = ANIM_ATTACK_LONG;
			ATTACK_RANGE = ATTACK_RANGE_LONG;
			ATTACK_HITRANGE = ATTACK_HITRANGE_LONG;
		}
		if (GetEntityRange(m_hAttackTarget) < ATTACK_RANGE_SHORT)
		{
			ANIM_ATTACK = ANIM_ATTACK_SHORT;
			ATTACK_RANGE = ATTACK_RANGE_SHORT;
			ATTACK_HITRANGE = ATTACK_HITRANGE_SHORT;
		}
		if (!(GetGameTime() > NEXT_SPECIAL)) return;
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += FREQ_SPECIAL;
		if (CUR_SPECIAL > 4)
		{
			CUR_SPECIAL = 0;
		}
		CUR_SPECIAL += 1;
		if (CUR_SPECIAL == 1)
		{
			do_charge();
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (GetEntityRange(m_hAttackTarget) > 400)
		{
			CUR_SPECIAL = 0;
			NEXT_SPECIAL = GetGameTime();
			string L_SPECIAL = FREQ_SPECIAL;
			L_SPECIAL *= 0.5;
			NEXT_SPECIAL += L_SPECIAL;
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		if (CUR_SPECIAL == 2)
		{
			AS_ATTACKING = GetGameTime();
			AS_ATTACKING += 3.0;
			PlayAnim("critical", ANIM_JUMP);
			ScheduleDelayedEvent(0.01, "jump_boost");
		}
		if (CUR_SPECIAL == 3)
		{
			int RND_BREATH = RandomInt(1, 2);
			if (RND_BREATH == 1)
			{
				BREATH_TYPE = 1;
			}
			else
			{
				BREATH_TYPE = 0;
			}
			do_breath_attack();
		}
		if (CUR_SPECIAL == 4)
		{
			poison_burst();
			CUR_SPECIAL = 0;
		}
	}

	void jump_boost()
	{
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 250, 200));
	}

	void do_breath_attack()
	{
		ClientEvent("new", "all", "monsters/abomination_cl", GetEntityIndex(GetOwner()), BREATH_TYPE);
		BREATH_IDX = "game.script.last_sent_id";
		npcatk_suspend_ai();
		npcatk_suspend_movement(ANIM_BREATH_ATTACK);
		if (BREATH_TYPE == 0)
		{
			EmitSound(GetOwner(), 1, SOUND_BREATH_START, 10);
			EmitSound(GetOwner(), 2, SOUND_BREATH_LOOP, 10);
		}
		else
		{
			EmitSound(GetOwner(), 1, SOUND_FBREATH, 10);
		}
		PlayAnim("once", "break");
		PlayAnim("hold", ANIM_BREATH_ATTACK);
		SetMoveDest(m_hAttackTarget);
		BREATH_ANG = GetEntityProperty(GetOwner(), "angles.yaw");
		BREATH_ANG -= 45;
		if (BREATH_ANG < 0)
		{
			BREATH_ANG += 359;
		}
		BREATH_COUNT = 0;
		BREATH_ATTACK_ON = 1;
		ScheduleDelayedEvent(0.01, "breath_attack_loop");
	}

	void breath_attack_loop()
	{
		if (!(BREATH_ATTACK_ON)) return;
		BREATH_COUNT += 1;
		if (BREATH_COUNT == 45)
		{
			end_breath_attack();
		}
		if (!(BREATH_COUNT < 45)) return;
		ScheduleDelayedEvent(0.05, "breath_attack_loop");
		BREATH_ANG += 1;
		if (BREATH_ANG > 359)
		{
			BREATH_ANG -= 359;
		}
		string FACE_POS = GetEntityOrigin(GetOwner());
		FACE_POS += /* TODO: $relpos */ $relpos(Vector3(0, BREATH_ANG, 0), Vector3(0, 500, 0));
		SetMoveDest(FACE_POS);
		if (!(GetGameTime() > NEXT_SCAN)) return;
		NEXT_SCAN = GetGameTime();
		NEXT_SCAN += 0.25;
		string SCAN_POINT = /* TODO: $relpos */ $relpos(0, 128, 0);
		CLOUD_TARGS = FindEntitiesInSphere("enemy", 256);
		if (CLOUD_TARGS != "none")
		{
			for (int i = 0; i < GetTokenCount(CLOUD_TARGS, ";"); i++)
			{
				breath_affect_targets();
			}
		}
	}

	void breath_affect_targets()
	{
		string CUR_TARGET = GetToken(CLOUD_TARGS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARGET);
		if (!(WithinCone2D(TARG_ORG, GetMonsterProperty("origin"), GetMonsterProperty("angles")))) return;
		if (!(GetEntityRange(CUR_TARGET) < 384)) return;
		if (BREATH_TYPE == 0)
		{
			ApplyEffect(CUR_TARGET, "effects/dot_poison_blind", 5.0, GetEntityIndex(GetOwner()), DOT_BREATH, 0, 0, "none");
		}
		else
		{
			ApplyEffect(CUR_TARGET, "effects/dot_fire", 5.0, GetEntityIndex(GetOwner()), DOT_BREATH);
		}
		AddVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(0, 800, 120));
	}

	void end_breath_attack()
	{
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += FREQ_SPECIAL;
		ClientEvent("update", "all", BREATH_IDX, "end_fx");
		npcatk_resume_ai();
		npcatk_resume_movement();
		PlayAnim("critical", ANIM_ATTACK);
		// svplaysound: svplaysound 2 0 SOUND_BREATH_LOOP
		EmitSound(2, 0, SOUND_BREATH_LOOP);
		BREATH_ATTACK_ON = 0;
	}

	void frame_attack_short()
	{
		EmitSound(GetOwner(), 1, SOUND_ATTACK_SHORT, 10);
		ATTACK_COUNTER += 1;
		if (ATTACK_COUNTER > 4)
		{
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
			ATTACK_COUNTER = Random(-2, 1);
		}
		MELEE_ATTACK_SHORT = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE_SHORT, ATTACK_HITCHANCE, "slash");
	}

	void frame_attack_long()
	{
		EmitSound(GetOwner(), 1, SOUND_ATTACK_LONG, 10);
		ATTACK_COUNTER += 1;
		if (ATTACK_COUNTER > 3)
		{
			// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2
			array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2};
			EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
			ATTACK_COUNTER = Random(-2, 1);
		}
		MELEE_ATTACK_LONG = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_BITE_LONG, ATTACK_HITCHANCE, "slash");
	}

	void frame_run()
	{
		// PlayRandomSound from: SOUND_STEP1, SOUND_STEP2
		array<string> sounds = {SOUND_STEP1, SOUND_STEP2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void frame_jump_land()
	{
		NEXT_SPECIAL = GetGameTime();
		NEXT_SPECIAL += FREQ_SPECIAL;
		string MY_GROUND = GetEntityOrigin(GetOwner());
		MY_GROUND = "z";
		ClientEvent("new", "all", "effects/sfx_stun_burst", MY_GROUND, 256, 1, Vector3(64, 64, 255));
		STUN_TARGS = FindEntitiesInSphere("enemy", 256);
		if (!(STUN_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(STUN_TARGS, ";"); i++)
		{
			stun_targets();
		}
	}

	void stun_targets()
	{
		string CUR_TARG = GetToken(STUN_TARGS, i, ";");
		if ((IsValidPlayer(CUR_TARG)))
		{
			if (!(IsOnGround(CUR_TARG)))
			{
			}
			int EXIT_SUB = 1;
		}
		if ((EXIT_SUB)) return;
		ApplyEffect(CUR_TARG, "effects/debuff_stun", 5.0, GetEntityIndex(GetOwner()));
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string TARG_ANG = /* TODO: $angles */ $angles(GetMonsterProperty("origin"), TARG_ORG);
		string NEW_YAW = TARG_ANG;
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 800, 110)));
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if ((MELEE_ATTACK_LONG))
			{
				AddVelocity(param2, /* TODO: $relvel */ $relvel(0, 400, 110));
			}
			if ((MELEE_ATTACK_SHORT))
			{
				AddVelocity(param2, /* TODO: $relvel */ $relvel(-150, 200, 110));
			}
		}
		MELEE_ATTACK_LONG = 0;
		MELEE_ATTACK_SHORT = 0;
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (GetEntityMaxHealth(GetOwner()) > NPC_HALF_HEALTH)
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
		}
		else
		{
			// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN1, SOUND_PAIN2
			array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_PAIN1, SOUND_PAIN2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
		}
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if ((DROP_HUNDERSWAMP_CHEST))
		{
			if ("game.players.totalhp" < 3000)
			{
				UseTrigger("mm_abom_seal");
				UseTrigger("brk_weed");
			}
			SpawnNPC("chests/hunderswamp1_extra", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy);
		}
		if (!(BREATH_ATTACK_ON)) return;
		ClientEvent("update", "all", BREATH_IDX, "end_fx");
	}

	void do_charge()
	{
		EmitSound(GetOwner(), 0, SOUND_CHARGE_START, 10);
		IN_CHARGE = 1;
		CHARGE_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		ClientEvent("new", "all", "effects/sfx_motionblur_perm", GetEntityIndex(GetOwner()), 0);
		CHARGE_CL_FX = "game.script.last_sent_id";
		npcatk_suspend_ai(5.0);
		SetCallback("touch", "enable");
		SetRoam(false);
		SetAnimFrameRate(3.0);
		SetMoveSpeed(3.0);
		PlayAnim("critical", ANIM_RUN);
		string CHARGE_DEST = GetEntityOrigin(GetOwner());
		CHARGE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, CHARGE_YAW, 0), Vector3(0, 4000, 0));
		SetMoveDest(CHARGE_DEST);
		charge_scan_loop();
		ScheduleDelayedEvent(5.0, "end_charge");
	}

	void end_charge()
	{
		if (!(IN_CHARGE)) return;
		ClientEvent("update", "all", CHARGE_CL_FX, "effect_die");
		IN_CHARGE = 0;
		SetCallback("touch", "disable");
		SetRoam(true);
		SetAnimFrameRate(1.0);
		SetMoveSpeed(1.0);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		npcatk_resume_ai();
		PlayAnim("critical", ANIM_ATTACK_SHORT);
	}

	void charge_scan_loop()
	{
		if (!(IN_CHARGE)) return;
		ScheduleDelayedEvent(0.1, "charge_scan_loop");
		string CHARGE_DEST = GetEntityOrigin(GetOwner());
		CHARGE_DEST += /* TODO: $relpos */ $relpos(Vector3(0, CHARGE_YAW, 0), Vector3(0, 256, 0));
		SetMoveDest(CHARGE_DEST);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 300, 0));
		PlayAnim("once", ANIM_RUN);
		string TRACE_START = GetEntityOrigin(GetOwner());
		TRACE_START += "z";
		string TRACE_END = TRACE_START;
		string MY_YAW = GetEntityProperty(GetOwner(), "angles.yaw");
		TRACE_END += /* TODO: $relpos */ $relpos(Vector3(0, MY_YAW, 0), Vector3(0, 100, 0));
		string TRACE_LINE = TraceLine(TRACE_START, TRACE_END);
		if (!(TRACE_LINE != TRACE_END)) return;
		end_charge();
	}

	void OnTouch(CBaseEntity@ other) override
	{
		LogDebug("game_touch GetEntityName(param1)");
		if (!(GetGameTime() > NEXT_TOUCH_CHECK)) return;
		NEXT_TOUCH_CHECK = GetGameTime();
		NEXT_TOUCH_CHECK += 0.1;
		string TARG_ORG = GetEntityOrigin(param1);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		AddVelocity(param1, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 2000, 400)));
		DoDamage(param1, 110, DMG_CHARGE, 1.0, "blunt");
	}

	void poison_burst()
	{
		PlayAnim("critical", "grab_fling");
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 5.0;
		string BURST_ORG = GetEntityOrigin(GetOwner());
		BURST_ORG += "z";
		ClientEvent("new", "all", "effects/sfx_poison_burst", BURST_ORG, 196, 0);
		BURST_TARGS = FindEntitiesInSphere("enemy", 196);
		if (!(BURST_TARGS != "none")) return;
		for (int i = 0; i < GetTokenCount(BURST_TARGS, ";"); i++)
		{
			poison_burst_affect_targets();
		}
	}

	void poison_burst_affect_targets()
	{
		string CUR_TARG = GetToken(BURST_TARGS, i, ";");
		string TARG_ORG = GetEntityOrigin(CUR_TARG);
		string MY_ORG = GetEntityOrigin(GetOwner());
		string NEW_YAW = /* TODO: $angles */ $angles(MY_ORG, TARG_ORG);
		AddVelocity(CUR_TARG, /* TODO: $relvel */ $relvel(Vector3(0, NEW_YAW, 0), Vector3(0, 2000, 400)));
		ApplyEffect(CUR_TARG, "effects/poison_spore", 5.0, GetEntityIndex(GetOwner()), DOT_POISON_BURST);
	}

	void set_hunderswamp_north_spec()
	{
		LogDebug("set_hunderswamp_north_spec");
		DROP_HUNDERSWAMP_CHEST = 1;
		SetRace("wildanimal");
	}

}

}
