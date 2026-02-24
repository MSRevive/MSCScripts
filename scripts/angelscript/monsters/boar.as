#pragma context server

#include "monsters/boar_base.as"

namespace MS
{

class Boar : CGameScript
{
	int BOAR_CAN_CHARGE;
	int CAN_FLEE;
	float FLEE_CHANCE;
	int FLEE_HEALTH;
	float GORE_FORWARD_DAMAGE;
	float GORE_SIDE_DAMAGE;
	int NPC_GIVE_EXP;
	string PUSH_VEL;

	Boar()
	{
		CAN_FLEE = 1;
		FLEE_HEALTH = 10;
		FLEE_CHANCE = 0.25;
		NPC_GIVE_EXP = 6;
		GORE_FORWARD_DAMAGE = 1.0;
		GORE_SIDE_DAMAGE = 0.7;
		BOAR_CAN_CHARGE = 0;
	}

	void OnSpawn() override
	{
		SetHealth(20);
		SetName("Wild Boar");
		SetHearingSensitivity(0);
	}

	void gore_forward()
	{
		PUSH_VEL = Vector3(0, 0, 0);
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, GORE_FORWARD_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void gore_left()
	{
		PUSH_VEL = /* TODO: $relvel */ $relvel(100, 50, 10);
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, GORE_SIDE_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

	void gore_right()
	{
		PUSH_VEL = /* TODO: $relvel */ $relvel(-100, 50, 10);
		DoDamage(ENTITY_ENEMY, ATTACK_HITRANGE, GORE_SIDE_DAMAGE, ATTACK_HITCHANCE, "slash");
	}

}

}
