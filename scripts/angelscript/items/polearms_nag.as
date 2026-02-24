#pragma context server

#include "items/polearms_base.as"

namespace MS
{

class PolearmsNag : CGameScript
{
	int BASE_LEVEL_REQ;
	float MELEE_ATK_DURATION;
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
	int POLE_BACKHAND_REPEL;
	int POLE_BACKHAND_STUN;
	float POLE_BACKHAND_STUN_CHANCE;
	float POLE_BLOCK_DELAY;
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
	int POLE_PRIMARY_SWIPE;
	string SOUND_HITWALL1;
	string SOUND_HITWALL2;
	int VMODEL_IDX;

	PolearmsNag()
	{
		BASE_LEVEL_REQ = 18;
		VMODEL_IDX = 7;
		PMODEL_FILE = "weapons/p_weapons4.mdl";
		PMODEL_IDX_FLOOR = 9;
		PMODEL_IDX_HANDS = 8;
		MELEE_DMG = 250;
		MELEE_RANGE = 90;
		MELEE_DMG_TYPE = "slash";
		MELEE_ATK_DURATION = 0.9;
		POLE_MIN_RANGE = 40;
		POLE_MIN_DMG_MULTI = 0.75;
		POLE_MAX_DMG_MULTI = 1.25;
		POLE_BLOCK_DELAY = 1.0;
		POLE_CAN_POKE1 = 0;
		POLE_PRIMARY_SWIPE = 1;
		POLE_CAN_POKE2 = 1;
		POLE_CAN_SWIPE = 0;
		POLE_CAN_BLOCK = 1;
		POLE_CAN_SPIN = 0;
		POLE_CAN_REPEL = 1;
		POLE_CAN_BACKHAND = 1;
		POLE_BACKHAND_DMG = 150;
		POLE_BACKHAND_DMG_RANGE = 10;
		POLE_BACKHAND_DMG_TYPE = "blunt";
		POLE_BACKHAND_RANGE = 40;
		POLE_BACKHAND_ACCURACY = 0.9;
		POLE_BACKHAND_STUN = 1;
		POLE_BACKHAND_STUN_CHANCE = 1.0;
		POLE_BACKHAND_REPEL = 500;
		SOUND_HITWALL1 = "weapons/cbar_hit1.wav";
		SOUND_HITWALL2 = "weapons/cbar_hit2.wav";
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
