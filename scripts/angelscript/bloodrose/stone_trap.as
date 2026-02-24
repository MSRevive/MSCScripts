#pragma context server

namespace MS
{

class StoneTrap : CGameScript
{
	int DID_INTRO;
	int GAVE_ANSWER;
	int SKELS_ON;
	int TRIGGER_RANGE;

	StoneTrap()
	{
		TRIGGER_RANGE = 256;
	}

	void OnSpawn() override
	{
		SetRace("beloved");
		SetBloodType("none");
		SetModel("null.mdl");
		SetInvincible(true);
		SetHealth(1);
		SetFly(true);
		SetWidth(32);
		SetHeight(32);
		SetSolid("none");
		SetHearingSensitivity(11);
		ScheduleDelayedEvent(0.1, "scan_for_players");
		SetIdleAnim("");
		SetMoveAnim("");
	}

	void scan_for_players()
	{
		if ((DID_INTRO)) return;
		ScheduleDelayedEvent(0.25, "scan_for_players");
		if (!(FindEntitiesInSphere("player", TRIGGER_RANGE) != "none")) return;
		do_intro();
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		if ((DID_INTRO)) return;
		if (!(IsValidPlayer("ent_lastheard"))) return;
		if (!(GetEntityRange("ent_lastheard") < TRIGGER_RANGE)) return;
		do_intro();
	}

	void do_intro()
	{
		if ((DID_INTRO)) return;
		DID_INTRO = 1;
		SetName("The Skeletal Statue");
		SetSayTextRange(2048);
		SayText("Identify yourself mortal! Only our masters may pass!");
		EmitSound(GetOwner(), 0, "monsters/stoners/identify.wav", 10);
		CatchSpeech("say_smart", "slithar");
		CatchSpeech("say_dumb", "venevus");
		ScheduleDelayedEvent(30.0, "times_up");
		string OUT_SOUND = "monsters/stoners/identify.wav";
		CallExternal("all", "ext_playsound", OUT_SOUND, GetMonsterProperty("origin"), 1024);
	}

	void say_dumb()
	{
		if ((SKELS_ON)) return;
		if ((GAVE_ANSWER)) return;
		SetSayTextRange(2048);
		SayText("Venevus is already in his chamber! Imposter!");
		EmitSound(GetOwner(), 0, "monsters/stoners/alreadyin.wav", 10);
		ScheduleDelayedEvent(3.0, "kill_intruder");
		ScheduleDelayedEvent(4.0, "clear_out");
		string OUT_SOUND = "monsters/stoners/alreadyin.wav";
		CallExternal("all", "ext_playsound", OUT_SOUND, GetMonsterProperty("origin"), 1024);
	}

	void times_up()
	{
		if ((SKELS_ON)) return;
		if ((GAVE_ANSWER)) return;
		SetSayTextRange(2048);
		EmitSound(GetOwner(), 0, "monsters/stoners/killtheintruder.wav", 10);
		SayText("Your time has expired, and now, so shall you.");
		ScheduleDelayedEvent(1.0, "kill_intruder");
		ScheduleDelayedEvent(2.0, "clear_out");
		string OUT_SOUND = "monsters/stoners/killtheintruder.wav";
		CallExternal("all", "ext_playsound", OUT_SOUND, GetMonsterProperty("origin"), 1024);
	}

	void say_smart()
	{
		GAVE_ANSWER = 1;
		UseTrigger("player_smart");
		EmitSound(GetOwner(), 0, "monsters/stoners/youmaypass.wav", 10);
		SetSayTextRange(2048);
		SayText("You may pass.");
		ScheduleDelayedEvent(1.0, "clear_out");
		string OUT_SOUND = "monsters/stoners/youmaypass.wav";
		CallExternal("all", "ext_playsound", OUT_SOUND, GetMonsterProperty("origin"), 1024);
	}

	void clear_out()
	{
		ScheduleDelayedEvent(0.1, "suicide_debug");
		SetInvincible(false);
		SetRace("hated");
		ScheduleDelayedEvent(0.2, "clear_out2");
	}

	void clear_out2()
	{
		DoDamage(GetEntityIndex(GetOwner()), "direct", 1000, 1.0, GetEntityIndex(GetOwner()));
	}

	void suicide_debug()
	{
		ScheduleDelayedEvent(2.0, "suicide_debug");
	}

	void kill_intruder()
	{
		if ((SKELS_ON)) return;
		SKELS_ON = 1;
		UseTrigger("player_dumb");
		Effect("screenshake", /* TODO: $relpos */ $relpos(0, 0, 0), 256, 50, 3.0, 512);
		EmitSound(GetOwner(), 0, "ambience/rocketrumble1.wav", 10);
		ScheduleDelayedEvent(0.1, "rumble_sound2");
		ScheduleDelayedEvent(0.3, "wakie_wakie");
	}

	void rumble_sound2()
	{
		EmitSound(GetOwner(), 0, "ambience/rocket_groan1.wav", 10);
	}

	void wakie_wakie()
	{
		EmitSound(GetOwner(), 0, "monsters/stoners/dieintruder.wav", 10);
		ScheduleDelayedEvent(0.1, "wakie_wakie2");
		string OUT_SOUND = "monsters/stoners/dieintruder.wav";
		CallExternal("all", "ext_playsound", OUT_SOUND, GetMonsterProperty("origin"), 1024);
	}

	void wakie_wakie2()
	{
		CallExternal("all", "skeleton_wakeup_call");
	}

}

}
