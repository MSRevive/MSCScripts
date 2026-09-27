#pragma context server

namespace MS
{

class Bunny : CGameScript
{
	void OnRepeatTimer()
	{
		SetRepeatDelay(4);
		PlayAnim("once", "hop");
	}

	void OnSpawn() override
	{
		SetHealth(20);
		SetMaxHealth(20);
		SetGold(0);
		SetWidth(0);
		SetHeight(0);
		SetRace("neutral");
		SetName("Bunny");
		SetRoam(true);
		SetModel("animals/bunny.mdl");
		SetIdleAnim("idle");
		SetInvincible(true);
	}

}

}
