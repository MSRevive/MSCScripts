#pragma context server

#include "effects/base_debuff.as"

namespace MS
{

class DebuffLightning : CGameScript
{
	DebuffLightning()
	{
		const string EFFECT_ID = "debuff_lightning";
		const string EFFECT_SCRIPT = currentscript;
	}

	void debuff_start()
	{
		SetHitMultiplier(GetOwner());
	}

	void effect_die()
	{
		if (!(DEBUFF_STARTED)) return;
		SetHitMultiplier(GetOwner());
	}

}

}
