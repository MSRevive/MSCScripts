#pragma context server

#include "items/magic_hand_ice_shield.as"

namespace MS
{

class MagicHandIceShieldLesser : CGameScript
{
	int CSKILL_REQ;
	float ICESHIELD_FORMULA;
	int MANA_COST;
	int SPELL_ENERGYDRAIN;
	int SPELL_MPDRAIN;

	MagicHandIceShieldLesser()
	{
		CSKILL_REQ = 1;
		SPELL_ENERGYDRAIN = 25;
		SPELL_MPDRAIN = 20;
		MANA_COST = 20;
		ICESHIELD_FORMULA = 0.75;
	}

	void spell_spawn()
	{
		SetName("Lesser Ice Shield");
		SetDescription("Provides 25% damage reduction for you or allies, for a time.");
	}

}

}
