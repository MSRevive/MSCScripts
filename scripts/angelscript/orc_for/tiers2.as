#pragma context server

namespace MS
{

class Tiers2 : CGameScript
{
	string NPC_ADJ_DMG_MUTLI_TOKENS;
	string NPC_ADJ_HP_MUTLI_TOKENS;
	string NPC_ADJ_TIERS;
	int NPC_SELF_ADJUST;

	Tiers2()
	{
		NPC_SELF_ADJUST = 1;
		NPC_ADJ_TIERS = "0;750;1500;2000;3000;5000";
		NPC_ADJ_DMG_MUTLI_TOKENS = "1.0;1.5;2.0;5.0;7.5;15.0;";
		NPC_ADJ_HP_MUTLI_TOKENS = "1.0;2.0;3.0;5.0;7.5;10.0;";
	}

}

}
