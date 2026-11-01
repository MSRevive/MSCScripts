#pragma context server

#include "monsters/boar_hard.as"

namespace MS
{

class Stoneboar : CGameScript
{
	float ATTACK_HITPERCENT;
	int BOAR_CAN_CHARGE;
	int BOAR_CHARGE_DMG;
	int CAN_FLEE;
	float DROP_ITEM1_CHANCE;
	int GORE_FORWARD_DAMAGE;
	float GORE_SIDE_DAMAGE;
	int IMMUNE_VAMPIRE;
	int NPC_BASE_EXP;
	int NPC_GIVE_EXP;
	string SOUND_STRUCK1;
	string SOUND_STRUCK2;
	string SOUND_STRUCK3;

	Stoneboar()
	{
		GORE_FORWARD_DAMAGE = 12;
		GORE_SIDE_DAMAGE = 8.5;
		ATTACK_HITPERCENT = 0.85;
		BOAR_CAN_CHARGE = 1;
		BOAR_CHARGE_DMG = 25;
		NPC_GIVE_EXP = 45;
		NPC_BASE_EXP = 45;
		DROP_ITEM1_CHANCE = 0.0;
		IMMUNE_VAMPIRE = 1;
		SOUND_STRUCK1 = "weapons/axemetal1.wav";
		SOUND_STRUCK2 = "weapons/axemetal2.wav";
		SOUND_STRUCK3 = "debris/concrete1.wav";
	}

	void OnSpawn() override
	{
		SetHealth(250);
		SetDamageResistance("all", ".45");
		SetDamageResistance("pierce", ".15");
		SetDamageResistance("fire", ".05");
		SetDamageResistance("poison", 0.0);
		SetName("Boar made of stone");
		SetHearingSensitivity(9);
		SetBloodType("none");
		SetProp(GetOwner(), "skin", 1);
		CAN_FLEE = 0;
	}

	void OnPostSpawn() override
	{
		SetDamageResistance("holy", 2.0);
		DROP_ITEM1_CHANCE = 0.0;
	}

}

}
