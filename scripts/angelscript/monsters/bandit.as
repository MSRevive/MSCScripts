#pragma context server

#include "monsters/base_monster.as"

namespace MS
{

class Bandit : CGameScript
{
	string ALLY_CHECK_ID;
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	string ATTACK1_DAMAGE;
	int ATTACK_COF;
	string ATTACK_HITRANGE;
	float ATTACK_PERCENTAGE;
	int ATTACK_RANGE;
	int ATTACK_SPEED;
	string BANDIT_FLEE_DELAY;
	string BD_COUNT;
	int CAN_ATTACK;
	int CAN_FLINCH;
	int CAN_HEAR;
	int CAN_HUNT;
	int CAN_RETALIATE;
	string CASTING_SPELL;
	float CONTAINER_DROP_CHANCE;
	string CONTAINER_SCRIPT;
	int DROPS_CONTAINER;
	string FIREBALL_DELAY;
	int HUNT_AGRO;
	string ICE_SHIELD_CHECK;
	int IS_BUFFING;
	int MOVE_RANGE;
	int NO_STEP_ADJ;
	int NO_STUCK_CHECKS;
	int NPC_GIVE_EXP;
	string SPELL_TARGET;
	string WEAPON;

	Bandit()
	{
		CONTAINER_DROP_CHANCE = 0.1;
		CONTAINER_SCRIPT = "chests/quiver_of_random_lesser";
		const string SOUND_PAIN = "player/chesthit1.wav";
		const string SOUND_PAIN2 = "player/armhit1.wav";
		const string SOUND_BOW = "weapons/bow/bow.wav";
		ANIM_IDLE = "idle";
		ANIM_RUN = "run";
		ANIM_WALK = "walk2";
		ANIM_DEATH = "die_simple";
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		CAN_ATTACK = 1;
		CAN_RETALIATE = 1;
		const float RETALIATE_CHANGETARGET_CHANCE = 0.75;
		CAN_HEAR = 1;
		NPC_GIVE_EXP = 60;
		bowey();
		fistey();
		daggerey();
		swordey();
		axey();
		macey();
		magey();
		ATTACK_HITRANGE = ATTACK_RANGE;
		ATTACK_HITRANGE *= 1.5;
		NO_STEP_ADJ = 1;
		const float FIREBALL_FREQ = 5.0;
		const int SPELL_RANGE = 700;
		const string ANIM_PREP_SPELL = "prepare_fireball";
		const string ANIM_AIM_SPELL = "aim_fireball_R";
		const string ANIM_CAST_SPELL = "throw_fireball_R";
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(2.0);
		if ((SUSPEND_AI))
		{
			BD_COUNT += 1;
		}
		if (!(SUSPEND_AI))
		{
			BD_COUNT = 0;
		}
		if (BD_COUNT > 10)
		{
			npcatk_resume_ai();
		}
	}

	void OnSpawn() override
	{
		BD_COUNT = 0;
		if (WEAPON == "WEAPON")
		{
			WEAPON = RandomInt(0, 6);
		}
		SetGold(RandomInt(13, 27));
		SetWidth(32);
		SetHeight(92);
		SetRace("rogue");
		SetDamageResistance("all", 0.7);
		SetHearingSensitivity(3);
		SetRoam(true);
		SetModel("npc/rogue.mdl");
		SetIdleAnim(ANIM_IDLE);
		SetMoveAnim(ANIM_WALK);
	}

	void bowey()
	{
		if (!(WEAPON == 0)) return;
		SetName("Bandit Archer");
		SetHealth(130);
		MOVE_RANGE = 300;
		ATTACK_RANGE = 800;
		ATTACK_SPEED = 1200;
		ATTACK1_DAMAGE = Random(8.5, 12.0);
		ATTACK_COF = 0;
		ANIM_ATTACK = "shootbow";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 5);
		DROPS_CONTAINER = 1;
		NO_STUCK_CHECKS = 1;
	}

	void daggerey()
	{
		if (!(WEAPON == 1)) return;
		SetName("Bandit Rogue");
		SetHealth(130);
		MOVE_RANGE = 50;
		ATTACK_RANGE = 90;
		ATTACK1_DAMAGE = Random(8.5, 10.0);
		ATTACK_PERCENTAGE = 0.8;
		ANIM_ATTACK = "swordjab1_R";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 1);
	}

	void fistey()
	{
		if (!(WEAPON == 2)) return;
		SetName("Bandit Martial Artist");
		SetHealth(160);
		MOVE_RANGE = 50;
		ATTACK_RANGE = 80;
		ATTACK1_DAMAGE = Random(6.5, 8.0);
		ATTACK_PERCENTAGE = 0.8;
		ANIM_ATTACK = "aim_punch1";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 0);
	}

	void swordey()
	{
		if (!(WEAPON == 3)) return;
		SetName("Bandit Swordsman");
		SetHealth(160);
		MOVE_RANGE = 80;
		ATTACK_RANGE = 120;
		ATTACK1_DAMAGE = Random(8.5, 10.0);
		ATTACK_PERCENTAGE = 0.85;
		ANIM_ATTACK = "swordswing2_R";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 4);
	}

	void axey()
	{
		if (!(WEAPON == 4)) return;
		SetName("Bandit Axeman");
		SetHealth(200);
		MOVE_RANGE = 80;
		ATTACK_RANGE = 120;
		ATTACK1_DAMAGE = Random(9.5, 11.0);
		ATTACK_PERCENTAGE = 0.85;
		ANIM_ATTACK = "battleaxe_swing1_R";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 3);
	}

	void macey()
	{
		if (!(WEAPON == 5)) return;
		SetName("Bandit Berserker");
		SetHealth(200);
		MOVE_RANGE = 80;
		ATTACK_RANGE = 130;
		ATTACK1_DAMAGE = Random(9.5, 11.0);
		ATTACK_PERCENTAGE = 0.85;
		ANIM_ATTACK = "battleaxe_swing1_R";
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 2);
	}

	void magey()
	{
		if (!(WEAPON == 6)) return;
		SetName("Bandit Mage");
		SetHealth(100);
		MOVE_RANGE = 300;
		ATTACK_RANGE = 32;
		ATTACK1_DAMAGE = Random(20.0, 40.0);
		ATTACK_PERCENTAGE = 0.85;
		ANIM_ATTACK = "aim_punch1";
		CAN_FLINCH = 0;
		SetActionAnim(ANIM_ATTACK);
		SetModelBody(1, 0);
		ScheduleDelayedEvent(1.0, "scan_for_allies");
		CatchSpeech("debug_params", "debug");
	}

	void debug_params()
	{
		SetSayTextRange(1024);
		SayText("Mov MOVE_RANGE");
	}

	void attack()
	{
		if (WEAPON == 0)
		{
			SetAngles("add_view.pitch");
			AS_ATTACKING = GetGameTime();
			TossProjectile("proj_arrow_npc", /* TODO: $relpos */ $relpos(0, 0, 2), "none", ATTACK_SPEED, ATTACK1_DAMAGE, ATTACK_COF, "none");
			CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_lighten", 0.4);
			EmitSound(GetOwner(), SOUND_BOW);
		}
		else
		{
			DoDamage(m_hAttackTarget, ATTACK_HITRANGE, ATTACK1_DAMAGE, ATTACK_PERCENTAGE, "slash");
		}
	}

	void attack_jab()
	{
		attack();
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN2
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		SetVolume(5);
		// PlayRandomSound from: SOUND_PAIN, SOUND_PAIN2
		array<string> sounds = {SOUND_PAIN, SOUND_PAIN2};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
		string L_DEATHANIM = RandomInt(0, 6);
		if (L_DEATHANIM == 0)
		{
			ANIM_DEATH = "die_simple";
		}
		if (L_DEATHANIM == 1)
		{
			ANIM_DEATH = "die_backwards1";
		}
		if (L_DEATHANIM == 2)
		{
			ANIM_DEATH = "die_backwards";
		}
		if (L_DEATHANIM == 3)
		{
			ANIM_DEATH = "die_forwards";
		}
		if (L_DEATHANIM == 4)
		{
			ANIM_DEATH = "headshot";
		}
		if (L_DEATHANIM == 5)
		{
			ANIM_DEATH = "die_spin";
		}
		if (L_DEATHANIM == 6)
		{
			ANIM_DEATH = "gutshot";
		}
	}

	void npc_targetsighted()
	{
		if (WEAPON == 0)
		{
			if (!(IS_FLEEING))
			{
			}
			if ((false))
			{
			}
			PlayAnim("once", ANIM_ATTACK);
		}
		if (WEAPON == 6)
		{
			if (!(IS_FLEEING))
			{
			}
			if (!(FIREBALL_DELAY))
			{
			}
			if (!(CASTING_SPELL))
			{
			}
			if (!(IS_BUFFING))
			{
			}
			FIREBALL_DELAY = 1;
			FIREBALL_FREQ("reset_fireball_delay");
			if ((CanSee("enemy", SPELL_RANGE)))
			{
			}
			string L_SPELL_TARGET = GetEntityIndex(m_hLastSeen);
			spell_attack(L_SPELL_TARGET);
			CASTING_SPELL = 1;
		}
	}

	void reset_fireball_delay()
	{
		FIREBALL_DELAY = 0;
	}

	void spell_attack()
	{
		AS_ATTACKING = GetGameTime();
		EmitSound(GetOwner(), 0, "magic/fireball_powerup.wav", 10);
		SPELL_TARGET = param1;
		SetMoveDest(SPELL_TARGET);
		PlayAnim("once", ANIM_PREP_SPELL);
		ScheduleDelayedEvent(0.5, "spell_attack2");
	}

	void spell_attack2()
	{
		SetMoveDest(SPELL_TARGET);
		PlayAnim("critical", ANIM_AIM_SPELL);
		ScheduleDelayedEvent(0.5, "spell_attack3");
	}

	void spell_attack3()
	{
		SetMoveDest(SPELL_TARGET);
		string TARG_ORG = GetEntityOrigin(SPELL_TARGET);
		SetAngles("face_origin");
		ScheduleDelayedEvent(0.1, "straighten_out");
		EmitSound(GetOwner(), 0, "magic/fireball_strike.wav", 10);
		PlayAnim("critical", ANIM_CAST_SPELL);
		TossProjectile("proj_fire_dart", /* TODO: $relpos */ $relpos(0, 48, 2), SPELL_TARGET, 400, ATTACK1_DAMAGE, 5, "none");
		CallExternal(GetEntityIndex("ent_lastprojectile"), "ext_lighten", 0);
		CASTING_SPELL = 0;
	}

	void straighten_out()
	{
		string MY_ANG = GetMonsterProperty("angles");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(SPELL_TARGET);
		SetAngles("face");
		ScheduleDelayedEvent(1.0, "mage_reposition");
	}

	void mage_reposition()
	{
		if (GetEntityRange(HUNT_LASTTARGET) < SPELL_RANGE)
		{
			npcatk_flee(GetEntityIndex(HUNT_LASTTARGET), 700, 1.0);
		}
		if (GetEntityRange(HUNT_LASTTARGET) >= MOVE_RANGE)
		{
			chicken_run(1.0);
		}
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		if (WEAPON == 6)
		{
			if (!(BANDIT_FLEE_DELAY))
			{
			}
			BANDIT_FLEE_DELAY = 1;
			ScheduleDelayedEvent(10.0, "reset_bandit_flee_delay");
			npcatk_flee(GetEntityIndex(m_hLastStruck), 2000, 5.0);
		}
	}

	void reset_bandit_flee_delay()
	{
		BANDIT_FLEE_DELAY = 0;
	}

	void npcatk_ally_alert()
	{
		if ((SUSPEND_AI)) return;
		if ((IsValidPlayer(param1)))
		{
			cycle_up("ally_hit_by_player");
		}
		if (!(GetEntityIndex(param2) != GetEntityIndex(GetOwner()))) return;
		if (!(WEAPON == 6)) return;
		if ((IS_BUFFING)) return;
		if (!(GetEntityRange(param2) < SPELL_RANGE)) return;
		ALLY_CHECK_ID = GetEntityIndex(param2);
		check_can_shield();
	}

	void check_can_shield()
	{
		if ((IS_BUFFING)) return;
		if (!(CYCLED_UP)) return;
		if (!(GetEntityRace(ALLY_CHECK_ID) == GetEntityRace(GetOwner()))) return;
		ICE_SHIELD_CHECK = GetEntityProperty(ALLY_CHECK_ID, "haseffect");
		ScheduleDelayedEvent(0.1, "check_can_shield2");
	}

	void check_can_shield2()
	{
		AS_ATTACKING = GetGameTime();
		if (!(ICE_SHIELD_CHECK != 1)) return;
		IS_BUFFING = 1;
		PlayAnim("critical", ANIM_PREP_SPELL);
		SetMoveDest(ALLY_CHECK_ID);
		npcatk_suspend_ai(1.0);
		ScheduleDelayedEvent(0.1, "shield_ally");
	}

	void shield_ally()
	{
		if (!(false)) return;
		ScheduleDelayedEvent(0.5, "cast_shield");
	}

	void cast_shield()
	{
		IS_BUFFING = 0;
		EmitSound(GetOwner(), 0, "magic/cast.wav", 10);
		ApplyEffect(ALLY_CHECK_ID, "effects/iceshield", 20, GetEntityIndex(GetOwner()), 0.5);
	}

	void scan_for_allies()
	{
		ScheduleDelayedEvent(0.7, "scan_for_allies");
		if (!(false)) return;
		ALLY_CHECK_ID = GetEntityIndex(m_hLastSeen);
		check_can_shield(m_hLastSeen);
	}

}

}
