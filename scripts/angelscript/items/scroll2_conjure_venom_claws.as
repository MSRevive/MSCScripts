#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2ConjureVenomClaws : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2ConjureVenomClaws()
	{
		BASE_SPELL_SCRIPT = "magic_hand_conjure_venom_claws";
		BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		BASE_REQUIRED_LEVEL = 20;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_affliction";
		SPELL_MAKER_HEIGHT = 48;
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
