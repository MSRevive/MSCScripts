#pragma context server

#include "items/item_charm_w1.as"

namespace MS
{

class ItemCharmW2 : CGameScript
{
	string PET_FAIL_MESSAGE;
	int PET_MAXHP;
	string PET_SEARCH;
	string PET_TYPE;
	string PET_YAY_MESSAGE;
	int SKILL_LEVEL_REQ;
	string SKILL_TYPE;

	ItemCharmW2()
	{
		SKILL_LEVEL_REQ = 15;
		SKILL_TYPE = "skill.spellcasting";
		PET_TYPE = "wolf";
		PET_SEARCH = "wolf_ice";
		PET_MAXHP = 1000;
		PET_FAIL_MESSAGE = "No weakened winter wolves in range.";
		PET_YAY_MESSAGE = "You now have a new pet winter wolf!";
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
