#pragma context server

#include "items/axes_base_twohanded.as"

namespace MS
{

class AxesBattleaxe : CGameScript
{
	AxesBattleaxe()
	{
		const int BASE_LEVEL_REQ = 12;
		const int ANIM_LIFT1 = 0;
		const int ANIM_IDLE1 = 1;
		const int ANIM_IDLE_TOTAL = 1;
		const int ANIM_ATTACK1 = 2;
		const int ANIM_ATTACK2 = 3;
		const string MODEL_VIEW = "viewmodels/v_2haxes.mdl";
		const int MODEL_VIEW_IDX = 2;
		const string MODEL_HANDS = "weapons/p_weapons1.mdl";
		const string MODEL_WORLD = "weapons/p_weapons1.mdl";
		const string SOUND_SWIPE = "weapons/swingsmall.wav";
		const int MODEL_BODY_OFS = 86;
		const string ANIM_PREFIX = "axe";
		const int MELEE_RANGE = 80;
		const float MELEE_DMG_DELAY = 0.6;
		const float MELEE_ATK_DURATION = 1.2;
		const int MELEE_ENERGY = 2;
		const int MELEE_DMG = 220;
		const int MELEE_DMG_RANGE = 100;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ACCURACY = 0.65;
		const string MELEE_STAT = "axehandling";
		const string MELEE_VIEWANIM_ATK = ANIM_ATTACK1;
		const string MELEE_SOUND = SOUND_SWIPE;
		const string MELEE_SOUND_DELAY = MELEE_DMG_DELAY;
		const float MELEE_PARRY_CHANCE = 0.1;
		const string PLAYERANIM_AIM = "battleaxe";
	}

	void weapon_spawn()
	{
		SetName("Battleaxe");
		SetDescription("A large two-handed Battleaxe , for skull-splitting action");
		SetWeight(80);
		SetSize(10);
		SetValue(270);
		SetHUDSprite("hand", "battleaxe");
		SetHUDSprite("trade", "battleaxe");
	}

}

}
