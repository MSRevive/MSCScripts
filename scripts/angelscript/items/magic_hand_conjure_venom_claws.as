#pragma context server

#include "items/magic_hand_base.as"

namespace MS
{

class MagicHandConjureVenomClaws : CGameScript
{
	int ANIM_CAST;
	float MELEE_ATK_DURATION;
	float MELEE_DMG_DELAY;
	int MELEE_RANGE;
	string SOUND_SHOOT;
	int SPELL_MPDRAIN;
	int SPELL_PREPARE_TIME;
	int SPELL_SKILL_REQUIRED;
	string SPELL_STAT;

	MagicHandConjureVenomClaws()
	{
		SOUND_SHOOT = "magic/cast.wav";
		ANIM_CAST = 12;
		MELEE_RANGE = 0;
		MELEE_DMG_DELAY = 0.9;
		MELEE_ATK_DURATION = 1.0;
		SPELL_SKILL_REQUIRED = 20;
		SPELL_PREPARE_TIME = 1;
		SPELL_MPDRAIN = 40;
		SPELL_STAT = "spellcasting.affliction";
	}

	void spell_spawn()
	{
		SetName("Conjure Venom Claws");
		SetDescription("A venomous imbuement of your fists.");
	}

	void spell_casted()
	{
		if (GetSkillLevel(GetOwner(), "spellcasting.affliction") >= 27)
		{
			SendPlayerMessage(GetOwner(), "Your affliction level strengthens the claws...");
			SpawnNPC("monsters/companion/spell_maker_base", Vector3(1000, 1000, 10000), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "blunt_gauntlets_fe2", "none", "none", "none"
		}
		else
		{
			SpawnNPC("monsters/companion/spell_maker_base", Vector3(1000, 1000, 10000), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "blunt_gauntlets_fe1", "none", "none", "none"
		}
		DeleteEntity(GetOwner());
	}

}

}
