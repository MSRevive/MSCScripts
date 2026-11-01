#pragma context server

namespace MS
{

class TriggerMonitor : CGameScript
{
	string ATHOLO_ID;
	string COLD_ON;
	string FIRE_ON;
	string LIGHTNING_ON;
	string MON_DONE;
	string POISON_ON;

	TriggerMonitor()
	{
		SetGlobalVar("COLD_TRIG", 0);
		SetGlobalVar("FIRE_TRIG", 0);
		SetGlobalVar("LIGHTNING_TRIG", 0);
		SetGlobalVar("POISON_TRIG", 0);
	}

	void OnSpawn() override
	{
		SetName("ele_monitor");
		SetModel("null.mdl");
		SetInvincible(true);
		SetFly(true);
		SetRoam(false);
		SetMoveSpeed(0.0);
		SetRace("beloved");
		ScheduleDelayedEvent(1.0, "monitor_triggers");
	}

	void monitor_triggers()
	{
		int FOUR_TRIGS = 0;
		FOUR_TRIGS += COLD_ON;
		FOUR_TRIGS += FIRE_ON;
		FOUR_TRIGS += POISON_ON;
		FOUR_TRIGS += LIGHTNING_ON;
		if (FOUR_TRIGS == 4)
		{
			ATHOLO_ID = FindEntityByName("boss_atholo");
			CallExternal(ATHOLO_ID, "vulnerable");
			UseTrigger("monitor_triggered");
			CallExternal("all", "element_trigs_remove");
			MON_DONE = 1;
		}
		if ((MON_DONE)) return;
		ScheduleDelayedEvent(0.5, "monitor_triggers");
	}

	void trigger_on()
	{
		if (param1 == "cold")
		{
			COLD_ON = 1;
		}
		if (param1 == "fire")
		{
			FIRE_ON = 1;
		}
		if (param1 == "poison")
		{
			POISON_ON = 1;
		}
		if (param1 == "lightning")
		{
			LIGHTNING_ON = 1;
		}
	}

	void trigger_off()
	{
		if (param1 == "cold")
		{
			COLD_ON = 0;
		}
		if (param1 == "fire")
		{
			FIRE_ON = 0;
		}
		if (param1 == "poison")
		{
			POISON_ON = 0;
		}
		if (param1 == "lightning")
		{
			LIGHTNING_ON = 0;
		}
	}

}

}
