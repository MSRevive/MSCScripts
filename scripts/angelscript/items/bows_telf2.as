#pragma context server

#include "items/bows_telf1.as"

namespace MS
{

class BowsTelf2 : CGameScript
{
	string TORKIE_BOW_TYPE;

	BowsTelf2()
	{
		const int BASE_LEVEL_REQ = 30;
		const int MODEL_VIEW_IDX = 9;
		const string MODEL_VIEW = "viewmodels/v_bows.mdl";
		const string MODEL_HANDS = "weapons/p_weapons3.mdl";
		const string MODEL_WORLD = "weapons/p_weapons3.mdl";
		const string MODEL_WEAR = "weapons/p_weapons3.mdl";
		const string SOUND_SHOOT = "weapons/bow/bow.wav";
		const string ITEM_NAME = "longbow";
		const string ANIM_PREFIX = "standard";
		const int MODEL_BODY_OFS = 54;
		const float RANGED_POSTFIRE_DELAY = 1.0;
		const float RANGED_ATK_DURATION = 1.0;
		const Vector3 RANGED_AIMANGLE = Vector3(0, 0, 0);
		const int CUSTOM_ATTACK = 1;
		const string RANGED_HOLD_MINMAX = "1.1;1.3";
		const string RANGED_STAT = "archery";
		const float RANGED_PULLTIME = 1.0;
		const string DAMAGE_TYPE = "cold_effect";
		const float DMG_ADJ = 0.55;
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
