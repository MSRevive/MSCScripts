#pragma context server

#include "keledrosruins/spawner_base.as"

namespace MS
{

class Spawner3 : CGameScript
{
	Spawner3()
	{
		SetName("spawner3");
	}

	void spawn_undead()
	{
		if (THREE_IS_DEAD == 1)
		{
			SpawnNPC("monsters/anim_archer", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		}
		CallExternal(m_hLastCreated, "three_was_summoned");
	}

}

}
