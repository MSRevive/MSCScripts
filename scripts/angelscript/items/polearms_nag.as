#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsNag : CGameScript
{
	PolearmsNag()
	{
		const int BASE_LEVEL_REQ = 18;
		const int VMODEL_IDX = 7;
		const string PMODEL_FILE = "weapons/p_weapons4.mdl";
		const int PMODEL_IDX_FLOOR = 9;
		const int PMODEL_IDX_HANDS = 8;
		const int MELEE_DMG = 250;
		const int MELEE_RANGE = 90;
		const string MELEE_DMG_TYPE = "slash";
		const float MELEE_ATK_DURATION = 0.9;
		const int POLE_MIN_RANGE = 40;
		const float POLE_MIN_DMG_MULTI = 0.75;
		const float POLE_MAX_DMG_MULTI = 1.25;
		const float POLE_BLOCK_DELAY = 1.0;
		const int POLE_CAN_POKE1 = 0;
		const int POLE_PRIMARY_SWIPE = 1;
		const int POLE_CAN_POKE2 = 1;
		const int POLE_CAN_SWIPE = 0;
		const int POLE_CAN_BLOCK = 1;
		const int POLE_CAN_SPIN = 0;
		const int POLE_CAN_REPEL = 1;
		const int POLE_CAN_BACKHAND = 1;
		const int POLE_BACKHAND_DMG = 150;
		const int POLE_BACKHAND_DMG_RANGE = 10;
		const string POLE_BACKHAND_DMG_TYPE = "blunt";
		const int POLE_BACKHAND_RANGE = 40;
		const float POLE_BACKHAND_ACCURACY = 0.9;
		const int POLE_BACKHAND_STUN = 1;
		const float POLE_BACKHAND_STUN_CHANCE = 1.0;
		const int POLE_BACKHAND_REPEL = 500;
		const string SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		const string SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
	}

	void polearm_spawn()
	{
		SetName("Elven Glaive");
		SetDescription("A long handled blade for fighting groups of opponents");
		SetWeight(60);
		SetSize(2);
		SetValue(1500);
		SetHUDSprite("trade", 182);
	}

}

}
