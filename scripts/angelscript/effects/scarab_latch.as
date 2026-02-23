#pragma context server

#include "effects/base_dot	allowduplicate.as"

namespace MS
{

class ScarabLatch : CGameScript
{
	ScarabLatch()
	{
		const string EFFECT_ID = "DOT_scarab";
		const string EFFECT_SCRIPT = currentscript;
		const string DOT_TYPE = "magic_effect";
		const string DOT_IM_AFFECTED = "A scarab latches to you, sapping your life away!";
		const string DOT_IM_RESIST = "Youre not supposed to resist this.";
		const string DOT_HE_IMMUNE = "Youre not supposed to resist this.";
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
