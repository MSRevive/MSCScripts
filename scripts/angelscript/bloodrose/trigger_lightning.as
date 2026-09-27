#pragma context server

#include "bloodrose/trigger_base.as"

namespace MS
{

class TriggerLightning : CGameScript
{
	string ELEMENT_TYPE;
	int MAX_HP;
	float RESET_DELAY;

	TriggerLightning()
	{
		SetGlobalVar("LIGHTNING_TRIG", 0);
		MAX_HP = 9999;
		ELEMENT_TYPE = "lightning";
		RESET_DELAY = 20.0;
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
