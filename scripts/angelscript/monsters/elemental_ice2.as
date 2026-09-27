#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class ElementalIce2 : CGameScript
{
	int AIM_RATIO;
	int AMB_FROST_DAMAGE;
	string ANIM_ALERT;
	string ANIM_ATTACK;
	string ANIM_BASEIDLE;
	string ANIM_BUGIDLE_A;
	string ANIM_BUGIDLE_B;
	string ANIM_BUGIDLE_C;
	string ANIM_CHARGE;
	string ANIM_CHARGEIDLE;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_FLOAT;
	string ANIM_FROMCHARGE;
	string ANIM_GLOAT;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_SEARCH;
	string ANIM_SWIPE;
	string ANIM_TOCHARGE;
	string ANIM_WALK;
	string AS_ATTACKING;
	int AS_SUMMON_TELE_CHECK;
	float ATTACK_ACCURACY;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CIRCLE_DELAY;
	float CIRCLE_FREQ;
	int CIRCLE_RANGE;
	int CIRCLE_RUNNING;
	string CIRCLE_SCRIPT;
	int DID_SHRUG;
	string DID_WARCRY;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	string FIRE_BALL_AMMO;
	int FROST_DAMAGE;
	string GLOAT_DELAY;
	int HOVER_LOOP_DELAY;
	int ICESEAL_DAMAGE;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	int I_AM_TURNABLE;
	string MONSTER_MODEL;
	int MOVE_FAST;
	int MOVE_NORMAL;
	int MOVE_RANGE;
	string MY_HURT_STAGE;
	int NO_STUCK_CHECKS;
	int NO_VICTORY_HEAL;
	float NPC_DELAYING_UNSTUCK;
	int NPC_GIVE_EXP;
	string NPC_HACKED_MOVE_SPEED;
	string NPC_MOVEDEST_TARGET;
	float PLAYTIME_HOVER;
	int PREP_CIRCLE;
	int SNOWBALL_DAMAGE;
	int SNOWBALL_DELAY;
	float SNOWBALL_DURATION;
	float SNOWBALL_FREQ;
	int SNOWBALL_RANGE;
	string SOUND_ALERT;
	string SOUND_CIRCLE_READY;
	string SOUND_DEATH;
	string SOUND_GLOAT;
	string SOUND_HOVER;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;
	string SOUND_PAIN0;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_SNOWBALL;
	string SOUND_SWIPE;
	string SOUND_SWIPEHIT;
	string SOUND_WAVE_GO;
	int STRIKE_DAMAGE;
	int SWIPE_HITRANGE;
	int SWIPE_MOVERANGE;
	int SWIPE_RANGE;
	string TEMP_MOVE_TARGET;
	int USE_SWIPE_SOUND;

	ElementalIce2()
	{
		AS_SUMMON_TELE_CHECK = 1;
		IS_UNHOLY = 1;
		IMMUNE_VAMPIRE = 1;
		ATTACK_RANGE = 1024;
		SWIPE_RANGE = 100;
		SNOWBALL_RANGE = 600;
		SNOWBALL_DAMAGE = 100;
		SNOWBALL_FREQ = 45.0;
		SNOWBALL_DURATION = 10.0;
		SOUND_SNOWBALL = "zombie/claw_miss1.wav";
		ATTACK_HITRANGE = 150;
		MOVE_RANGE = 65;
		ATTACK_HITCHANCE = 0.8;
		SWIPE_MOVERANGE = 65;
		SWIPE_RANGE = 100;
		SWIPE_HITRANGE = 150;
		ATTACK_ACCURACY = 0.8;
		CIRCLE_RANGE = 2048;
		AIM_RATIO = 50;
		AMB_FROST_DAMAGE = "$rand(30,60)";
		FROST_DAMAGE = "$rand(60,80)";
		STRIKE_DAMAGE = "$rand(100,250)";
		ICESEAL_DAMAGE = 200;
		ANIM_IDLE = "idle1";
		ANIM_WALK = "idle1";
		ANIM_RUN = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_SWIPE = "attack1";
		ANIM_FLINCH = "flinch";
		ANIM_DEATH = "die1";
		ANIM_BASEIDLE = "idle1";
		ANIM_FLOAT = "idle1";
		ANIM_BUGIDLE_A = "idle1";
		ANIM_BUGIDLE_B = "idle2";
		ANIM_BUGIDLE_C = "dunno";
		ANIM_CHARGE = "float";
		ANIM_SWIPE = "attack1";
		ANIM_ALERT = "yes";
		ANIM_GLOAT = "no";
		ANIM_SEARCH = "dunno";
		ANIM_TOCHARGE = "tocharge";
		ANIM_CHARGEIDLE = "charging";
		ANIM_FROMCHARGE = "fromcharge";
		SOUND_ALERT = "agrunt/ag_alert5.wav";
		SOUND_IDLE1 = "agrunt/ag_alert1.wav";
		SOUND_IDLE2 = "agrunt/ag_die1.wav";
		SOUND_IDLE3 = "agrunt/ag_idle1.wav";
		SOUND_SWIPE = "weapons/debris1.wav";
		SOUND_SWIPEHIT = "magic/frost_reverse.wav";
		SOUND_DEATH = "garg/gar_die1.wav";
		SOUND_PAIN0 = "debris/glass1.wav";
		SOUND_PAIN1 = "agrunt/ag_pain1.wav";
		SOUND_PAIN2 = "agrunt/ag_pain4.wav";
		SOUND_GLOAT = "x/x_laugh1.wav";
		SOUND_CIRCLE_READY = "debris/beamstart1.wav";
		SOUND_WAVE_GO = "ambience/flameburst1.wav";
		SOUND_HOVER = "fans/fan3on.wav";
		PLAYTIME_HOVER = 3.0;
		CIRCLE_FREQ = 30.0;
		NO_VICTORY_HEAL = 1;
		CIRCLE_SCRIPT = "monsters/summon/ice_wave";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 40;
		I_AM_TURNABLE = 0;
		MOVE_FAST = 200;
		MOVE_NORMAL = 100;
		NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
		MONSTER_MODEL = "monsters/elementals_greater.mdl";
		Precache(MONSTER_MODEL);
	}

	void OnSpawn() override
	{
		SetName("Greater Ice Elemental");
		SetHealth(1750);
		SetWidth(32);
		SetHeight(48);
		SetRace("demon");
		SetDamageResistance("all", 0.4);
		SetDamageResistance("holy", 1.5);
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("poison", 0.0);
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(3);
		Precache(MONSTER_MODEL);
		SetModel(MONSTER_MODEL);
		SetModelBody(0, 1);
		SetBloodType("none");
		CIRCLE_DELAY = 1;
		ScheduleDelayedEvent(15.0, "reset_circle_delay");
		NPC_GIVE_EXP = 400;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		SetStat("parry", 40);
		MY_HURT_STAGE = GetEntityMaxHealth(GetOwner());
		MY_HURT_STAGE *= 0.5;
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		string MY_HEALTH = GetEntityHealth(GetOwner());
		if (MY_HEALTH >= MY_HURT_STAGE)
		{
			// PlayRandomSound from: SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN1
			array<string> sounds = {SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN1};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (MY_HEALTH <= MY_HURT_STAGE)
		{
			// PlayRandomSound from: SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN2
			array<string> sounds = {SOUND_PAIN0, SOUND_PAIN0, SOUND_PAIN2};
			EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		}
		if (param1 > 40)
		{
			AddVelocity(GetOwner(), /* TODO: $relpos */ $relpos(1, -10, 1));
		}
		if (!(GetEntityRange(m_hLastStruck) < MOVE_RANGE)) return;
		ApplyEffect(m_hLastStruck, "effects/dot_cold", 1, GetEntityIndex(GetOwner()), AMB_FROST_DAMAGE);
	}

	void idle_sounds()
	{
		float NEXT_SOUND = Random(5, 15);
		NEXT_SOUND("idle_sounds");
		if ((IS_HUNTING)) return;
		int RAND_ANIM = RandomInt(1, 3);
		if (RAND_ANIM == 1)
		{
			PlayAnim("once", ANIM_BUGIDLE_A);
		}
		if (RAND_ANIM == 2)
		{
			PlayAnim("once", ANIM_BUGIDLE_B);
		}
		if (RAND_ANIM == 3)
		{
			PlayAnim("once", ANIM_BUGIDLE_C);
		}
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void game_dodamage()
	{
		if ((CIRCLE_RUNNING))
		{
			if ((param1))
			{
				ApplyEffect(m_hLastStruckByMe, "effects/dot_cold_freeze", 10.0, /* TODO: $get with insufficient args */ null);
				int THROW_DIR = RandomInt(1, 2);
				if (THROW_DIR == 1)
				{
					AddVelocity(param2, /* TODO: $relvel */ $relvel(-100, 50, 30));
				}
				if (THROW_DIR == 2)
				{
					AddVelocity(param2, /* TODO: $relvel */ $relvel(100, 50, 30));
				}
			}
		}
		if ((param1))
		{
			if ((USE_SWIPE_SOUND))
			{
				ApplyEffect(param2, "effects/dot_cold", 4, GetEntityIndex(GetOwner()), FROST_DAMAGE, "none");
				EmitSound(GetOwner(), 0, SOUND_SWIPEHIT, 10);
			}
		}
		USE_SWIPE_SOUND = 0;
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if ((SUSPEND_AI)) return;
		if (!(CIRCLE_DELAY))
		{
			ATTACK_RANGE = CIRCLE_RANGE;
		}
		if ((CIRCLE_DELAY))
		{
			ATTACK_RANGE = SWIPE_RANGE;
		}
		if (!(SNOWBALL_DELAY))
		{
			if (GetEntityRange(m_hAttackTarget) > 256)
			{
				if (!(CIRCLE_RUNNING))
				{
				}
				if (!(PREP_CIRCLE))
				{
				}
				PlayAnim("critical", "fireball");
				AS_ATTACKING = GetGameTime();
				SNOWBALL_DELAY = 1;
				SNOWBALL_FREQ("reset_snowball");
			}
		}
	}

	void npc_selectattack()
	{
		if ((CIRCLE_RUNNING)) return;
		if ((CIRCLE_DELAY)) return;
		if (!(false)) return;
		if (!(GetEntityRange(m_hAttackTarget) < CIRCLE_RANGE)) return;
		PREP_CIRCLE = 1;
		NO_STUCK_CHECKS = 1;
		AS_ATTACKING = GetGameTime();
		npcatk_suspend_ai();
		npcatk_clear_movedest();
		ScheduleDelayedEvent(0.1, "circle_prep");
		CIRCLE_DELAY = 1;
		CIRCLE_FREQ("reset_circle_delay");
	}

	void circle_prep()
	{
		SetMoveSpeed(0);
		SetAnimMoveSpeed(0);
		NPC_HACKED_MOVE_SPEED = 0;
		Effect("glow", GetOwner(), Vector3(0, 75, 255), 50, 5, 5);
		EmitSound(GetOwner(), 0, SOUND_CIRCLE_READY, 10);
		PlayAnim("critical", "tocharge");
	}

	void tocharge_done()
	{
		if ((false))
		{
			string TRACE_START = GetMonsterProperty("origin");
			string TRACE_END = /* TODO: $relpos */ $relpos(0, 9999, 0);
			TEMP_MOVE_TARGET = TraceLine(TRACE_START, TRACE_END);
			SetMoveDest(TEMP_MOVE_TARGET);
		}
		SetIdleAnim(ANIM_CHARGEIDLE);
		SetMoveAnim(ANIM_CHARGEIDLE);
		ScheduleDelayedEvent(2.0, "circle_go");
	}

	void circle_go()
	{
		if ((CIRCLE_RUNNING)) return;
		SetMoveAnim(ANIM_CHARGE);
		SetIdleAnim(ANIM_CHARGE);
		SetMoveSpeed(2.0);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 100, 0));
		SetAnimMoveSpeed(MOVE_FAST);
		NPC_HACKED_MOVE_SPEED = MOVE_FAST;
		PlayAnim("critical", ANIM_CHARGE);
		CIRCLE_RUNNING = 1;
		EmitSound(GetOwner(), 0, SOUND_WAVE_GO, 10);
		SpawnNPC(CIRCLE_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: 3.0, GetEntityIndex(GetOwner())
		circle_cycle();
		ScheduleDelayedEvent(3.0, "circle_done");
	}

	void circle_cycle()
	{
		if (!(CIRCLE_RUNNING)) return;
		SetMoveDest(TEMP_MOVE_TARGET);
		if (Distance(GetMonsterProperty("origin"), TEMP_MOVE_TARGET) < 32)
		{
			circle_done();
		}
		npcatk_dodamage(/* TODO: $relpos */ $relpos(0, 32, 0), 72, 0, 100, 0);
		ScheduleDelayedEvent(0.1, "circle_cycle");
	}

	void circle_done()
	{
		if (!(CIRCLE_RUNNING)) return;
		npcatk_resume_ai();
		PREP_CIRCLE = 0;
		SetMoveSpeed(1.0);
		SetMoveAnim(ANIM_WALK);
		SetIdleAnim(ANIM_IDLE);
		ANIM_ATTACK = ANIM_SWIPE;
		SetAnimMoveSpeed(MOVE_NORMAL);
		NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
		CIRCLE_RUNNING = 0;
		NO_STUCK_CHECKS = 0;
	}

	void reset_circle_delay()
	{
		CIRCLE_DELAY = 0;
	}

	void slow_down()
	{
		NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
	}

	void ammo_up()
	{
		FIRE_BALL_AMMO = FULL_FIRE_BALL_AMMO;
	}

	void npcatk_search_init_advanced()
	{
		if ((false)) return;
		if ((DID_SHRUG)) return;
		DID_SHRUG = 1;
		NPC_DELAYING_UNSTUCK = 5.0;
		PlayAnim("critical", ANIM_SEARCH);
		EmitSound(GetOwner(), 0, SOUND_IDLE3, 10);
	}

	void my_target_died()
	{
		if (!(GLOAT_DELAY))
		{
			PlayAnim("critical", ANIM_GLOAT);
			EmitSound(GetOwner(), 0, SOUND_GLOAT, 10);
			GLOAT_DELAY = 1;
			ScheduleDelayedEvent(10.0, "reset_gloat");
		}
		if (!(false))
		{
			DID_WARCRY = 0;
			DID_SHRUG = 0;
		}
	}

	void reset_gloat()
	{
		GLOAT_DELAY = 0;
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((SUSPEND_AI)) return;
		if (!(IsValidPlayer(param1))) return;
		if ((DID_WARCRY)) return;
		DID_WARCRY = 1;
		PlayAnim("critical", ANIM_ALERT);
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
	}

	void attack1_strike()
	{
		USE_SWIPE_SOUND = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, STRIKE_DAMAGE, ATTACK_ACCURACY);
	}

	void game_movingto_dest()
	{
		if ((RUNNING_CIRCLE)) return;
		SetAnimMoveSpeed(NPC_HACKED_MOVE_SPEED);
		if ((HOVER_LOOP_DELAY)) return;
		EmitSound(GetOwner(), CHAN_BODY, SOUND_HOVER, 8);
		HOVER_LOOP_DELAY = 1;
		PLAYTIME_HOVER("hover_loop_reset");
	}

	void hover_loop_reset()
	{
		HOVER_LOOP_DELAY = 0;
	}

	void game_stopmoving()
	{
		SetAnimMoveSpeed(0);
	}

	void throw_fireball()
	{
		EmitSound(GetOwner(), 0, SOUND_SNOWBALL, 10);
		string AIM_ANGLE = GetEntityDist(m_hLastSeen);
		AIM_ANGLE /= AIM_RATIO;
		SetAngles("add_view.pitch");
		TossProjectile("proj_snow_ball", /* TODO: $relpos */ $relpos(0, 52, 24), "none", 200, SNOWBALL_DAMAGE, 2, "none");
	}

	void reset_snowball()
	{
		SNOWBALL_DELAY = 0;
	}

	void npcatk_clear_movedest()
	{
		SetMoveDest("none");
		NPC_MOVEDEST_TARGET = "unset";
	}

}

}
