#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsHal : CGameScript
{
	PolearmsHal()
	{
		const int BASE_LEVEL_REQ = 9;
		const int VMODEL_IDX = 10;
		const string PMODEL_FILE = "weapons/p_weapons4.mdl";
		const int PMODEL_IDX_FLOOR = 3;
		const int PMODEL_IDX_HANDS = 2;
		const int MELEE_DMG = 200;
		const int MELEE_RANGE = 120;
		const string MELEE_DMG_TYPE = "pierce";
		const int POLE_MIN_RANGE = 60;
		const float POLE_MIN_DMG_MULTI = 0.5;
		const float POLE_MAX_DMG_MULTI = 2.0;
		const int POLE_CAN_POKE1 = 1;
		const int POLE_CAN_POKE2 = 1;
		const int POLE_CAN_SWIPE = 1;
		const int POLE_CAN_BLOCK = 1;
		const int POLE_CAN_SPIN = 0;
		const int POLE_CAN_REPEL = 1;
		const int POLE_CAN_BACKHAND = 1;
		const int POLE_SWIPE_DMG = 190;
		const int POLE_SWIPE_DMG_RANGE = 20;
		const string POLE_SWIPE_DMG_TYPE = "slash";
		const int POLE_SWIPE_RANGE = 80;
		const float POLE_SWIPE_ACCURACY = 0.7;
		const int VANIM_SWIPE1 = 7;
		const int VANIM_SWIPE2 = 7;
		const int POLE_BACKHAND_DMG = 200;
		const int POLE_BACKHAND_DMG_RANGE = 10;
		const string POLE_BACKHAND_DMG_TYPE = "blunt";
		const int POLE_BACKHAND_RANGE = 40;
		const float POLE_BACKHAND_ACCURACY = 0.9;
	}

	void polearm_spawn()
	{
		SetName("Halberd");
		SetDescription("The dynamic military stand by");
		SetWeight(30);
		SetSize(2);
		SetValue(50);
		SetHUDSprite("trade", 179);
	}

}

}
