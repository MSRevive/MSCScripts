#pragma context server

#include "effects/base_debuff.as"

namespace MS
{

class DebuffDefile : CGameScript
{
	string EFFECT_ID;
	string EFFECT_SCRIPT;

	DebuffDefile()
	{
		EFFECT_ID = "debuff_defile";
		EFFECT_SCRIPT = currentscript;
	}

	void OnDamagedOther(CBaseEntity@ victim, int damage) override
	{
		if (!(DEBUFF_STARTED)) return;
		return;
	}

}

}
