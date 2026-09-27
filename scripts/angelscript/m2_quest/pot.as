#pragma context server

namespace MS
{

class Pot : CGameScript
{
	string GLOW_COLOR;
	int GLOW_RAD;
	int PLAYING_DEAD;

	void OnSpawn() override
	{
		SetName("cooking_pot");
		SetInvincible(true);
		PLAYING_DEAD = 1;
		SetNoPush(true);
		SetWidth(16);
		SetHeight(72);
		SetModel("props/pot1.mdl");
		GLOW_COLOR = Vector3(255, 200, 128);
		GLOW_RAD = 64;
		ScheduleDelayedEvent(0.1, "glow_loop");
	}

	void glow_loop()
	{
		ScheduleDelayedEvent(10.0, "glow_loop");
		ClientEvent("new", "all", "effects/sfx_follow_glow_cl", GetEntityIndex(GetOwner()), GLOW_COLOR, GLOW_RAD, 10.1);
	}

	void ext_cooking()
	{
		SetModelBody(0, 1);
		GLOW_COLOR = Vector3(255, 225, 164);
		GLOW_RAD = 96;
	}

}

}
