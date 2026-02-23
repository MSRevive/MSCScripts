#pragma context server

#include "effects/base_effect	allowduplicate.as"

namespace MS
{

class EffectStaminaRegen : CGameScript
{
	EffectStaminaRegen()
	{
		const string EFFECT_ID = "effect_stamina";
		const string EFFECT_FLAGS = "nostack";
		const string EFFECT_SCRIPT = currentscript;
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
