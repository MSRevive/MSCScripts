#pragma context server

#include "effects/base_debuff.as"

namespace MS
{

class DebuffDefile : CGameScript
{
	DebuffDefile()
	{
		const string EFFECT_ID = "debuff_defile";
		const string EFFECT_SCRIPT = currentscript;
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(DEBUFF_STARTED)) return;
		return;
	}

}

}
