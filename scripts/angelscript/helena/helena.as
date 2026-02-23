#pragma context server

namespace MS
{

class Helena : CGameScript
{
	int PLAYING_DEAD;

	Helena()
	{
		const string FREQ_CHECK = RandomInt(540, 1020);
		const int HPREQ_MEDIUM_WAVE = 500;
		const int HPREQ_STRONG_WAVE = 1250;
	}

	void OnSpawn() override
	{
		SetName("script_helena");
		SetName(_);
		ScheduleDelayedEvent(FREQ_CHECK, "check_for_raid");
		SetInvincible(true);
		SetFly(true);
		PLAYING_DEAD = 1;
		SetAlive(1);
		SetRace("beloved");
		LogDebug("helena NPC spawned");
	}

	void check_for_raid()
	{
		string RND_CHANCE = RandomInt(1, 5);
		LogDebug("check_for_raid RND_CHANCE / 5");
		if (RND_CHANCE != 1)
		{
			ScheduleDelayedEvent(FREQ_CHECK, "check_for_raid");
		}
		if (!(RND_CHANCE == 1)) return;
		start_raid();
	}

	void start_raid()
	{
		string TOTAL_HP = "game.players.totalhp";
		LogDebug("start_raid TOTAL_HP");
		if (TOTAL_HP < HPREQ_MEDIUM_WAVE)
		{
			UseTrigger("spawn_orcs_weak");
		}
		if (TOTAL_HP >= HPREQ_MEDIUM_WAVE)
		{
			if (TOTAL_HP < HPREQ_STRONG_WAVE)
			{
			}
			UseTrigger("spawn_orcs_medium");
		}
		if (TOTAL_HP >= HPREQ_STRONG_WAVE)
		{
			UseTrigger("spawn_orcs_strong");
		}
		SendInfoMsg("all", "HELENA IS UNDER ATTACK! The Blackhand Orcs are raiding Helena!");
		CallExternal("all", "helena_raid_go");
		ScheduleDelayedEvent(1.0, "music_orcs");
	}

	void bandit_raid()
	{
		LogDebug("bandit_raid");
		ScheduleDelayedEvent(1.0, "bandit_raid2");
		UseTrigger("del_stuff");
	}

	void bandit_raid2()
	{
		SendInfoMsg("all", "HELENA IS UNDER ATTACK Bandits are raiding Helena!");
		CallExternal("all", "helena_raid_go");
		ScheduleDelayedEvent(1.0, "music_bandits");
	}

	void music_orcs()
	{
		// TODO: playmp3 all combat media/Half-Life11.mp3
	}

	void music_bandits()
	{
		// TODO: playmp3 all combat barbarian_gladiator.mp3
	}

	void music_raid_end()
	{
		// TODO: playmp3 all combat mshelena.mp3
	}

	void raid_done()
	{
		LogDebug("raid_done");
		CallExternal("all", "helena_raid_end");
		ScheduleDelayedEvent(FREQ_CHECK, "check_for_raid");
		ScheduleDelayedEvent(2.0, "music_raid_end");
		// TODO: playmp3 all stop
	}

	void manual_start()
	{
		LogDebug("manual_start");
		start_raid(param1);
	}

}

}
