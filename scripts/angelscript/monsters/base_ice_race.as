#pragma context server

namespace MS
{

class BaseIceRace : CGameScript
{
	void OnSpawn() override
	{
		SetDamageResistance("fire", 1.5);
		SetDamageResistance("cold", 0.0);
	}

}

}
