#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollIceXolt : CGameScript
{
	ScrollIceXolt()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_frost_bolt";
		const string BASE_SUMMON_TEXT = "You learn to create ice shards.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		const int BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("Frost Bolt Tome");
		SetDescription("The method to create a shard of ice is here.");
		SetValue(200);
	}

}

}
