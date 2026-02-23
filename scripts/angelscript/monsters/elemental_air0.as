#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class ElementalAir0 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	int AS_SUMMON_TELE_CHECK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string BEAM_DURATION;
	string BEAM_ID;
	string BEAM_ON;
	int CAN_ATTACK;
	int CAN_FLINCH;
	int CAN_FLY;
	int CAN_HEAR;
	int CAN_HUNT;
	int CAN_RETALIATE;
	int CAN_WANDER;
	int DID_SHRUG;
	string DID_WARCRY;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	string EL_FLEE_DELAY;
	string FIRE_BALL_AMMO;
	int FLEE_DISTANCE;
	string FLINCH_ANIM;
	int FLINCH_CHANCE;
	int FLINCH_DELAY;
	int FLINCH_DMG_REQ;
	string GLOAT_DELAY;
	int HOVER_LOOP_DELAY;
	int HUNT_AGRO;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	int I_JUST_SPAWNED;
	int LIGHTNING_COUNT;
	string ME_SHOOTING;
	int MONSTER_WIDTH;
	int MOVE_RANGE;
	string MY_HURT_STAGE;
	string NEXT_BEAM;
	int NPC_GIVE_EXP;
	string NPC_HACKED_MOVE_SPEED;
	string OLD_BEAM_TARG;
	string SHOCK_AMT;
	int THROWING_FIRE_BALL;
	string USE_SWIPE_SOUND;
	int ZAP_DELAY;

	ElementalAir0()
	{
		AS_SUMMON_TELE_CHECK = 1;
		IS_UNHOLY = 1;
		IMMUNE_VAMPIRE = 1;
		const string FREQ_ZAP = RandomInt(3, 8);
		const float FREQ_FLEE = 10.0;
		const string FREQ_REPOS = Random(1, 3);
		const string DMG_CHAIN = Random(2, 6);
		const int BEAM_RANGE = 2048;
		const string FINGER_ADJ = "$relpos($vec(0,MY_YAW,0),$vec(0,30,0))";
		const string SOUND_SHOCK1 = "debris/zap8.wav";
		const string SOUND_SHOCK2 = "debris/zap3.wav";
		const string SOUND_SHOCK3 = "debris/zap4.wav";
		CAN_ATTACK = 1;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		CAN_FLY = 0;
		CAN_HEAR = 1;
		CAN_WANDER = 1;
		CAN_RETALIATE = 1;
		const int RETALIATE_CHANGETARGET_CHANCE = 100;
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 10;
		FLINCH_ANIM = "flinch";
		FLINCH_DELAY = 1;
		FLINCH_DMG_REQ = 30;
		FLEE_DISTANCE = 4096;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 150;
		MOVE_RANGE = 65;
		const float ATTACK_HITCHANCE = 0.8;
		const int SWIPE_MOVERANGE = 65;
		const int SWIPE_RANGE = 100;
		const int SWIPE_HITRANGE = 150;
		const int FIRE_BALL_RANGE = 2000;
		const float ATTACK_ACCURACY = 0.8;
		const string ATTACK_DAMAGE = "$rand(50,100)";
		const int CIRCLE_RANGE = 256;
		const int AIM_RATIO = 50;
		const int ATTACK_CONE_OF_FIRE = 2;
		const int ATTACK_SPEED = 500;
		const string FIRE_DAMAGE = "$rand(20,50)";
		const string AMB_FIRE_DAMAGE = "$rand(10,30)";
		const int FIRESEAL_DAMAGE = 200;
		const string FIRE_BALL_DAMAGE = "$rand(50,100)";
		const int FULL_FIRE_BALL_AMMO = 3;
		ANIM_IDLE = "idle1";
		ANIM_WALK = "idle1";
		ANIM_RUN = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_FLINCH = "flinch";
		ANIM_DEATH = "die1";
		const string ANIM_BASEIDLE = "idle1";
		const string ANIM_FLOAT = "idle1";
		const string ANIM_BUGIDLE_A = "idle1";
		const string ANIM_BUGIDLE_B = "idle2";
		const string ANIM_BUGIDLE_C = "dunno";
		const string ANIM_CHARGE = "float";
		const string ANIM_FIRE_BALL = "fireball";
		const string ANIM_SWIPE = "attack1";
		const string ANIM_PARRY = "block";
		const string ANIM_ALERT = "yes";
		const string ANIM_GLOAT = "no";
		const string ANIM_SEARCH = "dunno";
		const string ANIM_TOCHARGE = "tocharge";
		const string ANIM_CHARGEIDLE = "charging";
		const string ANIM_FROMCHARGE = "fromcharge";
		const string SOUND_ALERT = "agrunt/ag_alert5.wav";
		const string SOUND_IDLE1 = "agrunt/ag_alert1.wav";
		const string SOUND_IDLE2 = "agrunt/ag_die1.wav";
		const string SOUND_IDLE3 = "agrunt/ag_idle1.wav";
		const string SOUND_SWIPE = "weapons/debris1.wav";
		const string SOUND_SWIPEHIT = "ambience/steamburst1.wav";
		const string SOUND_DEATH = "garg/gar_die1.wav";
		const float HURT_THRESHOLD = 0.5;
		const string SOUND_PAIN0 = "debris/bustflesh2.wav";
		const string SOUND_PAIN1 = "agrunt/ag_pain1.wav";
		const string SOUND_PAIN2 = "agrunt/ag_pain4.wav";
		const string SOUND_GLOAT = "x/x_laugh1.wav";
		const string SOUND_FIRECHARGE = "magic/fireball_powerup.wav";
		const string SOUND_FIRESHOOT = "magic/fireball_strike.wav";
		const string SOUND_CIRCLE_READY = "debris/beamstart1.wav";
		const string SOUND_HOVER = "fans/fan4on.wav";
		const float PLAYTIME_HOVER = 3.0;
		const string PROJ_SCRIPT = "proj_fire_ball";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 40;
		const int I_AM_TURNABLE = 0;
		MONSTER_WIDTH = 32;
		const int MOVE_FAST = 200;
		const int MOVE_NORMAL = 100;
		NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
		Precache("monsters/elementals_lesser.mdl");
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(FREQ_REPOS);
		string RND_FLOAT_X = RandomInt(1, 20);
		string RND_FLOAT_Y = RandomInt(1, 20);
		string RND_FLOAT_Z = RandomInt(1, 20);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(RND_FLOAT_X, RND_FLOAT_Y, RND_FLOAT_Z));
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", RandomInt(200, 255));
	}

	void OnSpawn() override
	{
		SetName("Summoned Air Elemental");
		SetHealth(500);
		SetWidth(72);
		SetHeight(72);
		SetRace("demon");
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("poison", 1.5);
		SetDamageResistance("lightning", 0.0);
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(5);
		SetModel("monsters/elementals_lesser_fly.mdl");
		SetModelBody(0, 1);
		NPC_GIVE_EXP = 150;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		FIRE_BALL_AMMO = FULL_FIRE_BALL_AMMO;
		I_JUST_SPAWNED = 1;
		SetBloodType("none");
		SetFly(true);
		MY_HURT_STAGE = GetEntityMaxHealth(GetOwner());
		MY_HURT_STAGE *= HURT_THRESHOLD;
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", RandomInt(200, 255));
		ScheduleDelayedEvent(0.1, "init_beam");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		if (GetEntityRange(m_hLastStruck) < ATTACK_HITRANGE)
		{
			if (!(EL_FLEE_DELAY))
			{
			}
			EL_FLEE_DELAY = 1;
			FREQ_FLEE("reset_el_flee_delay");
			npcatk_flee(GetEntityIndex(m_hLastStruck), 1024, 5);
		}
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
	}

	void reset_el_flee_delay()
	{
		EL_FLEE_DELAY = 0;
	}

	void idle_sounds()
	{
		string NEXT_SOUND = Random(5, 15);
		NEXT_SOUND("idle_sounds");
		if (!(HUNT_LASTTARGET == �NONE�)) return;
		string RAND_ANIM = RandomInt(1, 3);
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
		if (!(param1)) return;
		if ((USE_SWIPE_SOUND))
		{
			string VEL_F = RandomInt(10, 400);
			string VEL_Z = RandomInt(10, 400);
			AddVelocity(param2, /* TODO: $relvel */ $relvel(0, VEL_F, VEL_Z));
			if (RandomInt(1, 3) == 1)
			{
				ApplyEffect(param2, "effects/debuff_stun", 5, GetEntityIndex(GetOwner()));
			}
			EmitSound(GetOwner(), 0, SOUND_SWIPEHIT, 10);
			USE_SWIPE_SOUND = 0;
		}
	}

	void npc_targetsighted()
	{
		if ((IS_FLEEING)) return;
		if ((THROWING_FIRE_BALL)) return;
		if ((ZAP_DELAY)) return;
		ZAP_DELAY = 1;
		FREQ_ZAP("reset_zap_delay");
		if ((THROWING_FIRE_BALL)) return;
		check_fire_ball();
	}

	void reset_zap_delay()
	{
		ZAP_DELAY = 0;
	}

	void check_fire_ball()
	{
		if ((THROWING_FIRE_BALL)) return;
		if (!(false)) return;
		if (!(GetEntityRange(m_hLastSeen) > ATTACK_RANGE)) return;
		if ((IsEntityAlive(G_SHOCKER))) return;
		if (!(GetGameTime() > G_NEXT_SHOCK)) return;
		SetGlobalVar("G_SHOCKER", GetEntityIndex(GetOwner()));
		SetGlobalVar("G_NEXT_SHOCK", GetGameTime());
		G_NEXT_SHOCK += 5.0;
		SetMoveDest(m_hLastSeen);
		EmitSound(GetOwner(), 0, SOUND_FIRECHARGE, 10);
		PlayAnim("critical", "tocharge");
		LIGHTNING_COUNT = 0;
		THROWING_FIRE_BALL = 1;
		npcatk_suspend_ai();
		SHOCK_AMT = RandomInt(15, 30);
		Effect("beam", "update", BEAM_ID, "brightness", 200);
		Effect("beam", "update", BEAM_ID, "end_target", m_hAttackTarget, 0);
		OLD_BEAM_TARG = m_hAttackTarget;
		ScheduleDelayedEvent(0.1, "do_lightning");
	}

	void do_lightning()
	{
		LIGHTNING_COUNT += 1;
		if (LIGHTNING_COUNT < SHOCK_AMT)
		{
			SetIdleAnim("charging");
			SetMoveAnim("charging");
			ME_SHOOTING = 1;
			ScheduleDelayedEvent(0.1, "do_lightning");
		}
		if (LIGHTNING_COUNT == SHOCK_AMT)
		{
			npcatk_resume_ai();
			SetIdleAnim(ANIM_IDLE);
			SetMoveAnim(ANIM_WALK);
			ME_SHOOTING = 0;
			PlayAnim("critical", "fromcharge");
			THROWING_FIRE_BALL = 0;
			SetGlobalVar("G_SHOCKER", "unset");
			Effect("beam", "update", BEAM_ID, "brightness", 0);
		}
		if (!(false)) return;
		if (m_hAttackTarget != OLD_BEAM_TARG)
		{
			Effect("beam", "update", BEAM_ID, "end_target", m_hAttackTarget, 0);
			OLD_BEAM_TARG = m_hAttackTarget;
		}
		string BEAM_START = GetMonsterProperty("origin");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("angles"));
		BEAM_START += FINGER_ADJ;
		DoDamage(m_hAttackTarget, BEAM_RANGE, DMG_CHAIN, 1.0, "lightning");
		if (GetGameTime() > NEXT_BEAM)
		{
			BEAM_ON = 1;
			BEAM_DURATION = SHOCK_AMT;
			BEAM_DURATION *= 0.1;
			NEXT_BEAM = GetGameTime();
			NEXT_BEAM += 0.5;
		}
		// PlayRandomSound from: SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3
		array<string> sounds = {SOUND_SHOCK1, SOUND_SHOCK2, SOUND_SHOCK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void slow_down()
	{
		NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
	}

	void ammo_up()
	{
		FIRE_BALL_AMMO = FULL_FIRE_BALL_AMMO;
	}

	void moveto_last_known()
	{
		if ((false)) return;
		if ((DID_SHRUG)) return;
		DID_SHRUG = 1;
		PlayAnim("critical", ANIM_SEARCH);
		EmitSound(GetOwner(), 0, SOUND_IDLE3, 10);
	}

	void my_target_died()
	{
		if (I_JUST_SPAWNED == 1)
		{
			int EXIT_SUB = 1;
			I_JUST_SPAWNED = 0;
		}
		if ((EXIT_SUB)) return;
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
			FIRE_BALL_AMMO = FULL_FIRE_BALL_AMMO;
		}
	}

	void reset_gloat()
	{
		GLOAT_DELAY = 0;
	}

	void cycle_up()
	{
		if (!(IsValidPlayer(m_hLastSeen))) return;
		SetMoveDest(m_hLastSeen);
		if ((DID_WARCRY)) return;
		DID_WARCRY = 1;
		PlayAnim("critical", ANIM_ALERT);
		EmitSound(GetOwner(), 0, SOUND_ALERT, 10);
	}

	void attack1_strike()
	{
		if (FIRE_BALL_AMMO >= 0)
		{
			FIRE_BALL_AMMO -= 0.5;
		}
		USE_SWIPE_SOUND = 1;
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, FIRE_DAMAGE, ATTACK_ACCURACY, "slash");
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

	void OnFlee()
	{
		flee_straight();
	}

	void flee_straight()
	{
		if (!(IS_FLEEING)) return;
		ScheduleDelayedEvent(0.1, "flee_straight");
		string MY_YAW = /* TODO: $get with insufficient args */ null;
		SetAngles("face");
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 0, 50));
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		CallExternal(GAME_MASTER, "gm_fade", GetEntityIndex(GetOwner()));
		Effect("beam", "update", BEAM_ID, "remove", 0);
	}

	void init_beam()
	{
		Effect("beam", "ents", "lgtning.spr", 30, GetOwner(), 0, GetOwner(), 1, Vector3(200, 200, 255), 0, 30, -1);
		BEAM_ID = m_hLastCreated;
	}

}

}
