#pragma context server

namespace MS
{

class SorcImageFinal : CGameScript
{
	string SOUND_TELE;

	SorcImageFinal()
	{
		SOUND_TELE = "magic/teleport.wav";
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
		SetName("Runegahr , Shadahar Orc Chieftain");
		SetSayTextRange(2048);
		SetMenuAutoOpen(1);
		CatchSpeech("say_hi", "hail");
	}

	void say_hi()
	{
		SayText(I + " got something you want , human?");
		OpenMenu(GetEntityIndex("ent_lastspoke"));
	}

	void game_menu_getoptions()
	{
		string reg.mitem.title = "Demand Reward";
		string reg.mitem.type = "callback";
		string reg.mitem.callback = "say_sword";
	}

	void say_sword()
	{
		SayText("Since you were the first to have the guts to ask , here you are , as promised.");
		SetModelBody(2, 0);
		ScheduleDelayedEvent(4.0, "say_sword2");
		// TODO: offer PARAM1 swords_blooddrinker
	}

	void say_sword2()
	{
		SayText("Worry not , " + I + "have a spare back at the Palace... " + A + " couple spares , actually.");
		ScheduleDelayedEvent(4.0, "say_sword3");
	}

	void say_sword3()
	{
		SayText("If you ever dare to step foot within the walls of the palace , be sure to find me.");
		ScheduleDelayedEvent(4.0, "say_sword4");
	}

	void say_sword4()
	{
		SayText("You maybe lowly human s, but you ve proven yourself mighty warriors all. Our doors are always open to true warriors.");
		ScheduleDelayedEvent(4.0, "say_sword4b");
	}

	void say_sword4b()
	{
		SayText("...and when you do visit us, be sure to show me that sword. All you human's look alike to me.");
		ScheduleDelayedEvent(4.0, "say_sword5");
	}

	void say_sword5()
	{
		SayText("That having been said , " + I + "must leave before this citidel comes crashing down - " + I + " suggest you do the same.");
		ScheduleDelayedEvent(4.0, "tele_out");
	}

	void tele_out()
	{
		SayText("Sorry I can't take you with me...");
		PlayAnim("once", "warcry");
		EmitSound(GetOwner(), 0, SOUND_TELE, 10);
		SpawnNPC("monsters/summon/ibarrier", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 64, 2, 0, 0, 0, 1
		ScheduleDelayedEvent(0.1, "fade_away");
	}

	void fade_away()
	{
		DeleteEntity(GetOwner(), true); // fade out
	}

}

}
