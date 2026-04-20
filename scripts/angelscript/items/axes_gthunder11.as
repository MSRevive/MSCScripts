#pragma context server

#include "items/axes_base_twohanded.as"

namespace MS
{

class AxesGthunder11 : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_ATTACK2;
	int ANIM_ATTACK3;
	int ANIM_IDLE1;
	int ANIM_LIFT1;
	string ANIM_PREFIX;
	int ANIM_SHEATH;
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
	float MELEE_ATK_DURATION;
	int MELEE_DMG;
	float MELEE_DMG_DELAY;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MELEE_ENERGY;
	float MELEE_PARRY_CHANCE;
	int MELEE_RANGE;
	string MELEE_SOUND;
	string MELEE_SOUND_DELAY;
	string MELEE_STAT;
	string MELEE_VIEWANIM_ATK;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string SOUND_SWIPE;

	AxesGthunder11()
	{
		MODEL_VIEW = "viewmodels/v_2haxesgreat.mdl";
		MODEL_VIEW_IDX = 2;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_BODY_OFS = 124;
		MELEE_DMG_TYPE = "lightning";
		MELEE_ACCURACY = 0.35;
		BASE_LEVEL_REQ = 20;
		ANIM_LIFT1 = 0;
		ANIM_IDLE1 = 1;
		ANIM_ATTACK1 = 2;
		ANIM_ATTACK2 = 3;
		ANIM_ATTACK3 = 4;
		ANIM_SHEATH = 5;
		MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		SOUND_SWIPE = "weapons/swingsmall.wav";
		ANIM_PREFIX = "axe";
		MELEE_RANGE = 100;
		MELEE_DMG_DELAY = 0.6;
		MELEE_ATK_DURATION = 1.5;
		MELEE_ENERGY = 3;
		MELEE_DMG = 400;
		MELEE_DMG_RANGE = 50;
		MELEE_STAT = "axehandling";
		MELEE_SOUND = SOUND_SWIPE;
		MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		MELEE_PARRY_CHANCE = 0.25;
	}

	void weapon_spawn()
	{
		SetName("Greater Thunderaxe");
		SetDescription("An axe enchanted with powerful lightning magics");
		SetWeight(110);
		SetSize(15);
		SetValue(3000);
		SetHUDSprite("hand", 122);
		SetHUDSprite("trade", 122);
	}

	void game_dodamage()
	{
		if (!(param1)) return;
		string BURN_DAMAGE = GetSkillLevel(GetOwner(), "spellcasting.lightning");
		BURN_DAMAGE += Random(1, 3);
		if (BURN_DAMAGE < 5)
		{
			int BURN_DAMAGE = 5;
		}
		ApplyEffect(param2, "effects/dot_lightning", 5, GetEntityIndex(GetOwner()), BURN_DAMAGE, "axehandling");
	}

}

}
