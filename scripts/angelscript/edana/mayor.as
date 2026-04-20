#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Mayor : CGameScript
{
	int ASKED_GUILD;
	string IMPOSTER;
	int NO_RUMOR;
	int OVER;
	string SOUND_HELP;

	Mayor()
	{
		NO_RUMOR = 1;
	}

	void OnSpawn() override
	{
		SetHealth(30);
		SetGold(15);
		SetName("Zerkold, the Mayor");
		SetWidth(32);
		SetHeight(72);
		SetRace("neutral");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetInvincible(true);
		SetModelBody(1, 3);
		ASKED_GUILD = 2;
		OVER = 0;
		SOUND_HELP = "voices/human/male_help_guards.wav";
		CatchSpeech("say_hi", "hi");
		CatchSpeech("say_yes", "yes");
		CatchSpeech("say_no", "no");
		CatchSpeech("say_know", "orcs");
		CatchSpeech("say_suliban", "suliban");
		CatchSpeech("say_job", "job");
		Precache("edana/guard");
	}

	void say_hi()
	{
		SayText("Yes? What do you want? Who are you?");
		ASKED_GUILD = RandomInt(0, 1);
	}

	void say_suliban()
	{
		if ((OVER)) return;
		if (ASKED_GUILD > 0)
		{
			PlayAnim("once", "panic1");
			SayText("Suliban was here an hour ago! You're not him!");
			ASKED_GUILD = 3;
			IMPOSTER = GetEntityIndex("ent_lastspoke");
			ScheduleDelayedEvent(120, "reset");
			ScheduleDelayedEvent(1.5, "guards");
		}
		else
		{
			PlayAnim("once", "talkleft");
			SayText("You're here again? You forgot to take the letter with you?");
			ScheduleDelayedEvent(3, "say_suliban2");
		}
		OVER = 1;
	}

	void guards()
	{
		string thiername = GetEntityName(IMPOSTER);
		SpawnNPC("edana/guard", Vector3(-137, -1131, -250), ScriptMode::Legacy); // params: IMPOSTER
		SpawnNPC("edana/guard", Vector3(1038, -284, -60), ScriptMode::Legacy); // params: IMPOSTER
		SpawnNPC("edana/guard", Vector3(2428, -1092, -250), ScriptMode::Legacy); // params: IMPOSTER
		SayText("Guards! Apprehend thiername");
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_HELP);
	}

	void reset()
	{
		ASKED_GUILD = 0;
	}

	void say_suliban2()
	{
		SayText("It's hidden in the secret compartment in my chest. Make sure nobody sees you with it.");
		CallExternal(FindEntityByName("mayor_chest"), "showletter");
		ASKED_GUILD = 3;
	}

	void say_know()
	{
		PlayAnim("once", "eye_wipe");
		SayText("You know nothing!");
		RemoveItem("letter");
	}

	void worldevent_evidence_found()
	{
		DeleteEntity(GetOwner());
	}

	void robbed()
	{
		SayText("Help! Help! I'm being robbed!");
		PlayAnim("once", "beatdoor");
		UseTrigger("spawnguards");
	}

	void attack_1()
	{
		DoDamage("ent_laststole", 100, 7, 0.75, "slash");
	}

	void game_recvoffer_gold()
	{
		ReceiveOffer("accept");
		SayText("Come to donate eh? Well, that's what you should be doing!");
		PlayAnim("once", "pondering3");
	}

	void say_job()
	{
		SayText("What? No. I don't need help, It's not like I'm planning anything...");
		PlayAnim("once", "quicklook");
	}

}

}
