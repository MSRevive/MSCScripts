#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2FireWall : CGameScript
{
	Scroll2FireWall()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_fire_wall";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		const int BASE_REQUIRED_LEVEL = 13;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_fire";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Fire Wall Scroll");
		SetDescription("A magical compendium of strong fire enchantments.");
		SetHUDSprite("trade", 205);
		SetValue(855);
	}

}

}
