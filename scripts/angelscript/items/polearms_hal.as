#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsHal : CGameScript
{
	int BASE_LEVEL_REQ;
	int MELEE_DMG;
	string MELEE_DMG_TYPE;
	int MELEE_RANGE;
	string PMODEL_FILE;
	int PMODEL_IDX_FLOOR;
	int PMODEL_IDX_HANDS;
	float POLE_BACKHAND_ACCURACY;
	int POLE_BACKHAND_DMG;
	int POLE_BACKHAND_DMG_RANGE;
	string POLE_BACKHAND_DMG_TYPE;
	int POLE_BACKHAND_RANGE;
	int POLE_CAN_BACKHAND;
	int POLE_CAN_BLOCK;
	int POLE_CAN_POKE1;
	int POLE_CAN_POKE2;
	int POLE_CAN_REPEL;
	int POLE_CAN_SPIN;
	int POLE_CAN_SWIPE;
	float POLE_MAX_DMG_MULTI;
	float POLE_MIN_DMG_MULTI;
	int POLE_MIN_RANGE;
	float POLE_SWIPE_ACCURACY;
	int POLE_SWIPE_DMG;
	int POLE_SWIPE_DMG_RANGE;
	string POLE_SWIPE_DMG_TYPE;
	int POLE_SWIPE_RANGE;
	int VANIM_SWIPE1;
	int VANIM_SWIPE2;
	int VMODEL_IDX;

	PolearmsHal()
	{
		BASE_LEVEL_REQ = 9;
		VMODEL_IDX = 10;
		PMODEL_FILE = "weapons/p_weapons4.mdl";
		PMODEL_IDX_FLOOR = 3;
		PMODEL_IDX_HANDS = 2;
		MELEE_DMG = 200;
		MELEE_RANGE = 120;
		MELEE_DMG_TYPE = "pierce";
		POLE_MIN_RANGE = 60;
		POLE_MIN_DMG_MULTI = 0.5;
		POLE_MAX_DMG_MULTI = 2.0;
		POLE_CAN_POKE1 = 1;
		POLE_CAN_POKE2 = 1;
		POLE_CAN_SWIPE = 1;
		POLE_CAN_BLOCK = 1;
		POLE_CAN_SPIN = 0;
		POLE_CAN_REPEL = 1;
		POLE_CAN_BACKHAND = 1;
		POLE_SWIPE_DMG = 190;
		POLE_SWIPE_DMG_RANGE = 20;
		POLE_SWIPE_DMG_TYPE = "slash";
		POLE_SWIPE_RANGE = 80;
		POLE_SWIPE_ACCURACY = 0.7;
		VANIM_SWIPE1 = 7;
		VANIM_SWIPE2 = 7;
		POLE_BACKHAND_DMG = 200;
		POLE_BACKHAND_DMG_RANGE = 10;
		POLE_BACKHAND_DMG_TYPE = "blunt";
		POLE_BACKHAND_RANGE = 40;
		POLE_BACKHAND_ACCURACY = 0.9;
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
