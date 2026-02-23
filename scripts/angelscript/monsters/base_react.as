#pragma context server

namespace MS
{

class BaseReact : CGameScript
{
	int NPC_REACTS;
	string NPC_REACT_CANSEETARGET;
	string NPC_REACT_LAST_TARGET;
	string NPC_REACT_RESET_TARGET_TIME;

	BaseReact()
	{
		const string NPC_REACT_SEETARGET = "player";
		const int NPC_REACT_SEETARGET_RANGE = 128;
		NPC_REACTS = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(1);
		if ((CanSee(NPC_REACT_SEETARGET, NPC_REACT_SEETARGET_RANGE)))
		{
			if (GetEntityIndex(m_hLastSeen) != NPC_REACT_LAST_TARGET)
			{
			}
			NPC_REACT_LAST_TARGET = GetEntityIndex(m_hLastSeen);
			NPC_REACT_RESET_TARGET_TIME = GetGameTime();
			NPC_REACT_RESET_TARGET_TIME += 60.0;
			if (!(NPC_REACT_CANSEETARGET))
			{
				npcreact_targetsighted(NPC_REACT_LAST_TARGET);
			}
			NPC_REACT_CANSEETARGET = 1;
		}
		else
		{
			if ((NPC_REACT_CANSEETARGET))
			{
				npc_react_sightlost();
			}
			NPC_REACT_CANSEETARGET = 0;
			if (GetGameTime() > NPC_REACT_RESET_TARGET_TIME)
			{
			}
			NPC_REACT_LAST_TARGET = 0;
		}
	}

}

}
