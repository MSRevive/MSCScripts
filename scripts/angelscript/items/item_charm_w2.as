#pragma context server

#include "items/item_charm_w1.as"

namespace MS
{

class ItemCharmW2 : CGameScript
{
	ItemCharmW2()
	{
		const int SKILL_LEVEL_REQ = 15;
		const string SKILL_TYPE = "skill.spellcasting";
		const string PET_TYPE = "wolf";
		const string PET_SEARCH = "wolf_ice";
		const int PET_MAXHP = 1000;
		const string PET_FAIL_MESSAGE = "No weakened winter wolves in range.";
		const string PET_YAY_MESSAGE = "You now have a new pet winter wolf!";
	}

	void crystal_spawn()
	{
		SetName("Winter Wolf Charm");
		SetDescription("This crystal can be used to tame one winter wolf");
		SetWeight(5);
		SetSize(5);
		SetValue(1000);
		SetHand("both");
	}

}

}
