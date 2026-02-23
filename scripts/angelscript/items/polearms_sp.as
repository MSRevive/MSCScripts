#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsSp : CGameScript
{
	PolearmsSp()
	{
		const int BASE_LEVEL_REQ = 3;
		const int VMODEL_IDX = 8;
		const string PMODEL_FILE = "weapons/p_weapons4.mdl";
		const int PMODEL_IDX_FLOOR = 7;
		const int PMODEL_IDX_HANDS = 6;
		const int MELEE_DMG = 160;
		const int MELEE_RANGE = 110;
		const string MELEE_DMG_TYPE = "pierce";
		const int POLE_MIN_RANGE = 70;
		const float POLE_MIN_DMG_MULTI = 0.5;
		const float POLE_MAX_DMG_MULTI = 1.65;
		const int POLE_CAN_POKE1 = 1;
		const int POLE_CAN_POKE2 = 1;
		const int POLE_CAN_SWIPE = 0;
		const int POLE_CAN_BLOCK = 0;
		const int POLE_CAN_SPIN = 0;
		const int POLE_CAN_REPEL = 0;
		const int POLE_CAN_BACKHAND = 0;
		const int POLE_CAN_THROW = 1;
		const string SOUND_HITWALL1 = "weapons/dagger/daggermetal1.wav";
		const string SOUND_HITWALL2 = "weapons/dagger/daggermetal2.wav";
		const int POLE_THROW_POWER = 600;
		const string POLE_THOW_PROJECTILE = "proj_pole_spear";
		const float POLE_THROW_RECHARGE_TIME = 1.0;
		const float POLE_THROW_MAX_CHARGE_TIME = 3.0;
	}

	void polearm_spawn()
	{
		SetName("Spear");
		SetDescription("A sturdy throwing spear");
		SetWeight(10);
		SetSize(2);
		SetValue(20);
		SetHUDSprite("trade", 181);
	}

}

}
