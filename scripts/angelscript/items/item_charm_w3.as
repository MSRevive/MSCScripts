#pragma context server

#include "items/item_charm_w1.as"

namespace MS
{

class ItemCharmW3 : CGameScript
{
	ItemCharmW3()
	{
		const int SKILL_LEVEL_REQ = 12;
		const string SKILL_TYPE = "skill.spellcasting";
		const string PET_TYPE = "wolf";
		const string PET_SEARCH = "wolf_shadow";
		const int PET_MAXHP = 500;
		const string PET_FAIL_MESSAGE = "No weakened shadow wolves in range.";
		const string PET_YAY_MESSAGE = "You now have a new pet shadow wolf!";
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
