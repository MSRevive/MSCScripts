#pragma context server

#include "monsters/boar_base_remake.as"

namespace MS
{

class Deadboar : CGameScript
{
	float ATTACK_HITCHANCE;
	string BOAR_MODEL;
	int BOAR_SIZE;
	int DMG_CHARGE;
	float DMG_GORE_FORWARD;
	float DMG_GORE_LEFT;
	float DMG_GORE_RIGHT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLEE_CHANCE;
	int NPC_GIVE_EXP;

	Deadboar()
	{
		BOAR_SIZE = 1;
		BOAR_MODEL = "nightmare/monsters/skeleboar.mdl";
		NPC_GIVE_EXP = 35;
		DMG_GORE_FORWARD = Random(4.0, 6.0);
		DMG_GORE_LEFT = Random(5.0, 7.0);
		DMG_GORE_RIGHT = Random(5.0, 7.0);
		DMG_CHARGE = RandomInt(5, 8);
		ATTACK_HITCHANCE = 0.7;
		FLEE_CHANCE = 0.1;
	}

	void boar_spawn()
	{
		SetName("Skeleton Boar");
		SetHealth(100);
		SetHearingSensitivity(2);
		SetRoam(true);
		SetRace("undead");
		SetWidth(24);
		SetHeight(24);
		SetDamageResistance("holy", 1.5);
		SetDamageResistance("poison", 0.01);
		SetDamageResistance("fire", 1.2);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("blunt", 1.25);
		SetDamageResistance("slash", 0.5);
	}

	void OnPostSpawn() override
	{
		DROP_ITEM1 = "skin_boar_heavy";
		DROP_ITEM1_CHANCE = 0.0;
	}

}

}
