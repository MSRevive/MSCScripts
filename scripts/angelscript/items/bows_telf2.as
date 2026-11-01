#pragma context server

#include "items/bows_telf1.as"

namespace MS
{

class BowsTelf2 : CGameScript
{
	string ANIM_PREFIX;
	int BASE_LEVEL_REQ;
	int CUSTOM_ATTACK;
	string DAMAGE_TYPE;
	float DMG_ADJ;
	string ITEM_NAME;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WEAR;
	string MODEL_WORLD;
	string RANGED_AIMANGLE;
	float RANGED_ATK_DURATION;
	string RANGED_HOLD_MINMAX;
	float RANGED_POSTFIRE_DELAY;
	float RANGED_PULLTIME;
	string RANGED_STAT;
	string SOUND_SHOOT;
	string TORKIE_BOW_TYPE;

	BowsTelf2()
	{
		BASE_LEVEL_REQ = 30;
		MODEL_VIEW_IDX = 9;
		MODEL_VIEW = "viewmodels/v_bows.mdl";
		MODEL_HANDS = "weapons/p_weapons3.mdl";
		MODEL_WORLD = "weapons/p_weapons3.mdl";
		MODEL_WEAR = "weapons/p_weapons3.mdl";
		SOUND_SHOOT = "weapons/bow/bow.wav";
		ITEM_NAME = "longbow";
		ANIM_PREFIX = "standard";
		MODEL_BODY_OFS = 54;
		RANGED_POSTFIRE_DELAY = 1.0;
		RANGED_ATK_DURATION = 1.0;
		RANGED_AIMANGLE = Vector3(0, 0, 0);
		CUSTOM_ATTACK = 1;
		RANGED_HOLD_MINMAX = "1.1;1.3";
		RANGED_STAT = "archery";
		RANGED_PULLTIME = 1.0;
		DAMAGE_TYPE = "cold_effect";
		DMG_ADJ = 0.55;
	}

	void bow_spawn()
	{
		SetName("Torkalath Frost Bow");
		SetDescription("This enchanted bow is cold to the touch.");
		SetWeight(100);
		SetValue(1500);
		SetHUDSprite("trade", 166);
		custom_register();
	}

	void set_bow_type()
	{
		string DMG_AMT = GetSkillLevel(GetOwner(), "spellcasting.ice");
		DMG_AMT *= DMG_ADJ;
		if ((UNDER_SKILLED))
		{
			DMG_AMT *= 0.1;
		}
		TORKIE_BOW_TYPE = "cold";
		CallExternal(GetOwner(), "ext_set_spiral", TORKIE_BOW_TYPE, DMG_AMT);
	}

	void ranged_start()
	{
		if (!(true)) return;
		string OWNER_SKILL = GetSkillLevel(GetOwner(), "spellcasting.ice");
		if (!(OWNER_SKILL < 15)) return;
		SendColoredMessage(GetOwner(), "You lack the ice affinity to activate this bow s magic.");
		CancelAttack();
	}

}

}
