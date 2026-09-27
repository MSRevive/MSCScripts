#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectStaminaRegen : CGameScript
{
	string EFFECT_FLAGS;
	string EFFECT_ID;
	string EFFECT_SCRIPT;

	EffectStaminaRegen()
	{
		EFFECT_ID = "effect_stamina";
		EFFECT_FLAGS = "nostack";
		EFFECT_SCRIPT = currentscript;
	}

	void game_activate()
	{
		stamina_loop();
	}

	void stamina_loop()
	{
		DrainStamina(GetOwner());
		ScheduleDelayedEvent(1.0, "stamina_loop");
	}

}

}
