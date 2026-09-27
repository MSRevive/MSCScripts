#pragma context server

namespace MS
{

class Chestmaker : CGameScript
{
	void OnSpawn() override
	{
		SetName("spawner");
		SetFly(true);
		SetInvincible(true);
		LogDebug("chest_maker spawned");
		ScheduleDelayedEvent(0.1, "make_chest");
	}

	void make_chest()
	{
		int ROLL = RandomInt(1, 6);
		if (ROLL == 1)
		{
			LogDebug("spawning chest_great");
			SpawnNPC("mines/chest_great", GetEntityOrigin(GetOwner()), ScriptMode::Legacy);
		}
		if (ROLL != 1)
		{
			LogDebug("spawning chest_good");
			SpawnNPC("mines/chest_good", GetEntityOrigin(GetOwner()), ScriptMode::Legacy);
		}
		DeleteEntity(GetOwner());
	}

}

}
