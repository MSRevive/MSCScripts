#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsQs : CGameScript
{
	PolearmsQs()
	{
		const int BASE_LEVEL_REQ = 0;
		const int VMODEL_IDX = 1;
		const string PMODEL_FILE = "weapons/p_weapons3.mdl";
		const int PMODEL_IDX_FLOOR = 61;
		const int PMODEL_IDX_HANDS = 62;
		const int MELEE_DMG = 120;
		const int MELEE_RANGE = 90;
		const string MELEE_DMG_TYPE = "blunt";
		const float MELEE_ACCURACY = 0.85;
		const int POLE_MIN_RANGE = 60;
		const float POLE_MIN_DMG_MULTI = 0.5;
		const float POLE_MAX_DMG_MULTI = 1.5;
		const int POLE_CAN_POKE1 = 1;
		const int POLE_CAN_POKE2 = 1;
		const int POLE_CAN_SWIPE = 1;
		const int POLE_CAN_BLOCK = 1;
		const int POLE_CAN_SPIN = 1;
		const int POLE_CAN_REPEL = 1;
		const int POLE_CAN_BACKHAND = 1;
		const int POLE_SWIPE_DMG = 60;
		const int POLE_SWIPE_DMG_RANGE = 20;
		const string POLE_SWIPE_DMG_TYPE = "blunt";
		const int POLE_SWIPE_RANGE = 60;
		const float POLE_SWIPE_ACCURACY = 0.6;
		const int POLE_BACKHAND_DMG = 90;
		const int POLE_BACKHAND_DMG_RANGE = 10;
		const string POLE_BACKHAND_DMG_TYPE = "blunt";
		const int POLE_BACKHAND_RANGE = 40;
		const float POLE_BACKHAND_ACCURACY = 0.7;
		const int POLE_BACKHAND_REPEL = 100;
		const int POLE_BACKHAND_STUN = 1;
		const float POLE_BACKHAND_STUN_CHANCE = 0.35;
	}

	void polearm_spawn()
	{
		SetName("Quarterstaff");
		SetDescription("A heavy staff reinforced with iron");
		SetWeight(3);
		SetSize(2);
		SetValue(5);
		SetHUDSprite("trade", 139);
	}

}

}
