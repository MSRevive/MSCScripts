#pragma context server

namespace MS
{

class Hibari : CGameScript
{
	int PLAYING_DEAD;

	void OnSpawn() override
	{
		SetModel("monsters/hibari.mdl");
		SetWidth(32);
		SetHeight(72);
		SetRace("beloved");
		PLAYING_DEAD = 1;
		SetHealth(9999);
		SetIdleAnim("idle");
		SetMoveAnim("idle");
		PlayAnim("once", "idle");
	}

}

}
