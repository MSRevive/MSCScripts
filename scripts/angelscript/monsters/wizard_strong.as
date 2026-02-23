#pragma context server

#include "bloodrose/venevus.as"

namespace MS
{

class WizardStrong : CGameScript
{
	WizardStrong()
	{
		const int AM_GENERIC = 1;
	}

	void game_precache()
	{
		Precache("aleyesu/death_image");
	}

	void OnSpawn() override
	{
		SetHealth(12000);
		SetDamageResistance("slash", 1);
		SetDamageResistance("pierce", 1);
		SetDamageResistance("blunt", 1);
		SetDamageResistance("lightning", 0.25);
		SetDamageResistance("cold", 0.25);
	}

	void do_ale_intro()
	{
		ScheduleDelayedEvent(1.0, "do_ale_intro1");
	}

	void do_ale_intro1()
	{
		SetSayTextRange(2048);
		SayText("I don't believe it! I mean of course I believe it, I did just travel forward through time.");
		ScheduleDelayedEvent(4.0, "do_ale_intro2");
	}

	void do_ale_intro2()
	{
		SayText("Who are you?! What are you doing in my chamber?!");
		ScheduleDelayedEvent(4.0, "do_ale_intro3");
	}

	void do_ale_intro3()
	{
		SayText("Don't tell me you touched that dial!?");
		ScheduleDelayedEvent(4.0, "do_ale_intro4");
	}

	void do_ale_intro4()
	{
		SayText("Oh never mind... I'll just kill you all!");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!((StringToLower(GetMapName())).findFirst("aleyesu") >= 0)) return;
		SpawnNPC("aleyesu/death_image", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: NPC_SPAWN_LOC
		SetProp(GetOwner(), "rendermode", 5);
		SetProp(GetOwner(), "renderamt", 0);
	}

}

}
