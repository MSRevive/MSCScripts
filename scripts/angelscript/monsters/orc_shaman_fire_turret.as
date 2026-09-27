#pragma context server

#include "monsters/orc_shaman_fire.as"

namespace MS
{

class OrcShamanFireTurret : CGameScript
{
	string ANIM_RUN;
	string ANIM_WALK;
	int NO_STUCK_CHECKS;
	int NPC_IGNORE_PLAYERS;

	OrcShamanFireTurret()
	{
		ANIM_WALK = "idle1";
		ANIM_RUN = "warcry";
		NO_STUCK_CHECKS = 1;
	}

	void OnSpawn() override
	{
		SetRoam(false);
		SetMoveSpeed(0.0);
		ScheduleDelayedEvent(5.0, "no_ignore");
	}

	void no_ignore()
	{
		NPC_IGNORE_PLAYERS = 0;
	}

}

}
