#pragma context server

namespace MS
{

class SfxGlassmaker : CGameScript
{
	int DO_NADDA2;

	SfxGlassmaker()
	{
		const int DO_NADDA = 0;
	}

	void game_dynamically_created()
	{
		DO_NADDA2 = 0;
	}

	void OnSpawn() override
	{
		SetRace("beloved");
		SetInvincible(true);
		ScheduleDelayedEvent(0.1, "glass_splodie");
	}

	void glass_splodie()
	{
		Effect("tempent", "gibs", "glassgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 0), 1, 40, 10, 100, 30);
		ScheduleDelayedEvent(0.1, "glass_splodie2");
	}

	void glass_splodie2()
	{
		Effect("tempent", "gibs", "glassgibs.mdl", /* TODO: $relpos */ $relpos(0, 0, 128), 1, 40, 10, 100, 30);
		ScheduleDelayedEvent(0.1, "remove_sploder");
	}

	void remove_sploder()
	{
		DeleteEntity(GetOwner());
	}

}

}
