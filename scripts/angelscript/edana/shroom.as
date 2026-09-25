#pragma context server

namespace MS
{

class Shroom : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(9999);
		SetRace("human");
		SetWidth(50);
		SetHeight(50);
		SetRoam(false);
		SetName("Shroom");
		SetIdleAnim("idle");
		SetModel("misc/env_shroom4.mdl");
	}

}

}
