#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollFireDart : CGameScript
{
	ScrollFireDart()
	{
		const string BASE_SPELL_SCRIPT = "magic_hand_fire_dart";
		const string BASE_SUMMON_TEXT = "You learn to cast a weak fireball.";
		const string BASE_REQUIRED_SKILL = "skill.spellcasting.fire";
		const int BASE_REQUIRED_LEVEL = 0;
	}

	void OnSpawn() override
	{
		SetName("Fire Dart Tome");
		SetDescription("The method to throw a small ball of fire is written here.");
		SetValue(100);
	}

}

}
