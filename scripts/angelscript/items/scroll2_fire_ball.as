#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2FireBall : CGameScript
{
	Scroll2FireBall()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_fire_ball";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		const int BASE_REQUIRED_LEVEL = 7;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_fire";
		const int SPELL_MAKER_HEIGHT = 48;
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
