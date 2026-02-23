#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_propelled.as"

namespace MS
{

class ElementalFire1 : CGameScript
{
	int AM_SUMMONED;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int AS_SUMMON_TELE_CHECK;
	float ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int COF_ACTIVE;
	int FIREBALL_PREPPED;
	string FIRE_BALL_AMMO;
	string FLINCH_ANIM;
	int FLINCH_CHANCE;
	int FLINCH_DELAY;
	int FLINCH_DMG_REQ;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	string MY_HURT_STAGE;
	string MY_OWNER;
	string NEXT_CIRCLE;
	string NEXT_FIRE_BALL;
	int NO_SPAWN_STUCK_CHECK;
	int NPC_GIVE_EXP;
	string NPC_HACKED_MOVE_SPEED;
	int SWIPE_ATTACK;

	ElementalFire1()
	{
		AS_SUMMON_TELE_CHECK = 1;
		ANIM_IDLE = "idle1";
		ANIM_WALK = "idle1";
		ANIM_RUN = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_FLINCH = "flinch";
		ANIM_DEATH = "die1";
		const string ANIM_TOCHARGE = "tocharge";
		const string ANIM_CHARGEIDLE = "charging";
		const string ANIM_FROMCHARGE = "fromcharge";
		const string ANIM_FIRE_BALL = "fireball";
		const string ANIM_SWIPE = "attack1";
		const string ANIM_ALERT = "yes";
		const string ANIM_GLOAT = "no";
		const string ANIM_SEARCH = "dunno";
		NPC_GIVE_EXP = 200;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 10;
		FLINCH_ANIM = "flinch";
		FLINCH_DELAY = 1;
		FLINCH_DMG_REQ = 30;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 150;
		ATTACK_MOVERANGE = 65;
		const int MOVE_FAST = 200;
		const int MOVE_NORMAL = 100;
		NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
		const int SWIPE_MOVERANGE = 65;
		const string RAND_IDLE_ANIMS = "idle1;idle2;dunno";
		const int LIGHT_RAD = 196;
		const int CIRCLE_RANGE = 128;
		const float FREQ_CIRCLE = 15.0;
		const float CIRCLE_DURATION = 8.0;
		ATTACK_HITCHANCE = 0.8;
		const string PROJ_SCRIPT = "proj_fire_ball";
		const int FIRE_BALL_RANGE = 2000;
		const int FULL_FIRE_BALL_AMMO = 3;
		const int AIM_RATIO = 50;
		const int ATTACK_CONE_OF_FIRE = 2;
		const int ATTACK_SPEED = 500;
		const string DOT_FIRE = RandomInt(10, 30);
		const int DMG_SEAL = 200;
		const string DMG_FIRE_BALL = RandomInt(50, 100);
		const string DMG_SWIPE = RandomInt(20, 50);
		const float FREQ_FIRE_BALL = 0.5;
		const string SOUND_ALERT = "agrunt/ag_alert5.wav";
		const string SOUND_IDLE1 = "agrunt/ag_alert1.wav";
		const string SOUND_IDLE2 = "agrunt/ag_die1.wav";
		const string SOUND_IDLE3 = "agrunt/ag_idle1.wav";
		const string SOUND_SWIPE = "weapons/debris1.wav";
		const string SOUND_SWIPEHIT = "ambience/steamburst1.wav";
		const string SOUND_DEATH = "garg/gar_die1.wav";
		const string SOUND_PAIN0 = "debris/bustflesh2.wav";
		const string SOUND_PAIN1 = "agrunt/ag_pain1.wav";
		const string SOUND_PAIN2 = "agrunt/ag_pain4.wav";
		const string SOUND_GLOAT = "x/x_laugh1.wav";
		const string SOUND_FIRECHARGE = "magic/fireball_powerup.wav";
		const string SOUND_FIRESHOOT = "magic/fireball_strike.wav";
		const string SOUND_CIRCLE_READY = "debris/beamstart1.wav";
		const string SOUND_HOVER = "fans/fan4on.wav";
		if ((IsEntityAlive(GetOwner())))
		{
		}
		// svplaysound: svplaysound 1 8 SOUND_HOVER
		EmitSound(1, 8, SOUND_HOVER);
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(Random(5, 15));
		if ((IsEntityAlive(GetOwner())))
		{
		}
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if ((m_hAttackTarget).findFirst("unset") >= 0)
		{
		}
		string RND_PICK = RandomInt(0, 2);
		string RND_ANIM = GetToken(RAND_IDLE_ANIMS, RND_PICK, ";");
		PlayAnim("critical", RND_ANIM);
	}

	void OnRepeatTimer_1()
	{
		SetRepeatDelay(15.1);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 128, 64), LIGHT_RAD, 15.0);
	}

	void OnSpawn() override
	{
		SetName("Fire Elemental");
		SetModel("monsters/elementals_lesser.mdl");
		SetHealth(500);
		SetWidth(32);
		SetHeight(48);
		SetRace("demon");
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.5);
		SetDamageResistance("poison", 0.0);
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(5);
		FIRE_BALL_AMMO = FULL_FIRE_BALL_AMMO;
		SetBloodType("none");
		IMMUNE_VAMPIRE = 1;
		IS_UNHOLY = 1;
		MY_HURT_STAGE = GetEntityMaxHealth(GetOwner());
		MY_HURT_STAGE *= 0.5;
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 128, 64), LIGHT_RAD, 15.0);
	}

	void cycle_up()
	{
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
		PlayAnim("once", ANIM_ALERT);
		NEXT_CIRCLE = GetGameTime();
		NEXT_CIRCLE += FREQ_CIRCLE;
	}

	void npc_targetsighted()
	{
		if (!(GetEntityRange(m_hAttackTarget) > ATTACK_RANGE)) return;
		if (!(FIRE_BALL_AMMO > 0)) return;
		if (!(FIREBALL_PREPPED))
		{
			EmitSound(GetOwner(), 0, SOUND_FIRECHARGE, 10);
		}
		FIREBALL_PREPPED = 1;
		PlayAnim("once", ANIM_FIRE_BALL);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		if (FIRE_BALL_AMMO > 0)
		{
			ATTACK_MOVERANGE = 512;
		}
		else
		{
			ATTACK_MOVERANGE = SWIPE_MOVERANGE;
		}
		if (!(m_hAttackTarget != "unset")) return;
		if (GetGameTime() > NEXT_CIRCLE)
		{
			ATTACK_MOVERANGE = SWIPE_MOVERANGE;
			if (GetEntityRange(m_hAttackTarget) < CIRCLE_RANGE)
			{
			}
			NEXT_CIRCLE = GetGameTime();
			NEXT_CIRCLE += FREQ_CIRCLE;
			do_cof();
		}
	}

	void throw_fireball()
	{
		FIREBALL_PREPPED = 0;
		FIRE_BALL_AMMO -= 1;
		EmitSound(GetOwner(), 0, SOUND_FIRESHOOT, 10);
		string AIM_ANGLE = GetEntityDist(m_hAttackTarget);
		LogDebug("throw_fireball AIM_ANGLE");
		AIM_ANGLE /= AIM_RATIO;
		SetAngles("add_view.x");
		TossProjectile(PROJ_SCRIPT, /* TODO: $relpos */ $relpos(0, 48, 24), "none", ATTACK_SPEED, DMG_FIRE_BALL, ATTACK_CONE_OF_FIRE, "none");
		CallExternal(GetEntityIndex("ent_lastprojectile"), "lighten", DOT_FIRE);
		NEXT_FIRE_BALL = GetGameTime();
		NEXT_FIRE_BALL += FREQ_FIRE_BALL;
	}

	void attack1_strike()
	{
		SWIPE_ATTACK = 1;
		DoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWIPE, 0.9, "blunt");
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
		if (param1 > 20)
		{
			if (MY_HEALTH > 0)
			{
			}
			AddVelocity(GetOwner(), /* TODO: $relpos */ $relpos(Vector3(0, GetMonsterProperty("angles.yaw"), 0), Vector3(Random(-100, 100), -500, 0)));
		}
		if (!(GetEntityRange(m_hLastStruck) < MOVE_RANGE)) return;
		ApplyEffect(m_hLastStruck, "effects/dot_fire", 2, GetEntityIndex(GetOwner()), DOT_FIRE);
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if ((SWIPE_ATTACK))
			{
			}
			ApplyEffect(param2, "effects/dot_fire", 5, GetEntityIndex(GetOwner()), DOT_FIRE);
			if ((USE_SWIPE_SOUND))
			{
				EmitSound(GetOwner(), 0, SOUND_SWIPEHIT, 10);
			}
		}
		SWIPE_ATTACK = 0;
	}

	void game_dynamically_created()
	{
		MY_OWNER = GetEntityIndex(param1);
		if (!(IsEntityAlive(MY_OWNER))) return;
		SetRace(GetEntityRace(MY_OWNER));
		AM_SUMMONED = 1;
		ScheduleDelayedEvent(0.1, "summoned_sound");
		NO_SPAWN_STUCK_CHECK = 1;
	}

	void summoned_sound()
	{
		EmitSound(GetOwner(), 0, "ambience/alien_humongo.wav", 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		// svplaysound: svplaysound 1 0 SOUND_HOVER
		EmitSound(1, 0, SOUND_HOVER);
		// svplaysound: svplaysound 2 0 weapons/egon_run3.wav
		EmitSound(2, 0, "weapons/egon_run3.wav");
		if (!(AM_SUMMONED)) return;
		CallExternal(MY_OWNER, "elemental_died");
	}

	void do_cof()
	{
		if (!(IsEntityAlive(GetOwner()))) return;
		if (!(m_hAttackTarget != "unset")) return;
		if (!(GetEntityRange(m_hAttackTarget) <= CIRCLE_RANGE)) return;
		npcatk_suspend_ai();
		game_stopmoving();
		PlayAnim("critical", ANIM_TOCHARGE);
		EmitSound(GetOwner(), 0, SOUND_CIRCLE_READY, 10);
		ScheduleDelayedEvent(0.5, "do_cof2");
	}

	void do_cof2()
	{
		npcatk_suspend_movement(ANIM_CHARGEIDLE);
		ClientEvent("new", "all", "effects/sfx_circle_of_fire", GetEntityOrigin(GetOwner()), 64, 1, CIRCLE_DURATION);
		// svplaysound: svplaysound 2 10 weapons/egon_run3.wav
		EmitSound(2, 10, "weapons/egon_run3.wav");
		COF_ACTIVE = 1;
		CIRCLE_DURATION("cof_end");
		do_cof_loop();
	}

	void cof_end()
	{
		npcatk_resume_ai();
		npcatk_resume_movement();
		EmitSound(GetOwner(), 3, "weapons/egon_off1.wav", 10);
		// svplaysound: svplaysound 2 0 weapons/egon_run3.wav
		EmitSound(2, 0, "weapons/egon_run3.wav");
		COF_ACTIVE = 0;
		FIRE_BALL_AMMO = FULL_FIRE_BALL_AMMO;
	}

	void do_cof_loop()
	{
		if (!(COF_ACTIVE)) return;
		if (!(IsEntityAlive(GetOwner()))) return;
		XDoDamage(/* TODO: $relpos */ $relpos(0, 0, 0), 128, DMG_SEAL, 0, GetOwner(), GetOwner(), "none", "fire_effect");
		ScheduleDelayedEvent(1.0, "do_cof_loop");
	}

}

}
