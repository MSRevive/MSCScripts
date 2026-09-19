#pragma context server

#include "NPCs/dwarf_pickaxe.as"

namespace MS
{

class DwarfWarrior : CGameScript
{
	string ATTACK2_CHANCE;
	string ATTACK2_DAMAGE;
	string ATTACK_DAMAGE;
	string WEAPON_CHOICE;

	void dwarf_spawn()
	{
		SetName("Dwarven Warrior");
		SetModel("dwarf/male1.mdl");
		SetModelBody(1, 0);
		SetProp(GetOwner(), "skin", RandomInt(0, 6));
		SetProp(GetOwner(), "scale", 1.2);
		SetWidth(38);
		SetHeight(50);
		SetRoam(true);
		SetHealth(700);
		SetRace("human");
		SetHearingSensitivity(8);
		ScheduleDelayedEvent(1.0, "select_weapon");
	}

	void select_weapon()
	{
		if (WEAPON_CHOICE == "WEAPON_CHOICE")
		{
			WEAPON_CHOICE = RandomInt(1, 4);
		}
		SetModelBody(1, WEAPON_CHOICE);
		if (WEAPON_CHOICE == 1)
		{
			ATTACK_DAMAGE = 40;
			ATTACK2_DAMAGE = 150;
			ATTACK2_CHANCE = 15;
		}
		if (WEAPON_CHOICE == 2)
		{
			ATTACK_DAMAGE = 50;
			ATTACK2_DAMAGE = 150;
			ATTACK2_CHANCE = 25;
		}
		if (WEAPON_CHOICE == 3)
		{
			ATTACK_DAMAGE = 40;
			ATTACK2_DAMAGE = 150;
			ATTACK2_CHANCE = 15;
		}
		if (WEAPON_CHOICE == 4)
		{
			ATTACK_DAMAGE = 50;
			ATTACK2_DAMAGE = 150;
			ATTACK2_CHANCE = 25;
		}
	}

	void set_weapon()
	{
		LogDebug("set_weapon PARAM1");
		WEAPON_CHOICE = param1;
	}

}

}
