#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2IceBlast : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2IceBlast()
	{
		BASE_SPELL_SCRIPT = "magic_hand_ice_blast";
		BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		BASE_REQUIRED_LEVEL = 18;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_ice";
		SPELL_MAKER_HEIGHT = 48;
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
