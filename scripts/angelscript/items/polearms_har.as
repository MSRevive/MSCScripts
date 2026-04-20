#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsHar : CGameScript
{
	int BASE_LEVEL_REQ;
	float MELEE_ACCURACY;
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
	int POLE_CAN_REPEL;
	int POLE_CAN_SPIN;
	int POLE_CAN_SWIPE;
	int POLE_CAN_THROW;
	float POLE_MAX_DMG_MULTI;
	float POLE_MIN_DMG_MULTI;
	int POLE_MIN_RANGE;
	string POLE_THOW_PROJECTILE;
	float POLE_THROW_MAX_CHARGE_TIME;
	int POLE_THROW_POWER;
	float POLE_THROW_RECHARGE_TIME;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	string SOUND_THROW;
	int VMODEL_IDX;

	PolearmsHar()
	{
		BASE_LEVEL_REQ = 15;
		VMODEL_IDX = 9;
		PMODEL_FILE = "weapons/p_weapons4.mdl";
		PMODEL_IDX_FLOOR = 5;
		PMODEL_IDX_HANDS = 4;
		MELEE_DMG = 220;
		MELEE_RANGE = 120;
		MELEE_DMG_TYPE = "pierce";
		MELEE_ACCURACY = 0.95;
		POLE_MIN_RANGE = 70;
		POLE_MIN_DMG_MULTI = 0.5;
		POLE_MAX_DMG_MULTI = 1.75;
		POLE_CAN_POKE1 = 1;
		POLE_CAN_POKE2 = 1;
		POLE_CAN_SWIPE = 0;
		POLE_CAN_BLOCK = 0;
		POLE_CAN_SPIN = 0;
		POLE_CAN_REPEL = 0;
		POLE_CAN_BACKHAND = 0;
		POLE_CAN_THROW = 1;
		SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		POLE_THROW_POWER = 800;
		POLE_THOW_PROJECTILE = "proj_pole_harpoon";
		POLE_THROW_RECHARGE_TIME = 2.0;
		POLE_THROW_MAX_CHARGE_TIME = 4.0;
		SOUND_THROW = "weapons/swinghuge.wav";
	}

	void polearm_spawn()
	{
		SetName("Harpoon");
		SetDescription("A heavy throwing spear");
		SetWeight(10);
		SetSize(2);
		SetValue(1000);
		SetHUDSprite("trade", 186);
	}

}

}
