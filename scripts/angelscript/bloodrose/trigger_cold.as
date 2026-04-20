#pragma context server

#include "bloodrose/trigger_base.as"

namespace MS
{

class TriggerCold : CGameScript
{
	string ELEMENT_TYPE;
	int TRIG_DELAY;

	TriggerCold()
	{
		SetGlobalVar("COLD_TRIG", 0);
		ELEMENT_TYPE = "cold";
	}

	void trigger_spawn()
	{
		SetName("Elemental Shard of Ice");
		SetDamageResistance("lightning", 0.0);
		SetDamageResistance("fire", 0.0);
		SetDamageResistance("cold", 1.0);
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("acid", 0.0);
		SetDamageResistance("slash", 0.0);
		SetDamageResistance("blunt", 0.0);
		SetDamageResistance("pierce", 0.0);
		SetDamageResistance("holy", 0.0);
	}

	void freeze_solid()
	{
		TRIG_DELAY = 1;
		SetGlobalVar("COLD_TRIG", 1);
		RESET_DELAY("trig_reset");
		UseTrigger(TRIGGER_STRING);
	}

}

}
