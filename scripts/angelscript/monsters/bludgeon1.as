#pragma context server

#include "monsters/bludgeon.as"

namespace MS
{

class Bludgeon1 : CGameScript
{
	int IS_JUMPING;

	void OnSpawn() override
	{
		SetDamageResistance("holy", 1.0);
	}

	void my_target_died()
	{
		IS_JUMPING = 0;
	}

}

}
