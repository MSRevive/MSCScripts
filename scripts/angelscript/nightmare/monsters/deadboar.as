#pragma context server

#include "monsters/boar_base_remake.as"

namespace MS
{

class Deadboar : CGameScript
{
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	float FLEE_CHANCE;
	int NPC_GIVE_EXP;

	Deadboar()
	{
		const int BOAR_SIZE = 1;
		const string BOAR_MODEL = "nightmare/monsters/skeleboar.mdl";
		NPC_GIVE_EXP = 35;
		const string DMG_GORE_FORWARD = Random(4.0, 6.0);
		const string DMG_GORE_LEFT = Random(5.0, 7.0);
		const string DMG_GORE_RIGHT = Random(5.0, 7.0);
		const string DMG_CHARGE = RandomInt(5, 8);
		const float ATTACK_HITCHANCE = 0.7;
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
