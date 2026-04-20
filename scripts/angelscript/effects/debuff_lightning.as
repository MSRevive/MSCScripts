#pragma context server

#include "effects/base_debuff.as"

namespace MS
{

class DebuffLightning : CGameScript
{
	string EFFECT_ID;
	string EFFECT_SCRIPT;

	DebuffLightning()
	{
		EFFECT_ID = "debuff_lightning";
		EFFECT_SCRIPT = currentscript;
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
