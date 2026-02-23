#pragma context server

#include "bloodrose/trigger_base.as"

namespace MS
{

class TriggerFire : CGameScript
{
	TriggerFire()
	{
		SetGlobalVar("FIRE_TRIG", 0);
		const string ELEMENT_TYPE = "fire";
	}

	void trigger_spawn()
	{
		SetName("Elemental Shard of Fire");
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("fire", 1.0);
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
