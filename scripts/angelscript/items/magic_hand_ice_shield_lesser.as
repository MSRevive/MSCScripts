#pragma context server

#include "items/magic_hand_ice_shield.as"

namespace MS
{

class MagicHandIceShieldLesser : CGameScript
{
	MagicHandIceShieldLesser()
	{
		const int CSKILL_REQ = 1;
		const int SPELL_ENERGYDRAIN = 25;
		const int SPELL_MPDRAIN = 20;
		const int MANA_COST = 20;
		const float ICESHIELD_FORMULA = 0.75;
	}

	void spell_spawn()
	{
		SetName("Lesser Ice Shield");
		SetDescription("Provides 25% damage reduction for you or allies, for a time.");
	}

}

}
