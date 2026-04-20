#pragma context server

#include "effects/dot_poison.as"

namespace MS
{

class PoisonSpore : CGameScript
{
	string DOT_IM_AFFECTED;
	string DOT_IM_RESIST;

	PoisonSpore()
	{
		DOT_IM_AFFECTED = "You have been overcome by noxious spores!";
		DOT_IM_RESIST = "You resist the worst of the spores.";
	}

}

}
