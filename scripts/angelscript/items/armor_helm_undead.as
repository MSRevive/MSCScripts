#pragma context server

#include "items/armor_base_helmet.as"

namespace MS
{

class ArmorHelmUndead : CGameScript
{
	ArmorHelmUndead()
	{
		const string ARMOR_MODEL = "armor/p_helmets.mdl";
		const int ARMOR_BODY = 12;
		const string ARMOR_TEXT = "You gain resistance to damage from undead.";
		const string BARMOR_TYPE = "platemail";
		const float BARMOR_PROTECTION = 0.0;
		const float STUN_PROTECTION = 0.7;
	}

	void OnSpawn() override
	{
		SetName("Helm of the Dead");
		SetDescription("This seems to be stitched from bat wings and rotting flesh");
		SetWeight(10);
		SetSize(1);
		SetWearable(1);
		SetValue(1);
		SetHUDSprite("trade", 86);
	}

	void OnTakeDamage(CBaseEntity@ inflictor, CBaseEntity@ attacker, int damage, int damageType) override
	{
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		if (GetEntityRace(param1) == "undead")
		{
			int IS_UNDEAD = 1;
		}
		if (GetEntityRace(param2) == "undead")
		{
			int IS_UNDEAD = 1;
		}
		if (!(IS_UNDEAD)) return;
		string IN_DMG = param3;
		string OUT_DMG = param3;
		IN_DMG *= 0.25;
		OUT_DMG -= IN_DMG;
		LogDebug("game_takedamage adjustdmg PARAM3 to OUT_DMG");
		SetDamage("hit");
		SetDamage("dmg");
	}

}

}
