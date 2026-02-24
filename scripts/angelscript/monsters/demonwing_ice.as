#pragma context server

#include "monsters/demonwing_venom.as"

namespace MS
{

class DemonwingIce : CGameScript
{
	int DMG_CLAW;
	int DMG_SPIT;
	int DOT_DMG;
	string DOT_EFFECT;
	int MONSTER_HP;
	string MONSTER_NAME;
	int MONSTER_SKIN_IDX;
	int NPC_BASE_EXP;
	string SOUND_SPIT;
	string SPIT_PROJECTILE;

	DemonwingIce()
	{
		MONSTER_NAME = "Icewing";
		MONSTER_SKIN_IDX = 2;
		SPIT_PROJECTILE = "proj_ice_bolt";
		DOT_EFFECT = "effects/dot_cold";
		MONSTER_HP = 1000;
		DMG_CLAW = 100;
		DOT_DMG = 20;
		DMG_SPIT = 50;
		NPC_BASE_EXP = 200;
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("fire", 1.25);
		SOUND_SPIT = "magic/ice_strike.wav";
	}

	void game_dynamically_created()
	{
		ScheduleDelayedEvent(0.05, "scale_down");
	}

	void scale_down()
	{
		SetProp(GetOwner(), "scale", 0.5);
	}

}

}
