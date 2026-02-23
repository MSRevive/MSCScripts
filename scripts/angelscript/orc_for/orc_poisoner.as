#pragma context server

#include "dq/voldar.as"

namespace MS
{

class OrcPoisoner : CGameScript
{
	int NPC_SELF_ADJUST;

	OrcPoisoner()
	{
		NPC_SELF_ADJUST = 1;
		const string NPC_ADJ_TIERS = "0;750;1500;2000;3000;5000";
		const string NPC_ADJ_DMG_MUTLI_TOKENS = "1.0;1.0;1.5;2.0;2.5;3.0;";
		const string NPC_ADJ_HP_MUTLI_TOKENS = "1.0;1.0;1.5;2.0;4.0;5.0;";
	}

}

}
