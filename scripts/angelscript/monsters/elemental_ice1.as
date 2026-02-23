#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class ElementalIce1 : CGameScript
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
	int ATTACK_RANGE_STANDARD;
	int CIRCLE_DELAY;
	int DID_SHRUG;
	string DID_WARCRY;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	string FIRE_BALL_AMMO;
	string GLOAT_DELAY;
	int HOVER_LOOP_DELAY;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	int MOVE_RANGE;
	string MY_HURT_STAGE;
	int NO_STUCK_CHECKS;
	float NPC_DELAYING_UNSTUCK;
	int NPC_GIVE_EXP;
	string NPC_HACKED_MOVE_SPEED;
	string PURE_FLEE;
	int RUNNING_CIRCLE;
	int SWITCHED_TO_CHARGEIDLE;
	int USE_SWIPE_SOUND;

	ElementalIce1()
	{
		AS_SUMMON_TELE_CHECK = 1;
		IS_UNHOLY = 1;
		IMMUNE_VAMPIRE = 1;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 150;
		MOVE_RANGE = 65;
		const float ATTACK_HITCHANCE = 0.8;
		ATTACK_RANGE_STANDARD = 100;
		const int SWIPE_MOVERANGE = 65;
		const int SWIPE_RANGE = 100;
		const int SWIPE_HITRANGE = 150;
		const float ATTACK_ACCURACY = 0.8;
		const int CIRCLE_RANGE = 256;
		const int AIM_RATIO = 50;
		const string AMB_FROST_DAMAGE = "$rand(10,30)";
		const string FROST_DAMAGE = "$rand(30,40)";
		const string STRIKE_DAMAGE = "$rand(50,150)";
		const int ICESEAL_DAMAGE = 200;
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
		const string ANIM_SWIPE = "attack1";
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
		const string SOUND_SWIPEHIT = "magic/frost_reverse.wav";
		const string SOUND_DEATH = "garg/gar_die1.wav";
		const string SOUND_PAIN0 = "debris/glass1.wav";
		const string SOUND_PAIN1 = "agrunt/ag_pain1.wav";
		const string SOUND_PAIN2 = "agrunt/ag_pain4.wav";
		const string SOUND_GLOAT = "x/x_laugh1.wav";
		const string SOUND_CIRCLE_READY = "debris/beamstart1.wav";
		const string SOUND_HOVER = "fans/fan3on.wav";
		const float PLAYTIME_HOVER = 3.0;
		const float CIRCLE_INTERVAL = 30.0;
		const string CIRCLE_SCRIPT = "monsters/summon/circle_of_ice_lesser";
		Precache("weapons/magic/seals.mdl");
		Precache("magic/spawn.wav");
		Precache("magic/frost_forward.wav");
		Precache("magic/frost_reverse.wav");
		Precache("teleporter_blue_sprites.mdl");
		Precache(FX_SPRITE);
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 40;
		const int I_AM_TURNABLE = 0;
		const int MOVE_FAST = 200;
		const int MOVE_NORMAL = 100;
		NPC_HACKED_MOVE_SPEED = MOVE_NORMAL;
		const string MONSTER_MODEL = "monsters/elementals_lesser.mdl";
		Precache(MONSTER_MODEL);
	}

	void OnSpawn() override
	{
		SetName("Ice Elemental");
		SetHealth(600);
		SetWidth(32);
		SetHeight(48);
		SetRace("demon");
		SetDamageResistance("all", 0.4);
		SetDamageResistance("holy", 1.25);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("poison", 0.0);
		SetRoam(true);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(3);
		Precache(MONSTER_MODEL);
		SetModel(MONSTER_MODEL);
		SetModelBody(0, 2);
		SetBloodType("none");
		NPC_GIVE_EXP = 130;
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
		if (param1 > 20)
		{
			AddVelocity(GetOwner(), /* TODO: $relpos */ $relpos(1, -10, 1));
		}
		if (!(GetEntityRange(m_hLastStruck) < MOVE_RANGE)) return;
		ApplyEffect(m_hLastStruck, "effects/dot_cold", 1, GetEntityIndex(GetOwner()), AMB_FROST_DAMAGE);
	}

	void idle_sounds()
	{
		string NEXT_SOUND = Random(5, 15);
		NEXT_SOUND("idle_sounds");
		if ((IS_HUNTING)) return;
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
		if ((param1))
		{
			if ((USE_SWIPE_SOUND))
			{
				ApplyEffect(m_hLastStruckByMe, "effects/dot_cold", 4, GetEntityIndex(GetOwner()), FROST_DAMAGE, "none");
				EmitSound(GetOwner(), 0, SOUND_SWIPEHIT, 10);
			}
		}
		USE_SWIPE_SOUND = 0;
	}

	void npc_selectattack()
	{
		if ((CIRCLE_DELAY))
		{
			ATTACK_RANGE = ATTACK_RANGE_STANDARD;
		}
		if ((RUNNING_CIRCLE)) return;
		if ((CIRCLE_DELAY)) return;
		if (!(false)) return;
		ATTACK_RANGE = MOVE_RANGE;
		ATTACK_RANGE *= 1.25;
		if (!(GetEntityRange(m_hAttackTarget) < ATTACK_RANGE)) return;
		Effect("glow", GetOwner(), Vector3(0, 75, 255), 50, 5, 5);
		EmitSound(GetOwner(), 0, SOUND_CIRCLE_READY, 10);
		circle_of_ice_init();
	}

	void circle_of_ice_init()
	{
		NO_STUCK_CHECKS = 1;
		npcatk_suspend_ai(5.0);
		RUNNING_CIRCLE = 1;
		SetAnimMoveSpeed(0);
		SetMoveSpeed(0);
		PlayAnim("critical", ANIM_TOCHARGE);
		SetIdleAnim(ANIM_CHARGEIDLE);
		SetMoveAnim(ANIM_CHARGEIDLE);
	}

	void tocharge_done()
	{
		if ((SWITCHED_TO_CHARGEIDLE)) return;
		SWITCHED_TO_CHARGEIDLE = 1;
		PlayAnim("critical", ANIM_CHARGEIDLE);
		ScheduleDelayedEvent(0.2, "circle_go");
	}

	void circle_go()
	{
		SpawnNPC(CIRCLE_SCRIPT, /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 10.0, 1.3, ICESEAL_DAMAGE
		ScheduleDelayedEvent(5.1, "circle_done");
	}

	void circle_done()
	{
		RUNNING_CIRCLE = 0;
		PlayAnim("critical", "fromcharge");
		SWITCHED_TO_CHARGEIDLE = 0;
		SetIdleAnim(ANIM_IDLE);
		SetActionAnim(ANIM_ATTACK);
		SetMoveAnim(ANIM_WALK);
		NPC_HACKED_MOVE_SPEED = MOVE_FAST;
		NO_STUCK_CHECKS = 0;
		SetAnimMoveSpeed(NPC_HACKED_MOVE_SPEED);
		SetMoveSpeed(1.0);
		if ((false))
		{
			PURE_FLEE = 1;
			npcatk_flee(m_hLastSeen, FLEE_DISTANCE, 5.0);
		}
		CIRCLE_DELAY = 1;
		ScheduleDelayedEvent(5.0, "slow_down");
		ScheduleDelayedEvent(4.0, "ammo_up");
		CIRCLE_INTERVAL("reset_circle_delay");
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
		if (!(IsValidPlayer(param1))) return;
		npcatk_setmovedest(m_hLastSeen, ATTACK_RANGE);
		if ((DID_WARCRY)) return;
		npcatk_faceattacker();
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

}

}
