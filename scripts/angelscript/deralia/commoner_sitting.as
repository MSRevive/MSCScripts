#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class CommonerSitting : CGameScript
{
	int NO_CHAT;

	CommonerSitting()
	{
		NO_CHAT = 1;
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetWidth(5);
		SetHeight(55);
		SetRace("human");
		SetName("Commoner");
		SetRoam(false);
		SetModel("npc/human1.mdl");
		SetModelBody(0, RandomInt(0, 2));
		SetModelBody(1, RandomInt(0, 5));
		SetIdleAnim("coffee");
		SetMoveAnim("walk");
		SetInvincible(true);
	}

}

}
