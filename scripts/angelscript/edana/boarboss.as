#pragma context server

#include "monsters/boar_hard.as"

namespace MS
{

class Boarboss : CGameScript
{
	float ATTACK_HITPERCENT;
	int BOAR_CAN_CHARGE;
	int BOAR_CHARGE_DMG;
	int CAN_FLEE;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	int GORE_FORWARD_DAMAGE;
	float GORE_SIDE_DAMAGE;
	int NPC_BASE_EXP;

	Boarboss()
	{
		GORE_FORWARD_DAMAGE = 3;
		GORE_SIDE_DAMAGE = 1.5;
		ATTACK_HITPERCENT = 0.6;
		BOAR_CAN_CHARGE = 1;
		BOAR_CHARGE_DMG = 9;
		NPC_BASE_EXP = 15;
	}

	void OnSpawn() override
	{
		SetHealth(60);
		SetDamageResistance("all", ".81");
		SetName("Huge Aggressive Wild Boar");
		SetModel("monsters/boar1.mdl");
		SetHearingSensitivity(4);
		CAN_FLEE = 0;
	}

	void OnPostSpawn() override
	{
		DROP_ITEM1 = "skin_boar_heavy";
		DROP_ITEM1_CHANCE = 1.0;
	}

}

}
