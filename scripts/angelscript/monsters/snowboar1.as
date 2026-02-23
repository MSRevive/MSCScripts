#pragma context server

#include "monsters/boar.as"
#include "monsters/base_ice_race.as"

namespace MS
{

class Snowboar1 : CGameScript
{
	int CAN_FLEE;
	string PUSH_VEL;

	Snowboar1()
	{
		CAN_FLEE = 1;
		const int FLEE_HEALTH = 10;
		const float FLEE_CHANCE = 0.25;
		const int NPC_BASE_EXP = 12;
		const float GORE_FORWARD_DAMAGE = 1.0;
		const float GORE_SIDE_DAMAGE = 0.7;
		const int BOAR_CAN_CHARGE = 0;
	}

	void OnSpawn() override
	{
		SetHealth(30);
		SetName("Snow Boar");
		SetHearingSensitivity(0);
		SetModel("monsters/boar1.mdl");
		SetProp(GetOwner(), "skin", 3);
	}

	void gore_forward()
	{
		PUSH_VEL = Vector3(0, 0, 0);
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, GORE_FORWARD_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void gore_left()
	{
		PUSH_VEL = /* TODO: $relvel */ $relvel(100, 50, 10);
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, GORE_SIDE_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void gore_right()
	{
		PUSH_VEL = /* TODO: $relvel */ $relvel(-100, 50, 10);
		DoDamage(m_hLastSeen, ATTACK_HITRANGE, GORE_SIDE_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

}

}
