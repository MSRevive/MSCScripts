#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2ConjureVenomClaws : CGameScript
{
	Scroll2ConjureVenomClaws()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_conjure_venom_claws";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		const int BASE_REQUIRED_LEVEL = 20;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_affliction";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Venom Claws Scroll");
		SetDescription("Evil runes are scrawled into this page.");
		SetHUDSprite("trade", 232);
		SetValue(2500);
	}

}

}
