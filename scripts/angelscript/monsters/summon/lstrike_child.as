#pragma context server

namespace MS
{

class LstrikeChild : CGameScript
{
	int IS_ACTIVE;
	string MY_DMG;
	string MY_DURATION;
	string MY_OWNER;
	string OWNER_ISPLAYER;
	int PLAYING_DEAD;
	string PVP_MODE;

	void OnRepeatTimer()
	{
		SetRepeatDelay(1.0);
		EmitSound(GetOwner(), 0, "magic/lightning_strike.wav", 10);
	}

	void game_dynamically_created()
	{
		MY_OWNER = param1;
		MY_DMG = param2;
		MY_DURATION = param3;
		StoreEntity("ent_expowner");
		OWNER_ISPLAYER = IsValidPlayer(MY_OWNER);
		PVP_MODE = "game.pvp";
		DropToFloor();
		IS_ACTIVE = 1;
		summon_start();
		MY_DURATION("summon_end");
	}

	void OnSpawn() override
	{
		SetName("Lightning Strike");
		SetInvincible(true);
		SetHealth(1);
		PLAYING_DEAD = 1;
		DropToFloor();
	}

	void summon_start()
	{
		ScheduleDelayedEvent(0.1, "damage_loop");
	}

	void damage_loop()
	{
		SetRepeatDelay(0.30);
		if (!(IS_ACTIVE)) return;
		DoDamage(GetMonsterProperty("origin"), 96, MY_DMG, 1.0, 0.1);
	}

	void summon_end()
	{
		IS_ACTIVE = 0;
		ScheduleDelayedEvent(0.1, "remove_me");
	}

	void remove_me()
	{
		DeleteEntity(GetOwner());
	}

}

}
