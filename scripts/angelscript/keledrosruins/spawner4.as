#pragma context server

#include "keledrosruins/spawner_base.as"

namespace MS
{

class Spawner4 : CGameScript
{
	Spawner4()
	{
		SetName("spawner4");
	}

	void spawn_undead()
	{
		if (FOUR_IS_DEAD == 1)
		{
			SpawnNPC("monsters/anim_archer", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
		}
		CallExternal(m_hLastCreated, "four_was_summoned");
	}

}

}
