#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class MagicHandHolyHammer : CGameScript
{
	MagicHandHolyHammer()
	{
		const int SPELL_SKILL_REQUIRED = 5;
		const int BASE_LEVEL_REQ = 5;
		const string MELEE_STAT = "spellcasting.divination";
		const string MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		const int MODEL_VIEW_IDX = 2;
		const int MODEL_BODY_OFS = 71;
		const string ANIM_PREFIX = "maul";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.8;
		const float MELEE_ATK_DURATION = 1.3;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 102;
		const int MELEE_DMG_RANGE = 5;
		const float MELEE_ACCURACY = 0.65;
		const float MELEE_PARRY_AUGMENT = 0.1;
		const string MELEE_DMG_TYPE = "holy";
	}

	void OnSpawn() override
	{
		string reg.spell.reqskill = BASE_LEVEL_REQ;
		int reg.spell.fizzletime = 9999999;
		float reg.spell.castsuccess = 1.0;
		int reg.spell.preparetime = 3;
		// TODO: UNCONVERTED: registerspell
	}

	void weapon_spawn()
	{
		SetName("Holy Hammer");
		SetDescription("Can't touch this.");
		SetWeight(10);
		SetSize(10);
		SetValue(270);
		SetHUDSprite("hand", "hammer");
		SetHUDSprite("trade", "maul");
	}

}

}
