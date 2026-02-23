#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class Commoner01 : CGameScript
{
	Commoner01()
	{
		const int NO_CHAT = 1;
	}

	void OnRepeatTimer()
	{
		SetRepeatDelay(30);
		CanSee("ally");
		SetMoveDest(m_hLastSeen);
		SetVolume(2);
		Say("chitchat[50] *[20] *[55] *[55] *[23] *[22]");
	}

	void OnSpawn() override
	{
		SetHealth(1);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetName("Commoner");
		SetRoam(true);
		SetModel("npc/human1.mdl");
		SetModelBody(0, RandomInt(0, 2));
		SetModelBody(1, RandomInt(0, 5));
		SetMoveAnim("coffee");
		SetInvincible(true);
	}

}

}
