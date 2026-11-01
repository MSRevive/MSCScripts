#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Bgoblin : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_BOW;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_KICK;
	string ANIM_PARRY;
	string ANIM_RUN;
	string ANIM_SMASH;
	string ANIM_SWIPE;
	string ANIM_WALK;
	string ANIM_WARCRY;
	string AS_ATTACKING;
	string ATTACK_HITCHANCE;
	int ATTACK_HITRANGE;
	int ATTACK_MOVERANGE;
	int ATTACK_RANGE;
	string CAN_FIREBALL;
	int CAN_FLINCH;
	string CAN_STUN;
	int CHARGE_SPEED;
	string DBL_JUMP;
	int DMG_AXE;
	int DMG_CLUB;
	int DMG_FIREBALL;
	int DMG_FIREBALL_DOT;
	int DMG_SWORD;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	string FLINCH_ANIM;
	float FLINCH_CHANCE;
	int FLINCH_HEALTH;
	float FREQ_CHARGE;
	float FREQ_FIREBALL;
	string F_GOB_TYPE;
	int GOBLIN_JUMPRANGE;
	int GOB_CHARGER;
	int GOB_CHARGE_MAX_DIST;
	int GOB_CHARGE_MIN_DIST;
	int GOB_JUMPER;
	int GOB_JUMP_SCANNING;
	int GOB_TYPE;
	int GOB_TYPE_SET;
	int MIN_FIREBALL_DIST;
	int MOVE_RANGE;
	int NEW_MODEL;
	string NEXT_FIREBALL;
	string NEXT_LEAP;
	int NPC_ALLY_RESPONSE_RANGE;
	int NPC_GIVE_EXP;
	string SOUND_ALERT1;
	string SOUND_ALERT2;
	string SOUND_ATTACK1;
	string SOUND_ATTACK2;
	string SOUND_ATTACK3;
	string SOUND_CHIEF_ALERT;
	string SOUND_DEATH;
	string SOUND_FIREBALL;
	string SOUND_FIREBALL_CAST;
	string SOUND_IDLE;
	string SOUND_JUMP1;
	string SOUND_JUMP2;
	string SOUND_PAIN1;
	string SOUND_PAIN2;
	string SOUND_PARRY1;
	string SOUND_PARRY2;
	string SOUND_PARRY3;
	string SOUND_SHAM_ALERT;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string STUN_LIST;
	int TOSS_FIREBALL;

	Bgoblin()
	{
		ANIM_WALK = "walk";
		ANIM_IDLE = "idle1";
		ANIM_RUN = "run";
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 80;
		ATTACK_MOVERANGE = 48;
		MOVE_RANGE = 48;
		NPC_GIVE_EXP = 200;
		DROP_GOLD = 1;
		DROP_GOLD_AMT = RandomInt(10, 15);
		NPC_ALLY_RESPONSE_RANGE = 4096;
		ANIM_DEATH = "die_fallback";
		CAN_FLINCH = 1;
		FLINCH_ANIM = "flinch";
		FLINCH_CHANCE = 0.25;
		FLINCH_HEALTH = 100;
		ANIM_SMASH = "battleaxe_swing1_L";
		ANIM_SWIPE = "swordswing1_L";
		ANIM_WARCRY = "warcry";
		ANIM_KICK = "kick";
		ANIM_BOW = "shootorcbow";
		DMG_CLUB = RandomInt(40, 75);
		DMG_AXE = RandomInt(50, 60);
		DMG_SWORD = RandomInt(25, 50);
		GOB_TYPE = RandomInt(1, 3);
		GOBLIN_JUMPRANGE = 512;
		DMG_FIREBALL = 50;
		DMG_FIREBALL_DOT = 10;
		FREQ_FIREBALL = Random(20.0, 30.0);
		GOB_JUMPER = 1;
		ANIM_PARRY = "deflectcounter";
		CHARGE_SPEED = 600;
		FREQ_CHARGE = 5.0;
		GOB_CHARGER = 1;
		GOB_CHARGE_MIN_DIST = 96;
		GOB_CHARGE_MAX_DIST = 256;
		MIN_FIREBALL_DIST = 96;
		NEW_MODEL = 1;
		SOUND_STRUCK1 = "body/flesh1.wav";
		SOUND_STRUCK2 = "body/flesh2.wav";
		SOUND_STRUCK3 = "body/flesh3.wav";
		SOUND_PAIN1 = "monsters/goblin/c_gargoyle_hit1.wav";
		SOUND_PAIN2 = "monsters/goblin/c_gargoyle_hit2.wav";
		SOUND_ALERT1 = "monsters/goblin/c_goblin_bat1.wav";
		SOUND_ALERT2 = "monsters/goblin/c_goblin_bat2.wav";
		SOUND_IDLE = "monsters/goblin/c_goblin_slct.wav";
		SOUND_ATTACK1 = "monsters/goblin/c_goblin_atk1.wav";
		SOUND_ATTACK2 = "monsters/goblin/c_goblin_atk2.wav";
		SOUND_ATTACK3 = "monsters/goblin/c_goblin_atk3.wav";
		SOUND_FIREBALL_CAST = "monsters/goblin/c_gargoyle_slct.wav";
		SOUND_FIREBALL = "magic/fireball_strike.wav";
		SOUND_IDLE = "monsters/goblin/c_goblin_slct.wav";
		SOUND_JUMP1 = "monsters/goblin/c_goblin_hit1.wav";
		SOUND_JUMP2 = "monsters/goblin/c_goblin_hit2.wav";
		SOUND_PARRY1 = "body/armour1.wav";
		SOUND_PARRY2 = "body/armour2.wav";
		SOUND_PARRY3 = "body/armour3.wav";
		SOUND_CHIEF_ALERT = "monsters/goblin/c_goblinchf_bat1.wav";
		SOUND_SHAM_ALERT = "monsters/goblin/c_goblinwiz_bat1.wav";
		SOUND_DEATH = "monsters/goblin/c_goblin_dead.wav";
		Precache(SOUND_DEATH);
	}

	void OnSpawn() override
	{
		goblin_spawn();
		ScheduleDelayedEvent(1.0, "idle_mode");
		ScheduleDelayedEvent(0.01, "goblin_pre_spawn");
	}

	void goblin_pre_spawn()
	{
		ATTACK_RANGE = 64;
		ATTACK_HITRANGE = 80;
		ATTACK_MOVERANGE = 48;
		MOVE_RANGE = 48;
	}

	void goblin_spawn()
	{
		SetName("Blood Goblin");
		if (!(NEW_MODEL))
		{
			SetModel("monsters/goblin2.mdl");
			SetWidth(32);
			SetHeight(60);
		}
		else
		{
			SetModel("monsters/goblin_new.mdl");
			SetWidth(24);
			SetHeight(50);
		}
		SetRace("goblin");
		SetBloodType("red");
		SetHealth(500);
		SetRoam(true);
		SetHearingSensitivity(2);
		if (!(NEW_MODEL))
		{
			SetModelBody(0, 0);
			SetModelBody(1, 4);
			SetModelBody(2, 0);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 2);
		}
		else
		{
			SetModelBody(0, 0);
			SetModelBody(1, 0);
			SetModelBody(2, 0);
			SetModelBody(3, 0);
			SetProp(GetOwner(), "skin", 1);
		}
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
		SetDamageResistance("fire", 0.5);
		SetDamageResistance("cold", 1.25);
		if (!(F_GOB_TYPE == "F_GOB_TYPE")) return;
		ScheduleDelayedEvent(0.01, "goblin_set_weapon");
	}

	void goblin_set_weapon()
	{
		if ((GOB_TYPE_SET)) return;
		GOB_TYPE_SET = 1;
		if ((param1).findFirst(PARAM) == 0)
		{
			F_GOB_TYPE = GOB_TYPE;
		}
		else
		{
			F_GOB_TYPE = param1;
		}
		if (F_GOB_TYPE == 1)
		{
			SetModelBody(0, 0);
			SetModelBody(2, 7);
			ANIM_ATTACK = ANIM_SMASH;
			ATTACK_HITCHANCE = 0.75;
			string MY_HP = GetEntityHealth(GetOwner());
			MY_HP *= 1.5;
			SetHealth(MY_HP);
			CAN_STUN = 0;
		}
		if (F_GOB_TYPE == 2)
		{
			SetModelBody(0, 0);
			SetModelBody(2, 1);
			ANIM_ATTACK = ANIM_SMASH;
			ATTACK_HITCHANCE = 0.8;
			string MY_HP = GetEntityHealth(GetOwner());
			MY_HP *= 1.25;
			SetHealth(MY_HP);
			CAN_STUN = 0;
		}
		if (F_GOB_TYPE == 3)
		{
			CAN_FIREBALL = 1;
			SetModelBody(0, 1);
			SetModelBody(2, 4);
			ANIM_ATTACK = ANIM_SWIPE;
			ATTACK_HITCHANCE = 0.9;
			CAN_STUN = 0;
		}
	}

	void swing_axe()
	{
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		if (F_GOB_TYPE == 1)
		{
			XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_CLUB, ATTACK_HITCHANCE, GetOwner(), GetOwner(), "none", "blunt", "dmgevent:swing");
		}
		if (F_GOB_TYPE == 2)
		{
			XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_AXE, ATTACK_HITCHANCE, GetOwner(), GetOwner(), "slash", "dmgevent:swing");
		}
	}

	void swing_sword()
	{
		if ((TOSS_FIREBALL))
		{
			toss_fireball();
		}
		if ((TOSS_FIREBALL)) return;
		// PlayRandomSound from: SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3
		array<string> sounds = {SOUND_ATTACK1, SOUND_ATTACK2, SOUND_ATTACK3};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		XDoDamage(m_hAttackTarget, ATTACK_HITRANGE, DMG_SWORD, ATTACK_HITCHANCE, GetOwner(), GetOwner(), "slash", "dmgevent:swing");
	}

	void toss_fireball()
	{
		TOSS_FIREBALL = 0;
		TossProjectile("proj_fire_ball", /* TODO: $relpos */ $relpos(0, 48, 0), m_hAttackTarget, 400, DMG_FIREBALL, 0.5, "none");
		CallExternal("ent_lastprojectile", "lighten", DMG_FIREBALL_DOT, 0.01);
		EmitSound(GetOwner(), 0, SOUND_FIREBALL, 10);
	}

	void OnHuntTarget(CBaseEntity@ target)
	{
		gob_hunt();
	}

	void gob_hunt()
	{
		if (!(IsEntityAlive(m_hAttackTarget))) return;
		if ((SUSPEND_AI)) return;
		if ((I_R_FROZEN)) return;
		if ((CAN_FIREBALL))
		{
			if (!(IS_FLEEING))
			{
			}
			if (GetGameTime() > NEXT_FIREBALL)
			{
			}
			prep_fireball();
		}
		if (!(GOB_CHARGER)) return;
		if (!(GetGameTime() > NEXT_LEAP)) return;
		if (!(GetEntityRange(m_hAttackTarget) > GOB_CHARGE_MIN_DIST)) return;
		if (!(GetEntityRange(m_hAttackTarget) < GOB_CHARGE_MAX_DIST)) return;
		if ((I_R_FROZEN)) return;
		leap_forward();
	}

	void prep_fireball()
	{
		if (!(GetEntityRange(m_hAttackTarget) > MIN_FIREBALL_DIST)) return;
		if (!(false)) return;
		NEXT_FIREBALL = GetGameTime();
		NEXT_FIREBALL += FREQ_FIREBALL;
		TOSS_FIREBALL = 1;
		PlayAnim("critical", ANIM_SWIPE);
		EmitSound(GetOwner(), 0, SOUND_FIREBALL_CAST, 10);
		AS_ATTACKING = GetGameTime();
		AS_ATTACKING += 10.0;
	}

	void leap_forward()
	{
		NEXT_LEAP = GetGameTime();
		NEXT_LEAP += FREQ_CHARGE;
		// PlayRandomSound from: SOUND_JUMP1, SOUND_JUMP2
		array<string> sounds = {SOUND_JUMP1, SOUND_JUMP2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		PlayAnim("critical", ANIM_SMASH);
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, CHARGE_SPEED, 100));
		ScheduleDelayedEvent(0.5, "leap_stun");
	}

	void leap_stun()
	{
		STUN_LIST = FindEntitiesInSphere("enemy", 64);
		if (!(STUN_LIST != "none")) return;
		for (int i = 0; i < GetTokenCount(STUN_LIST, ";"); i++)
		{
			stun_targets();
		}
	}

	void stun_targets()
	{
		string CUR_TARGET = GetToken(STUN_LIST, i, ";");
		AddVelocity(CUR_TARGET, /* TODO: $relvel */ $relvel(0, 200, 120));
		if ((CAN_STUN))
		{
			ApplyEffect(CUR_TARGET, "effects/debuff_stun", 3.0, GetEntityIndex(GetOwner()));
		}
	}

	void cycle_up()
	{
		gob_cycle_up();
	}

	void gob_cycle_up()
	{
		NEXT_FIREBALL = GetGameTime();
		NEXT_FIREBALL += Random(10, 30);
		if ((GOB_JUMP_SCANNING)) return;
		GOB_JUMP_SCANNING = 1;
		// PlayRandomSound from: SOUND_ALERT1, SOUND_ALERT2
		array<string> sounds = {SOUND_ALERT1, SOUND_ALERT2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		gob_jump_check();
	}

	void cycle_down()
	{
		GOB_JUMP_SCANNING = 0;
		SetMoveAnim(ANIM_WALK);
		ScheduleDelayedEvent(1.0, "idle_mode");
	}

	void gob_jump_check()
	{
		if (!(GOB_JUMPER)) return;
		if (!(GOB_JUMP_SCANNING)) return;
		float GOB_HOP_DELAY = Random(2, 4);
		GOB_HOP_DELAY("gob_jump_check");
		if (!(m_hAttackTarget != "unset")) return;
		if ((I_R_FROZEN)) return;
		if ((IS_FLEEING)) return;
		if ((SUSPEND_AI)) return;
		if (!(GetEntityRange(m_hAttackTarget) < GOBLIN_JUMPRANGE)) return;
		string ME_POS = GetMonsterProperty("origin");
		string MY_Z = (ME_POS).z;
		string TARGET_POS = GetEntityOrigin(m_hAttackTarget);
		string TARGET_Z = (TARGET_POS).z;
		string TARGET_Z_DIFFERENCE = TARGET_Z;
		TARGET_Z_DIFFERENCE -= MY_Z;
		if (TARGET_Z_DIFFERENCE > GOB_JUMP_THRESH)
		{
			if (TARGET_Z_DIFFERENCE < 500)
			{
			}
			PlayAnim("critical", ANIM_SMASH);
			ScheduleDelayedEvent(0.1, "gob_hop");
		}
	}

	void gob_hop()
	{
		// PlayRandomSound from: SOUND_JUMP1, SOUND_JUMP2
		array<string> sounds = {SOUND_JUMP1, SOUND_JUMP2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 10);
		int JUMP_HEIGHT = RandomInt(350, 550);
		if ((DBL_JUMP))
		{
			JUMP_HEIGHT *= 2.0;
			DBL_JUMP = 0;
		}
		AddVelocity(GetOwner(), /* TODO: $relvel */ $relvel(0, 250, JUMP_HEIGHT));
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetModelBody(2, 0);
	}

	void idle_mode()
	{
		if (!(m_hAttackTarget == "unset")) return;
		if (!(false)) return;
		SetMoveDest(m_hLastSeen);
		PlayAnim("once", ANIM_WARCRY);
		EmitSound(GetOwner(), 0, SOUND_IDLE, 10);
		Random(10, 20)("idle_mode");
		CallExternal(m_hLastSeen, "ext_faceme", GetEntityIndex(GetOwner()));
	}

	void ext_faceme()
	{
		if (!(m_hAttackTarget == "unset")) return;
		SetMoveDest(param1);
		ScheduleDelayedEvent(0.1, "reply_anim");
	}

	void reply_anim()
	{
		PlayAnim("once", ANIM_WARCRY);
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		// PlayRandomSound from: SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2
		array<string> sounds = {SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_STRUCK1, SOUND_STRUCK2, SOUND_STRUCK3, SOUND_PAIN1, SOUND_PAIN2};
		EmitSound(GetOwner(), 0, sounds[RandomInt(0, sounds.length() - 1)], 5);
	}

}

}
