#pragma context server

#include "keledrosruins/spawner_base.as"

namespace MS
{

class Spawner1 : CGameScript
{
	Spawner1()
	{
		SetName("spawner1");
	}

	void spawn_undead()
	{
		if (ONE_IS_DEAD == 1)
		{
			SpawnNPC("monsters/anim_archer", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		}
		CallExternal(m_hLastCreated, "one_was_summoned");
	}

}

}
