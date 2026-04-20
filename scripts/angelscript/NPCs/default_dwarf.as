#pragma context server

#include "monsters/base_npc.as"
#include "monsters/base_civilian.as"
#include "NPCs/dwarf_lantern_base.as"

namespace MS
{

class DefaultDwarf : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_DEATH;
	string ANIM_RUN;
	string ANIM_WALK;
	int ATTACK1_DAMAGE;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_FLINCH;
	int CAN_HEAR;
	int CAN_HUNT;
	int CAN_RETALIATE;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	string FLINCH_ANIM;
	float FLINCH_CHANCE;
	int FLINCH_DELAY;
	int HUNT_AGRO;
	int MOVE_RANGE;
	int NO_HAIL;
	int NO_JOB;
	int NO_RUMOR;
	float RETALIATE_CHANGETARGET_CHANCE;

	DefaultDwarf()
	{
		MOVE_RANGE = 32;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		ATTACK1_DAMAGE = 1;
		ANIM_DEATH = "diesimple";
		CAN_HUNT = 0;
		HUNT_AGRO = 0;
		CAN_ATTACK = 0;
		ATTACK_RANGE = 48;
		ATTACK_HITRANGE = 80;
		CAN_FLEE = 1;
		FLEE_HEALTH = 25;
		FLEE_CHANCE = 1.0;
		CAN_HEAR = 1;
		CAN_RETALIATE = 1;
		RETALIATE_CHANGETARGET_CHANCE = 0.75;
		CAN_FLINCH = 1;
		FLINCH_ANIM = "flinch1";
		FLINCH_CHANCE = 0.5;
		FLINCH_DELAY = 1;
		NO_JOB = 1;
		NO_HAIL = 1;
		NO_RUMOR = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(30);
		if ((LANTERN_ON))
		{
			npcatk_hunt();
		}
		if ((CanSee("ally", 180)))
		{
		}
		SetMoveDest(m_hLastSeen);
		EmitSound(GetOwner(), 0, "npc/dwarfchitchat.wav", 2);
	}

	void OnSpawn() override
	{
		SetHealth(25);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Commoner");
		SetRoam(true);
		SetModel("dwarf/male1.mdl");
		SetModelBody(1, 0);
		SetMoveAnim("walk");
		SetProp(GetOwner(), "skin", RandomInt(1, 6));
		ScheduleDelayedEvent(1.0, "do_lantern");
	}

	void do_lantern()
	{
		if ((LANTERN_SET)) return;
		if (RandomInt(1, 2) == 1)
		{
			set_lantern();
		}
	}

	void attack_1()
	{
		DoDamage(m_hLastStruck, ATTACK_HITRANGE, ATTACK1_DAMAGE, ATTACK_PERCENTAGE, "blunt");
	}

	void OnHitByAttack(CBaseEntity@ attacker, int damage) override
	{
		SetMoveDest(m_hLastStruck);
		PlayAnim("critical", ANIM_ATTACK);
	}

}

}
