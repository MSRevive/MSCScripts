#pragma context server

#include "keledrosruins/spawner_base.as"

namespace MS
{

class Spawner2 : CGameScript
{
	Spawner2()
	{
		SetName("spawner2");
	}

	void spawn_undead()
	{
		if (TWO_IS_DEAD == 1)
		{
			SpawnNPC("monsters/anim_archer", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		}
		CallExternal(m_hLastCreated, "two_was_summoned");
	}

}

}
