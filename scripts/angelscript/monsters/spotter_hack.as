#pragma context server

namespace MS
{

class SpotterHack : CGameScript
{
	string CAN_ATTACK;
	string CAN_HUNT;
	string CYCLE_TIME;
	string HUNT_LASTTARGET;
	string NPC_ATTACK_TARGET;
	string NPC_MOVE_TARGET;

	void see_enemy()
	{
		SetRepeatDelay(1.0);
		if (HUNT_LASTTARGET != "HUNT_LASTTARGET")
		{
			if (HUNT_LASTTARGET != �NONE�)
			{
				int EXIT_SUB = 1;
			}
		}
		if ((EXIT_SUB)) return;
		if ((false))
		{
			if (!(NO_ADVANCED_SEARCHES))
			{
				SetFOV(359);
			}
			CAN_ATTACK = 1;
			CAN_HUNT = 1;
			NPC_MOVE_TARGET = GetEntityIndex(m_hLastSeen);
			NPC_ATTACK_TARGET = NPC_MOVE_TARGET;
			HUNT_LASTTARGET = m_hLastSeen;
			CYCLE_TIME = CYCLE_TIME_ACTIVE;
			cycle_up();
			SetMoveDest(m_hLastSeen);
			if (GetEntityProperty("range", "m_hlastseen") < ATTACK_RANGE)
			{
				npcatk_attackenemy();
			}
		}
	}

}

}
