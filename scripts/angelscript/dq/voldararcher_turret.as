#pragma context server

#include "dq/voldararcher.as"

namespace MS
{

class VoldararcherTurret : CGameScript
{
	string ANIM_RUN;
	string ANIM_WALK;
	int NO_STUCK_CHECKS;

	VoldararcherTurret()
	{
		ANIM_WALK = "idle1";
		ANIM_RUN = "warcry";
		NO_STUCK_CHECKS = 1;
	}

	void OnSpawn() override
	{
		SetRoam(false);
		SetMoveSpeed(0.0);
		SetProp(GetOwner(), "skin", 3);
	}

	void back_off()
	{
	}

}

}
