#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollIceBolt : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollIceBolt()
	{
		BASE_SPELL_SCRIPT = "magic_hand_frost_bolt";
		BASE_SUMMON_TEXT = "You learn to cast a bolt of freezing ice.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("Frost Bolt Tome");
		SetDescription("The method for creating a bolt of freezing ice is here.");
		SetValue(250);
	}

}

}
