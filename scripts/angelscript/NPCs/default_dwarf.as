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
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	int CAN_FLEE;
	int MOVE_RANGE;

	DefaultDwarf()
	{
		MOVE_RANGE = 32;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		const int ATTACK1_DAMAGE = 1;
		ANIM_DEATH = "diesimple";
		const int CAN_HUNT = 0;
		const int HUNT_AGRO = 0;
		const int CAN_ATTACK = 0;
		ATTACK_RANGE = 48;
		ATTACK_HITRANGE = 80;
		CAN_FLEE = 1;
		const int FLEE_HEALTH = 25;
		const float FLEE_CHANCE = 1.0;
		const int CAN_HEAR = 1;
		const int CAN_RETALIATE = 1;
		const float RETALIATE_CHANGETARGET_CHANCE = 0.75;
		const int CAN_FLINCH = 1;
		const string FLINCH_ANIM = "flinch1";
		const float FLINCH_CHANCE = 0.5;
		const int FLINCH_DELAY = 1;
		const int NO_JOB = 1;
		const int NO_HAIL = 1;
		const int NO_RUMOR = 1;
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
