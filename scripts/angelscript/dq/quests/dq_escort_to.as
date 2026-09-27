#pragma context server

#include "dq/quests/bases/dq_base_quests.as"

namespace MS
{

class DqEscortTo : CGameScript
{
	string DQ_ARRIVAL_POINT;
	float DQ_CHECK_POS_INTERVAL;

	DqEscortTo()
	{
		DQ_ARRIVAL_POINT = QUEST_DATA1;
		DQ_CHECK_POS_INTERVAL = 2.0;
	}

	void quest_activate()
	{
		SetInvincible(false);
		SetRace("human");
		handle_pos();
		check_pos();
	}

	void handle_pos()
	{
		string L_INFO_TARGET = FindEntityByName(DQ_ARRIVAL_POINT);
		if (((L_INFO_TARGET !is null)))
		{
			DQ_ARRIVAL_POINT = GetEntityOrigin(L_INFO_TARGET);
		}
	}

	void check_pos()
	{
		if (QUEST_MODE == QUEST_ACTIVE)
		{
			if (Distance(GetEntityOrigin(GetOwner()), DQ_ARRIVAL_POINT) <= 128)
			{
				quest_finished();
			}
			else
			{
				DQ_CHECK_POS_INTERVAL("check_pos");
			}
		}
	}

}

}
