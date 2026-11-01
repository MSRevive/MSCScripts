#pragma context server

#include "keledrosruins/spawner_base.as"

namespace MS
{

class Spawner6 : CGameScript
{
	Spawner6()
	{
		SetName("spawner6");
	}

	void spawn_undead()
	{
		SpawnNPC("monsters/anim_warrior2", GetEntityOrigin(GetOwner()), ScriptMode::Legacy); // params: GetEntityIndex(GetOwner())
	}

}

}
