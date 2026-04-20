#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2FireBall : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2FireBall()
	{
		BASE_SPELL_SCRIPT = "magic_hand_fire_ball";
		BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		BASE_REQUIRED_LEVEL = 7;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_fire";
		SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Fire Ball Scroll");
		SetDescription("A magical compendium of strong fire enchantments");
		SetHUDSprite("trade", 203);
		SetValue(300);
	}

}

}
