#pragma context server

#include "keledrosruins/keledros.as"

namespace MS
{

class WizardNormal : CGameScript
{
	int AM_GENERIC;

	WizardNormal()
	{
		AM_GENERIC = 1;
	}

	void do_ale_intro()
	{
		ScheduleDelayedEvent(1.0, "do_ale_intro1");
	}

	void do_ale_intro1()
	{
		SetSayTextRange(2048);
		SayText("Whoever you are, turn around and head back. Only death awaits further.");
		ScheduleDelayedEvent(4.0, "do_ale_intro2");
	}

	void do_ale_intro2()
	{
		SayText("For many cycles I have guarded these canyons and will continue to do so until the great Keledros returns.");
		ScheduleDelayedEvent(4.0, "do_ale_intro3");
	}

	void do_ale_intro3()
	{
		SayText("Keledros dead, you say!? Ha! Only time will tell if that is true or not.");
		ScheduleDelayedEvent(4.0, "do_ale_intro4");
	}

	void do_ale_intro4()
	{
		SayText("Enough! Prepare to die at my hands!");
	}

	void OnDeath(CBaseEntity@ attacker) override
	{
		if (!(AM_SKELE)) return;
		if (!((StringToLower(GetMapName())).findFirst("aleyesu") >= 0)) return;
		SayText("Master... Forgive me...");
	}

}

}
