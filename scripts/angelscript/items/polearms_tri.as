#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsTri : CGameScript
{
	PolearmsTri()
	{
		const int BASE_LEVEL_REQ = 11;
		const int VMODEL_IDX = 6;
		const string PMODEL_FILE = "weapons/p_weapons4.mdl";
		const int PMODEL_IDX_FLOOR = 11;
		const int PMODEL_IDX_HANDS = 10;
		const int MELEE_DMG = 200;
		const int MELEE_RANGE = 110;
		const string MELEE_DMG_TYPE = "pierce";
		const int POLE_MIN_RANGE = 60;
		const float POLE_MIN_DMG_MULTI = 0.5;
		const float POLE_MAX_DMG_MULTI = 1.5;
		const int POLE_CAN_POKE1 = 1;
		const int POLE_CAN_POKE2 = 1;
		const int POLE_CAN_SWIPE = 0;
		const int POLE_CAN_BLOCK = 1;
		const int POLE_CAN_SPIN = 0;
		const int POLE_CAN_REPEL = 1;
		const int POLE_CAN_BACKHAND = 0;
		const int POLE_CAN_POWER_THROW = 1;
		const int POLE_THROW_POWER = 800;
		const string POLE_THOW_PROJECTILE = "proj_pole_trident";
	}

	void polearm_spawn()
	{
		SetName("Trident");
		SetDescription("A three pronged military fork");
		SetWeight(10);
		SetSize(2);
		SetValue(400);
		SetHUDSprite("trade", 183);
	}

}

}
