#pragma context server

#include "monsters/base_chat.as"

namespace MS
{

class Hmaster : CGameScript
{
	string SOUND_IDLE1;
	string SOUND_IDLE2;
	string SOUND_IDLE3;

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
		CatchSpeech("say_job", "job");
		CatchSpeech("say_ship", "boat");
		CatchSpeech("say_ara", "ara");
		CatchSpeech("say_rumour", "rumours");
	}

	void say_rumor()
	{
		say_rumour();
	}

	void idle()
	{
		SetRepeatDelay(Random(30, 40));
		SetVolume(3);
		// PlayRandomSound from: SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3
		array<string> sounds = {SOUND_IDLE1, SOUND_IDLE2, SOUND_IDLE3};
		EmitSound(GetOwner(), 2, sounds[RandomInt(0, sounds.length() - 1)], 10);
	}

	void say_hi()
	{
		SayText("Ahoy! What you doin' around the harbor mate?");
	}

	void gossip_1()
	{
		SayText("The winds be tellin' me about some trouble around here.");
	}

	void say_rumour()
	{
		PlayAnim("once", "pondering");
		SayText("Rumour has it , the wind will be changing to the other side. Aye.");
	}

	void say_job()
	{
		SayText("I've got a shipment to get to Ara, could always use some good hands.");
		ScheduleDelayedEvent(2, "say_job2");
	}

	void say_job2()
	{
		SayText("Business has been mighty slow , so the best " + I + " can offer for a wage is free passage.");
	}

	void say_ship()
	{
		SayText("That ship can take you out into the sea if you want. Joins up with Ron's Galleon about 20 leagues out.");
		ScheduleDelayedEvent(4, "say_ship2");
	}

	void say_ship2()
	{
		SayText("But beware, it be a crazy place out thar!");
		ScheduleDelayedEvent(2, "say_ship3");
	}

	void say_ship3()
	{
		SayText("This time of year be icy, so the only place I can trade goods is Port Ara.");
		ScheduleDelayedEvent(2, "say_ship4");
	}

	void say_ship4()
	{
		SayText("Ye are welcome to come along, if ye like.");
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Join Crew";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "vote_ara";
	}

	void vote_ara()
	{
		SayText("It'll be a fine thing indeed to have ye aboard.");
		CallExternal(GAME_MASTER, "gm_create_vote", "gm_votemap", "Yes!:oceancrossing;No!:0", "Do you wish to travel the ocean blue?");
		CallExternal("players", "ext_set_map", "oceancrossing", "from_deralia", "from_deralia");
	}

	void say_ara()
	{
		SayText("It's a prosperous little trade town up the coast, last one before Verath.");
		ScheduleDelayedEvent(2, "say_ara2");
	}

	void say_ara2()
	{
		SayText("Too dangerous to go any farther than that with the ice flows this time of year.");
		ScheduleDelayedEvent(2, "say_ara3");
	}

	void say_ara3()
	{
		SayText("I could use a hand with the boat. Would ye be volunteering?");
	}

}

}
