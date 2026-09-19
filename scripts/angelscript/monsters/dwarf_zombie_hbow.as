#pragma context server

#include "monsters/dwarf_zombie_sbow.as"

namespace MS
{

class DwarfZombieHbow : CGameScript
{
	string AMMO_TYPE;
	int DMG_XBOW;
	int IMMUNE_VAMPIRE;
	int IS_BLOODLESS;
	int IS_UNHOLY;
	string LANTERN_COLOR;
	float PBOLT_DURATION;
	string SOUND_XBOW_STRETCH;
	int XBOW_TYPE;

	DwarfZombieHbow()
	{
		XBOW_TYPE = 0;
		DMG_XBOW = 60;
		PBOLT_DURATION = 15.0;
		SOUND_XBOW_STRETCH = "weapons/bow/stretch.wav";
		LANTERN_COLOR = Vector3(32, 0, 16);
	}

	void frame_reload_hxbow()
	{
		EmitSound(GetOwner(), 0, SOUND_XBOW_STRETCH, 10);
	}

	void frame_attack_hxbow()
	{
		bow_fire();
	}

	void select_ammo()
	{
		if (!(AMMO_TYPE == "unset")) return;
		int L_RND_TYPE = RandomInt(1, 3);
		if (L_RND_TYPE == 1)
		{
			AMMO_TYPE = "poison";
		}
		if (L_RND_TYPE == 2)
		{
			AMMO_TYPE = "explode";
		}
		if (L_RND_TYPE == 3)
		{
			AMMO_TYPE = "pierce";
		}
		adjust_xp();
	}

	void darcher_spawn()
	{
		SetName("Dwarven Zombie Bowman");
		SetModel("dwarf/male1.mdl");
		SetModelBody(0, 2);
		SetModelBody(1, 7);
		SetWidth(32);
		SetHeight(48);
		SetRoam(true);
		SetHealth(300);
		SetRace("undead");
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 2.0);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("fire", 1.25);
		SetDamageResistance("slash", 1.25);
		SetHearingSensitivity(8);
		IS_BLOODLESS = 1;
		IMMUNE_VAMPIRE = 1;
		IS_UNHOLY = 1;
	}

}

}
