#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2IceBlast : CGameScript
{
	Scroll2IceBlast()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_ice_blast";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		const int BASE_REQUIRED_LEVEL = 18;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_ice";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Freezing Sphere Scroll");
		SetDescription("A magical compendium of epic ice enchantments.");
		SetHUDSprite("trade", 206);
		SetValue(3000);
	}

}

}
