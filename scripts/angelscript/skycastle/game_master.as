#pragma context server

namespace MS
{

class GameMaster : CGameScript
{
	void gm_bear_god_death()
	{
		ScheduleDelayedEvent(1.0, "gm_bear_god_death2");
	}

	void gm_bear_god_death2()
	{
		SpawnNPC("monsters/summon/stun_burst", /* TODO: $relpos */ $relpos(0, 0, 0), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner()), 512, 0, 150
	}

}

}
