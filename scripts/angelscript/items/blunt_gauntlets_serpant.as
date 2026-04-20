#pragma context server

#include "items/blunt_gauntlets_fire.as"

namespace MS
{

class BluntGauntletsSerpant : CGameScript
{
	int ANIM_ATTACK1;
	int ANIM_HANDS_DOWN;
	int ANIM_IDLE1;
	int ANIM_IDLE_TOTAL;
	int ANIM_LIFT1;
	int ANIM_LOWER;
	int ANIM_SHEATH;
	int BASE_LEVEL_REQ;
	string DOT_EFFECT;
	float MELEE_ACCURACY;
	string MELEE_CALLBACK;
	int MELEE_DMG;
	int MELEE_DMG_RANGE;
	string MELEE_DMG_TYPE;
	int MODEL_BODY_OFS;
	string MODEL_HANDS;
	string MODEL_VIEW;
	int MODEL_VIEW_IDX;
	string MODEL_WORLD;
	string SOUND_BITE;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_SWING;
	string SOUND_SWIPE;

	BluntGauntletsSerpant()
	{
		BASE_LEVEL_REQ = 15;
		ANIM_HANDS_DOWN = 3;
		ANIM_LIFT1 = 2;
		ANIM_LOWER = 3;
		ANIM_IDLE1 = 1;
		ANIM_IDLE_TOTAL = 1;
		ANIM_ATTACK1 = 4;
		ANIM_SHEATH = 3;
		MODEL_VIEW = "viewmodels/v_martialarts.mdl";
		MODEL_VIEW_IDX = 4;
		MODEL_HANDS = "weapons/p_weapons2.mdl";
		MODEL_WORLD = "weapons/p_weapons2.mdl";
		MODEL_BODY_OFS = 112;
		MELEE_DMG = 125;
		MELEE_DMG_RANGE = 0;
		MELEE_DMG_TYPE = "poison";
		MELEE_ACCURACY = 0.85;
		SOUND_SWIPE = "weapons/swingsmall.wav";
		SOUND_HITWALL1 = "weapons/cbar_hitbod1.wav";
		SOUND_HITWALL2 = "bullchicken/bc_bite2.wav";
		SOUND_SWING = "weapons/swingsmall.wav";
		MELEE_CALLBACK = "gaunt";
		SOUND_BITE = "bullchicken/bc_bite2.wav";
		DOT_EFFECT = "effects/dot_poison";
	}

	void weapon_spawn()
	{
		SetName("Serpent Gauntlets");
		SetDescription("These magical gauntlets have a bite");
		SetWeight(3);
		SetSize(1);
		SetValue(2000);
		SetHand("both");
		SetHUDSprite("hand", 117);
		SetHUDSprite("trade", 117);
	}

}

}
