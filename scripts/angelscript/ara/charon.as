#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Charon : CGameScript
{
	int NO_JOB;
	int NO_RUMOR;
	string ORC_TIME;
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;

	Charon()
	{
		NO_RUMOR = 1;
		NO_JOB = 1;
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetName("Captain Charon");
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(0, 1);
		SetModelBody(1, 2);
		SOUND_IDLE1 = "voices/human/male_idle4.wav";
		SOUND_IDLE2 = "voices/human/male_idle5.wav";
		SOUND_IDLE3 = "voices/human/male_idle6.wav";
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_orc", "orc");
		ScheduleDelayedEvent(0.1, "post_spawn");
	}

	void post_spawn()
	{
		ORC_TIME = GetGameTime();
		ORC_TIME += 120.0;
	}

	void say_hi()
	{
		if (GetGameTime() < ORC_TIME)
		{
			PlayAnim("critical", "pondering");
			SayText("Oh , " + I + "don t like this. It s far too quiet... No one in sight. Something is up , something " + BAD.);
		}
		if (GetGameTime() >= ORC_TIME)
		{
			PlayAnim("once", "checktie");
			if ((IsEntityAlive(param1)))
			{
				face_speaker(param1);
			}
			if ((IsEntityAlive("ent_lastspoke")))
			{
				face_speaker(GetEntityIndex("ent_lastspoke"));
			}
			SayText("Orcs!? Blast! Get in there and see if you can save any potential customers!");
			SayText(I + " ll stay here and guard the ship.");
		}
	}

	void say_orc()
	{
		PlayAnim("critical", "pondering2");
		if ((IsEntityAlive("ent_lastheard")))
		{
			face_speaker(GetEntityIndex("ent_lastspoke"));
		}
		SayText("Awfully brazen these days. Orcs in Helena is one thing... Orcs in Ara is unheard of!");
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Sail Back to Deralia";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "vote_deralia";
	}

	void vote_deralia()
	{
		SayText(I + " suppose this town is a bust - sorry for wasting your time.");
		UseTrigger("touch_trans_deralia");
		SendColoredMessage(param1, "Starting " + AMX + " vote for Deralia...");
	}

}

}
