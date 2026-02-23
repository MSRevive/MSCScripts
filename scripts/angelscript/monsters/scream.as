#pragma context server

namespace MS
{

class Scream : CGameScript
{
	void OnSpawn() override
	{
		SetHealth(150);
		SetWidth(50);
		SetHeight(50);
		SetRoam(false);
		SetName("PlaceHolder [Test Minions]");
		SetIdleAnim("seq-name");
		SetModel("props/rock1.mdl");
	}

}

}
