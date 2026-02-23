#pragma context server

#include "bloodrose/trigger_base.as"

namespace MS
{

class TriggerPoison : CGameScript
{
	TriggerPoison()
	{
		SetGlobalVar("POISON_TRIG", 0);
		const string ELEMENT_TYPE = "poison";
	}

	void trigger_spawn()
	{
		SetName("Elemental Shard of Affliction");
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 0.0);
		SetDamageResistance("poison", 1.0);
		SetDamageResistance("acid", 1.0);
		SetDamageResistance("slash", 0.0);
		SetDamageResistance("blunt", 0.0);
		SetDamageResistance("pierce", 0.0);
		SetDamageResistance("holy", 0.0);
	}

}

}
