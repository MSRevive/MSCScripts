#pragma context server

#include "items/base_scroll.as"

namespace MS
{

class Scroll2FireDart : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	int SPELL_MAKER_HEIGHT;
	string SPELL_MAKER_SCRIPT;

	Scroll2FireDart()
	{
		BASE_SPELL_SCRIPT = "magic_hand_fire_dart";
		BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		BASE_REQUIRED_LEVEL = 0;
		SPELL_MAKER_SCRIPT = "monsters/companion/spell_maker_fire";
		SPELL_MAKER_HEIGHT = 48;
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
