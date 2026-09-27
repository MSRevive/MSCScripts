#pragma context server

#include "effects/base_dot	allowduplicate.as"

namespace MS
{

class ScarabLatch : CGameScript
{
	string DOT_HE_IMMUNE;
	string DOT_IM_AFFECTED;
	string DOT_IM_RESIST;
	string DOT_TYPE;
	string EFFECT_ID;
	string EFFECT_SCRIPT;

	ScarabLatch()
	{
		EFFECT_ID = "DOT_scarab";
		EFFECT_SCRIPT = currentscript;
		DOT_TYPE = "magic_effect";
		DOT_IM_AFFECTED = "A scarab latches to you, sapping your life away!";
		DOT_IM_RESIST = "Youre not supposed to resist this.";
		DOT_HE_IMMUNE = "Youre not supposed to resist this.";
	}

	void dot_effect()
	{
		if (!(IsEntityAlive(DOT_ATTACKER)))
		{
			RemoveScript();
		}
	}

}

}
