#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2FireWall : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2FireWall()
	{
		BASE_SPELL_SCRIPT = "magic_hand_fire_wall";
		BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		BASE_REQUIRED_LEVEL = 13;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_fire";
		SPELL_MAKER_HEIGHT = 48;
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
