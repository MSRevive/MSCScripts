#pragma context server

#include "monsters/boar.as"
#include "monsters/base_ice_race.as"

namespace MS
{

class Snowboar1 : CGameScript
{
	int BOAR_CAN_CHARGE;
	int CAN_FLEE;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	float GORE_FORWARD_DAMAGE;
	float GORE_SIDE_DAMAGE;
	int NPC_BASE_EXP;
	string PUSH_VEL;

	Snowboar1()
	{
		CAN_FLEE = 1;
		FLEE_HEALTH = 10;
		FLEE_CHANCE = 0.25;
		NPC_BASE_EXP = 12;
		GORE_FORWARD_DAMAGE = 1.0;
		GORE_SIDE_DAMAGE = 0.7;
		BOAR_CAN_CHARGE = 0;
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
