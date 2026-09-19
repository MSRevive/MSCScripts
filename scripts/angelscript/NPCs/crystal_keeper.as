#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class CrystalKeeper : CGameScript
{
	string ANIM_GIVE;
	string ANIM_MAGIC;
	float CHAT_SPEED;
	string DUNGEON_NAME;
	int GAVE_KEY;
	int IN_CHAT;
	string JOB_STEP;
	string MONSTER_MODEL;
	int NO_RUMOR;
	string PLAYER_NAME;
	string QUEST_WINNER;
	string SHARDS_LEFT;
	int SHARDS_RECIEVED;
	int SHARDS_REQ;
	string SHARD_SUFFIX;

	CrystalKeeper()
	{
		SHARDS_REQ = 10;
		ANIM_MAGIC = "kneel";
		ANIM_GIVE = "gluonshow";
		DUNGEON_NAME = "Crows dungeon name";
		MONSTER_MODEL = "npc/balancepriest1.mdl";
		Precache(MONSTER_MODEL);
		CHAT_SPEED = 5.0;
		NO_RUMOR = 1;
	}

	void OnSpawn() override
	{
		SetName("Tal thul, the High Priest");
		SetHealth(100);
		SetRace("human");
		SetInvincible(true);
		Precache(MONSTER_MODEL);
		SetModel(MONSTER_MODEL);
		SetModelBody(1, 3);
		SetWidth(32);
		SetHeight(72);
		GiveItem(GetOwner(), "ring_light2");
		SHARDS_RECIEVED = 0;
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_job", "crystal");
		CatchSpeech("say_where", "where");
	}

	void say_job()
	{
		if ((IN_CHAT)) return;
		IN_CHAT = 1;
		say_job_loop();
	}

	void say_job_loop()
	{
		if ((GAVE_KEY)) return;
		JOB_STEP += 1;
		if (JOB_STEP == 1)
		{
			SayText("The door to this temple requires a crystal key , but the key has been shattered.");
		}
		if (JOB_STEP == 2)
		{
			SayText("If warriors of light cannot penetrate inside , the evil therein will simply grow without end.");
		}
		if (JOB_STEP == 3)
		{
			SayText(I + "have some of the shards... " + I + "think if " + I + "had the rest " + I + " could re-forge the key.");
		}
		if (JOB_STEP == 4)
		{
			SayText("They are scattered throughout " + DUNGEON_NAME + "but " + I + " lack the power to gather the rest.");
		}
		if (JOB_STEP == 5)
		{
			SayText("If you can bring me " + SHARDS_REQ + "shards , " + I + " can re-forge magical key that opens this door.");
		}
		if (JOB_STEP == 6)
		{
			SayText("Be sure to bring them to me all at once , for " + I + " must have all the pieces on hand at the same time.");
		}
		if (JOB_STEP < 6)
		{
			CHAT_SPEED("say_job_loop");
		}
		if (JOB_STEP == 6)
		{
			JOB_STEP = 0;
			IN_CHAT = 0;
		}
	}

	void say_hi()
	{
		if ((IN_CHAT)) return;
		if (SHARDS_RECIEVED > 0)
		{
			SayText(I + "still need " + SHARDS_LEFT + " shards to re-forge the key to the temple door.");
		}
		if (!(SHARDS_RECIEVED == 0)) return;
		if (!(GAVE_KEY))
		{
			SayText("Greetings warrior , " + I + " am Tal thul, priest of Felewyn.");
		}
		if ((GAVE_KEY))
		{
			SayText("Thank you for your work , now hurry , use the key to enter the temple before it s too late.");
		}
		CHAT_SPEED("say_job");
	}

	void say_where()
	{
		if ((IN_CHAT)) return;
		SayText(I + "am uncertain as to where exactally , " + I + "only barely survived finding the first three pieces in " + DUNGEON_NAME.);
	}

	void gave_shard()
	{
		QUEST_WINNER = GetEntityIndex(param1);
		PLAYER_NAME = GetEntityName(QUEST_WINNER);
		PLAYER_NAME += ",";
		SHARDS_RECIEVED += 1;
		SHARDS_LEFT = SHARDS_REQ;
		SHARDS_LEFT -= SHARDS_RECIEVED;
		SHARDS_LEFT = int(SHARDS_LEFT);
		SHARD_SUFFIX = "shards.";
		if (SHARDS_LEFT == 1)
		{
			string SHARD_SUFFIX = "shard.";
		}
		if (SHARDS_LEFT == 0)
		{
			give_key();
		}
		if (!(SHARDS_LEFT > 0)) return;
		int RANDOM_CHAT = RandomInt(1, 4);
		if (RANDOM_CHAT == 1)
		{
			SayText("Excellent , " + PLAYER_NAME + I + "only need " + SHARDS_LEFT + "more " + SHARD_SUFFIX);
		}
		if (RANDOM_CHAT == 2)
		{
			SayText("Good work , " + PLAYER_NAME + I + "only need " + SHARDS_LEFT + "more " + SHARD_SUFFIX);
		}
		if (RANDOM_CHAT == 3)
		{
			SayText("Keep them coming , " + PLAYER_NAME + I + "only need " + SHARDS_LEFT + "more " + SHARD_SUFFIX);
		}
		if (RANDOM_CHAT == 4)
		{
			SayText("Alright , " + PLAYER_NAME + I + "only need " + SHARDS_LEFT + "more " + SHARD_SUFFIX);
		}
	}

	void game_menu_getoptions()
	{
		if ((GAVE_KEY)) return;
		if ((ItemExists(param1, "item_crow_shard")))
		{
			string reg.mitem.id = "payment";
			string reg.mitem.title = "Give Crystal Shard";
			string reg.mitem.type = "payment";
			string reg.mitem.data = "item_crow_shard";
			string reg.mitem.callback = "gave_shard";
		}
	}

	void give_key()
	{
		SayText("Truly you are a warrior of the light " + PLAYER_NAME + "one moment while " + I + " perform the incantation.");
		SpawnNPC("monsters/companion/spell_maker_divination", /* TODO: $relpos */ $relpos(0, 0, 40), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), "none", "none", 50
		PlayAnim("once", ANIM_MAGIC);
		ScheduleDelayedEvent(2.0, "give_key2");
	}

	void give_key2()
	{
		PlayAnim("once", ANIM_GIVE);
		SayText("Here , take it quickly and use it to enter the foul temple and expunge the evil therein!");
		// TODO: offer QUEST_WINNER key_crystal
		GAVE_KEY = 1;
		ScheduleDelayedEvent(5.0, "return_home");
	}

	void return_home()
	{
		SayText(I + " ve done all I can here, so I am using my return scroll s magic now.");
		ScheduleDelayedEvent(2.0, "return_home2");
	}

	void return_home2()
	{
		SayText(I + " wish you luck in your quest!");
		ScheduleDelayedEvent(0.1, "npc_fade_away");
	}

}

}
