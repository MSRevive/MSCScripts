#pragma context server

#include "monsters/orc_sniper.as"

namespace MS
{

class SorcArcher2 : CGameScript
{
	int AM_SORC;
	int ARROW_DAMAGE_HIGH;
	int ARROW_DAMAGE_LOW;
	string ARROW_TYPE;
	string CONTAINER_BASE;
	int DOING_KICK;
	int DROP_GOLD_AMT;
	string DROP_ITEM_BASE1;
	int FIN_EXP;
	int KICK_TYPE;

	SorcArcher2()
	{
		ARROW_TYPE = "proj_arrow_lightning";
		FIN_EXP = 200;
		DROP_GOLD_AMT = RandomInt(20, 60);
		DROP_ITEM_BASE1 = "bows_swiftbow";
		CONTAINER_BASE = "chests/quiver_of_lightning";
		AM_SORC = 1;
		ARROW_DAMAGE_LOW = 75;
		ARROW_DAMAGE_HIGH = 150;
		AM_SORC = 1;
	}

	void orc_spawn()
	{
		SetHealth(500);
		SetName("Shadahar Archer");
		SetHearingSensitivity(10);
		SetStat("parry", 60);
		SetDamageResistance("all", ".7");
		SetRace("orc");
		SetModel("monsters/sorc.mdl");
		DOING_KICK = 0;
		KICK_TYPE = 1;
		SetModelBody(0, 3);
		SetModelBody(1, 2);
		SetModelBody(2, 2);
	}

}

}
