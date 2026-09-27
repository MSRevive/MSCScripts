#pragma context server

#include "keledrosruins/spawner_base.as"

namespace MS
{

class Spawner5 : CGameScript
{
	Spawner5()
	{
		SetName("spawner5");
	}

	void spawn_undead()
	{
		SpawnNPC("monsters/anim_warrior2", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
	}

}

}
