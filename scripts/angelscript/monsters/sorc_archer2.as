#pragma context server

#include "monsters/orc_sniper.as"

namespace MS
{

class SorcArcher2 : CGameScript
{
	int DOING_KICK;
	string DROP_GOLD_AMT;
	int KICK_TYPE;

	SorcArcher2()
	{
		const string ARROW_TYPE = "proj_arrow_lightning";
		const int FIN_EXP = 200;
		DROP_GOLD_AMT = RandomInt(20, 60);
		const string DROP_ITEM_BASE1 = "bows_swiftbow";
		const string CONTAINER_BASE = "chests/quiver_of_lightning";
		const int AM_SORC = 1;
		const int ARROW_DAMAGE_LOW = 75;
		const int ARROW_DAMAGE_HIGH = 150;
		const int AM_SORC = 1;
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
