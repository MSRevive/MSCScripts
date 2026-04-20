#pragma context server

#include "chests/base_treasurechest.as"

namespace MS
{

class TundraBase : CGameScript
{
	void OnSpawn() override
	{
		G_GAVE_ARTI1 += 1;
		tc_add_artifact("blunt_staff_i", (G_GAVE_ARTI1 * 1));
	}

}

}
