#pragma context server

#include "monsters/orc_sniper.as"

namespace MS
{

class SorcArcher1 : CGameScript
{
	int DOING_KICK;
	string DROP_GOLD_AMT;
	string DROP_ITEM1;
	float DROP_ITEM1_CHANCE;
	string DROP_ITEM2;
	float DROP_ITEM2_CHANCE;
	int KICK_TYPE;

	SorcArcher1()
	{
		const string ARROW_TYPE = "proj_arrow_npc";
		const int FIN_EXP = 120;
		DROP_GOLD_AMT = RandomInt(10, 40);
		const int AM_SORC = 1;
		DROP_ITEM1 = "bows_longbow";
		DROP_ITEM1_CHANCE = 0.05;
		DROP_ITEM2 = "proj_arrow_jagged";
		DROP_ITEM2_CHANCE = 0.1;
		const int AM_SORC = 1;
	}

	void orc_spawn()
	{
		SetHealth(320);
		SetName("Shadahar Scout");
		SetHearingSensitivity(10);
		SetStat("parry", 60);
		SetDamageResistance("all", ".7");
		SetModel("monsters/sorc.mdl");
		DOING_KICK = 0;
		KICK_TYPE = 1;
		SetModelBody(0, 1);
		SetModelBody(1, 4);
		SetModelBody(2, 2);
	}

}

}
