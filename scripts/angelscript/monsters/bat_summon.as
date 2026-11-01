#pragma context server

#include "monsters/bat.as"

namespace MS
{

class BatSummon : CGameScript
{
	string BAT_ATTACK_DMG;
	int CAN_ATTACK;
	int CAN_FLEE;
	int CAN_HEAR;
	int CAN_HUNT;
	int NPC_GIVE_EXP;

	BatSummon()
	{
		NPC_GIVE_EXP = 5;
		CAN_FLEE = 0;
	}

	void game_dynamically_created()
	{
		BAT_ATTACK_DMG = param2;
		SetMoveDest(param3);
		PARAM1("bat_die");
	}

	void bat_die()
	{
		CAN_ATTACK = 0;
		CAN_HUNT = 0;
		CAN_HEAR = 0;
		DeleteEntity(GetOwner(), true); // fade out
	}

	void bat_spawn()
	{
		SetName("Summoned Bat");
		SetHealth(20);
		SetWidth(1);
		SetHeight(1);
		SetHearingSensitivity(3.5);
		SetIdleAnim(ANIM_IDLE_FLY);
		SetMoveAnim(ANIM_WALK);
	}

	void bat_hang()
	{
	}

	void bite1()
	{
		DoDamage(m_hLastSeen, ATTACK_RANGE, BAT_ATTACK_DMG, ATTACK_HITCHANCE, "slash");
	}

}

}
