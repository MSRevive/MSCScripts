#pragma context server

#include "items/bows_telf1.as"

namespace MS
{

class BowsTelf4 : CGameScript
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
	string SKILL_TYPE;
	string SOUND_SHOOT;
	string TORKIE_BOW_TYPE;

	BowsTelf4()
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
		DAMAGE_TYPE = "dark";
		DMG_ADJ = 0.75;
	}

	void bow_spawn()
	{
		SetName("Torkalath Chaos Bow");
		SetDescription("An enchanted bow oft wielded by the dark elves of Torkalath.");
		SetWeight(100);
		SetValue(1750);
		SetHUDSprite("trade", 166);
		custom_register();
	}

	void set_bow_type()
	{
		int RND_ARROW = RandomInt(1, 3);
		if (RND_ARROW == 1)
		{
			TORKIE_BOW_TYPE = "fire";
			string DMG_AMT = GetSkillLevel(GetOwner(), "spellcasting.fire");
			SKILL_TYPE = "fire";
			if (DMG_AMT < 15)
			{
				magic_skill_cancel();
			}
			DMG_AMT *= DMG_ADJ;
		}
		if (RND_ARROW == 2)
		{
			TORKIE_BOW_TYPE = "cold";
			string DMG_AMT = GetSkillLevel(GetOwner(), "spellcasting.ice");
			SKILL_TYPE = "ice";
			if (DMG_AMT < 15)
			{
				magic_skill_cancel();
			}
			DMG_AMT *= DMG_ADJ;
		}
		if (RND_ARROW == 3)
		{
			TORKIE_BOW_TYPE = "lightning";
			string DMG_AMT = GetSkillLevel(GetOwner(), "spellcasting.lightning");
			SKILL_TYPE = "lightning";
			if (DMG_AMT < 15)
			{
				magic_skill_cancel();
			}
			DMG_AMT *= DMG_ADJ;
		}
		if ((UNDER_SKILLED))
		{
			DMG_AMT *= 0.1;
		}
		CallExternal(GetOwner(), "ext_set_spiral", TORKIE_BOW_TYPE, DMG_AMT);
	}

	void ranged_start()
	{
		if (!(true)) return;
		set_bow_type();
	}

	void magic_skill_cancel()
	{
		SendColoredMessage(GetOwner(), "The projectile fails to form due to your lack of " + SKILL_TYPE + " affinity.");
		CancelAttack();
	}

}

}
