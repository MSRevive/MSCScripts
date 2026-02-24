#pragma context server

#include "monsters/beetle_base.as"

namespace MS
{

class BeetleHorned : CGameScript
{
	int BBET_CAN_FLY;
	int BBET_CAN_LEAP;
	int BBET_CAN_SLAM;
	int BBET_FAKE_DEATH;
	int BBET_GORE_PUSH_STR;
	int BBET_SIZE;
	int DMG_GORE;
	int DMG_LEAP;
	int DMG_SLASH;
	int NPC_GIVE_EXP;

	BeetleHorned()
	{
		NPC_GIVE_EXP = 300;
		BBET_SIZE = 1;
		BBET_CAN_FLY = 1;
		BBET_CAN_LEAP = 1;
		BBET_CAN_SLAM = 0;
		BBET_GORE_PUSH_STR = 300;
		BBET_FAKE_DEATH = 1;
		DMG_SLASH = 20;
		DMG_GORE = 30;
		DMG_LEAP = 50;
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
