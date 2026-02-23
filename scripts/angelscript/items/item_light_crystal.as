#pragma context server

#include "items/base_crystal.as"

namespace MS
{

class ItemLightCrystal : CGameScript
{
	string ACTIVE_DELAY;

	ItemLightCrystal()
	{
		const int SKILL_LEVEL_REQ = 0;
		const string SKILL_TYPE = "skill.spellcasting";
		const int SILENT_DELAY = 1;
	}

	void crystal_spawn()
	{
		SetName("Light Crystal");
		SetDescription("These crystals of light become less corporeal with age");
		SetWeight(1);
		SetSize(1);
		SetValue(10);
		SetHand("both");
		ACTIVE_DELAY = Random(0, 0.5);
	}

	void activate_crystal()
	{
		CallExternal("all", "ext_flash_bang", GetEntityOrigin(GetOwner()), 128, GetEntityIndex(GetOwner()));
		SendPlayerMessage(GetOwner(), "You break the light crystal!");
	}

}

}
