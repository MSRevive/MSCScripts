#pragma context server

#include "effects/base_debuff.as"

namespace MS
{

class DebuffAcid : CGameScript
{
	string EFFECT_ID;
	string EFFECT_SCRIPT;

	DebuffAcid()
	{
		EFFECT_ID = "debuff_acid";
		EFFECT_SCRIPT = currentscript;
	}

	void OnDamage(int damage) override
	{
		if (!(DEBUFF_STARTED)) return;
		return;
	}

}

}
