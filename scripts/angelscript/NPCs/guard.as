#pragma context server

#include "monsters/base_npc_attack.as"

namespace MS
{

class Guard : CGameScript
{
	string ANIM_ATTACK;
	string ANIM_RUN;
	string ANIM_WALK;
	float ATTACK_PERCENTAGE;
	int ATTACK_RANGE;
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_HUNT;
	int CAN_RETALIATE;
	int CAN_STTACK;
	int MOVE_RANGE;
	float RETALIATE_CHANGETARGET_CHANCE;

	Guard()
	{
		ATTACK_RANGE = 150;
		MOVE_RANGE = 90;
		CAN_ATTACK = 0;
		ATTACK_PERCENTAGE = 0.95;
		ANIM_WALK = "walk";
		ANIM_RUN = "run";
		ANIM_ATTACK = "attack";
		CAN_HUNT = 0;
		CAN_FLEE = 0;
		CAN_RETALIATE = 1;
		RETALIATE_CHANGETARGET_CHANCE = 0.75;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(30);
		CanSee("ally");
		SetMoveDest(m_hLastSeen);
		SetVolume(2);
		Say("hello1[50] *[20] *[55] *[55] *[23] *[22]");
	}

	void OnSpawn() override
	{
		SetHealth(100);
		SetMaxHealth(100);
		SetGold(10);
		SetWidth(32);
		SetHeight(72);
		SetRace("neutral");
		SetName("Guard");
		SetRoam(true);
		SetModel("npc/guard1.mdl");
		SetMoveAnim("walk");
		SetInvincible(false);
	}

	void attack_1()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, Random(5.0, 8.0), ATTACK_PERCENTAGE, "slash");
	}

	void OnStruck(CBaseEntity@ attacker, int damage)
	{
		CAN_STTACK = 1;
	}

}

}
