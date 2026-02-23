#pragma context server

#include "items/gauntlets_normal.as"

namespace MS
{

class BluntGauntletsLeather : CGameScript
{
	BluntGauntletsLeather()
	{
		const int ANIM_HANDS_DOWN = 3;
		const int ANIM_LIFT1 = 2;
		const int ANIM_LOWER = 3;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_ATTACK1 = 4;
		const int ANIM_SHEATH = 3;
		const string MODEL_VIEW = "viewmodels/v_martialarts.mdl";
		const int MODEL_VIEW_IDX = 1;
		const string MODEL_HANDS = "weapons/p_weapons2.mdl";
		const string MODEL_WORLD = "weapons/p_weapons2.mdl";
		const int MODEL_BODY_OFS = 114;
		const int MELEE_DMG = 70;
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const string SOUND_HITWALL1 = "weapons/cbar_hitbod1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hitbod2.wav";
		const string SOUND_SWING = "weapons/swingsmall.wav";
	}

	void weapon_spawn()
	{
		SetName("a set of|Leather Gauntlets");
		SetDescription("The inner padding allows you to punch slightly harder");
		SetWeight(3);
		SetSize(1);
		SetValue(40);
		SetHand("both");
		SetHUDSprite("hand", 118);
		SetHUDSprite("trade", 118);
	}

}

}
