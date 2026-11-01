#pragma context server

#include "monsters/base_temporary.as"

namespace MS
{

class Stop : CGameScript
{
	void OnSpawn() override
	{
		string SLITHAR_ID = FindEntityByName("snake_lord");
		string MY_YAW = /* TODO: $vec.yaw */ $vec.yaw(GetMonsterProperty("origin"));
		CallExternal(SLITHAR_ID, "slithar_stop", MY_YAW);
	}

}

}
