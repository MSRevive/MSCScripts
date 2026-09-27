#pragma context server

#include "items/base_crystal.as"

namespace MS
{

class ItemLightCrystal : CGameScript
{
	float ACTIVE_DELAY;
	int SILENT_DELAY;
	int SKILL_LEVEL_REQ;
	string SKILL_TYPE;

	ItemLightCrystal()
	{
		SKILL_LEVEL_REQ = 0;
		SKILL_TYPE = "skill.spellcasting";
		SILENT_DELAY = 1;
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
