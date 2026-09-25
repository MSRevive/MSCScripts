#pragma context server

#include "items/item_charm_w1.as"

namespace MS
{

class ItemCharmW3 : CGameScript
{
	string PET_FAIL_MESSAGE;
	int PET_MAXHP;
	string PET_SEARCH;
	string PET_TYPE;
	string PET_YAY_MESSAGE;
	int SKILL_LEVEL_REQ;
	string SKILL_TYPE;

	ItemCharmW3()
	{
		SKILL_LEVEL_REQ = 12;
		SKILL_TYPE = "skill.spellcasting";
		PET_TYPE = "wolf";
		PET_SEARCH = "wolf_shadow";
		PET_MAXHP = 500;
		PET_FAIL_MESSAGE = "No weakened shadow wolves in range.";
		PET_YAY_MESSAGE = "You now have a new pet shadow wolf!";
	}

	void crystal_spawn()
	{
		SetName("Shadow Wolf Charm");
		SetDescription("This crystal can be used to tame one shadow wolf");
		SetWeight(5);
		SetSize(5);
		SetValue(750);
		SetHand("both");
	}

}

}
