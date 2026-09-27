#pragma context server

#include "monsters/troll_ice_lobber.as"

namespace MS
{

class TrollIceTurret : CGameScript
{
	string ANIM_RUN;
	string ANIM_WALK;
	int NO_STUCK_CHECKS;

	TrollIceTurret()
	{
		ANIM_WALK = "idle0";
		ANIM_RUN = "idle1";
		NO_STUCK_CHECKS = 1;
	}

	void OnSpawn() override
	{
		SetRoam(false);
		SetMoveSpeed(0.0);
	}

}

}
