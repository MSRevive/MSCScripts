#pragma context server

#include "bloodrose/trigger_base.as"

namespace MS
{

class TriggerLightning : CGameScript
{
	TriggerLightning()
	{
		SetGlobalVar("LIGHTNING_TRIG", 0);
		const int MAX_HP = 9999;
		const string ELEMENT_TYPE = "lightning";
		const float RESET_DELAY = 20.0;
	}

	void trigger_spawn()
	{
		SetName("Elemental Shard of Lightning");
		SetDamageResistance("lightning", 1.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("acid", 0.0);
		SetDamageResistance("slash", 0.0);
		SetDamageResistance("blunt", 0.0);
		SetDamageResistance("pierce", 0.0);
		SetDamageResistance("holy", 0.0);
	}

}

}
