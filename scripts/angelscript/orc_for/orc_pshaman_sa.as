#pragma context server

#include "dq/voldarshaman.as"

namespace MS
{

class OrcPshamanSa : CGameScript
{
	int NPC_SELF_ADJUST;

	OrcPshamanSa()
	{
		NPC_SELF_ADJUST = 1;
		const string NPC_ADJ_TIERS = "0;750;1500;2000;3000;5000";
		const string NPC_ADJ_DMG_MUTLI_TOKENS = "1.0;1.5;2.0;5.0;7.5;10.0;";
		const string NPC_ADJ_HP_MUTLI_TOKENS = "1.0;1.5;2.0;3.0;5.0;7.5;";
	}

	void orc_spawn()
	{
		SetProp(GetOwner(), "skin", 3);
		SetHealth(220);
		SetName("Orc Venom Shaman");
		SetHearingSensitivity(8);
		SetStat("parry", 30);
		SetDamageResistance("all", ".8");
		SetDamageResistance("lightning", 3.0);
		SetDamageResistance("acid", 0.0);
		SetDamageResistance("poison", 0.0);
		SetStat("spellcasting", 30);
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
	}

}

}
