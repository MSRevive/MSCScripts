#pragma context server

namespace MS
{

class SorcImageDefeat : CGameScript
{
	SorcImageDefeat()
	{
		const string SOUND_TELE = "magic/teleport.wav";
	}

	void OnSpawn() override
	{
		SetModel("monsters/sorc.mdl");
		SetWidth(32);
		SetHeight(72);
		SetModelBody(0, 2);
		SetModelBody(1, 3);
		SetModelBody(2, 8);
		SetNoPush(true);
		SetInvincible(true);
		SetRace("demon");
		SetHearingSensitivity(11);
		SetName("Runegahr , Shadahar Orc Chieftain");
		SetSayTextRange(2048);
		SetMenuAutoOpen(1);
		CatchSpeech("say_hi", "hail");
		CatchSpeech("offer_accepted", "yes");
		CatchSpeech("offer_denied", "no");
		ScheduleDelayedEvent(0.1, "say_stop");
	}

	void OnHeardSound(CBaseEntity@ source, Vector3 origin) override
	{
		string LAST_HEARD = GetEntityIndex("ent_lastheard");
		if (!(IsValidPlayer(LAST_HEARD))) return;
		SetMoveDest(LAST_HEARD);
	}

	void say_hi()
	{
		say_stop();
		OpenMenu(GetEntityIndex("ent_lastspoke"));
	}

	void say_stop()
	{
		SayText("ENOUGH! Maybe you aren't the pathetic creatures I took you for...");
		ScheduleDelayedEvent(4.0, "say_stop2");
	}

	void say_stop2()
	{
		SayText("However , defeating me alone is not enough to prove yourselves worthy of alliance.");
		ScheduleDelayedEvent(4.0, "say_stop3");
	}

	void say_stop3()
	{
		SayText("For humans are treacherous , and fall easily to temptation and despair.");
		ScheduleDelayedEvent(4.0, "say_stop4");
	}

	void say_stop4()
	{
		SayText("If you can reach Maldora's lair, at the heart of Lodagond, I swear upon this sword, that I will join you and aid in his defeat!");
		ScheduleDelayedEvent(4.0, "say_stop5");
	}

	void say_stop5()
	{
		SayText("Do you [accept] this offer? Or would you rather [die] at my hand here and now?");
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "I accept.";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "offer_accepted";
		string reg.mitem.title = "Die evil orc!";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "offer_denied";
	}

	void offer_accepted()
	{
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		SpawnNPC("monsters/summon/ibarrier", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 64, 2, 0, 0, 0, 1
		SayText("Very well. When the time comes , I will be there , and in exchange for your aid , I will give one of you this sword.");
		PlayAnim("critical", "warcry");
		ScheduleDelayedEvent(1.0, "do_fadeout");
		SetGlobalVar("G_SHAD_ORC", 1);
	}

	void offer_denied()
	{
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		SpawnNPC("monsters/summon/ibarrier", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 64, 2, 0, 0, 0, 1
		PlayAnim("critical", "warcry");
		SayText("Impudent fools! You stand no chance against the charlatan without my help. So be it , die at his hands - you ll wish you d done so at mine.");
		ScheduleDelayedEvent(1.0, "do_fadeout");
		SetGlobalVar("G_SHAD_ORC", 0);
	}

	void do_fadeout()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
