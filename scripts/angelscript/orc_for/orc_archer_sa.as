#pragma context server

#include "monsters/orc_archer.as"

namespace MS
{

class OrcArcherSa : CGameScript
{
	int NPC_SELF_ADJUST;

	OrcArcherSa()
	{
		NPC_SELF_ADJUST = 1;
		const string NPC_ADJ_TIERS = "0;750;1500;2000;3000;5000";
		const string NPC_ADJ_DMG_MUTLI_TOKENS = "1.0;1.5;2.0;5.0;7.5;10.0;";
		const string NPC_ADJ_HP_MUTLI_TOKENS = "1.0;2.0;3.0;5.0;7.5;10.0;";
	}

}

}
