#pragma context server

#include "monsters/morc_shaman_ice_noblizz.as"

namespace MS
{

class MorcShamanIceTurretNoblizz : CGameScript
{
	string ANIM_RUN;
	string ANIM_WALK;
	int NO_STUCK_CHECKS;

	MorcShamanIceTurretNoblizz()
	{
		ANIM_WALK = "idle1";
		ANIM_RUN = "warcry";
		NO_STUCK_CHECKS = 1;
	}

	void OnSpawn() override
	{
		SetRoam(false);
		SetMoveSpeed(0.0);
	}

}

}
