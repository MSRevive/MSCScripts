#pragma context server

#include "orc_for/tiers1.as"
#include "monsters/orc_shaman_fire.as"

namespace MS
{

class OrcFshamanSa : CGameScript
{
	string FIRE_BALL_DAMAGE;
	int NPC_SELF_ADJUST;

	OrcFshamanSa()
	{
		NPC_SELF_ADJUST = 1;
		const string NPC_ADJ_TIERS = "0;750;1500;2000;3000;5000";
		const string NPC_ADJ_DMG_MUTLI_TOKENS = "1.0;1.5;2.0;5.0;7.5;10.0;";
		const string NPC_ADJ_HP_MUTLI_TOKENS = "1.0;1.5;2.0;3.0;5.0;7.5;";
	}

	void OnSpawn() override
	{
		ScheduleDelayedEvent(2.0, "final_adjstments");
	}

	void final_adjstments()
	{
		if (!(NPC_ADJ_LEVEL < 2)) return;
		FIRE_BALL_DAMAGE = FIRE_BALL_DAMAGE_ALT;
	}

}

}
