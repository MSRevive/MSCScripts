#pragma context server

namespace MS
{

class TimeVote : CGameScript
{
	string script.newhour;

	void game_vote_end()
	{
		if (param1 == "advtime")
		{
			if (param3 == "success")
			{
			}
			script.newhour = CURRENT_TIME_HOUR;
			if (param4 == 0)
			{
				script.newhour += 3;
			}
			else
			{
				if (param4 == 1)
				{
					script.newhour += 6;
				}
				else
				{
					if (param4 == 2)
					{
						script.newhour += 12;
					}
				}
			}
			Effect("screenfade", "all", 0.5, 10, Vector3(0, 0, 0), 255, "fadeout");
			ScheduleDelayedEvent(4, "adv_time");
			ScheduleDelayedEvent(5, "adv_fadin");
		}
	}

	void adv_time()
	{
		set_time(script.newhour, CURRENT_TIME_MIN);
		SendInfoMsg("all", "Time Change Later that day...");
	}

	void adv_fadin()
	{
		Effect("screenfade", "all", 2, 3, Vector3(0, 0, 0), 255, "fadein");
	}

}

}
