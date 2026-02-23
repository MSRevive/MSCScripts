#pragma context server

#include "items/blunt_gauntlets_fire.as"

namespace MS
{

class BluntGauntletsSerpant : CGameScript
{
	BluntGauntletsSerpant()
	{
		const int BASE_LEVEL_REQ = 15;
		const int ANIM_HANDS_DOWN = 3;
		const int ANIM_LIFT1 = 2;
		const int ANIM_LOWER = 3;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_ATTACK1 = 4;
		const int ANIM_SHEATH = 3;
		const string MODEL_VIEW = "viewmodels/v_martialarts.mdl";
		const int MODEL_VIEW_IDX = 4;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const int MODEL_BODY_OFS = 112;
		const int MELEE_DMG = 125;
		const int MELEE_DMG_RANGE = 0;
		const string MELEE_DMG_TYPE = "poison";
		const float MELEE_ACCURACY = 0.85;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_HITWALL2 = "bullchicken/bc_bite2.wav";
		const string SOUND_SWING = "weapons/swingsmall.wav";
		const string MELEE_CALLBACK = "gaunt";
		const string SOUND_BITE = "bullchicken/bc_bite2.wav";
		const string DOT_EFFECT = "effects/dot_poison";
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
