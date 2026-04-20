#pragma context server

#include "items/blunt_base_onehanded.as"

namespace MS
{

class MagicHandHolyHammer : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_AUGMENT;
	int MELEE_RANGE;
	string MELEE_STAT;
	int MODEL_BODY_OFS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	int SPELL_SKILL_REQUIRED;

	MagicHandHolyHammer()
	{
		SPELL_SKILL_REQUIRED = 5;
		BASE_LEVEL_REQ = 5;
		MELEE_STAT = "spellcasting.divination";
		MODEL_VIEW = "viewmodels/v_1hblunts.mdl";
		MODEL_VIEW_IDX = 2;
		MODEL_BODY_OFS = 71;
		ANIM_PREFIX = "maul";
		MELEE_RANGE = 80;
		MELEE_DMG_DELAY = 0.8;
		MELEE_ATK_DURATION = 1.3;
		MELEE_ENERGY = 2;
		MELEE_DMG = 102;
		MELEE_DMG_RANGE = 5;
		MELEE_ACCURACY = 0.65;
		MELEE_PARRY_AUGMENT = 0.1;
		MELEE_DMG_TYPE = "holy";
	}

	void OnSpawn() override
	{
		string reg.spell.reqskill = BASE_LEVEL_REQ;
		int reg.spell.fizzletime = 9999999;
		float reg.spell.castsuccess = 1.0;
		int reg.spell.preparetime = 3;
		// TODO: registerspell
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
