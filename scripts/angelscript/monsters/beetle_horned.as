#pragma context server

#include "monsters/beetle_base.as"

namespace MS
{

class BeetleHorned : CGameScript
{
	int NPC_GIVE_EXP;

	BeetleHorned()
	{
		NPC_GIVE_EXP = 300;
		const int BBET_SIZE = 1;
		const int BBET_CAN_FLY = 1;
		const int BBET_CAN_LEAP = 1;
		const int BBET_CAN_SLAM = 0;
		const int BBET_GORE_PUSH_STR = 300;
		const int BBET_FAKE_DEATH = 1;
		const int DMG_SLASH = 20;
		const int DMG_GORE = 30;
		const int DMG_LEAP = 50;
	}

	void game_precache()
	{
		Precache("monsters/beetles.mdl");
	}

	void beetle_spawn()
	{
		SetName("Horned Beetle");
		SetHealth(500);
		SetModelBody(0, 0);
	}

}

}
