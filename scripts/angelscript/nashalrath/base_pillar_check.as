#pragma context server

namespace MS
{

class BasePillarCheck : CGameScript
{
	int PLAYING_DEAD;
	string TARGET_CHECK;

	void OnSpawn() override
	{
		SetInvincible(true);
		SetNoPush(true);
		PLAYING_DEAD = 1;
		SetSolid("none");
		SetModel("null.mdl");
	}

	void ext_check_targets()
	{
		TARGET_CHECK = FindEntitiesInSphere("player", 256);
	}

	void ext_do_shake()
	{
		TARGET_CHECK = "none";
		Effect("screenshake", GetEntityOrigin(GetOwner()), 300, 30, 10.0, 384);
		EmitSound(GetOwner(), 0, "magic/volcano_start.wav", 10);
	}

	void ext_do_boom()
	{
		ScheduleDelayedEvent(1.5, "ext_do_boom2");
	}

	void ext_do_boom2()
	{
		EmitSound(GetOwner(), 0, "magic/boom.wav", 10);
	}

}

}
