#pragma context server

#include "effects/dot_poison.as"

namespace MS
{

class PoisonSpore : CGameScript
{
	PoisonSpore()
	{
		const string DOT_IM_AFFECTED = "You have been overcome by noxious spores!";
		const string DOT_IM_RESIST = "You resist the worst of the spores.";
	}

}

}
