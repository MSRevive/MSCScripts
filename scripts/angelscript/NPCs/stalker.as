#pragma context server

#include "monsters/base_npc.as"

namespace MS
{

class Stalker : CGameScript
{
	void OnRepeatTimer()
	{
		SetRepeatDelay(0.5);
		CanSee("ally");
		SetMoveDest(m_hLastSeen);
	}

	void OnSpawn() override
	{
		SetHealth(45);
		SetWidth(32);
		SetHeight(72);
		SetRace("human");
		SetSkillLevel(-5);
		SetName("Strange Person");
		SetRoam(true);
		SetModel("npc/human1.mdl");
		SetModelBody(0, 1);
		SetModelBody(1, 5);
		SetMoveAnim("walk_scared");
	}

}

}
