#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsHar : CGameScript
{
	PolearmsHar()
	{
		const int BASE_LEVEL_REQ = 15;
		const int VMODEL_IDX = 9;
		const string PMODEL_FILE = "weapons/p_weapons4.mdl";
		const int PMODEL_IDX_FLOOR = 5;
		const int PMODEL_IDX_HANDS = 4;
		const int MELEE_DMG = 220;
		const int MELEE_RANGE = 120;
		const string MELEE_DMG_TYPE = "pierce";
		const float MELEE_ACCURACY = 0.95;
		const int POLE_MIN_RANGE = 70;
		const float POLE_MIN_DMG_MULTI = 0.5;
		const float POLE_MAX_DMG_MULTI = 1.75;
		const int POLE_CAN_POKE1 = 1;
		const int POLE_CAN_POKE2 = 1;
		const int POLE_CAN_SWIPE = 0;
		const int POLE_CAN_BLOCK = 0;
		const int POLE_CAN_SPIN = 0;
		const int POLE_CAN_REPEL = 0;
		const int POLE_CAN_BACKHAND = 0;
		const int POLE_CAN_THROW = 1;
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
		const int POLE_THROW_POWER = 800;
		const string POLE_THOW_PROJECTILE = "proj_pole_harpoon";
		const float POLE_THROW_RECHARGE_TIME = 2.0;
		const float POLE_THROW_MAX_CHARGE_TIME = 4.0;
		const string SOUND_THROW = "weapons/swinghuge.wav";
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
