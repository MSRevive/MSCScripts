#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class OrcWeak : CGameScript
{
	string ANIM_ATTACK;
	int ATTACK_HITRANGE;
	int ATTACK_RANGE;
	string DROP_GOLD;
	string DROP_GOLD_AMT;
	int MOVE_RANGE;
	int NPC_GIVE_EXP;

	OrcWeak()
	{
		DROP_GOLD = RandomInt(0, 1);
		DROP_GOLD_AMT = RandomInt(1, 4);
		NPC_GIVE_EXP = 10;
		ANIM_ATTACK = "battleaxe_swing1_L";
		MOVE_RANGE = 64;
		ATTACK_RANGE = 72;
		ATTACK_HITRANGE = 128;
		const float ATTACK_ACCURACY = 0.3;
		const float ATTACK_DMG_LOW = 0.5;
		const float ATTACK_DMG_HIGH = 1.5;
	}

	void orc_spawn()
	{
		SetHealth(20);
		SetName("Orc");
		SetHearingSensitivity(1);
		SetStat("parry", 15);
		SetModelBody(0, 0);
		SetModelBody(1, 0);
		SetModelBody(2, 1);
	}

}

}
