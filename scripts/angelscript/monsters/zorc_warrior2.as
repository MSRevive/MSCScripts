#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class ZorcWarrior2 : CGameScript
{
	string ANIM_ATTACK;
	float BASE_FRAMERATE;
	int BO_ZOMBIE_MODE;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int NPC_GIVE_EXP;

	ZorcWarrior2()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 50;
		NPC_GIVE_EXP = 400;
		ANIM_ATTACK = "swordswing1_L";
		const float ATTACK_ACCURACY = 0.8;
		const int ATTACK_DMG_LOW = 100;
		const int ATTACK_DMG_HIGH = 200;
		BO_ZOMBIE_MODE = 1;
	}

	void orc_spawn()
	{
		SetHealth(5000);
		SetName("Undead Orc");
		SetHearingSensitivity(5);
		SetDamageResistance("all", ".8");
		SetDamageResistance("poison", 0.0);
		SetDamageResistance("holy", 1.0);
		SetDamageResistance("pierce", 0.5);
		SetDamageResistance("cold", 0.25);
		SetDamageResistance("lightning", 0.5);
		SetDamageResistance("fire", 1.25);
		SetAnimFrameRate(0.5);
		BASE_FRAMERATE = 0.5;
		SetRace("undead");
		SetModelBody(0, 2);
		SetModelBody(1, 2);
		SetModelBody(2, 4);
		SetProp(GetOwner(), "skin", 1);
	}

}

}
