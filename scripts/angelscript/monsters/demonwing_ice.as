#pragma context server

#include "monsters/demonwing_venom.as"

namespace MS
{

class DemonwingIce : CGameScript
{
	DemonwingIce()
	{
		const string MONSTER_NAME = "Icewing";
		const int MONSTER_SKIN_IDX = 2;
		const string SPIT_PROJECTILE = "proj_ice_bolt";
		const string DOT_EFFECT = "effects/dot_cold";
		const int MONSTER_HP = 1000;
		const int DMG_CLAW = 100;
		const int DOT_DMG = 20;
		const int DMG_SPIT = 50;
		const int NPC_BASE_EXP = 200;
		SetDamageResistance("cold", 0.5);
		SetDamageResistance("fire", 1.25);
		const string SOUND_SPIT = "magic/ice_strike.wav";
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
