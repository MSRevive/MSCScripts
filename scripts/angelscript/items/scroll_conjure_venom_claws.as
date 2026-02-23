#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollConjureVenomClaws : CGameScript
{
	ScrollConjureVenomClaws()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_conjure_venom_claws";
		const string BASE_SUMMON_TEXT = "You learn to conjure Venom Claws.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		const int BASE_REQUIRED_LEVEL = 20;
	}

	void OnSpawn() override
	{
		SetName("Venom Claws Tome");
		SetDescription("Evil runes are scrawled in these pages.");
		SetValue(2500);
	}

}

}
