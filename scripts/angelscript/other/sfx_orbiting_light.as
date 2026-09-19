#pragma context server

namespace MS
{

class SfxOrbitingLight : CGameScript
{
	int PLAYING_DEAD;

	void OnRepeatTimer()
	{
		SetRepeatDelay(60.0);
		refresh_sound();
		ClientEvent("new", "all", "other/sfx_orbiting_light_cl", GetEntityOrigin(GetOwner()), 60.0, 96, 256, Vector3(128, 128, 0), 0.8);
	}

	void OnSpawn() override
	{
		SetWidth(1);
		SetHeight(1);
		SetRace("beloved");
		SetHealth(1);
		SetInvincible(true);
		PLAYING_DEAD = 1;
		SetNoPush(true);
		SetSolid("none");
		SetGravity(0);
		SetProp(GetOwner(), "movetype", 0);
		ClientEvent("new", "all", "other/sfx_orbiting_light_cl", GetEntityOrigin(GetOwner()), 60.0, 96, 256, Vector3(128, 128, 0), 0.8);
		// svplaysound: svplaysound 1 10 ambience/alien_creeper.wav
		EmitSound(1, 10, "ambience/alien_creeper.wav");
	}

	void refresh_sound()
	{
		// svplaysound: svplaysound 1 0 ambience/alien_creeper.wav
		EmitSound(1, 0, "ambience/alien_creeper.wav");
		ScheduleDelayedEvent(0.1, "refresh_sound2");
	}

	void refresh_sound2()
	{
		// svplaysound: svplaysound 1 10 ambience/alien_creeper.wav
		EmitSound(1, 10, "ambience/alien_creeper.wav");
	}

}

}
