#pragma context server

namespace MS
{

class Chestmaker : CGameScript
{
	void OnSpawn() override
	{
		int rand = RandomInt(0, 5);
		if (rand == 0)
		{
			SpawnNPC("daragoth/chest_great", GetEntityOrigin(GetOwner()), ScriptMode::Legacy);
		}
		if (rand != 0)
		{
			SpawnNPC("daragoth/chest_good", GetEntityOrigin(GetOwner()), ScriptMode::Legacy);
		}
		DeleteEntity(GetOwner());
	}

}

}
