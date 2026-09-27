#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2IceWall : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2IceWall()
	{
		BASE_SPELL_SCRIPT = "magic_hand_ice_wall";
		BASE_REQUIRED_SKILL = "skill.spellcasting.ice";
		BASE_REQUIRED_LEVEL = 4;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_ice";
		SPELL_MAKER_HEIGHT = 18;
	}

	void OnSpawn() override
	{
		SetName("Ice Wall Scroll");
		SetDescription("A magical compendium of weak ice enchantments.");
		SetHUDSprite("trade", 213);
		SetValue(95);
	}

}

}
