#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsTri : CGameScript
{
	int BASE_LEVEL_REQ;
	int MELEE_DMG;
	string MELEE_DMG_TYPE;
	int MELEE_RANGE;
	string PMODEL_FILE;
	int PMODEL_IDX_FLOOR;
	int PMODEL_IDX_HANDS;
	int POLE_CAN_BACKHAND;
	int POLE_CAN_BLOCK;
	int POLE_CAN_POKE1;
	int POLE_CAN_POKE2;
	int POLE_CAN_POWER_THROW;
	int POLE_CAN_REPEL;
	int POLE_CAN_SPIN;
	int POLE_CAN_SWIPE;
	float POLE_MAX_DMG_MULTI;
	float POLE_MIN_DMG_MULTI;
	int POLE_MIN_RANGE;
	string POLE_THOW_PROJECTILE;
	int POLE_THROW_POWER;
	int VMODEL_IDX;

	PolearmsTri()
	{
		BASE_LEVEL_REQ = 11;
		VMODEL_IDX = 6;
		PMODEL_FILE = "weapons/p_weapons4.mdl";
		PMODEL_IDX_FLOOR = 11;
		PMODEL_IDX_HANDS = 10;
		MELEE_DMG = 200;
		MELEE_RANGE = 110;
		MELEE_DMG_TYPE = "pierce";
		POLE_MIN_RANGE = 60;
		POLE_MIN_DMG_MULTI = 0.5;
		POLE_MAX_DMG_MULTI = 1.5;
		POLE_CAN_POKE1 = 1;
		POLE_CAN_POKE2 = 1;
		POLE_CAN_SWIPE = 0;
		POLE_CAN_BLOCK = 1;
		POLE_CAN_SPIN = 0;
		POLE_CAN_REPEL = 1;
		POLE_CAN_BACKHAND = 0;
		POLE_CAN_POWER_THROW = 1;
		POLE_THROW_POWER = 800;
		POLE_THOW_PROJECTILE = "proj_pole_trident";
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
