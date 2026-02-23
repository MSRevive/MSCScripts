#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	void game_triggered()
	{
		if (param1 == "music_voldar_dead")
		{
			ScheduleDelayedEvent(2.5, "sailor_moon");
		}
	}

	void sailor_moon()
	{
		// TODO: playmp3 all combat sailormoon_victory.mp3
		ScheduleDelayedEvent(7.5, "end_music");
	}

	void end_music()
	{
		// TODO: playmp3 all stop
	}

}

}
