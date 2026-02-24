#pragma context server

#include "items/base_tome.as"

namespace MS
{

class ScrollPoisonCloud : CGameScript
{
	int BASE_REQUIRED_LEVEL;
	string BASE_REQUIRED_SKILL;
	string BASE_SPELL_SCRIPT;
	string BASE_SUMMON_TEXT;

	ScrollPoisonCloud()
	{
		BASE_SPELL_SCRIPT = "magic_hand_poison_cloud";
		BASE_SUMMON_TEXT = "You learn to create poisonous clouds.";
		BASE_REQUIRED_SKILL = "skill.spellcasting.affliction";
		BASE_REQUIRED_LEVEL = 15;
	}

	void OnSpawn() override
	{
		SetName("Poison Cloud Tome");
		SetDescription("A treatises of obscure necromantic gestures to form a poisonous cloud.");
		SetValue(900);
	}

}

}
