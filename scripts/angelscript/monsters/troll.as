#pragma context server

#include "monsters/base_monster_new.as"

namespace MS
{

class Troll : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_IDLE;
	string ANIM_RUN;
	string ANIM_WALK;
	string AS_ATTACKING;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLINCH;
	int CAN_HUNT;
	int DID_WARCRY;
	int DROP_GOLD;
	int DROP_GOLD_MAX;
	int DROP_GOLD_MIN;
	int HUNT_AGRO;
	string IMMUNE_VAMPIRE;
	string IS_GUARDIAN;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;
	int NPC_MUST_SEE_TARGET;
	string PUSH_VEL;
	string SOUND_ATTACK;
	string SOUND_DEATH;
	string SOUND_IDLE;
	string SOUND_PAIN;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;
	string SOUND_WALK1;
	string SOUND_WALK2;

	Troll()
	{
		SOUND_STRUCK1 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK2 = "weapons/cbar_hitbod1.wav";
		SOUND_STRUCK3 = "weapons/cbar_hitbod1.wav";
		SOUND_PAIN = "monsters/troll/trollpain.wav";
		SOUND_ATTACK = "monsters/troll/trollattack.wav";
		SOUND_DEATH = "monsters/troll/trolldeath.wav";
		SOUND_WALK1 = "monsters/troll/step1.wav";
		SOUND_WALK2 = "monsters/troll/step2.wav";
		SOUND_IDLE = "monsters/troll/trollidle2.wav";
		DROP_GOLD = 1;
		DROP_GOLD_MIN = 10;
		DROP_GOLD_MAX = 35;
		ANIM_IDLE = "idle0";
		ANIM_RUN = "run";
		ANIM_WALK = "walk";
		ANIM_DEATH = "die_fall";
		ANIM_ATTACK = "double_punch";
		ATTACK_RANGE = 135;
		ATTACK_HITRANGE = 200;
		CAN_FLINCH = 0;
		MOVE_RANGE = 100;
		CAN_HUNT = 1;
		HUNT_AGRO = 1;
		NPC_GIVE_EXP = 100;
		NPC_MUST_SEE_TARGET = 0;
		Precache(SOUND_DEATH);
		Precache("monsters/base_monster");
		Precache("monsters/base_npc_attack");
		Precache("monsters/base_npc");
		Precache("weapons/axemetal1.wav");
		Precache("weapons/axemetal2.wav");
		Precache("debris/concrete1.wav");
		Precache("weapons/cbar_hitbod1.wav");
	}

	void OnSpawn() override
	{
		SetHealth(300);
		SetWidth(100);
		SetHeight(125);
		SetName("Troll");
		if (GetMapName() == "ww3d")
		{
			IS_GUARDIAN = 1;
		}
		if ((G_SHAD_PRESENT))
		{
			bo_zombie_mode();
		}
		if ((IS_GUARDIAN))
		{
			SetName("Temple Guardian");
			SetRace("demon");
			SetProp(GetOwner(), "skin", 1);
			IMMUNE_VAMPIRE = 1;
			SetBloodType("none");
			ScheduleDelayedEvent(0.1, "guard_attribs");
		}
		if (!(IS_GUARDIAN))
		{
			SetRace("orc");
		}
		SetRoam(true);
		SetDamageResistance("all", ".7");
		SetDamageResistance("fire", 1.2);
		SetDamageResistance("lightning", 1.1);
		SetModel("monsters/troll.mdl");
		SetIdleAnim("idle1");
		SetMoveAnim(ANIM_WALK);
		SetActionAnim(ANIM_ATTACK);
		SetHearingSensitivity(5);
		ScheduleDelayedEvent(10.0, "random_idle");
		troll_spawn();
	}

	void guard_attribs()
	{
		SetDamageResistance("holy", 2.0);
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STRUCK3 = "debris/concrete1.wav";
	}

	void attack_1()
	{
		EmitSound(GetOwner(), 2, SOUND_ATTACK, 10);
		PUSH_VEL = /* TODO: $relvel */ $relvel(10, 200, 10);
		if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
		{
			npcatk_dodamage(ENTITY_ENEMY, "direct", Random(20, 30), 0.75, "blunt");
		}
		if (RandomInt(1, 4) == 1)
		{
			ANIM_ATTACK = "hit_down";
		}
	}

	void attack_2()
	{
		EmitSound(GetOwner(), 2, SOUND_ATTACK, 10);
		if (GetEntityRange(m_hAttackTarget) < ATTACK_HITRANGE)
		{
			npcatk_dodamage(ENTITY_ENEMY, "direct", Random(35, 45), 0.75, "blunt");
		}
		ANIM_ATTACK = "double_punch";
		if (RandomInt(1, 4) == 1)
		{
			ANIM_ATTACK = "double_punch";
		}
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		SetVolume(5);
		EmitSound(GetOwner(), 2, SOUND_PAIN, 5);
	}

	void stomp_1()
	{
		EmitSound(GetOwner(), 2, SOUND_WALK1, 8);
	}

	void stomp_2()
	{
		EmitSound(GetOwner(), 2, SOUND_WALK2, 8);
	}

	void game_hearsound()
	{
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_IDLE);
	}

	void random_idle()
	{
		ScheduleDelayedEvent(10.0, "random_idle");
		if ((IS_HUNTING)) return;
		if ((false)) return;
		if ((IS_FLEEING)) return;
		int ANIM_SELECT = RandomInt(0, 3);
		if (ANIM_SELECT == 0)
		{
			ANIM_IDLE = "idle0";
		}
		if (ANIM_SELECT == 1)
		{
			ANIM_IDLE = "idle1";
		}
		if (ANIM_SELECT == 2)
		{
			ANIM_IDLE = "idle2";
		}
		if (ANIM_SELECT == 3)
		{
			ANIM_IDLE = "idle3";
		}
		if ((ADVANCED_SEARCHING))
		{
			ANIM_IDLE = "idle0";
		}
		PlayAnim("once", ANIM_IDLE);
	}

	void warcry()
	{
		EmitSound(GetOwner(), 2, SOUND_IDLE, 10);
	}

	void OnTargetValidate(CBaseEntity@ target)
	{
		if ((DID_WARCRY)) return;
		if (!(IsValidPlayer(m_hLastSeen))) return;
		AS_ATTACKING = GetGameTime();
		PlayAnim("critical", "idle2");
		DID_WARCRY = 1;
	}

	void my_target_died()
	{
		DID_WARCRY = 0;
		if ((false)) return;
		PlayAnim("critical", "idle2");
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(PUSH_VEL != "PUSH_VEL")) return;
		AddVelocity(m_hLastStruckByMe, PUSH_VEL);
	}

	void bo_zombie_mode()
	{
		SetName("Petrified Troll");
		SetRace("demon");
		SetProp(GetOwner(), "skin", 1);
		IMMUNE_VAMPIRE = 1;
		SetBloodType("none");
		ScheduleDelayedEvent(0.1, "guard_attribs");
	}

}

}
