#pragma context server

namespace MS
{

class Bats : CGameScript
{
	string SOUND_IDLE1;

	void OnRepeatTimer()
	{
		SetRepeatDelay(8);
		SetVolume(10);
		EmitSound(GetOwner(), SOUND_IDLE1);
	}

	void OnSpawn() override
	{
		SetHealth(20);
		SetMaxHealth(20);
		SetGold(0);
		SetWidth(0);
		SetHeight(0);
		SetRace("neutral");
		SetName("Bats");
		SetRoam(true);
		SetFly(true);
		SetModel("animals/bats.mdl");
		SetIdleAnim("flappin");
		SOUND_IDLE1 = "monsters/bats/bats.wav";
		SetInvincible(true);
	}

}

}
