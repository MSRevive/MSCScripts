#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollFireDart : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollFireDart()
	{
		BASE_SPELL_SCRIPT = "magic_hand_fire_dart";
		BASE_SUMMON_TEXT = "You learn to cast a weak fireball.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("Fire Dart Tome");
		SetDescription("The method to throw a small ball of fire is written here.");
		SetValue(100);
	}

}

}
