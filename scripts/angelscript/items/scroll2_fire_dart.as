#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2FireDart : CGameScript
{
	Scroll2FireDart()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_fire_dart";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		const int BASE_REQUIRED_LEVEL = 0;
		const string SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_fire";
		const int SPELL_MAKER_HEIGHT = 48;
	}

	void OnSpawn() override
	{
		SetName("Fire Dart Scroll");
		SetDescription("A magical compendium of weak fire enchantments");
		SetHUDSprite("trade", 204);
		SetValue(100);
	}

}

}
