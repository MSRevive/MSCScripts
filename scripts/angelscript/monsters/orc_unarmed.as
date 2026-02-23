#pragma context server

#include "monsters/orc_base_melee.as"
#include "monsters/orc_base.as"

namespace MS
{

class OrcUnarmed : CGameScript
{
	string ANIM_ATTACK;
	int CAN_FLEE;
	int DROP_GOLD;
	string LIGHT_COLOR;
	int NPC_GIVE_EXP;

	OrcUnarmed()
	{
		DROP_GOLD = 0;
		NPC_GIVE_EXP = 1;
		CAN_FLEE = 1;
		const int FLEE_HEALTH = 19;
		const float FLEE_CHANCE = 0.99;
		ANIM_ATTACK = "swordswing1_L";
		const float ATTACK_ACCURACY = 0.5;
		const int ATTACK_DMG_LOW = 1;
		const int ATTACK_DMG_HIGH = 2;
	}

	void orc_spawn()
	{
		SetHealth(20);
		SetName("Unarmed Orc");
		SetHearingSensitivity(0);
		SetStat("parry", 1);
		SetDamageResistance("all", 1.0);
		SetInvincible(false);
		SetModelBody(0, 0);
		SetModelBody(1, 4);
		SetModelBody(2, 0);
	}

	void superorc()
	{
		SetInvincible(true);
		SetName("INVULNERABLE Unarmed Orc");
		LIGHT_COLOR = Vector3(255, 255, 255);
		Effect("glow", GetOwner(), LIGHT_COLOR, 255, 255, 5);
		SetSayTextRange(1024);
		SayText("W00t! I r invlnerable!");
	}

	void godoff()
	{
		SetInvincible(false);
		SetName("Unarmed Orc");
		LIGHT_COLOR = Vector3(1, 1, 1);
		Effect("glow", GetOwner(), LIGHT_COLOR, 255, 5, 5);
		SetSayTextRange(1024);
		SayText("OMG WTF h4x!");
	}

}

}
