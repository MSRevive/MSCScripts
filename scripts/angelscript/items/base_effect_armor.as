#pragma context server

namespace MS
{

class BaseEffectArmor : CGameScript
{
	void ext_activate_items()
	{
		if (!(param1 == GetEntityIndex(GetOwner()))) return;
		if (!(GetEntityProperty(GetOwner(), "is_worn"))) return;
		barmor_effect_activate();
	}

	void game_wear()
	{
		ScheduleDelayedEvent(0.1, "barmor_effect_activate");
	}

	void game_putinpack()
	{
		ScheduleDelayedEvent(0.1, "barmor_effect_remove");
	}

	void game_remove()
	{
		ScheduleDelayedEvent(0.1, "barmor_effect_remove");
	}

	void game_fall()
	{
		ScheduleDelayedEvent(0.1, "barmor_effect_remove");
	}

	void game_sheath()
	{
		ScheduleDelayedEvent(0.1, "barmor_effect_remove");
	}

	void OnDrop() override
	{
		ScheduleDelayedEvent(0.1, "barmor_effect_remove");
	}

	void OnDeploy() override
	{
		ScheduleDelayedEvent(0.1, "barmor_effect_remove");
	}

}

}
