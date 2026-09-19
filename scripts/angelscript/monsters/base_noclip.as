#pragma context server

#include "monsters/base_propelled.as"

namespace MS
{

class BaseNoclip : CGameScript
{
	int NPC_HACKED_MOVE_SPEED;

	BaseNoclip()
	{
		NPC_HACKED_MOVE_SPEED = 1;
	}

	void OnSpawn() override
	{
		basenoclip_flight();
	}

	void basenoclip_flight()
	{
		ScheduleDelayedEvent(0.1, "basenoclip_flight");
		string MY_ORG = GetMonsterProperty("origin");
		MY_ORG += /* TODO: $relvel */ $relvel(0, FWD_SPEED, 0);
		SetEntityOrigin(GetOwner(), MY_ORG);
		if (!(IS_FLEEING))
		{
			SetMoveDest(NPC_NOCLIP_DEST);
		}
		else
		{
			SetMoveDest(NPC_NOCLIP_DEST);
		}
	}

}

}
