#pragma context server

#include "effects/base_debuff.as"

namespace MS
{

class DebuffAcid : CGameScript
{
	DebuffAcid()
	{
		const string EFFECT_ID = "debuff_acid";
		const string EFFECT_SCRIPT = currentscript;
	}

	void OnDamage(int damage) override
	{
		if (!(DEBUFF_STARTED)) return;
		return;
	}

}

}
