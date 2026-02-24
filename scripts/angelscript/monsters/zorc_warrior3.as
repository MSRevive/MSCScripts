#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class ZorcWarrior3 : CGameScript
{
	string ANIM_ATTACK;
	float ATTACK_ACCURACY;
	int ATTACK_DMG_HIGH;
	int ATTACK_DMG_LOW;
	float BASE_FRAMERATE;
	int BO_ZOMBIE_MODE;
	int DROP_GOLD;
	int DROP_GOLD_AMT;
	int NPC_GIVE_EXP;

	ZorcWarrior3()
	{
		DROP_GOLD = 1;
		DROP_GOLD_AMT = 75;
		NPC_GIVE_EXP = 600;
		ANIM_ATTACK = "battleaxe_swing1_L";
		ATTACK_ACCURACY = 0.8;
		ATTACK_DMG_LOW = 200;
		ATTACK_DMG_HIGH = 500;
		BO_ZOMBIE_MODE = 1;
	}

	void orc_spawn()
	{
		SetHealth(8000);
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
		SetModelBody(1, 1);
		SetModelBody(2, 1);
		SetProp(GetOwner(), "skin", 1);
	}

}

}
