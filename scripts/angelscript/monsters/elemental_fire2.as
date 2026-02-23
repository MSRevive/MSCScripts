#pragma context server

#include "monsters/base_monster_new.as"
#include "monsters/base_propelled.as"

namespace MS
{

class ElementalFire2 : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_FLINCH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int AS_SUMMON_TELE_CHECK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int BREATH_COUNT;
	int CAN_FLINCH;
	int CUR_SPELL;
	int CYCLES_ON;
	string FLINCH_ANIM;
	int FLINCH_CHANCE;
	float FREQ_SPECIAL;
	string HOVER_LOOP_DELAY;
	int IMMUNE_VAMPIRE;
	int IS_UNHOLY;
	int MOVE_RANGE;
	string MY_HURT_STAGE;
	string NEXT_GLOAT;
	int NO_SPAWN_STUCK_CHECK;
	int NPC_GIVE_EXP;
	int NPC_HACKED_MOVE_SPEED;
	string NPC_MOVE_DEST;
	int STRIKE_ATTACK;

	ElementalFire2()
	{
		AS_SUMMON_TELE_CHECK = 1;
		ANIM_IDLE = "idle1";
		ANIM_WALK = "idle1";
		ANIM_RUN = "idle1";
		ANIM_ATTACK = "attack1";
		ANIM_FLINCH = "flinch";
		ANIM_DEATH = "die1";
		CAN_FLINCH = 1;
		FLINCH_CHANCE = 10;
		FLINCH_ANIM = "flinch";
		ANIM_ATTACK = "attack1";
		const string ANIM_PROJECTILE = "fireball";
		IS_UNHOLY = 1;
		ATTACK_RANGE = 100;
		ATTACK_HITRANGE = 150;
		MOVE_RANGE = 65;
		NPC_HACKED_MOVE_SPEED = 100;
		const int MOVESPEED_SLOW = 100;
		const int MOVESPEED_FAST = 200;
		const string DMG_STRIKE = RandomInt(175, 250);
		const string DOT_STRIKE = RandomInt(60, 80);
		const float ACCURACY_STRIKE = 0.8;
		const string DMG_AMB_BURN = RandomInt(30, 60);
		FREQ_SPECIAL = 5.0;
		const int DMG_FIRE_BALL = 100;
		const int DMG_FIRE_BOLT = 20;
		IMMUNE_VAMPIRE = 1;
		const string SOUND_FIRECHARGE = "magic/fireball_powerup.wav";
		const string SOUND_FIRESHOOT = "magic/fireball_strike.wav";
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
		const string SOUND_HOVER = "fans/fan4on.wav";
		const float HURT_THRESHOLD = 0.5;
		const float PLAYTIME_HOVER = 3.0;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(15.1);
		if ((IsEntityAlive(GetOwner())))
		{
		}
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 0, 0), 196, 15.0);
	}

	void game_precache()
	{
		Precache("monsters/summon/fire_ball_guided");
		Precache("monsters/summon/fire_wave");
	}

	void OnSpawn() override
	{
		SetName("Greater Fire Elemental");
		SetHealth(2500);
		SetWidth(48);
		SetHeight(80);
		SetRace("demon");
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("fire", 0.0);
		SetRoam(false);
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetHearingSensitivity(5);
		SetModel("monsters/elementals_greater.mdl");
		SetModelBody(0, 0);
		NPC_GIVE_EXP = 500;
		ScheduleDelayedEvent(1.0, "idle_sounds");
		SetBloodType("none");
		MY_HURT_STAGE = GetEntityMaxHealth(GetOwner());
		MY_HURT_STAGE *= HURT_THRESHOLD;
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), Vector3(255, 0, 0), 196, 15.0);
		CUR_SPELL = 0;
	}

	void my_target_died()
	{
		NPC_MOVE_DEST = "unset";
		if (!(GetGameTime() > NEXT_GLOAT)) return;
		NEXT_GLOAT = GetGameTime();
		NEXT_GLOAT += FREQ_GLOAT;
		PlayAnim("critical", "idle2");
	}

	void game_movingto_dest()
	{
		if (!(GetGameTime() > HOVER_LOOP_DELAY)) return;
		EmitSound(GetOwner(), CHAN_BODY, SOUND_HOVER, 8);
		HOVER_LOOP_DELAY = GetGameTime();
		HOVER_LOOP_DELAY += 3.0;
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
			int LR_FLING = 200;
			if (RandomInt(1, 2) == 1)
			{
				string LR_FLING = /* TODO: $neg */ $neg(LR_FLING);
			}
			AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(LR_FLING, 0, 0));
		}
	}

	void attack1_strike()
	{
		STRIKE_ATTACK = 1;
		npcatk_dodamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_STRIKE, ACCURACY_STRIKE);
	}

	void game_dodamage()
	{
		if ((param1))
		{
			if ((STRIKE_ATTACK))
			{
			}
			STRIKE_ATTACK = 0;
			ApplyEffect(param2, "effects/dot_fire", 3, GetEntityIndex(GetOwner()), DOT_STRIKE);
		}
	}

	void OnDamage(int damage) override
	{
		if (!(GetEntityRange(param1) < ATTACK_RANGE)) return;
		ApplyEffect(param1, "effects/dot_fire", 2, GetEntityIndex(GetOwner()), DOT_AMB_BURN);
	}

	void cycle_up()
	{
		if ((CYCLES_ON)) return;
		CYCLES_ON = 1;
		FREQ_SPECIAL("pick_spell");
	}

	void do_fire_ball()
	{
		if (!(false)) return;
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", ANIM_PROJECTILE);
		ScheduleDelayedEvent(0.5, "do_fire_ball1");
		ScheduleDelayedEvent(0.7, "do_fire_ball2");
	}

	void do_fire_ball1()
	{
		SpawnNPC("monsters/summon/fire_ball_guided", /* TODO: $relpos */ $relpos(-32, 0, 64), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_FIRE_BALL, 10.0, 200
	}

	void do_fire_ball2()
	{
		SpawnNPC("monsters/summon/fire_ball_guided", /* TODO: $relpos */ $relpos(32, 0, 64), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), DMG_FIRE_BALL, 10.0, 200
	}

	void do_fire_wave()
	{
		if (!(CYCLED_UP)) return;
		SetMoveDest(m_hAttackTarget);
		npcatk_suspend_ai(1.0);
		PlayAnim("critical", "block");
		ScheduleDelayedEvent(0.5, "do_fire_wave2");
	}

	void do_fire_wave2()
	{
		SpawnNPC("monsters/summon/fire_wave", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 100, 100, 5
	}

	void idle_sounds()
	{
		string NEXT_SOUND = Random(5, 15);
		NEXT_SOUND("idle_sounds");
		if (!(m_hAttackTarget == "unset")) return;
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void do_fire_breath()
	{
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		npcatk_suspend_ai();
		SetMoveAnim("charging");
		SetIdleAnim("charging");
		PlayAnim("critical", "charging");
		BREATH_COUNT = 0;
		do_fire_breath_loop();
	}

	void do_fire_breath_loop()
	{
		BREATH_COUNT += 1;
		if (BREATH_COUNT < 30)
		{
			ScheduleDelayedEvent(0.1, "do_fire_breath_loop");
			SetMoveDest(m_hAttackTarget);
			TossProjectile("proj_fire_bolt", /* TODO: $relpos */ $relpos(0, 0, 24), "none", 300, DMG_FIRE_BOLT, 30, "none");
		}
		else
		{
			npcatk_resume_ai();
			SetMoveAnim(ANIM_WALK);
			SetIdleAnim(ANIM_IDLE);
		}
	}

	void pick_spell()
	{
		CUR_SPELL += 1;
		if (CUR_SPELL > 4)
		{
			CUR_SPELL = 1;
		}
		if (CUR_SPELL == 1)
		{
			do_fire_ball();
			FREQ_SPECIAL = 10.0;
		}
		if (CUR_SPELL == 2)
		{
			do_fire_wave();
			FREQ_SPECIAL = 10.0;
		}
		if (CUR_SPELL == 3)
		{
			if (GetEntityRange(m_hAttackTarget) < 768)
			{
				do_fire_breath();
				FREQ_SPECIAL = 5.0;
			}
			else
			{
				do_fire_ball();
				FREQ_SPECIAL = 10.0;
			}
		}
		FREQ_SPECIAL("pick_spell");
	}

	void game_dynamically_created()
	{
		NO_SPAWN_STUCK_CHECK = 1;
	}

}

}
